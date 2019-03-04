module sacc( // average pooling
    input  wire         clk,
    input  wire         rst,
    input  wire [15:0]  tmp_sum,
    input  wire [15:0]  data,
    output reg  [15:0]  result,
    input  wire         pool_valid,
    input  wire         data_ready,
    output reg          data_valid,
    output reg          sum_ready,
    input  wire         div_en,
    output reg          pool_ready
);

reg [15:0] a_div, b_div, a_acc, b_acc;

reg         operation_nd_div;
wire        operation_rfd_acc, operation_rfd_div;
wire        acc_ready, div_ready;
wire [15:0] result_div, result_acc;

accum acc_ (.a(a_acc), .b(b_acc), .clk(clk), .operation_nd(data_ready), .operation_rfd(operation_rfd_acc), .result(result_acc), .rdy(acc_ready));

divider div_(.a(a_div), .b(b_div), .clk(clk), .operation_nd(operation_nd_div), .operation_rfd(operation_rfd_div), .result(result_div), .rdy(div_ready));

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        operation_nd_div <= 1'b0;
        result <= 16'h0000;
        sum_ready <= 0; pool_ready <= 0;
        a_div <= 16'h0000; b_div <= 16'h3c00;
        a_acc <= 16'h0000; b_acc <= 16'h0000;
        data_valid <= 0;
    end else begin
        data_valid <= operation_rfd_acc;
        if(data_ready) begin a_acc <= tmp_sum; b_acc <= data; end
        operation_nd_div <= div_en; // sync, one cycle delay
        if(operation_rfd_div) begin a_div <= data; b_div <= 16'h5948; end //196:5a20, 169:5948
        sum_ready <= acc_ready;
        pool_ready <= div_ready;
    end
end
endmodule