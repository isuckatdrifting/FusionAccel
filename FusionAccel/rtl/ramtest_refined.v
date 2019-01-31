//------------------------------------------------------------------------
// ramtest.v
//
// This sample uses the Xilinx MIG DDR2 controller and HDL to move data
// from the PC to the DDR2 and vice-versa. Based on MIG generated example_top.v
//
// Host Interface registers:
// WireIn 0x00
//     0 - DDR2 read enable (0=disabled, 1=enabled)
//     1 - DDR2 write enable (0=disabled, 1=enabled)
//     2 - Reset
//
// PipeIn 0x80 - DDR2 write port (U11, DDR2)
// PipeOut 0xA0 - DDR2 read port (U11, DDR2)
//
// This sample is included for reference only.  No guarantees, either 
// expressed or implied, are to be drawn.
//------------------------------------------------------------------------
// tabstop 3
// Copyright (c) 2005-2009 Opal Kelly Incorporated
// $Rev$ $Date$
//------------------------------------------------------------------------
`timescale 1ns/1ps

module ramtest  #(
	parameter C3_P0_MASK_SIZE           = 4,
	parameter C3_P0_DATA_PORT_SIZE      = 32,
	parameter C3_P1_MASK_SIZE           = 4,
	parameter C3_P1_DATA_PORT_SIZE      = 32,    
	parameter C3_NUM_DQ_PINS            = 16,       
	parameter C3_MEM_ADDR_WIDTH         = 13,       
	parameter C3_MEM_BANKADDR_WIDTH     = 3        
	)
	(
	
	input  wire [4:0]   okUH,
	output wire [2:0]   okHU,
	inout  wire [31:0]  okUHU,
	inout  wire         okAA,

	input  wire         sys_clkp,
	input  wire         sys_clkn,
	
	output wire [7:0]   led,
	
	inout  wire [C3_NUM_DQ_PINS-1:0]         ddr2_dq,
	output wire [C3_MEM_ADDR_WIDTH-1:0]      ddr2_a,
	output wire [C3_MEM_BANKADDR_WIDTH-1:0]  ddr2_ba,
	output wire                              ddr2_ras_n,
	output wire                              ddr2_cas_n,
	output wire                              ddr2_we_n,
	output wire                              ddr2_odt,
	output wire                              ddr2_cke,
	output wire                              ddr2_dm,
	inout  wire                              ddr2_udqs,
	inout  wire                              ddr2_udqs_n,
	inout  wire                              ddr2_rzq,
	inout  wire                              ddr2_zio,
	output wire                              ddr2_udm,
	inout  wire                              ddr2_dqs,
	inout  wire                              ddr2_dqs_n,
	output wire                              ddr2_ck,
	output wire                              ddr2_ck_n,
	output wire                              ddr2_cs_n
);

	localparam BLOCK_SIZE      = 128;   // 512 bytes / 4 byte per word;
	localparam FIFO_SIZE       = 1023;  // note that Xilinx does not allow use of the full 1024 words
	localparam BUFFER_HEADROOM = 20; // headroom for the FIFO count to account for latency

	wire                              c3_sys_clk;
	wire                              c3_error;
	wire                              c3_calib_done;
	wire                              c3_clk0;
	reg                               c3_sys_rst_n;
	wire                              c3_rst0;
	wire                              c3_pll_lock;

	wire                              c3_p0_cmd_en;
	wire [2:0]                        c3_p0_cmd_instr;
	wire [5:0]                        c3_p0_cmd_bl;
	wire [29:0]                       c3_p0_cmd_byte_addr;
	wire                              c3_p0_cmd_empty;
	wire                              c3_p0_cmd_full;
	wire                              c3_p0_wr_en;
	wire [C3_P0_MASK_SIZE - 1:0]      c3_p0_wr_mask;
	wire [C3_P0_DATA_PORT_SIZE - 1:0] c3_p0_wr_data;
	wire                              c3_p0_wr_full;
	wire                              c3_p0_wr_empty;
	wire [6:0]                        c3_p0_wr_count;
	wire                              c3_p0_wr_underrun;
	wire                              c3_p0_wr_error;
	wire                              c3_p0_rd_en;
	wire [C3_P0_DATA_PORT_SIZE - 1:0] c3_p0_rd_data;
	wire                              c3_p0_rd_full;
	wire                              c3_p0_rd_empty;
	wire [6:0]                        c3_p0_rd_count;
	wire                              c3_p0_rd_overflow;
	wire                              c3_p0_rd_error;

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
	.c3_sys_clk_p          		(sys_clkp),
	.c3_sys_clk_n          		(sys_clkn),
	.c3_sys_rst_i      		(c3_sys_rst_n),                      

	.mcb3_dram_dq           		(ddr2_dq),  
	.mcb3_dram_a            		(ddr2_a),  
	.mcb3_dram_ba           		(ddr2_ba),
	.mcb3_dram_ras_n        		(ddr2_ras_n),                        
	.mcb3_dram_cas_n        		(ddr2_cas_n),                        
	.mcb3_dram_we_n         		(ddr2_we_n),                          
	.mcb3_dram_odt          		(ddr2_odt),
	.mcb3_dram_cke          		(ddr2_cke),                          
	.mcb3_dram_ck           		(ddr2_ck),                          
	.mcb3_dram_ck_n         		(ddr2_ck_n),       
	.mcb3_dram_dqs          		(ddr2_dqs),                          
	.mcb3_dram_dqs_n        		(ddr2_dqs_n),
	.mcb3_dram_udqs         		(ddr2_udqs),    // for X16 parts                        
	.mcb3_dram_udqs_n       		(ddr2_udqs_n),  // for X16 parts
	.mcb3_dram_udm          		(ddr2_udm),     // for X16 parts
	.mcb3_dram_dm           		(ddr2_dm),
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

	.c3_p1_cmd_en           (c3_p1_cmd_en),
	.c3_p1_cmd_instr        (c3_p1_cmd_instr),
	.c3_p1_cmd_bl           (c3_p1_cmd_bl),
	.c3_p1_cmd_byte_addr    (c3_p1_cmd_byte_addr),
	.c3_p1_cmd_empty        (c3_p1_cmd_empty),
	.c3_p1_cmd_full         (c3_p1_cmd_full),

	.c3_p1_wr_en            (c3_p1_wr_en),
	.c3_p1_wr_mask          (c3_p1_wr_mask),
	.c3_p1_wr_data          (c3_p1_wr_data),
	.c3_p1_wr_full          (c3_p1_wr_full),
	.c3_p1_wr_empty         (c3_p1_wr_empty),
	.c3_p1_wr_count         (c3_p1_wr_count),
	.c3_p1_wr_underrun      (c3_p1_wr_underrun),
	.c3_p1_wr_error         (c3_p1_wr_error),

	.c3_p1_rd_en            (c3_p1_rd_en),
	.c3_p1_rd_data          (c3_p1_rd_data),
	.c3_p1_rd_full          (c3_p1_rd_full),
	.c3_p1_rd_empty         (c3_p1_rd_empty),
	.c3_p1_rd_count         (c3_p1_rd_count),
	.c3_p1_rd_overflow      (c3_p1_rd_overflow),
	.c3_p1_rd_error         (c3_p1_rd_error));

dma dma_ (
	.clk(c3_clk0),
	.reset(ep00wire[2] | c3_rst0), 
	.reads_en(ep00wire[0]),
	.writes_en(ep00wire[1]),
	.calib_done(c3_calib_done), 

	.ib_re(pipe_in_read),
	.ib_data(pipe_in_data),
	.ib_count(pipe_in_rd_count),
	.ib_valid(pipe_in_valid),
	.ib_empty(pipe_in_empty),

	.ob_we(pipe_out_write),
	.ob_data(pipe_out_data),
	.ob_count(pipe_out_wr_count),

	.rd_en_o(c3_p0_rd_en),  
	.rd_empty(c3_p0_rd_empty), 
	.rd_data(c3_p0_rd_data), 

	.cmd_en(c3_p0_cmd_en),
	.cmd_full(c3_p0_cmd_full), 
	.cmd_instr(c3_p0_cmd_instr),
	.cmd_byte_addr(c3_p0_cmd_byte_addr), 
	.cmd_bl_o(c3_p0_cmd_bl), 

	.wr_en(c3_p0_wr_en),
	.wr_full(c3_p0_wr_full), 
	.wr_data(c3_p0_wr_data), 
	.wr_mask(c3_p0_wr_mask));
	
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

endmodule
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          