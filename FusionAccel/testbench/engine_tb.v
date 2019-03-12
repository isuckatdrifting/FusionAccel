`timescale 1ns/1ps
`define CMAC
//`define SACC
//`define SCMP

module engine_tb;

reg 		clk;
//Control signals csb->engine
reg 		rst;
reg 		engine_valid;
reg [2:0] 	op_type;
reg	[3:0]	stride;
reg [15:0]  stride2;
reg [7:0]  	kernel;
reg [7:0]	kernel_size;
reg [15:0]  i_channel;
reg [15:0]  o_channel;
reg [7:0]	i_side;
reg [7:0]   o_side;
reg	[15:0]  bias;
//Response signals engine->csb
wire		gemm_finish;
wire 		engine_ready;
//Command path engine->dma
wire        dma_p0_writes_en;
wire        dma_p2_reads_en;
wire        dma_p3_reads_en;
//Data path dma->engine
reg [15:0] 	dma_p2_ob_data;
reg [15:0] 	dma_p3_ob_data;
reg 		dma_p2_ob_we;
reg 		dma_p3_ob_we;
//Data path engine->dma
wire [15:0]	dma_p0_ib_data;

`ifdef CMAC
	reg [15:0] data [0:95];
	reg [15:0] weight [0:72];
	initial begin
	data[0] = 16'hce83; data[1] = 16'h4f98; data[2] = 16'h4e17; data[3] = 16'h0000; 
	data[4] = 16'h0000; data[5] = 16'h0000; data[6] = 16'h0000; data[7] = 16'h0000; 
	data[8] = 16'hce24; data[9] = 16'h5087; data[10] = 16'h4F8D; data[11] = 16'h0000; 
	data[12] = 16'h0000; data[13] = 16'h0000; data[14] = 16'h0000; data[15] = 16'h0000; 
	data[16] = 16'hCCEF; data[17] = 16'h51FB; data[18] = 16'h50DE; data[19] = 16'h0000;
	data[20] = 16'h0000; data[21] = 16'h0000; data[22] = 16'h0000; data[23] = 16'h0000;

	data[24] = 16'hCDE5; data[25] = 16'h5087; data[26] = 16'h4F10; data[27] = 16'h0000; 
	data[28] = 16'h0000; data[29] = 16'h0000; data[30] = 16'h0000; data[31] = 16'h0000; 
	data[32] = 16'hCFEB; data[33] = 16'h4FA7; data[34] = 16'h4DA9; data[35] = 16'h0000; 
	data[36] = 16'h0000; data[37] = 16'h0000; data[38] = 16'h0000; data[39] = 16'h0000;
	data[40] = 16'hD035; data[41] = 16'h5050; data[42] = 16'h4E61; data[43] = 16'h0000; 
	data[44] = 16'h0000; data[45] = 16'h0000; data[46] = 16'h0000; data[47] = 16'h0000;

	data[48] = 16'hD0A0; data[49] = 16'h4E32; data[50] = 16'h4C33; data[51] = 16'h0000; 
	data[52] = 16'h0000; data[53] = 16'h0000; data[54] = 16'h0000; data[55] = 16'h0000; 
	data[56] = 16'hD151; data[57] = 16'h4D6D; data[58] = 16'h49E7; data[59] = 16'h0000;
	data[60] = 16'h0000; data[61] = 16'h0000; data[62] = 16'h0000; data[63] = 16'h0000; 
	data[64] = 16'hD157; data[65] = 16'h4E9C; data[66] = 16'h4BC3; data[67] = 16'h0000; 
	data[68] = 16'h0000; data[69] = 16'h0000; data[70] = 16'h0000; data[71] = 16'h0000; 
	
	data[72] = 16'hd2b2; data[73] = 16'h4bef; data[74] = 16'h5e40; data[75] = 16'h0000; 
	data[76] = 16'h0000; data[77] = 16'h0000; data[78] = 16'h0000; data[79] = 16'h0000; 
	data[80] = 16'hd1fc; data[81] = 16'h4d8b; data[82] = 16'h482d; data[83] = 16'h0000;
	data[84] = 16'h0000; data[85] = 16'h0000; data[86] = 16'h0000; data[87] = 16'h0000; 
	data[88] = 16'hd1db; data[89] = 16'h4e52; data[90] = 16'h49b4; data[91] = 16'h0000;
	data[92] = 16'h0000; data[93] = 16'h0000; data[94] = 16'h0000; data[95] = 16'h0000; 

	weight[0] = 16'h341E; weight[1] = 16'h3867; weight[2] = 16'h3509; weight[3] = 16'h0000;
	weight[4] = 16'h0000; weight[5] = 16'h0000; weight[6] = 16'h0000; weight[7] = 16'h0000;
	weight[8] = 16'hAE6E; weight[9] = 16'hB0BF;	weight[10] = 16'hB0F7; weight[11] = 16'h0000;
	weight[12] = 16'h0000; weight[13] = 16'h0000; weight[14] = 16'h0000; weight[15] = 16'h0000;
	weight[16] = 16'hAC84; weight[17] = 16'hB2B4; weight[18] = 16'hAF54; weight[19] = 16'h0000;
	weight[20] = 16'h0000; weight[21] = 16'h0000; weight[22] = 16'h0000; weight[23] = 16'h0000;

	weight[24] = 16'h35C0; weight[25] = 16'h396D; weight[26] = 16'h36E1; weight[27] = 16'h0000;
	weight[28] = 16'h0000; weight[29] = 16'h0000; weight[30] = 16'h0000; weight[31] = 16'h0000;
	weight[32] = 16'hB10F; weight[33] = 16'hB456; weight[34] = 16'hB2C4; weight[35] = 16'h0000;
	weight[36] = 16'h0000; weight[37] = 16'h0000; weight[38] = 16'h0000; weight[39] = 16'h0000;
	weight[40] = 16'hB209; weight[41] = 16'hB76D; weight[42] = 16'hB3F0; weight[43] = 16'h0000;
	weight[44] = 16'h0000; weight[45] = 16'h0000; weight[46] = 16'h0000; weight[47] = 16'h0000;

	weight[48] = 16'h3282; weight[49] = 16'h376F; weight[50] = 16'h3504; weight[51] = 16'h0000;
	weight[52] = 16'h0000; weight[53] = 16'h0000; weight[54] = 16'h0000; weight[55] = 16'h0000;
	weight[56] = 16'hAE46; weight[57] = 16'hB1E7; weight[58] = 16'hACF0; weight[59] = 16'h0000;
	weight[60] = 16'h0000; weight[61] = 16'h0000; weight[62] = 16'h0000; weight[63] = 16'h0000;
	weight[64] = 16'hB249; weight[65] = 16'hB72B; weight[66] = 16'hB338; weight[67] = 16'h0000;
	weight[68] = 16'h0000; weight[69] = 16'h0000; weight[70] = 16'h0000; weight[71] = 16'h0000;
	end
`endif
`ifdef SACC
	reg [169*16-1:0] avepooldata;
	initial begin
		avepooldata = {16'h3757, 16'h39da, 16'h3b67, 16'h3376, 16'h3bb5, 16'h30da, 16'h3b8a, 16'h2675, 16'h3454, 16'h2d3e, 16'h39d1, 16'h3614, 16'h36dd,
	16'h304e, 16'h3023, 16'h3b02, 16'h3367, 16'h3b9d, 16'h32ff, 16'h387e, 16'h384d, 16'h3812, 16'h3bad, 16'h3587, 16'h33f5, 16'h3ab1,
	16'h3945, 16'h3625, 16'h2f8f, 16'h39de, 16'h367c, 16'h287c, 16'h354f, 16'h2d21, 16'h39a8, 16'h382e, 16'h3b5c, 16'h3ba0, 16'h39cd,
	16'h3a0c, 16'h2e91, 16'h38cb, 16'h2bc9, 16'h3872, 16'h3173, 16'h37b0, 16'h32da, 16'h3b5a, 16'h380e, 16'h3892, 16'h3988, 16'h390d,
	16'h38e9, 16'h3a7c, 16'h3a78, 16'h3a50, 16'h3894, 16'h397d, 16'h314d, 16'h2c73, 16'h304c, 16'h3774, 16'h36ca, 16'h3512, 16'h3b17,
	16'h363f, 16'h3721, 16'h3489, 16'h2fe5, 16'h34c6, 16'h3aaf, 16'h37b1, 16'h38e3, 16'h36e3, 16'h3942, 16'h3bbe, 16'h39ac, 16'h3873,
	16'h37c1, 16'h340b, 16'h3b26, 16'h3b70, 16'h372c, 16'h36f3, 16'h3bd5, 16'h3a3a, 16'h339e, 16'h3821, 16'h33f5, 16'h3858, 16'h3bf0,
	16'h3beb, 16'h3b73, 16'h3a1c, 16'h3a83, 16'h3bb2, 16'h3808, 16'h39c7, 16'h3b72, 16'h39cf, 16'h2a93, 16'h3402, 16'h39d8, 16'h3974,
	16'h3483, 16'h3b46, 16'h3af9, 16'h38ad, 16'h3933, 16'h30de, 16'h305e, 16'h2fdb, 16'h3ad9, 16'h3ad2, 16'h39fa, 16'h2ae8, 16'h32b6,
	16'h3596, 16'h3b5e, 16'h329c, 16'h2da6, 16'h3a5a, 16'h3562, 16'h3a02, 16'h3a38, 16'h354e, 16'h3b19, 16'h3976, 16'h383c, 16'h29d8,
	16'h3a29, 16'h3a08, 16'h3301, 16'h386f, 16'h2a75, 16'h37cf, 16'h3267, 16'h30e1, 16'h3967, 16'h388a, 16'h397b, 16'h3ab4, 16'h3999,
	16'h3899, 16'h378f, 16'h394b, 16'h3554, 16'h3723, 16'h3880, 16'h327a, 16'h3a9b, 16'h383c, 16'h3936, 16'h387d, 16'h34c5, 16'h3782,
	16'h3a3f, 16'h3b8c, 16'h3156, 16'h3ba7, 16'h3b97, 16'h2e65, 16'h3194, 16'h32d6, 16'h3572, 16'h3889, 16'h3aa1, 16'h36d4, 16'h2cc5}; //16'h558f, 16'h3836
	end
`endif
`ifdef SCMP
	reg [9*16-1:0] maxpooldata;
	initial begin
		maxpooldata = {16'h4880, 16'h4400, 16'h4600, 16'h4880, 16'h4200, 16'h4700, 16'h3c00, 16'h4000, 16'h4500}; //9,4,6,8,3,7,1,2,5
	end
`endif

