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

//--------------v1, Minimum Hardware Cores for SqueezeNet------------------//
wire        c3_clk0;

wire 		op_en;
wire [2:0] 	op_type;
wire [15:0] op_num;
wire [31:0] cmd;
wire [31:0] data_0, weight_0, data_1, weight_1;
wire [15:0] p0_result, p1_result;
wire 		p0_write_fifo_en, p1_write_fifo_en;
wire [9:0] 	cmd_fifo_wr_count;

//------------------------------------------------
// Control Signal Block for all cores
//------------------------------------------------
csb csb_(
    .clk				(c3_clk0),
    .rst_n				(ep00wire[3]),
	.op_en				(ep00wire[4]),		// A wire from ep

    .conv_valid			(conv_valid),
	.conv_ready			(conv_ready),
    .maxpool_valid		(maxpool_valid),
	.maxpool_ready		(maxpool_ready),
	.avepool_valid		(avepool_valid),
	.avepool_ready		(avepool_ready),

	.cmd_fifo_wr_count	(cmd_fifo_wr_count),
	.cmd				(cmd),
	.cmd_fifo_empty		(cmd_fifo_empty),
	.cmd_size			(),
	.cmd_fifo_rd_en		(cmd_fifo_rd_en),

	.op_type			(op_type),
	.op_num				(op_num),
	.weight_start_addr	(),
	.data_start_addr	(),
    .writeback_addr		(writeback_addr),
	.op_run				(op_run),

	.p0_reads_en		(p0_reads_en),
    .p0_writes_en		(p0_writes_en),
    .p1_reads_en		(p1_reads_en),
    .p1_writes_en		(p1_writes_en),
	.p2_reads_en		(p2_reads_en),
    .p2_writes_en		(p2_writes_en),
    .p3_reads_en		(p3_reads_en),
    .p3_writes_en		(p3_writes_en),
    
    .irq				(irq));

engine engine_(
	.clk				(c3_clk0),
	.rst				(rst),
	//Control signals from csb
	.conv_ready			(conv_ready),
	.maxpool_ready		(maxpool_ready),
	.avepool_ready		(avepool_ready),
	.op_type			(op_type),
	.op_num				(op_num),

	.conv_valid			(conv_valid),
	.maxpool_valid		(maxpool_valid),
	.avepool_valid		(avepool_valid),

	//Data path from dma -> fifos
	.p0_data_fifo_rd_en (p0_data_fifo_rd_en),
	.data_0				(data_0),
	.p0_weight_fifo_rd_en (p0_weight_fifo_rd_en),
	.weight_0			(weight_0),
	.p1_data_fifo_rd_en (p1_data_fifo_rd_en),
	.data_1				(data_1),
	.p1_weight_fifo_rd_en (p1_weight_fifo_rd_en),
	.weight_1			(weight_1),
	
	.p0_result			(p0_result),
	.p1_result			(p1_result),
	.p0_write_fifo_en	(p0_write_fifo_en),
	.p1_write_fifo_en	(p1_write_fifo_en)
);


localparam BLOCK_SIZE      = 128;   // 512 bytes / 4 byte per word;
localparam FIFO_SIZE       = 1023;  // note that Xilinx does not allow use of the full 1024 words
localparam BUFFER_HEADROOM = 20; // headroom for the FIFO count to account for latency

wire        c3_sys_clk;
wire        c3_error;
wire        c3_calib_done;

reg         c3_sys_rst_n;
wire        c3_rst0;
wire        c3_pll_lock;

