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
reg	[7:0]	p0_padding_head;
reg	[7:0]	p0_padding_body;
reg	[7:0]	p1_padding_head;
reg	[7:0]	p1_padding_body;
reg	[3:0]	stride;
reg [15:0]  stride2;
reg [7:0]  	kernel;
reg [7:0]	kernel_size;
reg [15:0]  i_channel;
reg [15:0]  o_channel;
reg [7:0]	i_side;
reg [7:0]   o_side;
reg [31:0]	data_start_addr;
reg [31:0]	weight_start_addr;
reg [31:0]  p0_result_start_addr;
reg [31:0]  p1_result_start_addr;
reg [1:0]   result_en;
//Response signals engine->csb
wire 		engine_ready;
//Command path engine->dma
wire        dma_p0_writes_en;
wire        dma_p1_writes_en;
wire        dma_p2_reads_en;
wire        dma_p3_reads_en;
wire        dma_p4_reads_en;
wire        dma_p5_reads_en;
wire [29:0] p0_addr;
wire [29:0] p1_addr;
wire [29:0] p2_addr;
wire [29:0] p3_addr;
wire [29:0] p4_addr;
wire [29:0] p5_addr;
//Data path dma->engine
reg [15:0] 	dma_p2_ob_data;
reg [15:0] 	dma_p3_ob_data;
reg [15:0] 	dma_p4_ob_data;
reg [15:0] 	dma_p5_ob_data;
reg			dma_p0_ib_re;
reg			dma_p1_ib_re;
reg 		dma_p2_ob_we;
reg 		dma_p3_ob_we;
reg 		dma_p4_ob_we;
reg 		dma_p5_ob_we;
//Data path engine->dma
wire [15:0]	dma_p0_ib_data;
wire [15:0]	dma_p1_ib_data;
wire		dma_p0_ib_valid;
wire		dma_p1_ib_valid;

reg [2:0] p0_state, p1_state, p2_state, p3_state;

