`include "macros.vh"
module csb 
(
    input           clk,
    input           rst,
    input           op_en,
    //FIFO Interface
    input           valid,
    output          rd_en,
    input  [31:0]   cmd,
    output [2:0]    op_type,
    output [3:0]    stride,     //TODO: valid check: stride < padding < kernel
    output [3:0]    kernel,
    output [7:0]    i_side,
    output [7:0]    o_side,
    output [15:0]   i_channel,
    output [15:0]   o_channel,
    output [7:0]    kernel_size,
    output [15:0]   stride2,    //kernel * stride
    output [2:0]    curr_state
);
//Notes: CMD Fifo: WR clock domain: okclk, RD clock domain: sys_clk.
//Notes: Use Img2col(MEC) Convolution
//|----------CMD TYPE----------|RESERVED|0  |-------type------|--op_type--|
//|             op_type:  3Bit |  1Bit  |   |IDLE             |    000    |
//|              stride:  4Bit |        |   |Convolution+ReLU |    001    |
//|              kernel:  8Bit |        |   |Max Pooling      |    100    |
//|     input side size:  8Bit |        |   |Average Pooling  |    101    |
//|    output side size:  8Bit |        |32 |-----------------|-----------|
//|  input channel size: 16Bit |        |   
//| output channel size: 16Bit |        |64 
//|         kernel size:  8Bit |  8Bit  |   
//|             stride2: 16Bit |        |96 
//|-------Totally  96Bit-------|--------|   

reg         rd_en;
reg [3:0]   cmd_burst_count;

//Output Command
reg [2:0]   op_type;
reg         padding;
reg [3:0]   stride;
reg [7:0]   kernel;
reg [15:0]  i_channel, o_channel, stride2;
reg [7:0]   kernel_size, i_side, o_side;

//State Machine
localparam  idle = 3'b000;
localparam  cmd_get = 3'b010;           //Get commands from USB
localparam  op_run = 3'b100;            //Get done signals from engine

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
            if(cmd_burst_count == `CMD_BURST_LEN-1) next_state = op_run;
            else next_state = cmd_get;
        end
        op_run: begin
            next_state = op_run;
        end
        default: next_state = idle;
    endcase
end

//    Output, non-blocking, Command issue, Interface with FIFO
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        rd_en <= 0;
        cmd_burst_count <= 4'd0;
        op_type <= 3'd0; stride <= 4'h0; kernel <= 8'h00;
        i_channel <= 16'h0000; o_channel <= 16'h0000;
        i_side <= 8'h00; o_side <= 8'h00; kernel_size <= 8'h00; stride2 <= 16'h0000;
    end else begin
        case (curr_state)
            idle: begin
                cmd_burst_count <= 0;
            end
            cmd_get: begin
                if(cmd_burst_count + 1 == `CMD_BURST_LEN) begin 
                    rd_en <= 0;
                end else rd_en <= 1;
                if(valid) begin
                    cmd_burst_count <= cmd_burst_count + 1;
                    case (cmd_burst_count) //Split cmds from fifo into separate attributes
                        4'd0: begin op_type <= cmd[2:0]; stride <= cmd[7:4]; kernel <= cmd[15:8]; i_side <= cmd[23:16]; o_side <= cmd[31:24]; end
                        4'd1: begin i_channel <= cmd[15:0]; o_channel <= cmd[31:16]; rd_en <= 0; end
                        4'd2: begin kernel_size <= cmd[15:8]; stride2 <= cmd[31:16]; end
                        default: ;
                    endcase
                end
            end
            op_run: begin
                cmd_burst_count <= 0;
            end
            default:  ;
        endcase
    end
end
    
endmodule