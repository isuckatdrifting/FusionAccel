module scmp( //max pooling
    input  wire         clk,
    input  wire         rst,
    input  wire [15:0]  new_data,
    input  wire [15:0]  ori_data,
    output reg          result,
    input  wire         data_ready,
    output reg          data_valid,
    output reg          pool_ready
);

reg [15:0]  a_cmp, b_cmp;

reg         operation_nd_cmp;
wire        operation_rfd_cmp;
wire        rdy;
wire        result_cmp;

// Output is high if a > b

comparator cmp_ (.a(a_cmp), .b(b_cmp), .clk(clk), .operation_nd(operation_nd_cmp), .operation_rfd(operation_rfd_cmp), .result(result_cmp), .rdy(rdy));

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        operation_nd_cmp <= 0;
        result <= 16'h0000;
        pool_ready <= 0;
        a_cmp <= 16'h0000; b_cmp <= 16'h0000;
        data_valid <= 0;
    end else begin
        data_valid <= operation_rfd_cmp;
        operation_nd_cmp <= data_ready;
        if(data_ready) begin a_cmp <= new_data; b_cmp <= ori_data; end
        pool_ready <= rdy;
        result <= result_cmp;
    end
end
endmodule