engine engine_(
	.clk					(clk),
//Control signals csb->engine
	.rst					(rst),
	.engine_valid			(engine_valid),
	.op_type				(op_type),
	.stride					(stride),
	.stride2				(stride2),
	.kernel					(kernel),
	.kernel_size			(kernel_size),
	.i_channel				(i_channel),
	.o_channel				(o_channel),
	.i_side					(i_side),
	.o_side					(o_side),
	.bias					(bias),
//Response signals engine->csb
	.gemm_finish			(gemm_finish),
	.engine_ready			(engine_ready),
//Command path engine->dma
	.dma_p0_writes_en		(dma_p0_writes_en),
	.dma_p2_reads_en		(dma_p2_reads_en),
    .dma_p3_reads_en		(dma_p3_reads_en),
//Data path dma->engine
	.dma_p2_ob_data			(dma_p2_ob_data),
	.dma_p3_ob_data			(dma_p3_ob_data),
	.dma_p2_ob_we			(dma_p2_ob_we),
	.dma_p3_ob_we			(dma_p3_ob_we),
	.dma_p0_ib_data			(dma_p0_ib_data)
);

always #5 clk = ~clk;
reg [7:0] count; initial count = 0;
always @(posedge clk) begin
	if(gemm_finish) engine_valid <= 0; // pull down engine_valid after the whole op is done
