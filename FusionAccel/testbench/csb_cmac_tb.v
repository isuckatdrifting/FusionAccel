module csb_cmac_tb;

reg c3_clk0;
reg sys_clk;
reg op_en;
reg [31:0] ep00wire;

wire conv_valid, conv_ready, maxpool_valid, maxpool_ready, avepool_valid, avepool_ready;
reg [31:0] cmd;
wire cmd_fifo_rd_en;
reg cmd_fifo_empty;
reg [31:0] data;
wire data_fifo_rd_en;
wire [15:0] im;
reg [31:0] weightbias;
wire weight_fifo_rd_en;
wire [15:0] iw;
wire [15:0] ib;
wire [31:0] r_addr, w_addr;
wire [2:0] op_type;
wire p0_reads_en, p0_writes_en, p1_reads_en, p1_writes_en;
wire [15:0] cmd_fifo_wr_count;
wire irq;

reg [31:0] cmd_fifo [0:8];
reg [15:0] data_fifo [0:8];
reg [15:0] weight_fifo [0:8];

initial begin
    cmd_fifo[0] = 32'hc400_e0_01; // Stride2, Stride1, op_type
    cmd_fifo[1] = 32'h0040_0003;  // Output Channel Size, Input Channel Size
    cmd_fifo[2] = 32'h0000_1000;  // Weight start addres
    cmd_fifo[3] = 32'h0029_0000;  // Data start address
    cmd_fifo[4] = 32'h002e_0000;  // Write back address
end

initial begin
    data_fifo[0] = 16'h3c00; weight_fifo[0] = 16'h3c00;
    data_fifo[1] = 16'h4000; weight_fifo[1] = 16'h4000;
    data_fifo[2] = 16'h4200; weight_fifo[2] = 16'h4200;
    data_fifo[3] = 16'h4400; weight_fifo[3] = 16'h4400;
    data_fifo[4] = 16'h4500; weight_fifo[4] = 16'h4500;
    data_fifo[5] = 16'h4600; weight_fifo[5] = 16'h4600;
    data_fifo[6] = 16'h4700; weight_fifo[6] = 16'h4700;
    data_fifo[7] = 16'h4800; weight_fifo[7] = 16'h4800;
    data_fifo[8] = 16'h4880; weight_fifo[8] = 16'h4880;
end

csb csb_(
    .clk				(sys_clk),
    .rst_n				(~ep00wire[3]),
	.op_en				(op_en),

    .conv_valid			(conv_valid),
	.conv_ready			(conv_ready),
    .maxpool_valid		(maxpool_valid),
	.maxpool_ready		(maxpool_ready),
	.avepool_valid		(avepool_valid),
	.avepool_ready		(avepool_ready),

	.cmd				(cmd),
	.cmd_fifo_rd_en		(cmd_fifo_rd_en),
	.cmd_fifo_empty		(cmd_fifo_empty),
	.cmd_size			(),

	.data				(data),
	.data_fifo_rd_en	(data_fifo_rd_en),
	.im					(im),

	.weightbias			(weightbias),
	.weight_fifo_rd_en	(weight_fifo_rd_en),
    .iw					(iw),
    .ib					(ib),

    .r_addr				(r_addr),
    .w_addr				(w_addr),
    .op_type            (op_type),

	.p0_reads_en		(p0_reads_en),
    .p0_writes_en		(p0_writes_en),
    .p1_reads_en		(p1_reads_en),
    .p1_writes_en		(p1_writes_en),
    .p2_reads_en        (),
    .p2_writes_en       (),
    .p3_reads_en        (),
    .p3_writes_en       (),
    .cmd_fifo_wr_count	(cmd_fifo_wr_count),
    .irq				(irq));


engine engine_(
	.clk			(sys_clk),
	.rst			(ep00wire[3]),
	//Control signals from csb
	.conv_ready		(conv_ready),
	.maxpool_ready	(maxpool_ready),
	.avepool_ready	(avepool_ready),
	.op_type		(op_type),
	.op_num			(),

	.conv_valid		(conv_valid),
	.maxpool_valid	(maxpool_valid),
	.avepool_valid	(avepool_valid),

	//Data path from dma -> fifos
	.data_0			(),
	.weight_0		(),
	.bias_0			(),
	.data_1			(),
	.weight_1		(),
	
	//Outputs directly back to dma
	.result_0		(),
	.result_1		()
);

fifo_w32_1024_r32_1024 csb_cmd_fifo (
	.rst(ep00wire[3]),
	.wr_clk(c3_clk0),
	.rd_clk(sys_clk),
	.din(), // Bus [31 : 0] 
	.wr_en(),
	.rd_en(cmd_fifo_rd_en),
	.dout(cmd), // Bus [31 : 0] 
	.full(),
	.empty(pipe_out_empty),
	.valid(),
	.rd_data_count(), // Bus [9 : 0] 
	.wr_data_count()); // Bus [9 : 0] 

fifo_w32_1024_r32_1024 csb_data_fifo (
	.rst(ep00wire[3]),
	.wr_clk(c3_clk0),
	.rd_clk(sys_clk),
	.din(), // Bus [31 : 0] 
	.wr_en(),
	.rd_en(data_fifo_rd_en),
	.dout(data), // Bus [31 : 0] 
	.full(),
	.empty(),
	.valid(),
	.rd_data_count(), // Bus [9 : 0] 
	.wr_data_count()); // Bus [9 : 0] 

fifo_w32_1024_r32_1024 csb_weight_fifo (
	.rst(ep00wire[3]),
	.wr_clk(c3_clk0),
	.rd_clk(sys_clk),
	.din(), // Bus [31 : 0] 
	.wr_en(),
	.rd_en(weight_fifo_rd_en),
	.dout(weightbias), // Bus [31 : 0] 
	.full(),
	.empty(),
	.valid(),
	.rd_data_count(), // Bus [9 : 0] 
	.wr_data_count()); // Bus [9 : 0] 

always #5 c3_clk0 = ~c3_clk0;
always #5 sys_clk = ~sys_clk;

integer i,j;
initial begin
    ep00wire[3] = 1;
    sys_clk = 0;
    i = 0;
    j = 0;
    c3_clk0 = 0;
    op_en = 0;
    cmd_fifo_empty = 0;

    #10 ep00wire[3] = 0;
    #10 op_en = 1;
    // Weight and data
    
end

always @(posedge c3_clk0 or posedge conv_ready) begin
    if(cmd_fifo_rd_en) cmd <= cmd_fifo[i];
    i <= i + 1;
end

always @(posedge c3_clk0 or posedge conv_ready) begin
    if(data_fifo_rd_en) data <= data_fifo[i];
    if(weight_fifo_rd_en) weightbias <= weight_fifo[i];
    j <= j + 1;
end

endmodule