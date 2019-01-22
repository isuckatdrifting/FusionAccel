
module memc3 #(
    parameter C3_P0_MASK_SIZE           = 4,
   parameter C3_P0_DATA_PORT_SIZE      = 32,
   parameter C3_P1_MASK_SIZE           = 4,
   parameter C3_P1_DATA_PORT_SIZE      = 32,
   parameter DEBUG_EN                = 0,       
                                       // # = 1, Enable debug signals/controls,
                                       //   = 0, Disable debug signals/controls.
   parameter C3_MEMCLK_PERIOD        = 3200,       
                                       // Memory data transfer clock period
   parameter C3_CALIB_SOFT_IP        = "TRUE",       
                                       // # = TRUE, Enables the soft calibration logic,
                                       // # = FALSE, Disables the soft calibration logic.
   parameter C3_SIMULATION           = "FALSE",       
                                       // # = TRUE, Simulating the design. Useful to reduce the simulation time,
                                       // # = FALSE, Implementing the design.
   parameter C3_HW_TESTING             = "FALSE",  
   parameter C3_RST_ACT_LOW          = 0,       
                                       // # = 1 for active low reset,
                                       // # = 0 for active high reset.
   parameter C3_INPUT_CLK_TYPE       = "DIFFERENTIAL",       
                                       // input clock type DIFFERENTIAL or SINGLE_ENDED
   parameter C3_MEM_ADDR_ORDER       = "ROW_BANK_COLUMN",       
                                       // The order in which user address is provided to the memory controller,
                                       // ROW_BANK_COLUMN or BANK_ROW_COLUMN
   parameter C3_NUM_DQ_PINS          = 16,       
                                       // External memory data width
   parameter C3_MEM_ADDR_WIDTH       = 13,       
                                       // External memory address width
   parameter C3_MEM_BANKADDR_WIDTH   = 3        
                                       // External memory bank address width
)
(
    input  wire         sys_clkp,
	input  wire         sys_clkn,
    input  wire         c3_sys_rst_n,
    inout  [C3_NUM_DQ_PINS-1:0]                      ddr2_dq,
   output [C3_MEM_ADDR_WIDTH-1:0]                   ddr2_a,
   output [C3_MEM_BANKADDR_WIDTH-1:0]               ddr2_ba,
   output                                           ddr2_ras_n,
   output                                           ddr2_cas_n,
   output                                           ddr2_we_n,
   output                                           ddr2_odt,
   output                                           ddr2_cke,
   output                                           ddr2_dm,
   inout                                            ddr2_udqs,
   inout                                            ddr2_udqs_n,
   inout                                            ddr2_rzq,
   inout                                            ddr2_zio,
   output                                           ddr2_udm,
   input                                            c3_sys_clk_p,
   input                                            c3_sys_clk_n,
   input                                            c3_sys_rst_i,
   output                                           c3_calib_done,
   output                                           c3_clk0,
   output                                           c3_rst0,
   inout                                            ddr2_dqs,
   inout                                            ddr2_dqs_n,
   output                                           ddr2_ck,
   output                                           ddr2_ck_n,
      input		c3_p0_cmd_clk,
      input		c3_p0_cmd_en,
      input [2:0]	c3_p0_cmd_instr,
      input [5:0]	c3_p0_cmd_bl,
      input [29:0]	c3_p0_cmd_byte_addr,
      output		c3_p0_cmd_empty,
      output		c3_p0_cmd_full,
      input		c3_p0_wr_clk,
      input		c3_p0_wr_en,
      input [C3_P0_MASK_SIZE - 1:0]	c3_p0_wr_mask,
      input [C3_P0_DATA_PORT_SIZE - 1:0]	c3_p0_wr_data,
      output		c3_p0_wr_full,
      output		c3_p0_wr_empty,
      output [6:0]	c3_p0_wr_count,
      output		c3_p0_wr_underrun,
      output		c3_p0_wr_error,
      input		c3_p0_rd_clk,
      input		c3_p0_rd_en,
      output [C3_P0_DATA_PORT_SIZE - 1:0]	c3_p0_rd_data,
      output		c3_p0_rd_full,
      output		c3_p0_rd_empty,
      output [6:0]	c3_p0_rd_count,
      output		c3_p0_rd_overflow,
      output		c3_p0_rd_error/*,
      input		c3_p1_cmd_clk,
      input		c3_p1_cmd_en,
      input [2:0]	c3_p1_cmd_instr,
      input [5:0]	c3_p1_cmd_bl,
      input [29:0]	c3_p1_cmd_byte_addr,
      output		c3_p1_cmd_empty,
      output		c3_p1_cmd_full,
      input		c3_p1_wr_clk,
      input		c3_p1_wr_en,
      input [C3_P1_MASK_SIZE - 1:0]	c3_p1_wr_mask,
      input [C3_P1_DATA_PORT_SIZE - 1:0]	c3_p1_wr_data,
      output		c3_p1_wr_full,
      output		c3_p1_wr_empty,
      output [6:0]	c3_p1_wr_count,
      output		c3_p1_wr_underrun,
      output		c3_p1_wr_error,
      input		c3_p1_rd_clk,
      input		c3_p1_rd_en,
      output [C3_P1_DATA_PORT_SIZE - 1:0]	c3_p1_rd_data,
      output		c3_p1_rd_full,
      output		c3_p1_rd_empty,
      output [6:0]	c3_p1_rd_count,
      output		c3_p1_rd_overflow,
      output		c3_p1_rd_error*/
);

