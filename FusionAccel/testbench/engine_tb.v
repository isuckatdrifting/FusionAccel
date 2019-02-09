`timescale 1ns/1ps
//`define CMAC
`define SCAP

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
wire p1_data_fifo_rd_en;
reg [15:0] data_1;
wire p1_weight_fifo_rd_en;
reg [15:0] weight_1;

reg [15:0] data0_fifo [0:143];
reg [15:0] weight0_fifo [0:159];
reg [15:0] data1_fifo [0:143];
reg [15:0] weight1_fifo [0:143];
reg [169*16-1:0] pooldata;
reg data0_fifo_valid;
reg weight0_fifo_valid;

`ifdef CMAC
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
	for (j=144;j<160;j=j+1) begin weight0_fifo[j] = 16'h3c00; end
end
`endif

`ifdef SCAP
integer j;
initial begin
	pooldata = {16'h2c2d, 16'h3448, 16'h38e2, 16'h3ac4, 16'h3a69, 16'h3ad9, 16'h35b5, 16'h39d0, 16'h2e9c, 16'h2ef7, 16'h3643, 16'h3b3f, 16'h31f6,
16'h38dc, 16'h2eb3, 16'h389a, 16'h3726, 16'h2d0b, 16'h3936, 16'h3bc6, 16'h3a24, 16'h23a0, 16'h390f, 16'h36b5, 16'h354e, 16'h393c,
16'h2633, 16'h30cd, 16'h39a0, 16'h2f79, 16'h34f2, 16'h2cf8, 16'h3359, 16'h3a00, 16'h34be, 16'h3a61, 16'h36af, 16'h3b2e, 16'h2fbc,
16'h3b06, 16'h3bfa, 16'h3351, 16'h2b67, 16'h39cc, 16'h3a35, 16'h3708, 16'h3291, 16'h2eaf, 16'h2c9b, 16'h3bd9, 16'h2f82, 16'h318b,
16'h36b1, 16'h3963, 16'h39ef, 16'h3203, 16'h3933, 16'h387d, 16'h37cf, 16'h385f, 16'h31c0, 16'h3876, 16'h3872, 16'h3933, 16'h3771,
16'h3990, 16'h3463, 16'h2e40, 16'h388c, 16'h3aeb, 16'h3b6f, 16'h2c69, 16'h3127, 16'h3832, 16'h30f3, 16'h1fe0, 16'h37e0, 16'h25ca,
16'h34e0, 16'h362a, 16'h25cf, 16'h2a2f, 16'h396d, 16'h393d, 16'h3650, 16'h2c4f, 16'h360c, 16'h2783, 16'h388e, 16'h34d7, 16'h3894,
16'h36e0, 16'h3afb, 16'h38e3, 16'h30fe, 16'h3926, 16'h2bed, 16'h384d, 16'h3422, 16'h357d, 16'h380d, 16'h2de3, 16'h384a, 16'h3477,
16'h328e, 16'h38aa, 16'h3af6, 16'h30a7, 16'h2f96, 16'h302d, 16'h3886, 16'h374e, 16'h3b6c, 16'h2f6f, 16'h2ea5, 16'h3ad0, 16'h3652,
16'h3556, 16'h2c12, 16'h3992, 16'h3ad2, 16'h3aaf, 16'h379b, 16'h313d, 16'h3960, 16'h39ac, 16'h312c, 16'h34e1, 16'h392e, 16'h3903,
16'h383a, 16'h1a34, 16'h380d, 16'h336c, 16'h2835, 16'h30ed, 16'h38e7, 16'h3b67, 16'h3948, 16'h344e, 16'h3612, 16'h34a4, 16'h3961,
16'h301a, 16'h301f, 16'h37b1, 16'h3b97, 16'h329f, 16'h3bc3, 16'h3751, 16'h3a4c, 16'h3bd1, 16'h374a, 16'h3adf, 16'h3bba, 16'h2d3a,
16'h1f34, 16'h3846, 16'h306e, 16'h36a2, 16'h3646, 16'h3ba7, 16'h3791, 16'h34c2, 16'h3927, 16'h3557, 16'h38b0, 16'h3850, 16'h2037};
end
`endif

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
	.p1_data_fifo_rd_en     (p1_data_fifo_rd_en),
	.data_1                 (data_1),
	.p1_weight_fifo_rd_en   (p1_weight_fifo_rd_en),
	.weight_1               (weight_1)
	
	//Outputs directly back to dma
);

always #5 clk = ~clk;
`ifdef CMAC
integer m,n;
initial begin
    rst = 1;
    clk = 0;
    m = 0;
	n = 0;
    op_num = 0;
    conv_ready = 0;
    op_type = 0;
	data0_fifo_valid = 0;
	weight0_fifo_valid = 0;
	data_0 <= 16'h0000;
	weight_0 <= 16'h0000;
    #20 rst = 1;
    #10 rst = 0;
    #100 op_num = 9; op_type = 2;
    #10 conv_ready = 1; 

end

always @(posedge conv_valid) conv_ready <= 0;

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
`endif

`ifdef SCAP
reg [15:0] m;
initial begin
    rst = 1;
    clk = 0;
    m = 0;
    op_num = 0;
    avepool_ready = 0;
    op_type = 0;
	data0_fifo_valid = 0;
	data_0 <= 16'h0000;
    #20 rst = 1;
    #10 rst = 0;
    #100 op_num = 169; op_type = 5;
    #10 avepool_ready = 1; 
end

always @(posedge avepool_valid) avepool_ready <= 0;

always @(posedge clk) begin
	if(avepool_ready) begin
		if(p0_data_fifo_rd_en) begin 
			data0_fifo_valid <= 1;
			data_0 <= pooldata[15:0]; 
			pooldata <= pooldata >> 16;
		end else data0_fifo_valid <= 0;
	end
end
`endif
endmodule