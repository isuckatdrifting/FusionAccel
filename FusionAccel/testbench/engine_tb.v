`timescale 1ns/1ps
module engine_tb;

reg clk;
reg rst;
reg conv_ready;
reg maxpool_ready;
reg avepool_ready;
reg [2:0] op_type;
reg [31:0] op_num;

wire conv_valid;
wire maxpool_valid;
wire avepool_valid;

wire p0_data_fifo_rd_en;
reg [15:0] data_0;
wire p0_weight_fifo_rd_en;
reg [15:0] weight_0;
reg [15:0] bias_0;
wire p1_data_fifo_rd_en;
reg [15:0] data_1;
wire p1_weight_fifo_rd_en;
reg [15:0] weight_1;
reg [15:0] bias_1;

reg [15:0] data0_fifo [0:143];
reg [15:0] weight0_fifo [0:143];
reg [15:0] data1_fifo [0:143];
reg [15:0] weight1_fifo [0:143];
reg data0_fifo_valid;
reg weight0_fifo_valid;

integer j;
initial begin
    for (j=0;j<16;j=j+1) begin data0_fifo[j] = 16'h3c00; weight0_fifo[j] = 16'h3c00; end
    for (j=16;j<32;j=j+1) begin data0_fifo[j] = 16'h4000; weight0_fifo[j] = 16'h4000; end
    for (j=32;j<48;j=j+1) begin data0_fifo[j] = 16'h4200; weight0_fifo[j] = 16'h4200; end
    for (j=48;j<64;j=j+1) begin data0_fifo[j] = 16'h4400; weight0_fifo[j] = 16'h4400; end
    for (j=64;j<80;j=j+1) begin data0_fifo[j] = 16'h4500; weight0_fifo[j] = 16'h4500; end
    for (j=80;j<96;j=j+1) begin data0_fifo[j] = 16'h4600; weight0_fifo[j] = 16'h4600; end
    for (j=96;j<112;j=j+1) begin data0_fifo[j] = 16'h4700; weight0_fifo[j] = 16'h4700; end
    for (j=112;j<128;j=j+1) begin data0_fifo[j] = 16'h4800; weight0_fifo[j] = 16'h4800; end
    for (j=128;j<144;j=j+1) begin data0_fifo[j] = 16'h4880; weight0_fifo[j] = 16'h4880; end
end

engine engine_(
	.clk                    (clk),
	.rst                    (rst),
	//Control signals from csb
	.conv_ready             (conv_ready),
	.maxpool_ready          (maxpool_ready),
	.avepool_ready          (avepool_ready),
	.op_type                (op_type),
	.op_num                 (op_num),

	.conv_valid             (conv_valid),
	.maxpool_valid          (maxpool_valid),
	.avepool_valid          (avepool_valid),

	//Data path from dma -> fifos
	.p0_data_fifo_rd_en     (p0_data_fifo_rd_en),
	.data_0                 (data_0),
	.p0_weight_fifo_rd_en   (p0_weight_fifo_rd_en),
	.weight_0               (weight_0),
	.bias_0                 (bias_0),
	.p1_data_fifo_rd_en     (p1_data_fifo_rd_en),
	.data_1                 (data_1),
	.p1_weight_fifo_rd_en   (p1_weight_fifo_rd_en),
	.weight_1               (weight_1),
	.bias_1                 (bias_1)
	
	//Outputs directly back to dma
);

always #5 clk = ~clk;
integer m,n;
initial begin
    rst = 1;
    clk = 0;
    m = 0;
	n = 0;
    op_num = 0;
    conv_ready = 0;
    op_type = 0;
    #20 rst = 1;
    #10 rst = 0;
    #100 op_num = 9; op_type = 2;
    #10 conv_ready = 1; 

end

always @(posedge clk) begin
	if(conv_ready) begin
		if(p0_data_fifo_rd_en) begin 
			data0_fifo_valid <= 1;
			data_0 <= data0_fifo[m]; 
			m <= m + 1; 
		end else data0_fifo_valid <= 0;
		if(p0_weight_fifo_rd_en) begin 
			weight0_fifo_valid <= 1;
			weight_0 <= weight0_fifo[n]; 
			n <= n + 1; 
		end else weight0_fifo_valid <= 0;
	end
end
endmodule