wire c3_pll_lock;
wire selfrefresh_enter;
wire selfrefresh_mode;

localparam C3_INCLK_PERIOD         = 10000; // 10000ps -> 10ns -> 100Mhz
	localparam C3_CLKOUT0_DIVIDE       = 1;     // 625 MHz system clock      
	localparam C3_CLKOUT1_DIVIDE       = 1;     // 625 MHz system clock (180 deg)      
	localparam C3_CLKOUT2_DIVIDE       = 4;     // 156.256 MHz test bench clock      
	localparam C3_CLKOUT3_DIVIDE       = 8;     // 78.125 MHz calibration clock      
	localparam C3_CLKFBOUT_MULT        = 25;    // 25MHz x 25 = 625 MHz system clock       
	localparam C3_DIVCLK_DIVIDE        = 4;     // 100MHz/4 = 25 Mhz       
	localparam C3_ARB_NUM_TIME_SLOTS   = 12;       
	localparam C3_ARB_TIME_SLOT_0      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_1      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_2      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_3      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_4      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_5      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_6      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_7      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_8      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_9      = 3'o0;       
	localparam C3_ARB_TIME_SLOT_10     = 3'o0;       
	localparam C3_ARB_TIME_SLOT_11     = 3'o0;       
	localparam C3_MEM_TRAS             = 40000;       
	localparam C3_MEM_TRCD             = 15000;       
	localparam C3_MEM_TREFI            = 7800000;       
	localparam C3_MEM_TRFC             = 127500;       
	localparam C3_MEM_TRP              = 15000;       
	localparam C3_MEM_TWR              = 15000;       
	localparam C3_MEM_TRTP             = 7500;       
	localparam C3_MEM_TWTR             = 7500;       
	localparam C3_MEM_TYPE             = "DDR2";       
	localparam C3_MEM_DENSITY          = "1Gb";       
	localparam C3_MEM_BURST_LEN        = 4;       
	localparam C3_MEM_CAS_LATENCY      = 5;       
	localparam C3_MEM_NUM_COL_BITS     = 10;       
	localparam C3_MEM_DDR1_2_ODS       = "FULL";       
	localparam C3_MEM_DDR2_RTT         = "50OHMS";       
	localparam C3_MEM_DDR2_DIFF_DQS_EN  = "YES";       
	localparam C3_MEM_DDR2_3_PA_SR     = "FULL";       
	localparam C3_MEM_DDR2_3_HIGH_TEMP_SR  = "NORMAL";       
	localparam C3_MEM_DDR3_CAS_LATENCY  = 6;       
	localparam C3_MEM_DDR3_ODS         = "DIV6";       
	localparam C3_MEM_DDR3_RTT         = "DIV2";       
	localparam C3_MEM_DDR3_CAS_WR_LATENCY  = 5;       
	localparam C3_MEM_DDR3_AUTO_SR     = "ENABLED";       
	localparam C3_MEM_DDR3_DYN_WRT_ODT  = "OFF";       
	localparam C3_MEM_MOBILE_PA_SR     = "FULL";       
	localparam C3_MEM_MDDR_ODS         = "FULL";       
	localparam C3_MC_CALIB_BYPASS      = "NO";       
	localparam C3_MC_CALIBRATION_MODE  = "CALIBRATION";       
	localparam C3_MC_CALIBRATION_DELAY  = "HALF";       
	localparam C3_SKIP_IN_TERM_CAL     = 0;       
	localparam C3_SKIP_DYNAMIC_CAL     = 0;       
	localparam C3_LDQSP_TAP_DELAY_VAL  = 0;       
	localparam C3_LDQSN_TAP_DELAY_VAL  = 0;       
	localparam C3_UDQSP_TAP_DELAY_VAL  = 0;       
	localparam C3_UDQSN_TAP_DELAY_VAL  = 0;       
	localparam C3_DQ0_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ1_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ2_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ3_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ4_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ5_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ6_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ7_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ8_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ9_TAP_DELAY_VAL    = 0;       
	localparam C3_DQ10_TAP_DELAY_VAL   = 0;       
	localparam C3_DQ11_TAP_DELAY_VAL   = 0;       
	localparam C3_DQ12_TAP_DELAY_VAL   = 0;       
	localparam C3_DQ13_TAP_DELAY_VAL   = 0;       
	localparam C3_DQ14_TAP_DELAY_VAL   = 0;       
	localparam C3_DQ15_TAP_DELAY_VAL   = 0;       
	localparam C3_p0_BEGIN_ADDRESS                   = (C3_HW_TESTING == "TRUE") ? 32'h01000000:32'h00000100;
	localparam C3_p0_DATA_MODE                       = 4'b0010;
	localparam C3_p0_END_ADDRESS                     = (C3_HW_TESTING == "TRUE") ? 32'h02ffffff:32'h000002ff;
	localparam C3_p0_PRBS_EADDR_MASK_POS             = (C3_HW_TESTING == "TRUE") ? 32'hfc000000:32'hfffffc00;
	localparam C3_p0_PRBS_SADDR_MASK_POS             = (C3_HW_TESTING == "TRUE") ? 32'h01000000:32'h00000100;

    