wire        c3_p0_cmd_en, c3_p1_cmd_en, c3_p2_cmd_en, c3_p3_cmd_en;
wire [2:0]  c3_p0_cmd_instr, c3_p1_cmd_instr, c3_p2_cmd_instr, c3_p3_cmd_instr;
wire [5:0]  c3_p0_cmd_bl, c3_p1_cmd_bl, c3_p2_cmd_bl, c3_p3_cmd_bl;
wire [29:0] c3_p0_cmd_byte_addr, c3_p1_cmd_byte_addr, c3_p2_cmd_byte_addr, c3_p3_cmd_byte_addr;
wire        c3_p0_cmd_empty, c3_p1_cmd_empty, c3_p2_cmd_empty, c3_p3_cmd_empty;
wire        c3_p0_cmd_full, c3_p1_cmd_full, c3_p2_cmd_full, c3_p3_cmd_full;
wire        c3_p0_wr_en, c3_p1_wr_en, c3_p2_wr_en, c3_p3_wr_en;
wire [3:0]  c3_p0_wr_mask, c3_p1_wr_mask, c3_p2_wr_mask, c3_p3_wr_mask;
wire [31:0] c3_p0_wr_data, c3_p1_wr_data, c3_p2_wr_data, c3_p3_wr_data;
wire        c3_p0_wr_full, c3_p1_wr_full, c3_p2_wr_full, c3_p3_wr_full;
wire        c3_p0_wr_empty, c3_p1_wr_empty, c3_p2_wr_empty, c3_p3_wr_empty;
wire [6:0]  c3_p0_wr_count, c3_p1_wr_count, c3_p2_wr_count, c3_p3_wr_count;
wire        c3_p0_wr_underrun, c3_p1_wr_underrun, c3_p2_wr_underrun, c3_p3_wr_underrun;
wire        c3_p0_wr_error, c3_p1_wr_error, c3_p2_wr_error, c3_p3_wr_error;
wire        c3_p0_rd_en, c3_p1_rd_en, c3_p2_rd_en, c3_p3_rd_en;
wire [31:0] c3_p0_rd_data, c3_p1_rd_data, c3_p2_rd_data, c3_p3_rd_data;
wire        c3_p0_rd_full, c3_p1_rd_full, c3_p2_rd_full, c3_p3_rd_full;
wire        c3_p0_rd_empty, c3_p1_rd_empty, c3_p2_rd_empty, c3_p3_rd_empty;
wire [6:0]  c3_p0_rd_count, c3_p1_rd_count, c3_p2_rd_count, c3_p3_rd_count;
wire        c3_p0_rd_overflow, c3_p1_rd_overflow, c3_p2_rd_overflow, c3_p3_rd_overflow;
wire        c3_p0_rd_error, c3_p1_rd_error, c3_p2_rd_error, c3_p3_rd_error;

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
	.c3_p1_rd_error         (c3_p1_rd_error),
	
	.c3_p2_cmd_clk			(c3_clk0),
	.c3_p2_cmd_en           (c3_p2_cmd_en),
	.c3_p2_cmd_instr        (c3_p2_cmd_instr),
	.c3_p2_cmd_bl           (c3_p2_cmd_bl),
	.c3_p2_cmd_byte_addr    (c3_p2_cmd_byte_addr),
	.c3_p2_cmd_empty        (c3_p2_cmd_empty),
	.c3_p2_cmd_full         (c3_p2_cmd_full),

	.c3_p2_wr_clk			(c3_clk0),
	.c3_p2_wr_en            (c3_p2_wr_en),
	.c3_p2_wr_mask          (c3_p2_wr_mask),
	.c3_p2_wr_data          (c3_p2_wr_data),
	.c3_p2_wr_full          (c3_p2_wr_full),
	.c3_p2_wr_empty         (c3_p2_wr_empty),
	.c3_p2_wr_count         (c3_p2_wr_count),
	.c3_p2_wr_underrun      (c3_p2_wr_underrun),
	.c3_p2_wr_error         (c3_p2_wr_error),

	.c3_p2_rd_clk			(c3_clk0),
	.c3_p2_rd_en            (c3_p2_rd_en),
	.c3_p2_rd_data          (c3_p2_rd_data),
	.c3_p2_rd_full          (c3_p2_rd_full),
	.c3_p2_rd_empty         (c3_p2_rd_empty),
	.c3_p2_rd_count         (c3_p2_rd_count),
	.c3_p2_rd_overflow      (c3_p2_rd_overflow),
	.c3_p2_rd_error         (c3_p2_rd_error),

	.c3_p3_cmd_clk			(c3_clk0),
	.c3_p3_cmd_en           (c3_p3_cmd_en),
	.c3_p3_cmd_instr        (c3_p3_cmd_instr),
	.c3_p3_cmd_bl           (c3_p3_cmd_bl),
	.c3_p3_cmd_byte_addr    (c3_p3_cmd_byte_addr),
	.c3_p3_cmd_empty        (c3_p3_cmd_empty),
	.c3_p3_cmd_full         (c3_p3_cmd_full),

	.c3_p3_wr_clk			(c3_clk0),
	.c3_p3_wr_en            (c3_p3_wr_en),
	.c3_p3_wr_mask          (c3_p3_wr_mask),
	.c3_p3_wr_data          (c3_p3_wr_data),
	.c3_p3_wr_full          (c3_p3_wr_full),
	.c3_p3_wr_empty         (c3_p3_wr_empty),
	.c3_p3_wr_count         (c3_p3_wr_count),
	.c3_p3_wr_underrun      (c3_p3_wr_underrun),
	.c3_p3_wr_error         (c3_p3_wr_error),

	.c3_p3_rd_clk			(c3_clk0),
	.c3_p3_rd_en            (c3_p3_rd_en),
	.c3_p3_rd_data          (c3_p3_rd_data),
	.c3_p3_rd_full          (c3_p3_rd_full),
	.c3_p3_rd_empty         (c3_p3_rd_empty),
	.c3_p3_rd_count         (c3_p3_rd_count),
	.c3_p3_rd_overflow      (c3_p3_rd_overflow),
	.c3_p3_rd_error         (c3_p3_rd_error));
	
