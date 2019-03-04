module scmp( //max pooling
    input  wire         clk,
    input  wire         rst,
    input  wire [15:0]  data,
    output reg  [15:0]  result,
    input  wire         pool_valid,
    input  wire         data_ready,
    output reg          data_valid,
    output reg          pool_ready
);

reg [15:0]  a_cmp, b_cmp;

wire        operation_rfd_cmp;
wire        rdy;
wire        result_cmp;

//Unordered             000100
//Less Than             001100
//Equal                 010100
//Less Than or Equal    011100
//Greater Than          100100
//Not Equal             101100
//Greater Than or Equal 110100

comparator cmp_ (.a(a_cmp), .b(b_cmp), .clk(clk), .operation(6'b100100), .operation_nd(data_ready), .operation_rfd(operation_rfd_cmp), .result(result_cmp), .rdy(rdy));

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        result <= 16'h0000;
        pool_ready <= 0;
        a_cmp <= 16'h0000;
        b_cmp <= 16'h0000;
        data_valid <= 0;
    end else begin
        data_valid <= operation_rfd_cmp;
        if(data_ready) begin 
            a_cmp <= data; 
            b_cmp <= result; 
        end
        pool_ready <= rdy;
        result <= result_cmp? a_cmp : b_cmp;
    end
end
endmodule