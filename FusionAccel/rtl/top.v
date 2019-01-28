module top 
(
    ///////////////////////////////////////
	// Front Panel Interface
	//////////////////////////////////////
	input  wire [4:0]   okUH,
	output wire [2:0]   okHU,
	inout  wire [31:0]  okUHU,
	inout  wire         okAA,
	input  wire         sys_clkp,
	input  wire         sys_clkn,
	output      [7:0]   led,

    //DDR2 Interface
    inout  wire [15:0]  ddr2_dq,
	output wire [12:0]  ddr2_a,
	output wire [2:0]  	ddr2_ba,
	output wire         ddr2_ras_n,
	output wire         ddr2_cas_n,
	output wire         ddr2_we_n,
	output wire         ddr2_odt,
	output wire         ddr2_cke,
	output wire         ddr2_dm,
	inout  wire         ddr2_udqs,
	inout  wire         ddr2_udqs_n,
	inout  wire         ddr2_rzq,
	inout  wire         ddr2_zio,
	output wire         ddr2_udm,
	inout  wire         ddr2_dqs,
	inout  wire         ddr2_dqs_n,
	output wire         ddr2_ck,
	output wire         ddr2_ck_n,
	output wire         ddr2_cs_n
);

//-----------------------------Clock PLL-----------------------------------//
clockgen clockgen_ (
    // Clock in ports
    .CLK_IN1_P				(sys_clkp),   // IN
    .CLK_IN1_N				(sys_clkn),   // IN
    // Clock out ports
    .CLK_OUT1				(sys_clk),    // OUT
	.CLK_OUT2				(),           // OUT
    // Status and control signals
    .RESET					(1'b0),       // IN
    .LOCKED					(LOCKED)      // OUT 
);      

//--------------v1, Minimum Hardware Cores for SqueezeNet------------------//

//------------------------------------------------
// Control Signal Block for all cores
//------------------------------------------------
csb csb_(
    .clk				(sys_clk),
    .rst_n				(ep00wire[3]),
	.op_en				(),

    .conv_valid			(conv_valid),
	.conv_ready			(conv_ready),
    .maxpool_valid		(maxpool_valid),
	.maxpool_ready		(maxpool_ready),
	.avepool_valid		(avepool_valid),
	.avepool_ready		(avepool_ready),

    .dma_aux_we			(dma_aux_we),      //P0: CSB & CONV1x1. P1: CONV3x3, POOL3x3 & POOL13x13
    .dma_aux_re			(dma_aux_re),      //P0: CSB & CONV1x1. P1: CONV3x3, POOL3x3 & POOL13x13

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

	.p0_reads_en		(p0_reads_en),
    .p0_writes_en		(p0_writes_en),
    .p1_reads_en		(p1_reads_en),
    .p1_writes_en		(p1_writes_en),
    .cmd_fifo_wr_count	(cmd_fifo_wr_count),
    .irq				(irq));

//------------------------------------------------
// Bitonic 3x3 Max Pooling Core
//------------------------------------------------
pool_3x3 pool_3x3_(
    .clk		(sys_clk),
    .rst_n		(ep00wire[2]),
    .im			(),					//Input Matrix 3x3 [143:0]
    .om			(),					//Output Matrix 1x1[15:0]
    .pool_ready	(maxpool_ready),
    .pool_valid	(maxpool_valid));

//------------------------------------------------
// Pipeline 13x13 Average Pooling Core
//------------------------------------------------
pool_13x13 pool_13x13_(
    .clk		(sys_clk),
    .rst_n		(ep00wire[2]),
    .im			(),					//Input Matrix 13x13[2703:0]
    .om			(),					//Output Matrix 1x1 [15:0]
    .pool_ready	(avepool_ready),
    .pool_valid	(avepool_valid));

//------------------------------------------------
// Memory Control Block
//------------------------------------------------
localparam BLOCK_SIZE      = 128;   // 512 bytes / 4 byte per word;
localparam FIFO_SIZE       = 1023;  // note that Xilinx does not allow use of the full 1024 words
localparam BUFFER_HEADROOM = 20; // headroom for the FIFO count to account for latency

wire        c3_sys_clk;
wire        c3_error;
wire        c3_calib_done;
wire        c3_clk0;
reg         c3_sys_rst_n;
wire        c3_rst0;
wire        c3_pll_lock;

wire        c3_p0_cmd_en;
wire [2:0]  c3_p0_cmd_instr;
wire [5:0]  c3_p0_cmd_bl;
wire [29:0] c3_p0_cmd_byte_addr;
wire        c3_p0_cmd_empty;
wire        c3_p0_cmd_full;
wire        c3_p0_wr_en;
wire [3:0]  c3_p0_wr_mask;
wire [31:0] c3_p0_wr_data;
wire        c3_p0_wr_full;
wire        c3_p0_wr_empty;
wire [6:0]  c3_p0_wr_count;
wire        c3_p0_wr_underrun;
wire        c3_p0_wr_error;
wire        c3_p0_rd_en;
wire [31:0] c3_p0_rd_data;
wire        c3_p0_rd_full;
wire        c3_p0_rd_empty;
wire [6:0]  c3_p0_rd_count;
wire        c3_p0_rd_overflow;
wire        c3_p0_rd_error;

// Front Panel

// Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

wire [31:0]  ep00wire;

wire        pipe_in_start;
wire        pipe_in_done;
wire        pipe_in_read;
wire [31:0] pipe_in_data;
wire [9:0]  pipe_in_rd_count;
wire [9:0]  pipe_in_wr_count;
wire        pipe_in_valid;
wire        pipe_in_full;
wire        pipe_in_empty;
reg         pipe_in_ready;

wire        pipe_out_start;
wire        pipe_out_done;
wire        pipe_out_write;
wire [31:0] pipe_out_data;
wire [9:0]  pipe_out_rd_count;
wire [9:0]  pipe_out_wr_count;
wire        pipe_out_full;
wire        pipe_out_empty;
reg         pipe_out_ready;

// Pipe Fifos
wire        pi0_ep_write, po0_ep_read;
wire [31:0] pi0_ep_dataout, po0_ep_datain;

//-------------------------LED Stage Monitor-------------------------------//
assign led = ~{pipe_in_full, pipe_in_empty, pipe_out_full, pipe_out_empty, c3_p0_wr_full,ep00wire[1],c3_calib_done,c3_pll_lock};

assign c3_sys_clk = 1'b0;
assign ddr2_cs_n = 1'b0;

//MIG Infrastructure Reset
reg [3:0] rst_cnt;
initial rst_cnt = 4'b0;
always @(posedge okClk) begin
    if(rst_cnt < 4'b1000) begin
        rst_cnt <= rst_cnt + 1;
        c3_sys_rst_n <= 1'b1;
    end
    else begin
        c3_sys_rst_n <= 1'b0;
    end
end

mem_ctrl # (
    .C3_P0_MASK_SIZE(4),
    .C3_P0_DATA_PORT_SIZE(32),
    .C3_P1_MASK_SIZE(4),
    .C3_P1_DATA_PORT_SIZE(32),
    .DEBUG_EN(0),
    .C3_MEMCLK_PERIOD(3200),
    .C3_CALIB_SOFT_IP("TRUE"),
    .C3_SIMULATION("FALSE"),
    .C3_RST_ACT_LOW(0),
    .C3_INPUT_CLK_TYPE("DIFFERENTIAL"),
    .C3_MEM_ADDR_ORDER("ROW_BANK_COLUMN"),
    .C3_NUM_DQ_PINS(16),
    .C3_MEM_ADDR_WIDTH(13),
    .C3_MEM_BANKADDR_WIDTH(3)
)
memc3_inst (
	.c3_sys_clk_p          	(sys_clkp),
	.c3_sys_clk_n          	(sys_clkn),
	.c3_sys_rst_i      		(c3_sys_rst_n),                      

	.mcb3_dram_dq           (ddr2_dq),  
	.mcb3_dram_a            (ddr2_a),  
	.mcb3_dram_ba           (ddr2_ba),
	.mcb3_dram_ras_n        (ddr2_ras_n),                        
	.mcb3_dram_cas_n        (ddr2_cas_n),                        
	.mcb3_dram_we_n         (ddr2_we_n),                          
	.mcb3_dram_odt          (ddr2_odt),
	.mcb3_dram_cke          (ddr2_cke),                          
	.mcb3_dram_ck           (ddr2_ck),                          
	.mcb3_dram_ck_n         (ddr2_ck_n),       
	.mcb3_dram_dqs          (ddr2_dqs),                          
	.mcb3_dram_dqs_n        (ddr2_dqs_n),
	.mcb3_dram_udqs         (ddr2_udqs),    // for X16 parts                        
	.mcb3_dram_udqs_n       (ddr2_udqs_n),  // for X16 parts
	.mcb3_dram_udm          (ddr2_udm),     // for X16 parts
	.mcb3_dram_dm           (ddr2_dm),
	.c3_clk0		     	(c3_clk0),
	.c3_rst0		     	(c3_rst0),
	.c3_calib_done     		(c3_calib_done),
	.c3_pll_lock			(c3_pll_lock),
	.mcb3_rzq          		(ddr2_rzq),        
	.mcb3_zio               (ddr2_zio), 

	.c3_p0_cmd_clk			(c3_clk0),
	.c3_p0_cmd_en           (c3_p0_cmd_en),
	.c3_p0_cmd_instr        (c3_p0_cmd_instr),
	.c3_p0_cmd_bl           (c3_p0_cmd_bl),
	.c3_p0_cmd_byte_addr    (c3_p0_cmd_byte_addr),
	.c3_p0_cmd_empty        (c3_p0_cmd_empty),
	.c3_p0_cmd_full         (c3_p0_cmd_full),

	.c3_p0_wr_clk			(c3_clk0),
	.c3_p0_wr_en            (c3_p0_wr_en),
	.c3_p0_wr_mask          (c3_p0_wr_mask),
	.c3_p0_wr_data          (c3_p0_wr_data),
	.c3_p0_wr_full          (c3_p0_wr_full),
	.c3_p0_wr_empty         (c3_p0_wr_empty),
	.c3_p0_wr_count         (c3_p0_wr_count),
	.c3_p0_wr_underrun      (c3_p0_wr_underrun),
	.c3_p0_wr_error         (c3_p0_wr_error),

	.c3_p0_rd_clk			(c3_clk0),
	.c3_p0_rd_en            (c3_p0_rd_en),
	.c3_p0_rd_data          (c3_p0_rd_data),
	.c3_p0_rd_full          (c3_p0_rd_full),
	.c3_p0_rd_empty         (c3_p0_rd_empty),
	.c3_p0_rd_count         (c3_p0_rd_count),
	.c3_p0_rd_overflow      (c3_p0_rd_overflow),
	.c3_p0_rd_error         (c3_p0_rd_error),

	.c3_p1_cmd_clk			(c3_clk0),
	.c3_p1_cmd_en           (c3_p1_cmd_en),
	.c3_p1_cmd_instr        (c3_p1_cmd_instr),
	.c3_p1_cmd_bl           (c3_p1_cmd_bl),
	.c3_p1_cmd_byte_addr    (c3_p1_cmd_byte_addr),
	.c3_p1_cmd_empty        (c3_p1_cmd_empty),
	.c3_p1_cmd_full         (c3_p1_cmd_full),

	.c3_p1_wr_clk			(c3_clk0),
	.c3_p1_wr_en            (c3_p1_wr_en),
	.c3_p1_wr_mask          (c3_p1_wr_mask),
	.c3_p1_wr_data          (c3_p1_wr_data),
	.c3_p1_wr_full          (c3_p1_wr_full),
	.c3_p1_wr_empty         (c3_p1_wr_empty),
	.c3_p1_wr_count         (c3_p1_wr_count),
	.c3_p1_wr_underrun      (c3_p1_wr_underrun),
	.c3_p1_wr_error         (c3_p1_wr_error),

	.c3_p1_rd_clk			(c3_clk0),
	.c3_p1_rd_en            (c3_p1_rd_en),
	.c3_p1_rd_data          (c3_p1_rd_data),
	.c3_p1_rd_full          (c3_p1_rd_full),
	.c3_p1_rd_empty         (c3_p1_rd_empty),
	.c3_p1_rd_count         (c3_p1_rd_count),
	.c3_p1_rd_overflow      (c3_p1_rd_overflow),
	.c3_p1_rd_error         (c3_p1_rd_error));

dma dma_ (
	.clk				(c3_clk0),
	.reset				(ep00wire[2] | c3_rst0), 
	.reads_en			(ep00wire[0]),
	.writes_en			(ep00wire[1]),
	.calib_done			(c3_calib_done), 

	.ib_re				(pipe_in_read),
	.ib_data			(pipe_in_data),
	.ib_count			(pipe_in_rd_count),
	.ib_valid			(pipe_in_valid),
	.ib_empty			(pipe_in_empty),

	.ob_we				(pipe_out_write),
	.ob_data			(pipe_out_data),
	.ob_count			(pipe_out_wr_count),

	.p0_rd_en_o			(c3_p0_rd_en),  
	.p0_rd_empty		(c3_p0_rd_empty), 
	.p0_rd_data			(c3_p0_rd_data), 

	.p0_cmd_en			(c3_p0_cmd_en),
	.p0_cmd_full		(c3_p0_cmd_full), 
	.p0_cmd_instr		(c3_p0_cmd_instr),
	.p0_cmd_byte_addr	(c3_p0_cmd_byte_addr), 
	.p0_cmd_bl_o		(c3_p0_cmd_bl), 

	.p0_wr_en			(c3_p0_wr_en),
	.p0_wr_full			(c3_p0_wr_full), 
	.p0_wr_data			(c3_p0_wr_data), 
	.p0_wr_mask			(c3_p0_wr_mask));
	
//Block Throttle
always @(posedge okClk) begin
	// Check for enough space in input FIFO to pipe in another block
	// The count is compared against a reduced size to account for delays in
	// FIFO count updates.
	if(pipe_in_wr_count <= (FIFO_SIZE-BUFFER_HEADROOM-BLOCK_SIZE) ) begin
	  pipe_in_ready <= 1'b1;
	end
	else begin
		pipe_in_ready <= 1'b0;
	end
	
	if(pipe_out_rd_count >= BLOCK_SIZE) begin
	  pipe_out_ready <= 1'b1;
	end
	else begin
		pipe_out_ready <= 1'b0;
	end
	
end

//TODO: MUX for Port0 of MCB
dma_aux dma_aux_ (
	.clk				(c3clk0),
	.reset				(ep00wire[3] | c3_rst0),
    .calib_done			(c3_calib_done), 
    //----------------------------------------------------------------------------------------------
    //Port 0: get csb command, get data, set output result
	.p0_writes_en		(p0_writes_en),
	.p0_reads_en		(p0_reads_en),
	//DDR Input Buffer (ib_) write mac calculation result back to ddr2
	.p0_ib_re			(),
	.p0_ib_data			(), //[31:0]
	.p0_ib_count		(), //[9:0]
	.p0_ib_valid		(),
	.p0_ib_empty		(),
	//DDR Output Buffer (ob_) get data from ddr2
	.p0_ob_we			(),
	.p0_ob_data			(),
	.p0_ob_count		(),
	
	.p0_rd_en_o			(), 
	.p0_rd_empty		(),
	.p0_rd_data			(),
	
	.p0_cmd_full		(),
	.p0_cmd_en			(),
	.p0_cmd_instr		(),
	.p0_cmd_byte_addr	(),
	.p0_cmd_bl_o		(), 
	.p0_wr_full			(),
	.p0_wr_en			(),
	.p0_wr_data			(),
	.p0_wr_mask			(),
    //----------------------------------------------------------------------------------------------
    //Port 1: get weight
    .p1_writes_en		(p1_writes_en),
    .p1_reads_en		(p1_reads_en),
    //DDR Input Buffer (ib_) write mac calculation result back to ddr2
	.p1_ib_re			(),
	.p1_ib_data			(),
	.p1_ib_count		(),
	.p1_ib_valid		(),
	.p1_ib_empty		(),
	//DDR Output Buffer (ob_) get weight and bias from ddr2
	.p1_ob_we			(),
	.p1_ob_data			(),
	.p1_ob_count		(),
    
    .p1_rd_en_o			(), 
	.p1_rd_empty		(),
	.p1_rd_data			(),
	
	.p1_cmd_full		(),
	.p1_cmd_en			(),
	.p1_cmd_instr		(),
	.p1_cmd_byte_addr	(),
	.p1_cmd_bl_o		(), 
	.p1_wr_full			(),
	.p1_wr_en			(),
	.p1_wr_data			(),
	.p1_wr_mask			());
//------------------------------------------------
// PC Communication using Front Panel(TM)
//------------------------------------------------

// Instantiate the okHost and connect endpoints.
wire [65*2-1:0]  okEHx;

okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE), 
	.okEH(okEH)
);

