module cmac(
    input           clk,
    input           rst,
    input  [15:0]   data,
    input  [15:0]   weight,
    output [15:0]   result,
    input           conv_valid,
    output          data_ready,
    input           data_valid,
    output          conv_ready
);

reg [15:0]  result;
reg [15:0]  a_mult, b_mult, a_acc, b_acc;
reg         conv_ready;

reg         operation_nd_acc;
wire        data_ready, operation_rfd_acc;
wire        mult_ready, acc_ready;
wire [15:0] result_mult, result_acc;

multiplier mult_ (.a(a_mult), .b(b_mult), .operation_nd(data_valid), .operation_rfd(data_ready),
.result(result_mult), .rdy(mult_ready));

accum acc_ (.a(a_acc), .b(b_acc), .operation_nd(operation_nd_acc), .operation_rfd(operation_rfd_acc),
.result(result_acc), .rdy(acc_ready));

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        result <= 0;
        conv_ready <= 0;
        operation_nd_acc <= 0;
        a_mult <= 0; b_mult <= 0;
        a_acc <= 0; b_acc <= 0;
    end else begin
        if(data_valid) begin a_mult <= data; b_mult <= weight; end
        operation_nd_acc <= mult_ready; // sync, one cycle delay
        if(operation_rfd_acc && mult_ready) begin a_acc <= result_acc; b_acc <= result_mult; end
    end
end
endmodule