//output MUX
wire [9:0] 	p0_count, p1_count, p2_count, p3_count, p0_count_data0;
wire 	   	p0_we_data0;
wire 		p0_we_csb;
wire [31:0] p0_data_csb;
wire [31:0] p0_data, p1_data, p2_data, p3_data;
wire [31:0] p0_data_data0;
assign p0_count = ep00wire[4]?(op_run?p0_count_data0:cmd_fifo_wr_count):pipe_out_wr_count;
assign p0_we_data0 = (ep00wire[4] & op_run) ? p0_we: 1'b0;
assign p0_data_data0 = (ep00wire[4] & op_run) ? p0_data: 32'h0000_0000;
assign p0_we_csb = (ep00wire[4] & ~op_run) ? p0_we: 1'b0;
assign p0_data_csb = (ep00wire[4] & ~op_run) ? p0_data: 32'h0000_0000;
assign pipe_out_write = ep00wire[4] ? 1'b0: p0_we;
assign pipe_out_data = ep00wire[4] ? 32'h0000_0000: p0_data;

//TODO: Add input start address and parsing in dma
dma dma_p0 ( // only dma_p0 and p2 can write to sdram, port0, conv3x3 data, maxpool data, avepool data, result write back
	.clk			(c3_clk0),
	.reset			(ep00wire[2] | c3_rst0), 
	.reads_en		(ep00wire[0] | p0_reads_en),		//in		-- okPipeOut/cmd/data0 FIFO
	.writes_en		(ep00wire[1]),			//in		-- okPipeIn
	.calib_done		(c3_calib_done), 

	.ib_re			(pipe_in_read),			//out		-- from okPipeIn
	.ib_data		(pipe_in_data),			//in		-- from okPipeIn
	.ib_count		(pipe_in_rd_count),		//in		-- from okPipeIn
	.ib_valid		(pipe_in_valid),		//in		-- from okPipeIn
	.ib_empty		(pipe_in_empty),		//in		-- from okPipeIn

	.ob_we			(p0_we),				//out		-- to okPipeOut/cmd/data0 FIFO
	.ob_data		(p0_data),				//out		-- to okPipeOut/cmd/data0 FIFO
	.ob_count		(p0_count),				//in		-- from okPipeOut/cmd/data0 FIFO

	.rd_en			(c3_p0_rd_en),  		//out		-- to MCB Port0
	.rd_empty		(c3_p0_rd_empty), 		//in		-- from MCB Port0
	.rd_data		(c3_p0_rd_data), 		//in		-- from MCB Port0

	.cmd_en			(c3_p0_cmd_en),			//out		-- to MCB Port0
	.cmd_full		(c3_p0_cmd_full), 		//in		-- from MCB Port0
	.cmd_instr		(c3_p0_cmd_instr),		//out		-- to MCB Port0
	.cmd_byte_addr	(c3_p0_cmd_byte_addr),	//out		-- to MCB Port0
	.cmd_bl			(c3_p0_cmd_bl), 		//out		-- to MCB Port0

	.wr_en			(c3_p0_wr_en),			//out		-- to MCB Port0
	.wr_full		(c3_p0_wr_full), 		//in		-- from MCB Port0
	.wr_data		(c3_p0_wr_data), 		//out		-- to MCB Port0
	.wr_mask		(c3_p0_wr_mask),		//out		-- to MCB Port0
	.start_addr		(30'h0000_0000),		//in		-- from csb
	.op_num			());					//in 		-- from csb

dma dma_p1 ( // Read only, port1, conv3x3 weight
	.clk			(c3_clk0),
	.reset			(ep00wire[2] | c3_rst0), 
	.reads_en		(p1_reads_en),			//in		-- weight0
	.writes_en		(1'b0),	
	.calib_done		(c3_calib_done), 

	.ob_we			(p1_we),				//out		-- to weight0 FIFO
	.ob_data		(p1_data),				//out		-- to weight0 FIFO
	.ob_count		(p1_count),				//in		-- from weight0 FIFO

	.rd_en			(c3_p1_rd_en),  		//out		-- to MCB Port1
	.rd_empty		(c3_p1_rd_empty), 		//in		-- from MCB Port1
	.rd_data		(c3_p1_rd_data), 		//in		-- from MCB Port1

	.cmd_en			(c3_p1_cmd_en),			//out		-- to MCB Port1
	.cmd_full		(c3_p1_cmd_full), 		//in		-- from MCB Port1
	.cmd_instr		(c3_p1_cmd_instr),		//out		-- to MCB Port1
	.cmd_byte_addr	(c3_p1_cmd_byte_addr), 	//out		-- to MCB Port1
	.cmd_bl			(c3_p1_cmd_bl), 		//out		-- to MCB Port1
	.start_addr		(30'h0000_0000),		//in		-- from csb
	.op_num			());					//in 		-- from csb

dma dma_p2 ( // Read and Write, port2, conv1x1 data
	.clk			(c3_clk0),
	.reset			(ep00wire[2] | c3_rst0), 
	.reads_en		(p2_reads_en),			//in		-- data1
	.writes_en		(),
	.calib_done		(c3_calib_done), 

	.ib_re			(),			//out		-- from
	.ib_data		(),			//in		-- from
	.ib_count		(),		//in		-- from
	.ib_valid		(),		//in		-- from
	.ib_empty		(),		//in		-- from

	.ob_we			(p2_we),				//out		-- to data1 FIFO
	.ob_data		(p2_data),				//out		-- to data1 FIFO
	.ob_count		(p2_count),				//in		-- from data1 FIFO

	.rd_en			(c3_p2_rd_en),  		//out		-- to MCB Port2
	.rd_empty		(c3_p2_rd_empty), 		//in		-- from MCB Port2
	.rd_data		(c3_p2_rd_data), 		//in		-- from MCB Port2

	.cmd_en			(c3_p2_cmd_en),			//out		-- to MCB Port2
	.cmd_full		(c3_p2_cmd_full), 		//in		-- from MCB Port2
	.cmd_instr		(c3_p2_cmd_instr),		//out		-- to MCB Port2
	.cmd_byte_addr	(c3_p2_cmd_byte_addr), 	//out		-- to MCB Port2
	.cmd_bl			(c3_p2_cmd_bl),			//out		-- to MCB Port2

	.wr_en			(c3_p2_wr_en),			//out		-- to MCB Port2
	.wr_full		(c3_p2_wr_full), 		//in		-- from MCB Port2
	.wr_data		(c3_p2_wr_data), 		//out		-- to MCB Port2
	.wr_mask		(c3_p2_wr_mask),		//out		-- to MCB Port2
	.start_addr		(30'h0000_0000),		//in		-- from csb
	.op_num			());					//in 		-- from csb

dma dma_p3 ( // Read Only, port3, conv1x1 weight
	.clk			(c3_clk0),
	.reset			(ep00wire[2] | c3_rst0), 
	.reads_en		(p3_reads_en),			//in		-- weight1
	.writes_en		(1'b0),
	.calib_done		(c3_calib_done), 

	.ob_we			(p3_we),				//out		-- to weight1 FIFO
	.ob_data		(p3_data),				//out		-- to weight1 FIFO
	.ob_count		(p3_count),				//in		-- from weight1 FIFO

	.rd_en			(c3_p3_rd_en),  		//out		-- to MCB Port3
	.rd_empty		(c3_p3_rd_empty), 		//in		-- from MCB Port3
	.rd_data		(c3_p3_rd_data), 		//in		-- from MCB Port3

	.cmd_en			(c3_p3_cmd_en),			//out		-- to MCB Port3
	.cmd_full		(c3_p3_cmd_full), 		//in		-- from MCB Port3
	.cmd_instr		(c3_p3_cmd_instr),		//out		-- to MCB Port3
	.cmd_byte_addr	(c3_p3_cmd_byte_addr), 	//out		-- to MCB Port3
	.cmd_bl			(c3_p3_cmd_bl), 		//out		-- to MCB Port3
	.start_addr		(30'h0000_0000),		//in		-- from csb
	.op_num			());					//in 		-- from csb
	
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

//------------------------------------------------
// PC Communication using Front Panel(TM)
//------------------------------------------------

// Instantiate the okHost and connect endpoints.
//ep00wire: 0: pipe read, 1: pipe write, 2: reset pipefifos and dma, 3: reset csb and command fifos, 4: op_en
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
	.rst			(ep00wire[2]),			// input
	.wr_clk			(okClk),				// input
	.rd_clk			(c3_clk0),				// input
	.din			(pi0_ep_dataout), 		// input, Bus [31 : 0] 
	.wr_en			(pi0_ep_write),			// input
	.rd_en			(pipe_in_read),			// input
	.dout			(pipe_in_data), 		// output, Bus [31 : 0] 
	.full			(pipe_in_full),			// output
	.empty			(pipe_in_empty),		// output
	.valid			(pipe_in_valid),		// output
	.rd_data_count	(pipe_in_rd_count), 	// output, Bus [9 : 0] 
	.wr_data_count	(pipe_in_wr_count));	// output, Bus [9 : 0] 

fifo_w32_1024_r32_1024 okPipeOut_fifo (
	.rst			(ep00wire[2]),			// input
	.wr_clk			(c3_clk0),				// input
	.rd_clk			(okClk),				// input
	.din			(pipe_out_data), 		// input, Bus [31 : 0] 
	.wr_en			(pipe_out_write),		// input
	.rd_en			(po0_ep_read),			// input
	.dout			(po0_ep_datain), 		// output, Bus [31 : 0] 
	.full			(pipe_out_full),		// output
	.empty			(pipe_out_empty),		// output
	.valid			(), 					// NC		
	.rd_data_count	(pipe_out_rd_count), 	// output, Bus [9 : 0] 
	.wr_data_count	(pipe_out_wr_count));	// output, Bus [9 : 0] 

//FIFO for: CSB Command
fifo_w32_1024_r32_1024 csb_cmd_fifo (
	.rst			(ep00wire[3]),			// input
	.wr_clk			(c3_clk0),				// input
	.rd_clk			(c3_clk0),				// input
	.din			(p0_data_csb), 			// input, Bus [31 : 0] 
	.wr_en			(p0_we_csb),			// input
	.rd_en			(cmd_fifo_rd_en),		// input
	.dout			(cmd), 					// output, Bus [31 : 0] 
	.full			(), 					// NC
	.empty			(cmd_fifo_empty),		// output
	.valid			(), 					// NC
	.rd_data_count	(), 					// output, Bus [9 : 0] 
	.wr_data_count	(cmd_fifo_wr_count)); 	// output, Bus [9 : 0] 

fifo_w32_1024_r32_1024 p0_data_fifo (
	.rst			(ep00wire[3]),			// input
	.wr_clk			(c3_clk0),				// input
	.rd_clk			(c3_clk0),				// input
	.din			(p0_data_data0), 		// input, Bus [31 : 0] 
	.wr_en			(p0_we_data0),			// input
	.rd_en			(p0_data_fifo_rd_en),	// input
	.dout			(data_0), 				// output, Bus [31 : 0] 
	.full			(), 					// NC
	.empty			(p0_data_fifo_empty),	// output
	.valid			(), 					// NC
	.rd_data_count	(), 					// output, Bus [9 : 0] 
	.wr_data_count	(p0_count_data0)); 		// output, Bus [9 : 0] 

fifo_w32_1024_r32_1024 p0_weight_fifo (
	.rst			(ep00wire[3]),			// input
	.wr_clk			(c3_clk0),				// input
	.rd_clk			(c3_clk0),				// input
	.din			(p1_data), 				// input, Bus [31 : 0] 
	.wr_en			(p1_wr),				// input
	.rd_en			(p0_weight_fifo_rd_en),	// input
	.dout			(weight_0), 			// output, Bus [31 : 0] 
	.full			(), 					// NC
	.empty			(p0_weight_fifo_empty),	// output
	.valid			(), 					// NC
	.rd_data_count	(), 					// output, Bus [9 : 0] 
	.wr_data_count	(p1_count)); 			// output, Bus [9 : 0] 

//FIFO for: CONV3x3, CONV3x3 & CONV1x1, MAXPOOL3x3
fifo_w32_1024_r32_1024 p1_data_fifo (
	.rst			(ep00wire[3]),			// input
	.wr_clk			(c3_clk0),				// input
	.rd_clk			(c3_clk0),				// input
	.din			(p2_data), 				// input, Bus [31 : 0] 
	.wr_en			(p2_wr),				// input
	.rd_en			(p1_data_fifo_rd_en),	// input
	.dout			(data_1), 				// output, Bus [31 : 0] 
	.full			(), 					// NC
	.empty			(p1_data_fifo_empty),	// output
	.valid			(), 					// NC
	.rd_data_count	(), 					// output, Bus [9 : 0] 
	.wr_data_count	(p2_count)); 			// output, Bus [9 : 0] 

fifo_w32_1024_r32_1024 p1_weight_fifo (
	.rst			(ep00wire[3]),			// input
	.wr_clk			(c3_clk0),				// input
	.rd_clk			(c3_clk0),				// input
	.din			(p3_data), 				// input, Bus [31 : 0] 
	.wr_en			(p3_wr),				// input
	.rd_en			(p1_weight_fifo_rd_en),	// input
	.dout			(weight_1), 			// output, Bus [31 : 0] 
	.full			(), 					// NC
	.empty			(p1_weight_fifo_empty),	// output
	.valid			(), 					// NC
	.rd_data_count	(), 					// output, Bus [9 : 0] 
	.wr_data_count	(p3_count)); 			// output, Bus [9 : 0] 

fifo_w32_1024_r32_1024 p0_write_fifo (
	.rst			(ep00wire[3]),			// input
	.wr_clk			(c3_clk0),				// input
	.rd_clk			(c3_clk0),				// input
	.din			(p0_result), 			// input, Bus [31 : 0] 
	.wr_en			(p0_write_fifo_en),		// input, from engine
	.rd_en			(),						// input, from dma
	.dout			(), 					// output, Bus [31 : 0] 
	.full			(),						// 
	.empty			(),						// output
	.valid			(),						//
	.rd_data_count	(), 					// output, Bus [9 : 0] 
	.wr_data_count	()); 					// output, Bus [9 : 0] 

fifo_w32_1024_r32_1024 p1_write_fifo (
	.rst			(ep00wire[3]),			// input
	.wr_clk			(c3_clk0),				// input
	.rd_clk			(c3_clk0),				// input
	.din			(p1_result), 			// input, Bus [31 : 0] 
	.wr_en			(p1_write_fifo_en),		// input, from engine
	.rd_en			(),						// input, from dma
	.dout			(), 					// output, Bus [31 : 0] 
	.full			(),						//
	.empty			(),						// output
	.valid			(),						//
	.rd_data_count	(), 					// output, Bus [9 : 0] 
	.wr_data_count	()); 					// output, Bus [9 : 0] 

//--------------v2, More complicate Cores for Other Function and Networks--//
//reshape reshape_(); //Memory Reshape and Concatenation Core
//acti acti_(); //Activation Core
//lut lut_(); //Loop up table for activation and lrn cores
//lrn lrn_(); //Local response normalization Core

endmodule