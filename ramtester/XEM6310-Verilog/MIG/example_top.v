//*****************************************************************************
// (c) Copyright 2009 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 3.5
//  \   \         Application        : MIG
//  /   /         Filename           : example_top.v
// /___/   /\     Date Last Modified : $Date$
// \   \  /  \    Date Created       : Mon Mar 2 2009
//  \___\/\___\
//
//Device           : Spartan-6
//Design Name      : DDR/DDR2/DDR3/LPDDR 
//Purpose          : This is the design top level. which instantiates top wrapper,
//                   test bench top and infrastructure modules.
//Reference        :
//Revision History :
//*****************************************************************************
`timescale 1ns/1ps

module example_top  #
  (
   parameter C3_P0_MASK_SIZE           = 4,
   parameter C3_P0_DATA_PORT_SIZE      = 32,
   parameter C3_P1_MASK_SIZE           = 4,
   parameter C3_P1_DATA_PORT_SIZE      = 32,
   parameter DEBUG_EN                = 0,       
   parameter C3_MEMCLK_PERIOD        = 3200,       
   parameter C3_CALIB_SOFT_IP        = "TRUE",       
   parameter C3_SIMULATION           = "FALSE",       
   parameter C3_HW_TESTING           = "FALSE",       
   parameter C3_RST_ACT_LOW          = 0,       
   parameter C3_INPUT_CLK_TYPE       = "DIFFERENTIAL",       
   parameter C3_MEM_ADDR_ORDER       = "ROW_BANK_COLUMN",       
   parameter C3_NUM_DQ_PINS          = 16,       
   parameter C3_MEM_ADDR_WIDTH       = 13,       
   parameter C3_MEM_BANKADDR_WIDTH   = 3        
   )
   
  (
   output                                           calib_done,
   output                                           error,
   inout  [C3_NUM_DQ_PINS-1:0]                      mcb3_dram_dq,
   output [C3_MEM_ADDR_WIDTH-1:0]                   mcb3_dram_a,
   output [C3_MEM_BANKADDR_WIDTH-1:0]               mcb3_dram_ba,
   output                                           mcb3_dram_ras_n,
   output                                           mcb3_dram_cas_n,
   output                                           mcb3_dram_we_n,
   output                                           mcb3_dram_odt,
   output                                           mcb3_dram_cke,
   output                                           mcb3_dram_dm,
   inout                                            mcb3_dram_udqs,
   inout                                            mcb3_dram_udqs_n,
   inout                                            mcb3_rzq,
   inout                                            mcb3_zio,
   output                                           mcb3_dram_udm,
   input                                            c3_sys_clk_p,
   input                                            c3_sys_clk_n,
   input                                            c3_sys_rst_n,
   inout                                            mcb3_dram_dqs,
   inout                                            mcb3_dram_dqs_n,
   output                                           mcb3_dram_ck,
   output                                           mcb3_dram_ck_n
   );

   localparam C3_CLKOUT0_DIVIDE       = 1;       
   localparam C3_CLKOUT1_DIVIDE       = 1;       
   localparam C3_CLKOUT2_DIVIDE       = 16;       
   localparam C3_CLKOUT3_DIVIDE       = 8;       
   localparam C3_CLKFBOUT_MULT        = 2;       
   localparam C3_DIVCLK_DIVIDE        = 1;       
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
   localparam C3_MEM_DDR1_2_ODS       = "REDUCED";       
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
  wire                              c3_sys_clk;
  wire                              c3_error;
  wire                              c3_calib_done;
  wire                              c3_clk0;
  wire                              c3_rst0;
  wire                              c3_async_rst;
  wire                              c3_sysclk_2x;
  wire                              c3_sysclk_2x_180;
  wire                              c3_pll_ce_0;
  wire                              c3_pll_ce_90;
  wire                              c3_pll_lock;
  wire                              c3_mcb_drp_clk;
  wire                              c3_cmp_error;
  wire                              c3_cmp_data_valid;
  wire                              c3_vio_modify_enable;
  wire  [127:0]                      c3_error_status;
  wire  [2:0]                      c3_vio_data_mode_value;
  wire  [2:0]                      c3_vio_addr_mode_value;
  wire  [31:0]                      c3_cmp_data;
  wire		c3_p0_cmd_en;
  wire [2:0]	c3_p0_cmd_instr;
  wire [5:0]	c3_p0_cmd_bl;
  wire [29:0]	c3_p0_cmd_byte_addr;
  wire		c3_p0_cmd_empty;
  wire		c3_p0_cmd_full;
  wire		c3_p0_wr_en;
  wire [C3_P0_MASK_SIZE - 1:0]	c3_p0_wr_mask;
  wire [C3_P0_DATA_PORT_SIZE - 1:0]	c3_p0_wr_data;
  wire		c3_p0_wr_full;
  wire		c3_p0_wr_empty;
  wire [6:0]	c3_p0_wr_count;
  wire		c3_p0_wr_underrun;
  wire		c3_p0_wr_error;
  wire		c3_p0_rd_en;
  wire [C3_P0_DATA_PORT_SIZE - 1:0]	c3_p0_rd_data;
  wire		c3_p0_rd_full;
  wire		c3_p0_rd_empty;
  wire [6:0]	c3_p0_rd_count;
  wire		c3_p0_rd_overflow;
  wire		c3_p0_rd_error;




assign error = c3_error;
assign calib_done = c3_calib_done;
assign  c3_sys_clk = 1'b0;

memc3_infrastructure #
 (
   .C_MEMCLK_PERIOD                  (C3_MEMCLK_PERIOD),
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
   .sys_clk_p                      (c3_sys_clk_p),
   .sys_clk_n                      (c3_sys_clk_n),
   .sys_clk                        (c3_sys_clk),
   .sys_rst_n                      (c3_sys_rst_n),
   .clk0                           (c3_clk0),
   .rst0                           (c3_rst0),
   .async_rst                      (c3_async_rst),
   .sysclk_2x                      (c3_sysclk_2x),
   .sysclk_2x_180                  (c3_sysclk_2x_180),
   .pll_ce_0                       (c3_pll_ce_0),
   .pll_ce_90                      (c3_pll_ce_90),
   .pll_lock                       (c3_pll_lock),
   .mcb_drp_clk                    (c3_mcb_drp_clk)
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
   .mcb3_dram_dq                        (mcb3_dram_dq),
   .mcb3_dram_a                         (mcb3_dram_a),
   .mcb3_dram_ba                        (mcb3_dram_ba),
   .mcb3_dram_ras_n                     (mcb3_dram_ras_n),
   .mcb3_dram_cas_n                     (mcb3_dram_cas_n),
   .mcb3_dram_we_n                      (mcb3_dram_we_n),
   .mcb3_dram_odt                       (mcb3_dram_odt),
   .mcb3_dram_cke                       (mcb3_dram_cke),
   .mcb3_dram_dm                        (mcb3_dram_dm),
   .mcb3_dram_udqs                      (mcb3_dram_udqs),
   .mcb3_dram_udqs_n                    (mcb3_dram_udqs_n),
   .mcb3_rzq                            (mcb3_rzq),
   .mcb3_zio                            (mcb3_zio),
   .mcb3_dram_udm                       (mcb3_dram_udm),
   .calib_done                     (c3_calib_done),
   .async_rst                      (c3_async_rst),
   .sysclk_2x                      (c3_sysclk_2x),
   .sysclk_2x_180                  (c3_sysclk_2x_180),
   .pll_ce_0                       (c3_pll_ce_0),
   .pll_ce_90                      (c3_pll_ce_90),
   .pll_lock                       (c3_pll_lock),
   .mcb_drp_clk                    (c3_mcb_drp_clk),
   .mcb3_dram_dqs                       (mcb3_dram_dqs),
   .mcb3_dram_dqs_n                     (mcb3_dram_dqs_n),
   .mcb3_dram_ck                        (mcb3_dram_ck),
   .mcb3_dram_ck_n                      (mcb3_dram_ck_n),
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

 memc3_tb_top #
 (
   .C_SIMULATION                     (C3_SIMULATION),
   .C_NUM_DQ_PINS                    (C3_NUM_DQ_PINS),
   .C_MEM_BURST_LEN                  (C3_MEM_BURST_LEN),
   .C_MEM_NUM_COL_BITS               (C3_MEM_NUM_COL_BITS),
   .C_p0_BEGIN_ADDRESS                      (C3_p0_BEGIN_ADDRESS),
   .C_p0_DATA_MODE                          (C3_p0_DATA_MODE),
   .C_p0_END_ADDRESS                        (C3_p0_END_ADDRESS),
   .C_p0_PRBS_EADDR_MASK_POS                (C3_p0_PRBS_EADDR_MASK_POS),
   .C_p0_PRBS_SADDR_MASK_POS                (C3_p0_PRBS_SADDR_MASK_POS)
   )
memc3_tb_top_inst
(
   .error                          (c3_error),
   .calib_done                     (c3_calib_done),
   .clk0                           (c3_clk0),
   .rst0                           (c3_rst0),
   .cmp_error                      (c3_cmp_error),
   .cmp_data_valid                 (c3_cmp_data_valid),
   .vio_modify_enable              (c3_vio_modify_enable),
   .error_status                   (c3_error_status),
   .vio_data_mode_value            (c3_vio_data_mode_value),
   .vio_addr_mode_value            (c3_vio_addr_mode_value),
   .cmp_data                       (c3_cmp_data),
   .p0_mcb_cmd_en_o                         (c3_p0_cmd_en),
   .p0_mcb_cmd_instr_o                      (c3_p0_cmd_instr),
   .p0_mcb_cmd_bl_o                         (c3_p0_cmd_bl),
   .p0_mcb_cmd_addr_o                       (c3_p0_cmd_byte_addr),
   .p0_mcb_cmd_full_i                       (c3_p0_cmd_full),
   .p0_mcb_wr_en_o                          (c3_p0_wr_en),
   .p0_mcb_wr_mask_o                        (c3_p0_wr_mask),
   .p0_mcb_wr_data_o                        (c3_p0_wr_data),
   .p0_mcb_wr_full_i                        (c3_p0_wr_full),
   .p0_mcb_wr_fifo_counts                   (c3_p0_wr_count),
   .p0_mcb_rd_en_o                          (c3_p0_rd_en),
   .p0_mcb_rd_data_i                        (c3_p0_rd_data),
   .p0_mcb_rd_empty_i                       (c3_p0_rd_empty),
   .p0_mcb_rd_fifo_counts                   (c3_p0_rd_count)
  );

 


endmodule
 