memc3_infrastructure #
	(
		.C_MEMCLK_PERIOD                  (C3_INCLK_PERIOD),
		.C_RST_ACT_LOW                    (C3_RST_ACT_LOW),
		.C_INPUT_CLK_TYPE                 (C3_INPUT_CLK_TYPE),
		.C_CLKOUT0_DIVIDE                 (C3_CLKOUT0_DIVIDE),
		.C_CLKOUT1_DIVIDE                 (C3_CLKOUT1_DIVIDE),
		.C_CLKOUT2_DIVIDE                 (C3_CLKOUT2_DIVIDE),
		.C_CLKOUT3_DIVIDE                 (C3_CLKOUT3_DIVIDE),
		.C_CLKFBOUT_MULT                  (C3_CLKFBOUT_MULT),
		.C_DIVCLK_DIVIDE                  (C3_DIVCLK_DIVIDE)
	)
memc3_infrastructure_inst
	(
		.sys_clk_p                        (sys_clkp),
		.sys_clk_n                        (sys_clkn),
		.sys_clk                          (c3_sys_clk),
		.sys_rst_n                        (c3_sys_rst_n),
		.clk0                             (c3_clk0),
		.rst0                             (c3_rst0),
		.async_rst                        (c3_async_rst),
		.sysclk_2x                        (c3_sysclk_2x),
		.sysclk_2x_180                    (c3_sysclk_2x_180),
		.pll_ce_0                         (c3_pll_ce_0),
		.pll_ce_90                        (c3_pll_ce_90),
		.pll_lock                         (c3_pll_lock),
		.mcb_drp_clk                      (c3_mcb_drp_clk)
	);

