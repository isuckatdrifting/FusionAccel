module sacc( // average pooling
    input           clk,
    input           rst,
    input  [15:0]   data,
    output [15:0]   result,
    input           pool_valid,
    output          acc_ready,
    output          data_ready,
    input           data_valid,
    output          pool_ready
);

reg [15:0] result;
reg [15:0] a_div, b_div, a_acc, b_acc;
reg pool_ready;

reg         operation_nd_div;
wire        operation_rfd_div;
wire        acc_ready, div_ready;
wire [15:0] result_div, result_acc;

accum acc_ (.a(a_acc), .b(b_acc), .operation_nd(data_valid), .operation_rfd(data_ready), .result(result_acc), .rdy(acc_ready));

divider div_(.a(a_div), .b(b_div), .operation_nd(operation_nd_div), .operation_rfd(operation_rfd_div), .result(result_div), .rdy(div_ready));

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        operation_nd_div <= 1'b0;
        result <= 0;
        pool_ready <= 0;
        a_div <= 0;
        b_div <= 16'h3c00;
        a_acc <= 0; b_acc <= 0;
    end else begin
        if(data_valid) begin a_acc <= result_acc; b_acc <= data; end
        operation_nd_div <= acc_ready; // sync, one cycle delay
        if(operation_rfd_div && acc_ready) begin a_div <= result_acc; b_div <= 16'h5948; end //196:5a20, 169:5948
    end
end
endmodule