okWireOR # (.N(2)) wireOR (okEH, okEHx);
okWireIn       wi00 (.okHE(okHE),                             .ep_addr(8'h00), .ep_dataout(ep00wire));
okBTPipeIn     pi0  (.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h80), .ep_write(pi0_ep_write), .ep_blockstrobe(), .ep_dataout(pi0_ep_dataout), .ep_ready(pipe_in_ready));
okBTPipeOut    po0  (.okHE(okHE), .okEH(okEHx[ 1*65 +: 65 ]), .ep_addr(8'ha0), .ep_read(po0_ep_read),   .ep_blockstrobe(), .ep_datain(po0_ep_datain),   .ep_ready(pipe_out_ready));

fifo_w32_1024_r32_1024 okPipeIn_fifo (
	.rst(ep00wire[2]),
	.wr_clk(okClk),
	.rd_clk(c3_clk0),
	.din(pi0_ep_dataout), // Bus [31 : 0] 
	.wr_en(pi0_ep_write),
	.rd_en(pipe_in_read),
	.dout(pipe_in_data), // Bus [31 : 0] 
	.full(pipe_in_full),
	.empty(pipe_in_empty),
	.valid(pipe_in_valid),
	.rd_data_count(pipe_in_rd_count), // Bus [9 : 0] 
	.wr_data_count(pipe_in_wr_count)); // Bus [9 : 0] 

fifo_w32_1024_r32_1024 okPipeOut_fifo (
	.rst(ep00wire[2]),
	.wr_clk(c3_clk0),
	.rd_clk(okClk),
	.din(pipe_out_data), // Bus [31 : 0] 
	.wr_en(pipe_out_write),
	.rd_en(po0_ep_read),
	.dout(po0_ep_datain), // Bus [31 : 0] 
	.full(pipe_out_full),
	.empty(pipe_out_empty),
	.valid(),
	.rd_data_count(pipe_out_rd_count), // Bus [9 : 0] 
	.wr_data_count(pipe_out_wr_count)); // Bus [9 : 0] 

//FIFO for: CSB Command
fifo_w32_1024_r32_1024 csb_cmd_fifo (
	.rst(ep00wire[3]),
	.wr_clk(c3_clk0),
	.rd_clk(sys_clk),
	.din(), // Bus [31 : 0] 
	.wr_en(),
	.rd_en(cmd_fifo_rd_en),
	.dout(cmd), // Bus [31 : 0] 
	.full(),
	.empty(cmd_fifo_empty),
	.valid(),
	.rd_data_count(), // Bus [9 : 0] 
	.wr_data_count(cmd_fifo_wr_count)); // Bus [9 : 0] 

//NOTES: always use port0 and port1 for conv3x3. When doing conv3x3&1x1, port0 and port1 reads out additional 1 data.
//TODO: Update estimated delay of dma access
//FIFO for: CONV3x3, CONV3x3 & CONV1x1, MAXPOOL3x3
//TODO: Use non-symmetric aspect ratio of read and write port of fifo.
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

//--------------v2, More complicate Cores for Other Function and Networks--//
//reshape reshape_(); //Memory Reshape and Concatenation Core
//acti acti_(); //Activation Core
//lut lut_(); //Loop up table for activation and lrn cores
//lrn lrn_(); //Local response normalization Core

endmodule