`ifdef CMAC
	reg [15:0] data [0:74];
	reg [15:0] weight [0:26];
	initial begin
	data[0] = 16'h3a07; data[1] = 16'h3413; data[2] = 16'h382f; data[3] = 16'h378a; data[4] = 16'h2d2d;
	data[5] = 16'h3af5; data[6] = 16'h2e19; data[7] = 16'h38db; data[8] = 16'h3ba1; data[9] = 16'h344b;
	data[10] = 16'h38fd; data[11] = 16'h392b; data[12] = 16'h357a; data[13] = 16'h3733; data[14] = 16'h37d3;
	data[15] = 16'h3ab5; data[16] = 16'h3abe; data[17] = 16'h3a2f; data[18] = 16'h32ba; data[19] = 16'h1012;
	data[20] = 16'h33d4; data[21] = 16'h3bee; data[22] = 16'h3850; data[23] = 16'h3764; data[24] = 16'h36c3;
	data[25] = 16'h33d2; data[26] = 16'h384e; data[27] = 16'h375a; data[28] = 16'h31f6; data[29] = 16'h34d0;
	data[30] = 16'h3a67; data[31] = 16'h348f; data[32] = 16'h3667; data[33] = 16'h3927; data[34] = 16'h292e;
	data[35] = 16'h305f; data[36] = 16'h3b41; data[37] = 16'h39d9; data[38] = 16'h3702; data[39] = 16'h39b1;
	data[40] = 16'h3982; data[41] = 16'h3ad2; data[42] = 16'h3971; data[43] = 16'h3a0a; data[44] = 16'h3296;
	data[45] = 16'h304e; data[46] = 16'h357a; data[47] = 16'h3653; data[48] = 16'h3b74; data[49] = 16'h3b13;
	data[50] = 16'h3231; data[51] = 16'h3a94; data[52] = 16'h3ae9; data[53] = 16'h381a; data[54] = 16'h362a;
	data[55] = 16'h2f07; data[56] = 16'h2b95; data[57] = 16'h2392; data[58] = 16'h3979; data[59] = 16'h35b6;
	data[60] = 16'h3a87; data[61] = 16'h38f1; data[62] = 16'h3734; data[63] = 16'h3a8d; data[64] = 16'h33be;
	data[65] = 16'h29be; data[66] = 16'h3a19; data[67] = 16'h37e1; data[68] = 16'h3561; data[69] = 16'h2f33;
	data[70] = 16'h3168; data[71] = 16'h3720; data[72] = 16'h31fe; data[73] = 16'h39c0; data[74] = 16'h2847;


	weight[0] = 16'h3bd2; weight[1] = 16'h36c1; weight[2] = 16'h2e79; weight[3] = 16'h3623; weight[4] = 16'h376d;
	weight[5] = 16'h3b55; weight[6] = 16'h3a80; weight[7] = 16'h27e7; weight[8] = 16'h2107; weight[9] = 16'h2d87;
	weight[10] = 16'h38b4; weight[11] = 16'h36b9; weight[12] = 16'h39b8; weight[13] = 16'h3172; weight[14] = 16'h3983;
	weight[15] = 16'h2e00; weight[16] = 16'h2d8c; weight[17] = 16'h380a; weight[18] = 16'h37e6; weight[19] = 16'h39cc;
	weight[20] = 16'h3919; weight[21] = 16'h35fc; weight[22] = 16'h27ab; weight[23] = 16'h3979; weight[24] = 16'h2005;
	weight[25] = 16'h3a07; weight[26] = 16'h38f5;
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
	.p0_padding_head		(p0_padding_head),
	.p0_padding_body		(p0_padding_body),
	.p1_padding_head		(p1_padding_head),
	.p1_padding_body		(p1_padding_body),
	.stride					(stride),
	.stride2				(stride2),
	.kernel					(kernel),
	.kernel_size			(kernel_size),
	.i_channel				(i_channel),
	.o_channel				(o_channel),
	.i_side					(i_side),
	.o_side					(o_side),
	.data_start_addr		(data_start_addr),
	.weight_start_addr		(weight_start_addr),
	.p0_result_start_addr	(p0_result_start_addr),
	.p1_result_start_addr	(p1_result_start_addr),
	.result_en				(result_en),
//Response signals engine->csb
	.engine_ready			(engine_ready),
//Command path engine->dma
	.dma_p0_writes_en		(dma_p0_writes_en),
    .dma_p1_writes_en		(dma_p1_writes_en),
	.dma_p2_reads_en		(dma_p2_reads_en),
    .dma_p3_reads_en		(dma_p3_reads_en),
	.dma_p4_reads_en		(dma_p4_reads_en),
    .dma_p5_reads_en		(dma_p5_reads_en),
	.p0_addr          		(p0_addr),
	.p1_addr          		(p1_addr),
	.p2_addr				(p2_addr),
	.p3_addr				(p3_addr),
	.p4_addr				(p4_addr),
	.p5_addr				(p5_addr),
//Data path dma->engine
	.dma_p2_ob_data			(dma_p2_ob_data),
	.dma_p3_ob_data			(dma_p3_ob_data),
	.dma_p4_ob_data			(dma_p4_ob_data),
	.dma_p5_ob_data			(dma_p5_ob_data),
	.dma_p0_ib_re			(dma_p0_ib_re),
	.dma_p1_ib_re			(dma_p1_ib_re),
	.dma_p2_ob_we			(dma_p2_ob_we),
	.dma_p3_ob_we			(dma_p3_ob_we),
	.dma_p4_ob_we			(dma_p4_ob_we),
	.dma_p5_ob_we			(dma_p5_ob_we),
	.dma_p0_ib_data			(dma_p0_ib_data),
	.dma_p1_ib_data			(dma_p1_ib_data),
	.dma_p0_ib_valid		(dma_p0_ib_valid),
	.dma_p1_ib_valid		(dma_p1_ib_valid)
);

always #5 clk = ~clk;
always @(posedge engine_ready) engine_valid <= 0; // pull down engine_valid after the whole op is done

integer m,n,offset;
initial begin
    rst = 1;
    clk = 0;
    m = 0; n = 0; offset = 0;
    engine_valid = 0;
    op_type = 0; p0_padding_head = 0; p0_padding_body = 0; p1_padding_head = 0; p1_padding_body = 0; stride = 0; stride2 = 0;
	kernel = 0; kernel_size = 0; i_channel = 0; o_channel = 0; i_side = 0; o_side = 0; 
	dma_p2_ob_data = 16'h0000;
	dma_p3_ob_data = 16'h0000;
	dma_p2_ob_we = 0;
	dma_p3_ob_we = 0;
	dma_p0_ib_re = 0;
	dma_p1_ib_re = 0;
	data_start_addr <= 30'h0000_0000; weight_start_addr <= 30'h0000_0000; p0_result_start_addr <= 30'h0000_0000; p1_result_start_addr <= 30'h0000_0000;
	result_en <= 2'b00;
	p0_state = 0; p1_state = 0; p2_state = 0; p3_state = 0;
    #20 rst = 1;
    #10 rst = 0;
`ifdef CMAC
    #100 op_type = 1; stride = 2; stride2 = 6;
		p0_padding_head = 0; p0_padding_body = 0; p1_padding_head = 0; p1_padding_body = 0;
		kernel = 3; kernel_size = 9; i_channel = 3; o_channel = 1; i_side = 227; o_side = 113; result_en <= 2'b01;
