module cmac(
    input           clk,
    input           rst,
    input  [15:0]   data,
    input  [15:0]   weight,
    output [15:0]   result,
    input  [15:0]   tmp_sum,
    input           conv_valid,
    input           data_ready,
    output          data_valid,
    output          conv_ready
);

reg [15:0]  a_mult, b_mult;
reg [15:0]  a_acc;
wire [15:0] b_acc;
wire         acc_ready;

wire         operation_nd_acc;
wire        operation_rfd_mult, operation_rfd_acc;
reg        mult_ready_buf, conv_ready;
wire [15:0] result_mult, result_acc;
reg  [15:0] result;

multiplier mult_ (.a(a_mult), .b(b_mult), .clk(clk), .operation_nd(data_ready), .operation_rfd(data_valid),
.result(result_mult), .rdy(mult_ready));

accum acc_ (.a(a_acc), .b(b_acc), .clk(clk), .operation_nd(operation_nd_acc), .operation_rfd(operation_rfd_acc),
.result(result_acc), .rdy(acc_ready));

assign b_acc = result_mult;
assign operation_nd_acc = mult_ready_buf;

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        a_acc <= 16'h0000; 
        a_mult <= 16'h0000; b_mult <= 16'h0000;
        mult_ready_buf <= 0; conv_ready <= 0;
        result <= 16'h0000;
    end else begin
        if(data_ready) begin a_mult <= data; b_mult <= weight; a_acc <= tmp_sum; end
        mult_ready_buf <= mult_ready; // sync, one cycle delay
        conv_ready <= acc_ready;
        result <= result_acc;
    end
end
endmodule