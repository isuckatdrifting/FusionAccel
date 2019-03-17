module cmac(
    input  wire         clk,
    input  wire         rst,
    input  wire [15:0]  data,
    input  wire [15:0]  weight,
    output reg  [15:0]  result,
    input  wire         data_ready,
    output reg          data_valid,
    output reg          conv_ready
);

reg [15:0]  a_mult, b_mult;
wire        operation_rfd_mult;
wire [15:0] result_mult;

multiplier mult_ (.a(a_mult), .b(b_mult), .clk(clk), .operation_nd(data_ready), .operation_rfd(operation_rfd_mult),
.result(result_mult), .rdy(mult_ready));

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        a_mult <= 16'h0000; b_mult <= 16'h0000;
        conv_ready <= 0;
        result <= 16'h0000;
        data_valid <= 0;
    end else begin
        data_valid <= operation_rfd_mult;
        if(data_ready) begin a_mult <= data; b_mult <= weight; end
        conv_ready <= mult_ready;
        result <= result_mult;
    end
end
endmodule