// wrapper instantiation
 memc3_wrapper #
	(
		.C_MEMCLK_PERIOD                  (C3_MEMCLK_PERIOD),
		.C_CALIB_SOFT_IP                  (C3_CALIB_SOFT_IP),
		.C_SIMULATION                     (C3_SIMULATION),
		.C_ARB_NUM_TIME_SLOTS             (C3_ARB_NUM_TIME_SLOTS),
		.C_ARB_TIME_SLOT_0                (C3_ARB_TIME_SLOT_0),
		.C_ARB_TIME_SLOT_1                (C3_ARB_TIME_SLOT_1),
		.C_ARB_TIME_SLOT_2                (C3_ARB_TIME_SLOT_2),
		.C_ARB_TIME_SLOT_3                (C3_ARB_TIME_SLOT_3),
		.C_ARB_TIME_SLOT_4                (C3_ARB_TIME_SLOT_4),
		.C_ARB_TIME_SLOT_5                (C3_ARB_TIME_SLOT_5),
		.C_ARB_TIME_SLOT_6                (C3_ARB_TIME_SLOT_6),
		.C_ARB_TIME_SLOT_7                (C3_ARB_TIME_SLOT_7),
		.C_ARB_TIME_SLOT_8                (C3_ARB_TIME_SLOT_8),
		.C_ARB_TIME_SLOT_9                (C3_ARB_TIME_SLOT_9),
		.C_ARB_TIME_SLOT_10               (C3_ARB_TIME_SLOT_10),
		.C_ARB_TIME_SLOT_11               (C3_ARB_TIME_SLOT_11),
		.C_MEM_TRAS                       (C3_MEM_TRAS),
		.C_MEM_TRCD                       (C3_MEM_TRCD),
		.C_MEM_TREFI                      (C3_MEM_TREFI),
		.C_MEM_TRFC                       (C3_MEM_TRFC),
		.C_MEM_TRP                        (C3_MEM_TRP),
		.C_MEM_TWR                        (C3_MEM_TWR),
		.C_MEM_TRTP                       (C3_MEM_TRTP),
		.C_MEM_TWTR                       (C3_MEM_TWTR),
		.C_MEM_ADDR_ORDER                 (C3_MEM_ADDR_ORDER),
		.C_NUM_DQ_PINS                    (C3_NUM_DQ_PINS),
		.C_MEM_TYPE                       (C3_MEM_TYPE),
		.C_MEM_DENSITY                    (C3_MEM_DENSITY),
		.C_MEM_BURST_LEN                  (C3_MEM_BURST_LEN),
		.C_MEM_CAS_LATENCY                (C3_MEM_CAS_LATENCY),
		.C_MEM_ADDR_WIDTH                 (C3_MEM_ADDR_WIDTH),
		.C_MEM_BANKADDR_WIDTH             (C3_MEM_BANKADDR_WIDTH),
		.C_MEM_NUM_COL_BITS               (C3_MEM_NUM_COL_BITS),
		.C_MEM_DDR1_2_ODS                 (C3_MEM_DDR1_2_ODS),
		.C_MEM_DDR2_RTT                   (C3_MEM_DDR2_RTT),
		.C_MEM_DDR2_DIFF_DQS_EN           (C3_MEM_DDR2_DIFF_DQS_EN),
		.C_MEM_DDR2_3_PA_SR               (C3_MEM_DDR2_3_PA_SR),
		.C_MEM_DDR2_3_HIGH_TEMP_SR        (C3_MEM_DDR2_3_HIGH_TEMP_SR),
		.C_MEM_DDR3_CAS_LATENCY           (C3_MEM_DDR3_CAS_LATENCY),
		.C_MEM_DDR3_ODS                   (C3_MEM_DDR3_ODS),
		.C_MEM_DDR3_RTT                   (C3_MEM_DDR3_RTT),
		.C_MEM_DDR3_CAS_WR_LATENCY        (C3_MEM_DDR3_CAS_WR_LATENCY),
		.C_MEM_DDR3_AUTO_SR               (C3_MEM_DDR3_AUTO_SR),
		.C_MEM_DDR3_DYN_WRT_ODT           (C3_MEM_DDR3_DYN_WRT_ODT),
		.C_MEM_MOBILE_PA_SR               (C3_MEM_MOBILE_PA_SR),
		.C_MEM_MDDR_ODS                   (C3_MEM_MDDR_ODS),
		.C_MC_CALIB_BYPASS                (C3_MC_CALIB_BYPASS),
		.C_MC_CALIBRATION_MODE            (C3_MC_CALIBRATION_MODE),
		.C_MC_CALIBRATION_DELAY           (C3_MC_CALIBRATION_DELAY),
		.C_SKIP_IN_TERM_CAL               (C3_SKIP_IN_TERM_CAL),
		.C_SKIP_DYNAMIC_CAL               (C3_SKIP_DYNAMIC_CAL),
		.C_LDQSP_TAP_DELAY_VAL            (C3_LDQSP_TAP_DELAY_VAL),
		.C_LDQSN_TAP_DELAY_VAL            (C3_LDQSN_TAP_DELAY_VAL),
		.C_UDQSP_TAP_DELAY_VAL            (C3_UDQSP_TAP_DELAY_VAL),
		.C_UDQSN_TAP_DELAY_VAL            (C3_UDQSN_TAP_DELAY_VAL),
		.C_DQ0_TAP_DELAY_VAL              (C3_DQ0_TAP_DELAY_VAL),
		.C_DQ1_TAP_DELAY_VAL              (C3_DQ1_TAP_DELAY_VAL),
		.C_DQ2_TAP_DELAY_VAL              (C3_DQ2_TAP_DELAY_VAL),
		.C_DQ3_TAP_DELAY_VAL              (C3_DQ3_TAP_DELAY_VAL),
		.C_DQ4_TAP_DELAY_VAL              (C3_DQ4_TAP_DELAY_VAL),
		.C_DQ5_TAP_DELAY_VAL              (C3_DQ5_TAP_DELAY_VAL),
		.C_DQ6_TAP_DELAY_VAL              (C3_DQ6_TAP_DELAY_VAL),
		.C_DQ7_TAP_DELAY_VAL              (C3_DQ7_TAP_DELAY_VAL),
		.C_DQ8_TAP_DELAY_VAL              (C3_DQ8_TAP_DELAY_VAL),
		.C_DQ9_TAP_DELAY_VAL              (C3_DQ9_TAP_DELAY_VAL),
		.C_DQ10_TAP_DELAY_VAL             (C3_DQ10_TAP_DELAY_VAL),
		.C_DQ11_TAP_DELAY_VAL             (C3_DQ11_TAP_DELAY_VAL),
		.C_DQ12_TAP_DELAY_VAL             (C3_DQ12_TAP_DELAY_VAL),
		.C_DQ13_TAP_DELAY_VAL             (C3_DQ13_TAP_DELAY_VAL),
		.C_DQ14_TAP_DELAY_VAL             (C3_DQ14_TAP_DELAY_VAL),
		.C_DQ15_TAP_DELAY_VAL             (C3_DQ15_TAP_DELAY_VAL)
	)