`endif
`ifdef SCMP
	#100 op_type = 2; stride = 2; stride2 = 6;
		p0_padding_head = 0; p0_padding_body = 0; p1_padding_head = 4; p1_padding_body = 2;
		kernel = 3; kernel_size = 9; i_channel = 8; o_channel = 1; i_side = 3; o_side = 1; result_en <= 2'b11;
`endif
`ifdef SACC
	#100 op_type = 3; stride = 1; 
		p0_padding_head = 0; p0_padding_body = 0; p1_padding_head = 0; p1_padding_body = 0;
		kernel = 13; kernel_size = 169; i_channel = 3; o_channel = 1; i_side = 13; o_side = 1; result_en <= 2'b01;
`endif
		data_start_addr <= 30'h0001_0000; weight_start_addr <= 30'h0000_1000; p0_result_start_addr <= 30'h0003_0000; p1_result_start_addr <= 30'h0004_0000;
    #10 engine_valid = 1; 
end

always @(posedge clk) begin
	if(engine_valid) begin
		if(dma_p2_reads_en) begin 
			if(p2_state < 2) p2_state <= p2_state + 1;
			else p2_state = 0;
			if(p2_state == 1) begin
				dma_p2_ob_we <= 1;
`ifdef CMAC
				dma_p2_ob_data <= data[m]; 
				m <= m + 1; 
				if(m == offset + 45) begin
					m <= offset + 1;
					offset <= offset + 1;
				end
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
		end
`ifdef CMAC
		if(dma_p3_reads_en) begin 
			if(p3_state < 2) p3_state <= p3_state + 1;
			else p3_state = 0;
			if(p3_state == 1) begin
				dma_p3_ob_we <= 1;
				dma_p3_ob_data <= weight[n]; 
				n <= n + 1; 
				if(n==26) n <= 0;
			end else dma_p3_ob_we <= 0;
		end
`endif
		if(dma_p0_writes_en) begin 
			if(p0_state < 2) p0_state <= p0_state + 1;
			else p0_state = 0;
			if(p0_state == 1) begin
				dma_p0_ib_re <= 1;
			end else dma_p0_ib_re <= 0;
		end
		if(dma_p1_writes_en) begin 
			if(p1_state < 2) p1_state <= p1_state + 1;
			else p1_state = 0;
			if(p1_state == 1) begin
				dma_p1_ib_re <= 1;
			end else dma_p1_ib_re <= 0;
		end
	end
end

endmodule