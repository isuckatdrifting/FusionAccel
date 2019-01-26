module csb_tb();

    reg clk;
    reg rst_n;
    reg op_en;

    reg conv_valid_1x1; 
    wire conv_ready_1x1;
    reg conv_valid_3x3;
    wire conv_ready_3x3;
    reg pool_valid_3x3;
    wire pool_ready_3x3;
    reg pool_valid_13x13;
    wire pool_ready_13x13;

    wire dma_aux_we;      //P0: CSB & CONV1x1. P1: CONV3x3; POOL3x3 & POOL13x13
    wire dma_aux_re;      //P0: CSB & CONV1x1. P1: CONV3x3; POOL3x3 & POOL13x13

    wire cmd_fifo_rd_en;
    reg [31:0] cmd;
    reg cmd_fifo_empty;
    reg [6:0] cmd_size;   //total command size received from okHost after loading memory.

    wire im_fifo_rd_en;
    wire iwb_fifo_rd_en;
    reg [31:0] data;
    reg [31:0] weightbias;
    wire [15:0] im_1x1;
    wire [15:0] iw_1x1;
    wire [143:0] im_3x3;
    wire [143:0] iw_3x3;
    wire [15:0] ib_1x1;
    wire [15:0] ib_3x3;
    wire [2703:0] im_13x13;

    wire [31:0] r_addr;
    wire [31:0] w_addr;
    wire irq;

csb csb_(
    .clk				(clk),
    .rst_n				(rst_n),
	.op_en				(op_en),

    .conv_valid_1x1		(conv_valid_1x1), 
	.conv_ready_1x1		(conv_ready_1x1),
    .conv_valid_3x3		(conv_valid_3x3),
    .conv_ready_3x3		(conv_ready_3x3),
    .pool_valid_3x3		(pool_valid_3x3),
    .pool_ready_3x3		(pool_ready_3x3),
    .pool_valid_13x13	(pool_valid_13x13),
    .pool_ready_13x13	(pool_ready_13x13),

    .dma_aux_we			(dma_aux_we),      //P0: CSB & CONV1x1. P1: CONV3x3, POOL3x3 & POOL13x13
    .dma_aux_re			(dma_aux_re),      //P0: CSB & CONV1x1. P1: CONV3x3, POOL3x3 & POOL13x13

    .cmd_fifo_rd_en     (cmd_fifo_rd_en),
	.cmd				(cmd),
    .cmd_fifo_empty     (cmd_fifo_empty),
	.cmd_size			(cmd_size),

	.im_fifo_rd_en		(im_fifo_rd_en),
	.iwb_fifo_rd_en		(iwb_fifo_rd_en),
	.data				(data),
	.weightbias			(weightbias),
	.im_1x1				(im_1x1),
    .iw_1x1				(iw_1x1),
    .im_3x3				(im_3x3),
    .iw_3x3				(iw_3x3),
    .ib_1x1				(ib_1x1),
    .ib_3x3				(ib_3x3),
    .im_13x13			(im_13x13),

    .r_addr				(r_addr),
    .w_addr				(w_addr),
    .irq				(irq));

always #5 clk = ~clk;

initial begin
    rst_n = 0;
    clk = 0;
    cmd = 32'h0;
    data = 32'h0;
    weightbias = 32'h0;
    conv_valid_1x1 = 0;
    conv_valid_3x3 = 0;
    pool_valid_3x3 = 0;
    pool_valid_13x13 = 0;
    op_en = 0;
    cmd_fifo_empty = 0;

    #10 rst_n = 1;
    #10 op_en = 1;
    // Command
    #10 cmd = 32'hc400_e0_01; // Stride2, Stride1, op_type
    #10 cmd = 32'h0040_0003;  // Output Channel Size, Input Channel Size
    #10 cmd = 32'h0000_1000;  // Weight start addres
    #10 cmd = 32'h0029_0000;  // Data start address
    #10 cmd = 32'h002e_0000;  // Write back address
    // Weight and data
    #10
    #10 data = {16'h3c00, 16'h4000}; weightbias = {16'h3c00, 16'h4000};
    #10 data = {16'h4200, 16'h4400}; weightbias = {16'h4200, 16'h4400};
    #10 data = {16'h4500, 16'h4600}; weightbias = {16'h4500, 16'h4600};
    #10 data = {16'h4700, 16'h4800}; weightbias = {16'h4700, 16'h4800};
    #10 data = {16'h0000, 16'h4880}; weightbias = {16'h0000, 16'h4880};
    #10 weightbias = {16'h0000, 16'h3c00};
    
    // Valid signal from submodules
    #500 conv_valid_3x3 = 1;
end

endmodule