memc3_wrapper_inst
	(
		.mcb3_dram_dq                        (ddr2_dq),
		.mcb3_dram_a                         (ddr2_a),
		.mcb3_dram_ba                        (ddr2_ba),
		.mcb3_dram_ras_n                     (ddr2_ras_n),
		.mcb3_dram_cas_n                     (ddr2_cas_n),
		.mcb3_dram_we_n                      (ddr2_we_n),
		.mcb3_dram_odt                       (ddr2_odt),
		.mcb3_dram_cke                       (ddr2_cke),
		.mcb3_dram_dm                        (ddr2_dm),
		.mcb3_dram_udqs                      (ddr2_udqs),
		.mcb3_dram_udqs_n                    (ddr2_udqs_n),
		.mcb3_rzq                            (ddr2_rzq),
		.mcb3_zio                            (ddr2_zio),
		.mcb3_dram_udm                       (ddr2_udm),
		.calib_done                          (c3_calib_done),
		.async_rst                           (c3_async_rst),
		.sysclk_2x                           (c3_sysclk_2x),
		.sysclk_2x_180                       (c3_sysclk_2x_180),
		.pll_ce_0                            (c3_pll_ce_0),
		.pll_ce_90                           (c3_pll_ce_90),
		.pll_lock                            (c3_pll_lock),
		.mcb_drp_clk                         (c3_mcb_drp_clk),
		.mcb3_dram_dqs                       (ddr2_dqs),
		.mcb3_dram_dqs_n                     (ddr2_dqs_n),
		.mcb3_dram_ck                        (ddr2_ck),
		.mcb3_dram_ck_n                      (ddr2_ck_n),
		.p0_cmd_clk                          (c3_clk0),
		.p0_cmd_en                           (c3_p0_cmd_en),
		.p0_cmd_instr                        (c3_p0_cmd_instr),
		.p0_cmd_bl                           (c3_p0_cmd_bl),
		.p0_cmd_byte_addr                    (c3_p0_cmd_byte_addr),
		.p0_cmd_empty                        (c3_p0_cmd_empty),
		.p0_cmd_full                         (c3_p0_cmd_full),
		.p0_wr_clk                           (c3_clk0),
		.p0_wr_en                            (c3_p0_wr_en),
		.p0_wr_mask                          (c3_p0_wr_mask),
		.p0_wr_data                          (c3_p0_wr_data),
		.p0_wr_full                          (c3_p0_wr_full),
		.p0_wr_empty                         (c3_p0_wr_empty),
		.p0_wr_count                         (c3_p0_wr_count),
		.p0_wr_underrun                      (c3_p0_wr_underrun),
		.p0_wr_error                         (c3_p0_wr_error),
		.p0_rd_clk                           (c3_clk0),
		.p0_rd_en                            (c3_p0_rd_en),
		.p0_rd_data                          (c3_p0_rd_data),
		.p0_rd_full                          (c3_p0_rd_full),
		.p0_rd_empty                         (c3_p0_rd_empty),
		.p0_rd_count                         (c3_p0_rd_count),
		.p0_rd_overflow                      (c3_p0_rd_overflow),
		.p0_rd_error                         (c3_p0_rd_error),
		.selfrefresh_enter                   (selfrefresh_enter),
		.selfrefresh_mode                    (selfrefresh_mode)
	);
	
	endmodule