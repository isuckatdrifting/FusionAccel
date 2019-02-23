`timescale 1ns/1ps
`define CMAC
//`define SACP
//`define SCMP

module engine_tb;

reg 			clk;
//Control signals csb->engine
reg 			rst;
reg 			engine_valid;
reg [2:0] 	op_type;
reg			padding;
reg [31:0] 	op_num;
reg [31:0]	data_start_addr;
reg [31:0]	weight_start_addr;
reg [31:0]    result_start_addr;
//Response signals engine->csb
wire 			engine_ready;
//Data path engine->dma
//Command path engine->dma
wire          dma_p0_writes_en;
wire          dma_p1_writes_en;
wire          dma_p2_reads_en;
wire          dma_p3_reads_en;
wire          dma_p4_reads_en;
wire          dma_p5_reads_en;
wire [29:0]   p0_addr;
wire [29:0]   p1_addr;
wire [29:0]   p2_addr;
wire [29:0]   p3_addr;
wire [29:0]   p4_addr;
wire [29:0]   p5_addr;
//Data path dma->engine

reg [15:0] 	dma_p2_ob_data;
reg [15:0] 	dma_p3_ob_data;
reg [15:0] 	dma_p4_ob_data;
reg [15:0] 	dma_p5_ob_data;
reg			dma_p0_ib_re;
reg			dma_p1_ib_re;
reg 			dma_p2_ob_we;
reg 			dma_p3_ob_we;
reg 			dma_p4_ob_we;
reg 			dma_p5_ob_we;
wire [15:0]	dma_p0_ib_data;
wire [15:0]	dma_p1_ib_data;
wire			dma_p0_ib_valid;
wire			dma_p1_ib_valid;

reg [2:0] p0_state, p1_state, p2_state, p3_state;
`ifdef CMAC
reg [15:0] data0_fifo [0:143];
reg [15:0] weight0_fifo [0:159];
reg [15:0] data1_fifo [0:143];
reg [15:0] weight1_fifo [0:143];
integer j;
initial begin
	data0_fifo[0] = 16'h3c00; data0_fifo[1] = 16'h4000; data0_fifo[2] = 16'h4200;
	data0_fifo[3] = 16'h4400; data0_fifo[4] = 16'h4500; data0_fifo[5] = 16'h4600;
	data0_fifo[6] = 16'h4700; data0_fifo[7] = 16'h4800; data0_fifo[8] = 16'h4880;
    for (j=0;j<16;j=j+1) begin weight0_fifo[j] = 16'h3c00; end
    for (j=16;j<32;j=j+1) begin weight0_fifo[j] = 16'h4000; end
    for (j=32;j<48;j=j+1) begin weight0_fifo[j] = 16'h4200; end
    for (j=48;j<64;j=j+1) begin weight0_fifo[j] = 16'h4400; end
    for (j=64;j<80;j=j+1) begin weight0_fifo[j] = 16'h4500; end
    for (j=80;j<96;j=j+1) begin weight0_fifo[j] = 16'h4600; end
    for (j=96;j<112;j=j+1) begin weight0_fifo[j] = 16'h4700; end
    for (j=112;j<128;j=j+1) begin weight0_fifo[j] = 16'h4800; end
    for (j=128;j<144;j=j+1) begin weight0_fifo[j] = 16'h4880; end
	for (j=144;j<160;j=j+1) begin weight0_fifo[j] = 16'h3c00; end
end
`endif

`ifdef SACP
reg [169*16-1:0] pooldata;
initial begin
	pooldata = {16'h3757, 16'h39da, 16'h3b67, 16'h3376, 16'h3bb5, 16'h30da, 16'h3b8a, 16'h2675, 16'h3454, 16'h2d3e, 16'h39d1, 16'h3614, 16'h36dd,
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
initial begin
	reg [9*16-1:0] maxpooldata;
	maxpooldata = {16'h4880, 16'h4400, 16'h4600, 16'h4880, 16'h4200, 16'h4700, 16'h3c00, 16'h4000, 16'h4500}; //9,4,6,8,3,7,1,2,5
end
`endif

engine #(
	.CONV_BURST_LEN(16),
	.POOL_BURST_LEN(1)
)
engine_(
	.clk					(clk),
//Control signals csb->engine
	.rst					(rst),
	.engine_valid			(engine_valid),
	.op_type				(op_type),
	.op_num					(op_num),
	.data_start_addr		(data_start_addr),
	.weight_start_addr		(weight_start_addr),
	.result_start_addr		(result_start_addr),
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

`ifdef CMAC
integer m,n;
initial begin
    rst = 1;
    clk = 0;
    m = 0;
	n = 0;
    op_num = 0;
    engine_valid = 0;
    op_type = 0;
	dma_p2_ob_data = 16'h0000;
	dma_p3_ob_data = 16'h0000;
	dma_p2_ob_we = 0;
	dma_p3_ob_we = 0;
	dma_p0_ib_re = 0;
	dma_p1_ib_re = 0;
	p0_state = 0; p1_state = 0; p2_state = 0; p3_state = 0;
    #20 rst = 1;
    #10 rst = 0;
    #100 op_num = 9; op_type = 1;
    #10 engine_valid = 1; 
end

always @(posedge clk) begin
	if(engine_valid) begin
		if(dma_p2_reads_en) begin 
			if(p2_state < 2) p2_state <= p2_state + 1;
			else p2_state = 0;
			if(p2_state == 1) begin
				dma_p2_ob_we <= 1;
				dma_p2_ob_data <= data0_fifo[m]; 
				m <= m + 1; 
			end else dma_p2_ob_we <= 0;
		end
		if(dma_p3_reads_en) begin 
			if(p3_state < 2) p3_state <= p3_state + 1;
			else p3_state = 0;
			if(p3_state == 1) begin
				dma_p3_ob_we <= 1;
				dma_p3_ob_data <= weight0_fifo[n]; 
				n <= n + 1; 
			end else dma_p3_ob_we <= 0;
		end
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
`endif

`ifdef SCAP
initial begin
    rst = 1;
    clk = 0;
    op_num = 0;
    engine_valid = 0;
    op_type = 0;
	data0_fifo_valid = 0;
	data_0 = 16'h0000;
    #20 rst = 1;
    #10 rst = 0;
    #100 op_num = 169; op_type = 5;
    #10 avepool_ready = 1; 
end

always @(posedge clk) begin
	if(engine_valid) begin
		if(p2_data_fifo_rd_en) begin 
			data0_fifo_valid <= 1;
			data_0 <= pooldata[15:0]; 
			pooldata <= pooldata >> 16;
		end else data0_fifo_valid <= 0;
	end
end
`endif

`ifdef SCMP
initial begin
    rst = 1;
    clk = 0;
    op_num = 0;
    engine_valid = 0;
    op_type = 0;
	data0_fifo_valid = 0;
	data_0 = 16'h0000;
    #20 rst = 1;
    #10 rst = 0;
    #100 op_num = 9; op_type = 4;
    #10 maxpool_ready = 1; 
end

always @(posedge clk) begin
	if(engine_valid) begin
		if(p2_data_fifo_rd_en) begin 
			data0_fifo_valid <= 1;
			data_0 <= maxpooldata[15:0]; 
			maxpooldata <= maxpooldata >> 16;
		end else data0_fifo_valid <= 0;
	end
end
`endif
endmodule