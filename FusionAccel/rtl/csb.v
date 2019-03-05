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
    output          padding,
    output [3:0]    stride,     //TODO: valid check: stride < padding < kernel
    output [3:0]    kernel,
    output [7:0]    stride2,    //kernel * stride
    output [15:0]   i_channel,
    output [15:0]   o_channel,
    output [7:0]    kernel_size,
    output [7:0]    i_side,
    output [7:0]    o_side,
    output [31:0]   data_start_addr,
    output [31:0]   weight_start_addr,
    output [31:0]   result_start_addr,
    output          engine_reset,

    output          irq
);
//Notes: CMDs are loaded initially to SDRAM to be called multiple times.
//Notes: CMD Fifo: WR clock domain: c3clk0, RD clock domain: clk.
//Notes: Use Img2col(MEC) Convolution

//Compressed Commands from SDRAM    |MEM-Block|---------Address---------|---Space--|---Used-Space---|
//|----------CMD TYPE----------|    |---------|-------------------------|----------|----------------|
//|        op_type:  3Bit(1Bit)|    |   Cmd   | 0x000_0000 - 0x000_007f |    128   |                |
//|    padding = 1:  1Bit(3Bit)|    |  Weight | 0x000_1000 - 0x009_D3FF |1280k / 2 |1231552+CONVBIAS|
//|         stride:  4Bit(4Bit)|    |  Image  | 0x00A_0000 - 0x00B_1F1B | 147k / 2 |                |
//|         kernel size:  8Bit |    |  Outbuf | 0x00C_0000 - 0x7ff_ffff | 125M-128 |    3071416     |
//|  input channel size: 16Bit |    |---------|-------------------------|----------|----------------|
//| output channel size: 16Bit |    
//|     input side size:  8Bit |(16)|---------------------type------------------------|----op_type----|
//|    output side size:  8Bit |    |IDLE                                             |      000      |
//|   weight_start_addr: 32Bit |    |Convolution + ReLU Activation                    |      001      |
//|     data_start_addr: 32Bit |    |Max Pooling                                      |      100      |
//|  write_back_address: 32Bit |    |Average Pooling                                  |      101      |
//|-------Totally 192Bit-------|    |-------------------------------------------------|---------------|    

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
reg [31:0]  result_start_addr;

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
        op_type <= 3'd0; stride <= 4'h0; padding <= 1'b0; kernel <= 8'h00;
        i_channel <= 16'h0000; o_channel <= 16'h0000;
        i_side <= 8'h00; o_side <= 8'h00; kernel_size <= 8'h00; stride2 <= 8'h00;
        data_start_addr <= 32'h0000_0000;
        weight_start_addr <= 32'h0000_0000;
        result_start_addr <= 32'h0000_0000;
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
                    4'd6: begin op_type <= cmd[2:0]; padding <= cmd[4]; stride <= cmd[11:8]; kernel <= cmd[23:16]; end
                    4'd5: begin i_channel <= cmd[15:0]; o_channel <= cmd[31:16]; end
                    4'd4: begin i_side <= cmd[7:0]; o_side <= cmd[15:8]; kernel_size <= cmd[23:16]; stride2 <= cmd[31:24]; end
                    4'd3: begin weight_start_addr <= cmd; end
                    4'd2: begin data_start_addr <= cmd; end
                    4'd1: begin result_start_addr <= cmd; cmd_collect_done <= 1; dma_p1_reads_en <= 0; end
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