end

integer m,n,offset;
initial begin
    rst = 1;
    clk = 0;
    m = 0; n = 0; offset = 0;
    engine_valid = 0;
    op_type = 0; stride = 0; stride2 = 0;
	kernel = 0; kernel_size = 0; i_channel = 0; o_channel = 0; i_side = 0; o_side = 0; 
	dma_p2_ob_data = 16'h0000;
	dma_p3_ob_data = 16'h0000;
	dma_p2_ob_we = 0;
	dma_p3_ob_we = 0;
	bias = 16'h0000;
    #20 rst = 1;
    #10 rst = 0;
`ifdef CMAC
    #100 op_type = 1; stride = 2; stride2 = 6;
		//kernel = 3; kernel_size = 9; i_channel = 3; o_channel = 1; i_side = 227; o_side = 113;
		kernel = 3; kernel_size = 9; i_channel = 3; o_channel = 1; i_side = 7; o_side = 4; bias = 16'hA35C;
`endif
`ifdef SCMP
	#100 op_type = 2; stride = 2; stride2 = 6;
		kernel = 3; kernel_size = 9; i_channel = 8; o_channel = 1; i_side = 3; o_side = 1; bias = 16'h0000;
`endif
`ifdef SACC
	#100 op_type = 3; stride = 1; 
		kernel = 13; kernel_size = 169; i_channel = 3; o_channel = 1; i_side = 13; o_side = 1; bias = 16'h0000;
`endif
    #10 engine_valid = 1;
	#3000 rst = 1;
	#20 rst = 0;
	#20 engine_valid = 1;
end

always @(posedge clk) begin
	if(engine_valid) begin
		if(dma_p2_reads_en) begin 
			dma_p2_ob_we <= 1;
`ifdef CMAC
			dma_p2_ob_data <= data[m]; 
			m <= m + 1; 
`endif
`ifdef SCMP
			dma_p2_ob_data <= maxpooldata[m*16 +: 16];
			offset <= offset + 1;
			if(offset == 7) begin
				m <= m + 1;
				offset <= 0;
			end
`endif
`ifdef SACC
			dma_p2_ob_data <= avepooldata[m*16 +: 16];
			offset <= offset + 1;
			if(offset == 7) begin
				m <= m + 1;
				offset <= 0;
			end
`endif
		end else dma_p2_ob_we <= 0;
`ifdef CMAC
		if(dma_p3_reads_en) begin 
			dma_p3_ob_we <= 1;
			dma_p3_ob_data <= weight[n]; 
			n <= n + 1; 
		end else dma_p3_ob_we <= 0;
`endif
	end
end

endmodule