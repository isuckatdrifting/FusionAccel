`include "macros.vh"
module csb 
(
    input           clk,
    input           rst,
    input           op_en,

    input           engine_ready,
    output          engine_valid,

    //FIFO Interface
    input           dma_p1_ob_we,
    input  [31:0]   cmd,
    input  [6:0]    cmd_size,   //total command size received from okHost after loading memory.
    output          dma_p1_reads_en,

    output [2:0]    op_type,
    output [3:0]    stride,     //TODO: valid check: stride < padding < kernel
    output [3:0]    kernel,
    output [7:0]    i_side,
    output [7:0]    o_side,
    output [15:0]   i_channel,
    output [15:0]   o_channel,
    output [7:0]    kernel_size,
    output [7:0]    stride2,    //kernel * stride
    output [31:0]   data_start_addr,
    output [31:0]   weight_start_addr,
    output [31:0]   p0_result_start_addr,
    output [31:0]   p1_result_start_addr,
    output [7:0]    p0_padding_head,
    output [7:0]    p0_padding_body,
    output [7:0]    p1_padding_head,
    output [7:0]    p1_padding_body,
    output [1:0]    result_en,
    output          engine_reset,

    output          irq
);
//Notes: CMDs are loaded initially to SDRAM to be called multiple times.
//Notes: CMD Fifo: WR clock domain: c3clk0, RD clock domain: clk.
//Notes: Use Img2col(MEC) Convolution

//Compressed Commands from SDRAM            |MEM-Block|---------Address---------|---Space--|---Used-Space---|
//|----------CMD TYPE----------|RESERVED|0  |---------|-------------------------|----------|----------------|
//|             op_type:  3Bit |  1Bit  |   |   Cmd   | 0x000_0000 - 0x000_007f |    128   |                |
//|              stride:  4Bit |        |   |  Weight | 0x000_1000 - 0x009_D3FF |1280k / 2 |1231552+CONVBIAS|
//|              kernel:  8Bit |        |   |  Image  | 0x00A_0000 - 0x00B_1F1B | 147k / 2 |                |
//|     input side size:  8Bit |        |   |  Outbuf | 0x00C_0000 - 0x7ff_ffff | 125M-128 |    3071416     |
//|    output side size:  8Bit |        |32 |---------|-------------------------|----------|----------------|
//|  input channel size: 16Bit |        |   
//| output channel size: 16Bit |        |64            
//|         kernel size:  8Bit |  8Bit  |   |---------------------type------------------------|----op_type----|
//|             stride2: 16Bit |        |96 |IDLE                                             |      000      |
//|   weight_start_addr: 32Bit |        |128|Convolution + ReLU Activation                    |      001      |
//|     data_start_addr: 32Bit |        |160|Max Pooling                                      |      100      |
//|p0_result_start_addr: 32Bit |        |192|Average Pooling                                  |      101      |
//|p1_result_start_addr: 32Bit |        |224|-------------------------------------------------|---------------| 
//|     p0_padding_head:  8Bit |        |
//|     p0_padding_body:  8Bit |        |
//|     p1_padding_head:  8Bit |        |
//|     p1_padding_body:  8Bit |        |256
//|-------Totally 256Bit-------|--------|      

//Handshake signals to submodules
reg         engine_valid;

//Command Parsing
reg [3:0]   cmd_burst_count;
reg         dma_p1_reads_en;

//Output Command
reg [2:0]   op_type;
reg         padding;
reg [3:0]   stride;
reg [7:0]   kernel;
reg [15:0]  i_channel, o_channel;
reg [7:0]   stride2, kernel_size, i_side, o_side;
reg [31:0]  weight_start_addr;
reg [31:0]  data_start_addr;
reg [31:0]  p0_result_start_addr, p1_result_start_addr;
reg [7:0]   p0_padding_head, p0_padding_body, p1_padding_head, p1_padding_body;
reg [1:0]   result_en;

reg [6:0]   done_cmd_count;
reg         engine_reset;

reg         irq;                        //Output, interrupt signal

//State Machine
localparam  idle = 3'b000;
localparam  cmd_get = 3'b001; //Get command from SDRAM
localparam  cmd_issue = 3'b010; //Generate DMA access commands
localparam  op_run = 3'b011; //Get done signals from submodule macs
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
        i_side <= 8'h00; o_side <= 8'h00; kernel_size <= 8'h00; stride2 <= 8'h00;
        data_start_addr <= 32'h0000_0000;
        weight_start_addr <= 32'h0000_0000;
        p0_result_start_addr <= 32'h0000_0000;
        p1_result_start_addr <= 32'h0000_0000; 
        p0_padding_head <= 8'h00; p0_padding_body <= 8'h00; p1_padding_head <= 8'h00; p1_padding_body <= 8'h00;
        result_en <= 2'b00;
        dma_p1_reads_en <= 0;

        done_cmd_count <= 8'd0; engine_valid <= 0;
        cmd_collect_done <= 0; cmd_issue_done <= 0; op_done <= 0;

        engine_reset <= 1;
        irq <= 0;
    end else begin
        case (curr_state)
            idle: begin
                cmd_burst_count <= `CMD_BURST_LEN;
            end
            cmd_get: begin
                engine_reset <= 1;
                dma_p1_reads_en <= 1;
                if(dma_p1_ob_we) begin
                    cmd_burst_count <= cmd_burst_count - 1;
                end
                case (cmd_burst_count) //Split cmds from fifo into separate attributes
                    //TODO: extend commands
                    4'd8: begin op_type <= cmd[2:0]; stride <= cmd[7:4]; kernel <= cmd[15:8]; i_side <= cmd[23:16]; o_side <= cmd[31:24]; end
                    4'd7: begin i_channel <= cmd[15:0]; o_channel <= cmd[31:16]; end
                    4'd6: begin kernel_size <= cmd[7:0]; stride2 <= cmd[31:16]; end
                    4'd5: begin weight_start_addr <= cmd; end
                    4'd4: begin data_start_addr <= cmd; end
                    4'd3: begin p0_result_start_addr <= cmd; end
                    4'd2: begin p1_result_start_addr <= cmd; end
                    4'd1: begin p0_padding_head <= cmd[7:0]; p0_padding_body <= cmd[15:8]; p1_padding_head <= cmd[23:16]; p1_padding_body <= cmd[31:24]; cmd_collect_done <= 1; dma_p1_reads_en <= 0; end
                    default: ;
                endcase
                op_done <= 0;
            end
            cmd_issue: begin
                engine_reset <= 0;
                cmd_burst_count <= `CMD_BURST_LEN;
                cmd_collect_done <= 0;
                engine_valid <= 1; cmd_issue_done <= 1; // start engine
            end
            op_run: begin
                cmd_issue_done <= 0; //Reset the registers in cmd_issue and wait for submodules to finish
                if(engine_ready) begin
                    engine_valid <= 0;
                    done_cmd_count <= done_cmd_count + 1;
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