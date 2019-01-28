//Instantiate 16CMACs for conv3x3, 16CMACs for conv1x1, maxpool and avepool in engine.
module engine(
	input clk,
	input rst,
	//Control signals from csb
	input conv_ready,
	input maxpool_ready,
	input avepool_ready,
	input [2:0] op_type,
	input [31:0] op_num,

	output conv_valid,
	output maxpool_valid,
	output avepool_valid,

	//Data path from dma -> fifos
	input [15:0] data_0,
	input [15:0] weight_0,
	input [15:0] bias_0,
	input [15:0] data_1,
	input [15:0] weight_1,
	input [15:0] bias_1
	
	//Outputs directly back to dma
);

localparam PARA = 16;
localparam CONV1 = 1;
localparam CONV3 = 2;
localparam CONVP = 3;
localparam MPOOL = 4;
localparam APOOL = 5;

reg conv_ready_0;
reg conv_ready_1;
wire [PARA-1:0] rdy_acc_0;
wire [PARA-1:0] rdy_acc_1;
wire [PARA-1:0] conv_valid_0;
wire [PARA-1:0] conv_valid_1;

reg [15:0] d0, w0, b0, d1, w1, b1, mp, ap;
wire [15:0] result_0 [0:15];
wire [15:0] result_1 [0:15];

//Generate 16CMACs for CONV3x3
//TODO: CMACs start one by one, using the same data path. weight is enabled according to sel.
genvar i;
generate 
	for (i = 0; i < 16; i = i + 1) begin
		cmac cmac_0(.clk(clk), .rst(rst), .data(d0), .weight(w0), .bias(b0), .result(result_0[i]), .conv_ready(conv_ready_0), .op_num(op_num), .rdy_acc(rdy_acc_0[i]), .conv_valid(conv_valid_0[i]));
	end 
endgenerate

//Generate 16CMACs for CONV1x1
genvar j;
generate 
	for (j = 0; j < 16; j = j + 1) begin
		cmac cmac_1(.clk(clk), .rst(rst), .data(d1), .weight(w1), .bias(b1), .result(result_1[j]), .conv_ready(conv_ready_1), .op_num(op_num), .rdy_acc(rdy_acc_1[j]), .conv_valid(conv_valid_1[j]));
	end 
endgenerate

//Instantiate MAXPOOL
//------------------------------------------------
// Bitonic 3x3 Max Pooling Core
//------------------------------------------------
pool_3x3 pool_3x3_(
    .clk		(sys_clk),
    .rst_n		(~rst),
    .im			(mp),					//Input Matrix 3x3 [143:0]
    .om			(),					//Output Matrix 1x1[15:0]
    .pool_ready	(maxpool_ready),
    .pool_valid	(maxpool_valid));

//Instantiate AVEPOOL
//------------------------------------------------
// Pipeline 13x13 Average Pooling Core
//------------------------------------------------
pool_13x13 pool_13x13_(
    .clk		(sys_clk),
    .rst_n		(~rst),
    .im			(ap),					//Input Matrix 13x13[2703:0]
    .om			(),					//Output Matrix 1x1 [15:0]
    .pool_ready	(avepool_ready),
    .pool_valid	(avepool_valid));

//Synchronous Port 0 MUX logic
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		d0 <= 16'h0000; w0 <= 16'h0000; b0 <= 16'h0000;
		d1 <= 16'h0000; w1 <= 16'h0000; b1 <= 16'h0000;
	end else begin
		if(conv_ready) begin
			case (op_type)
			  CONV1: begin conv_ready_1 <= 1; end
			  CONV3: begin conv_ready_0 <= 1; end
			  CONVP: begin conv_ready_0 <= 1; conv_ready_1 <= 1; end
			  default: ;
			endcase
		end
		if(maxpool_ready) begin
			mp <= data_0;
		end
		if(avepool_ready) begin
			ap <= data_0;
		end
	end
end

//Merged Wire out to csb
endmodule
