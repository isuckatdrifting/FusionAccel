`include "macros.vh"
module csb 
(
    input           clk,
    input           rst,
    input           op_en,

    input           gemm_valid,
    input           gemm_finish,
    input           engine_ready,
    output          engine_valid,

    //FIFO Interface
    input           valid,
    output          rd_en,
    input  [31:0]   cmd,
    input  [6:0]    cmd_size,   //total command size received from okHost after loading memory.

    output [2:0]    op_type,
    output [3:0]    stride,     //TODO: valid check: stride < padding < kernel
    output [3:0]    kernel,
    output [7:0]    i_side,
    output [7:0]    o_side,
    output [15:0]   i_channel,
    output [15:0]   o_channel,
    output [7:0]    kernel_size,
    output [15:0]   stride2,    //kernel * stride
    output          engine_reset,
    output [2:0]    curr_state,
    output          gemm_clear,

    output          irq
);
//Notes: CMD Fifo: WR clock domain: okclk, RD clock domain: sys_clk.
//Notes: Use Img2col(MEC) Convolution

//Compressed Commands from SDRAM            |MEM-Block|---------Address---------|---Space--|---Used-Space---|
//|----------CMD TYPE----------|RESERVED|0  |---------|-------------------------|----------|----------------|
//|             op_type:  3Bit |  1Bit  |   |   Cmd   | 0x000_0000 - 0x000_007f |    128   |                |
//|              stride:  4Bit |        |   |  Weight | 0x000_1000 - 0x009_D3FF |1280k / 2 |1231552+CONVBIAS|
//|              kernel:  8Bit |        |   |  Image  | 0x00A_0000 - 0x00B_1F1B | 147k / 2 |                |
//|     input side size:  8Bit |        |   |  Outbuf | 0x00C_0000 - 0x7ff_ffff | 125M-128 |    3071416     |
//|    output side size:  8Bit |        |32 |---------|-------------------------|----------|----------------|
//|  input channel size: 16Bit |        |   |--------type-------|----op_type----|
//| output channel size: 16Bit |        |64 |IDLE               |      000      |
//|         kernel size:  8Bit |  8Bit  |   |Convolution + ReLU |      001      |
//|             stride2: 16Bit |        |96 |Max Pooling        |      100      |
//|-------Totally 256Bit-------|--------|   |Average Pooling    |      101      |

//Handshake signals to submodules
reg         engine_valid;
reg         gemm_clear;
reg         rd_en;
//Command Parsing
reg [3:0]   cmd_burst_count;

//Output Command
reg [2:0]   op_type;
reg         padding;
reg [3:0]   stride;
reg [7:0]   kernel;
reg [15:0]  i_channel, o_channel, stride2;
reg [7:0]   kernel_size, i_side, o_side;

reg [6:0]   done_cmd_count;
reg         engine_reset;

reg         irq;                        //Output, interrupt signal

//State Machine
localparam  idle = 3'b000;
localparam  cmd_get = 3'b001;           //Get commands from USB
localparam  cmd_issue = 3'b010;         //Generate engine commands
localparam  op_run = 3'b011;            //Get done signals from engine
localparam  finish = 3'b100;
// State jump triggers
reg         cmd_collect_done;
reg         cmd_issue_done;
reg         op_done;

reg [2:0]   curr_state;
reg [2:0]   next_state;
//    Current State, non-blocking
always @ (posedge clk or posedge rst)    begin
    if (rst)
        curr_state    <= idle;
    else
        curr_state    <= next_state;
end

//    Status Jump, blocking
always @ (*) begin
    next_state = idle;    //    Initialize
    case (curr_state)
        idle: begin
            if(op_en) next_state = cmd_get;
            else next_state = idle;
        end
        cmd_get: begin
            if(cmd_collect_done) next_state = cmd_issue;
            else next_state = cmd_get;
        end
        cmd_issue: begin
            if(cmd_issue_done) next_state = op_run;
            else next_state = cmd_issue;
        end
        op_run: begin
            if(op_done) begin
                if(done_cmd_count == cmd_size) next_state = finish;
                else next_state = cmd_get;
            end
            else next_state = op_run;
        end
        finish: begin
            next_state = finish;
        end
        default:
            next_state = idle;
    endcase
end

//    Output, non-blocking, Command issue, Interface with FIFO
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        cmd_burst_count <= 4'd0;
        //Commands
        op_type <= 3'd0; stride <= 4'h0; kernel <= 8'h00;
        i_channel <= 16'h0000; o_channel <= 16'h0000;
        i_side <= 8'h00; o_side <= 8'h00; kernel_size <= 8'h00; stride2 <= 16'h0000;

        done_cmd_count <= 8'd0; engine_valid <= 0;
        cmd_collect_done <= 0; cmd_issue_done <= 0; op_done <= 0;
        rd_en <= 0;
        engine_reset <= 1;
        irq <= 0; gemm_clear <= 0;
    end else begin
        case (curr_state)
            idle: begin
                cmd_burst_count <= `CMD_BURST_LEN;
            end
            cmd_get: begin
                rd_en <= 1;
                engine_reset <= 1;
                op_done <= 0;
                if(valid) begin
                    cmd_burst_count <= cmd_burst_count - 1;
                    case (cmd_burst_count) //Split cmds from fifo into separate attributes
                        4'd3: begin op_type <= cmd[2:0]; stride <= cmd[7:4]; kernel <= cmd[15:8]; i_side <= cmd[23:16]; o_side <= cmd[31:24]; end
                        4'd2: begin i_channel <= cmd[15:0]; o_channel <= cmd[31:16]; end
                        4'd1: begin kernel_size <= cmd[15:8]; stride2 <= cmd[31:16]; cmd_collect_done <= 1; rd_en <= 0; end
                        default: ;
                    endcase
                end
            end
            cmd_issue: begin
                engine_reset <= 0;
                cmd_burst_count <= `CMD_BURST_LEN;
                cmd_collect_done <= 0;
                cmd_issue_done <= 1; // start engine
            end
            op_run: begin
                cmd_issue_done <= 0; //Reset the registers in cmd_issue and wait for submodules to finish
                if(gemm_finish) engine_valid <= 0;
                if(gemm_valid) gemm_clear <= 1; 
                if(gemm_clear) begin gemm_clear <= 0; engine_valid <= 1; end
                if(engine_ready) begin
                    engine_valid <= 0;
                    done_cmd_count <= done_cmd_count + 1;
                    op_done <= 1;
                end
            end
            finish: begin
                op_done <= 0;
                irq <= 1;
            end
            default:  ;
        endcase
    end
end
    
endmodule