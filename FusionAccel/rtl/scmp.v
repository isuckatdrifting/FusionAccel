module scmp( //max pooling
    input           clk,
    input           rst,
    input [15:0]    data,
    output [15:0]   result,
    input           pool_valid,
    output          cmp_ready,
    output          data_ready,
    input           data_valid,
    output          pool_ready
);

reg [15:0]  result;
reg [15:0]  a_cmp, b_cmp;
reg         pool_ready;

wire        cmp_ready;
wire        result_cmp;
wire [15:0]  tmp;

//Unordered             000100
//Less Than             001100
//Equal                 010100
//Less Than or Equal    011100
//Greater Than          100100
//Not Equal             101100
//Greater Than or Equal 110100

comparator cmp_ (.a(a_cmp), .b(b_cmp), .operation(6'b100100), .operation_nd(data_valid), .operation_rfd(data_ready), .result(result_cmp), .rdy(cmp_ready));

assign tmp = result_cmp? a_cmp : b_cmp;
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        result <= 0;
        pool_ready <= 0;
        a_cmp <= 0;
        b_cmp <= 0;
    end else begin
        if(data_valid) begin 
            a_cmp <= data; 
            b_cmp <= tmp; 
        end
    end
end
endmodule