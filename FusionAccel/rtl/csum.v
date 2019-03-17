`include "macros.vh"
module csum(
    input wire          clk,
    input wire       rst,
    input wire          fifo_empty,
    output reg         reads_en,
    input  wire [7:0]   kernel_size,
    input  wire [15:0]   data,
    input  wire         data_ready,
    output reg          data_valid,
    output reg [15:0]   csum_result,
    output reg          csum_ready
);

reg [15:0]  a_acc, b_acc;
reg         operation_nd_acc;
wire [15:0] result_acc;
wire        operation_rfd_acc;
wire         acc_ready;
reg [7:0] count;

accum acc_ (.a(a_acc), .b(b_acc), .clk(clk), .operation_nd(data_ready), .operation_rfd(operation_rfd_acc),
.result(result_acc), .rdy(acc_ready));

localparam idle 		= 0;
localparam busy         = 1;

reg [1:0] curr_state;
reg [1:0] next_state;

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
            if(!fifo_empty) next_state = busy;
            else next_state = idle;
        end
		busy: begin
            if(csum_ready) next_state = idle;
            else next_state = busy;
        end
    endcase
end

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        a_acc <= 16'h0000; b_acc <= 16'h0000; 
        csum_ready <= 0;
        //operation_nd_acc <= 0;
        csum_result <= 16'h0000;
        data_valid <= 0;
        count <= 0;
        reads_en <= 0;
    end else begin
        case(curr_state)
            idle: begin
                if(!fifo_empty) reads_en <= 1;     
                csum_ready <= 0;           
            end
            busy: begin
                data_valid <= operation_rfd_acc;
                if(reads_en) reads_en <= 0;
                if(data_ready) begin 
                    if(count == 0) begin
                        a_acc <= 0; b_acc <= data; 
                    end else begin
                        a_acc <= result_acc; b_acc <= data;
                    end
                end
                if(acc_ready) begin
                    if(count + 1 < kernel_size) begin
                        count <= count + 1;
                        reads_en <= 1;
                    end else begin
                        count <= 0;
                        csum_ready <= 1;
                    end
                end
                if(csum_ready) csum_result <= result_acc;
            end
        endcase
    end
end
endmodule