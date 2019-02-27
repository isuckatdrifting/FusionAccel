`timescale 1ns/1ns 
`define FFD 1
module cmac(
    input           clk,
    input           rst,
    input           rst_acc,
    input  [15:0]   data,
    input  [15:0]   weight,
    output [15:0]   result,
    input           tmp_sum,
    input           conv_valid,
    input           data_ready,
    output          data_valid,
    output          conv_ready
);

reg [15:0]  a_mult, b_mult;
reg [15:0]  a_acc, b_acc;
wire         acc_ready;

wire         operation_nd_acc;
wire        operation_rfd_mult, operation_rfd_acc;
reg        mult_ready_buf, conv_ready;
wire [15:0] result_mult, result;

multiplier mult_ (.a(a_mult), .b(b_mult), .operation_nd(data_ready), .operation_rfd(data_valid),
.result(result_mult), .rdy(mult_ready));

accum acc_ (.a(a_acc), .b(b_acc), .operation_nd(operation_nd_acc), .operation_rfd(operation_rfd_acc),
.result(result), .rdy(acc_ready));

assign operation_nd_acc = mult_ready_buf;

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        a_acc <= 0; b_acc <= 0;
        a_mult <= 0; b_mult <= 0;
        mult_ready_buf <= 0; conv_ready <= 0;
    end else begin
        if(data_valid) begin a_mult <= data; b_mult <= weight; end
        mult_ready_buf <= #`FFD mult_ready; // sync, one cycle delay
        if(operation_nd_acc) begin a_acc <= rst_acc?0:result; b_acc <= result_mult; end
        conv_ready <= #`FFD acc_ready;
    end
end
endmodule