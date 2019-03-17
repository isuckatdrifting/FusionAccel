module cmac(
    input  wire         clk,
    input  wire         rst,
    input  wire [15:0]  data,
    input  wire [15:0]  weight,
    output reg  [15:0]  result,
    input  wire [15:0]  tmp_sum,
    output reg          mult_ready_buf,
    input  wire         data_ready,
    output reg          data_valid,
    output reg          conv_ready
);

reg [15:0]  a_mult, b_mult;
reg [15:0]  a_acc;
reg [15:0]  b_acc;
reg         operation_nd_acc;
wire        operation_rfd_mult, operation_rfd_acc;
wire [15:0] result_mult, result_acc;
wire         acc_ready;

multiplier mult_ (.a(a_mult), .b(b_mult), .clk(clk), .operation_nd(data_ready), .operation_rfd(operation_rfd_mult),
.result(result_mult), .rdy(mult_ready));

accum acc_ (.a(a_acc), .b(b_acc), .clk(clk), .operation_nd(operation_nd_acc), .operation_rfd(operation_rfd_acc),
.result(result_acc), .rdy(acc_ready));

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        a_acc <= 16'h0000; b_acc <= 16'h0000; 
        a_mult <= 16'h0000; b_mult <= 16'h0000;
        mult_ready_buf <= 0; conv_ready <= 0;
        operation_nd_acc <= 0;
        result <= 16'h0000;
        data_valid <= 0;
    end else begin
        data_valid <= operation_rfd_mult;
        if(data_ready) begin a_mult <= data; b_mult <= weight; end
        mult_ready_buf <= mult_ready; // sync, one cycle delay
        operation_nd_acc <= mult_ready_buf;
        if(mult_ready_buf) begin
            a_acc <= tmp_sum; b_acc <= result_mult;
        end
        conv_ready <= acc_ready;
        result <= result_acc;
    end
end
endmodule