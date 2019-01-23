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
//  /   /         Filename           : memc3_tb_top.v
// /___/   /\     Date Last Modified : $Date$
// \   \  /  \    Date Created       : Mon Mar 2 2009
//  \___\/\___\
//
//Device           : Spartan-6
//Design Name      : DDR/DDR2/DDR3/LPDDR
//Purpose          : This is top level module for test bench. which instantiates 
//                   init_mem_pattern_ctr and mcb_traffic_gen modules for each user
//                   port.
//Reference        :
//Revision History :
//*****************************************************************************

`timescale 1ps/1ps

module memc3_tb_top #(
   parameter C_MEM_BURST_LEN      = 8,	       
   parameter C_MEM_NUM_COL_BITS   = 11,         
   parameter C_NUM_DQ_PINS        = 4,
   parameter C_SIMULATION         = "FALSE",   
   parameter C_P0_MASK_SIZE       = 4,
   parameter C_P0_DATA_PORT_SIZE  = 32,
   parameter C_P1_MASK_SIZE       = 4,
   parameter C_P1_DATA_PORT_SIZE  = 32,

   parameter C_p0_BEGIN_ADDRESS                      = 32'h00000100,
   parameter C_p0_DATA_MODE                          = 4'b0010,
   parameter C_p0_END_ADDRESS                        = 32'h000002ff,
   parameter C_p0_PRBS_EADDR_MASK_POS                = 32'hfffffc00,
   parameter C_p0_PRBS_SADDR_MASK_POS                = 32'h00000100
 )
 (
   input                    clk0, 
   input                    rst0, 
   input                    calib_done, 

   /////////////////////////////////////////////////////////////////////////////
   //  MCB INTERFACE
   // interface to mcb command port

      output		p0_mcb_cmd_en_o,
      output [2:0]	p0_mcb_cmd_instr_o,
      output [5:0]	p0_mcb_cmd_bl_o,
      output [29:0]	p0_mcb_cmd_addr_o,
      input		p0_mcb_cmd_full_i,

      output		p0_mcb_wr_en_o,
      output [C_P0_MASK_SIZE - 1:0]	p0_mcb_wr_mask_o,
      output [C_P0_DATA_PORT_SIZE - 1:0]	p0_mcb_wr_data_o,
      input		p0_mcb_wr_full_i,
      input [6:0]	p0_mcb_wr_fifo_counts,

      output		p0_mcb_rd_en_o,
      input [C_P0_DATA_PORT_SIZE - 1:0]	p0_mcb_rd_data_i,
      input		p0_mcb_rd_empty_i,
      input [6:0]	p0_mcb_rd_fifo_counts,




   /////////////////////////////////////////////////////////////////////////////   
   // vio 
   input          vio_modify_enable,
   input [2:0]    vio_data_mode_value,
   input [2:0]    vio_addr_mode_value,
   // status feedback
   output [31:0]             cmp_data,
   output                    cmp_data_valid,
   output                    cmp_error,
   output                    error,       // asserted whenever the read back data is not correct.
   output [127:0]             error_status // TBD how signals mapped
  );

  
   localparam p0_DWIDTH           = 32;           
     
  
   localparam p0_PORT_MODE        = "BI_MODE";           
  

     
        

    
       

   
     

  
    


   localparam FAMILY                        = "SPARTAN6";  
   localparam DATA_PATTERN                  = "DGEN_ALL";   
   localparam CMD_PATTERN                   = "CGEN_ALL";   
   localparam ADDR_WIDTH                    = 30;           
   localparam CMP_DATA_PIPE_STAGES          = 0;            
   localparam PRBS_SADDR_MASK_POS           = 32'h00007000;
   localparam PRBS_EADDR_MASK_POS           = 32'hFFFF8000;
   localparam PRBS_SADDR                    = 32'h00005000;
   localparam PRBS_EADDR                    = 32'h00007fff;
   localparam BEGIN_ADDRESS                 = 32'h00000000; 
   localparam END_ADDRESS                   = 32'h00000fff; 
   localparam DATA_MODE                     = 4'b0010;
   localparam DQ_ERROR_WIDTH                = (C_NUM_DQ_PINS==4)? 1 : (C_NUM_DQ_PINS/8);









	
//p0 wire declarations

 wire            p0_tg_run_traffic; 
 wire [31:0]     p0_tg_start_addr;
 wire [31:0]     p0_tg_end_addr;
 wire [31:0]     p0_tg_cmd_seed; 
 wire [31:0]     p0_tg_data_seed;
 wire            p0_tg_load_seed;
 wire [2:0]      p0_tg_addr_mode;
 wire [3:0]      p0_tg_instr_mode;
 wire [1:0]      p0_tg_bl_mode;
 wire [3:0]      p0_tg_data_mode;
 wire            p0_tg_mode_load;
 wire [5:0]      p0_tg_fixed_bl;
 wire [2:0]      p0_tg_fixed_instr;
 wire [31:0]     p0_tg_fixed_addr;
 wire [64 + (2*p0_DWIDTH - 1):0]     p0_error_status;
 wire            p0_error;
 wire            p0_cmp_error;
 wire  [p0_DWIDTH-1 :0]          p0_cmp_data;
 wire           p0_cmp_data_valid;

	 


   assign cmp_error      = p0_cmp_error;
   assign error          = p0_error;
   assign error_status   = p0_error_status;
   assign cmp_data       = p0_cmp_data[31:0];
   assign cmp_data_valid = p0_cmp_data_valid;
//assign vio_modify_enable   = 1'b1;
//assign vio_data_mode_value = 3'b010;
//assign vio_addr_mode_value = 3'b011;
//assign vio_bl_mode_value   = 2'b10;
//assign vio_fixed_bl_value  = 6'b010000;  


 init_mem_pattern_ctr #(
    .DWIDTH                (p0_DWIDTH),
    .FAMILY                (FAMILY),
    .BEGIN_ADDRESS         (C_p0_BEGIN_ADDRESS),
    .END_ADDRESS           (C_p0_END_ADDRESS),
    .CMD_SEED_VALUE        (32'h56456783),
    .DATA_SEED_VALUE       (32'h12345678),
    .DATA_MODE             (C_p0_DATA_MODE),
    .PORT_MODE             (p0_PORT_MODE)
	
   )
 init_mem_pattern_ctr_p0
    (
    .clk_i                 (clk0),
    .rst_i                 (rst0),

    .mcb_cmd_en_i          (p0_mcb_cmd_en_o),
    .mcb_cmd_instr_i       (p0_mcb_cmd_instr_o),
    .mcb_cmd_addr_i        (p0_mcb_cmd_addr_o),
    .mcb_cmd_bl_i          (p0_mcb_cmd_bl_o),
    .mcb_wr_en_i           (p0_mcb_wr_en_o),

    .vio_modify_enable	   (vio_modify_enable),
    .vio_data_mode_value   (vio_data_mode_value),
    .vio_addr_mode_value   (vio_addr_mode_value),
    .vio_bl_mode_value     (2'b10), // always set to PRBS_BL mode
    .vio_fixed_bl_value    (6'd64), // always set to 64 in order to run PRBS data pattern
    .mcb_init_done_i       (calib_done),
    .cmp_error             (p0_error),
    .run_traffic_o         (p0_tg_run_traffic), 
    .start_addr_o          (p0_tg_start_addr),
    .end_addr_o            (p0_tg_end_addr   ),
    .cmd_seed_o            (p0_tg_cmd_seed   ), 
    .data_seed_o           (p0_tg_data_seed  ),
    .load_seed_o           (p0_tg_load_seed  ),
    .addr_mode_o           (p0_tg_addr_mode  ),
    .instr_mode_o          (p0_tg_instr_mode ),
    .bl_mode_o             (p0_tg_bl_mode    ),
    .data_mode_o           (p0_tg_data_mode  ),
    .mode_load_o           (p0_tg_mode_load  ),
    .fixed_bl_o            (p0_tg_fixed_bl   ),
    .fixed_instr_o         (p0_tg_fixed_instr),
    .fixed_addr_o          (p0_tg_fixed_addr )
      );


 mcb_traffic_gen #(  
    .MEM_BURST_LEN         (C_MEM_BURST_LEN), 
    .MEM_COL_WIDTH         (C_MEM_NUM_COL_BITS),
    .NUM_DQ_PINS           (C_NUM_DQ_PINS),
    .DQ_ERROR_WIDTH        (DQ_ERROR_WIDTH),

    .PORT_MODE             (p0_PORT_MODE),    
    .DWIDTH                (p0_DWIDTH),

    .FAMILY                (FAMILY),
    .SIMULATION            ("FALSE"),
    .DATA_PATTERN          ("DGEN_ADDR"),  
    .CMD_PATTERN           ("CGEN_ALL"),
    .ADDR_WIDTH            (30),
    .PRBS_SADDR_MASK_POS   (C_p0_PRBS_SADDR_MASK_POS),
    .PRBS_EADDR_MASK_POS   (C_p0_PRBS_EADDR_MASK_POS),
    .PRBS_SADDR            (C_p0_BEGIN_ADDRESS),
    .PRBS_EADDR            (C_p0_END_ADDRESS)
  )  
  m_traffic_gen_p0 
  (  
    .clk_i                 (clk0),
    .rst_i                 (rst0),
    .run_traffic_i         (p0_tg_run_traffic),
    .manual_clear_error    (rst0),
   // runtime parameter  
    .start_addr_i          (p0_tg_start_addr ),
    .end_addr_i            (p0_tg_end_addr   ),
    .cmd_seed_i            (p0_tg_cmd_seed   ),
    .data_seed_i           (p0_tg_data_seed  ),
    .load_seed_i           (p0_tg_load_seed),
    .addr_mode_i           (p0_tg_addr_mode),
                           
    .instr_mode_i          (p0_tg_instr_mode ),
    .bl_mode_i             (p0_tg_bl_mode    ),
    .data_mode_i           (p0_tg_data_mode  ),
    .mode_load_i           (p0_tg_mode_load  ),
    
    // fixed pattern inputs interface  
    .fixed_bl_i            (p0_tg_fixed_bl),      
    .fixed_instr_i         (p0_tg_fixed_instr),   
    .fixed_addr_i          (p0_tg_fixed_addr),
    .fixed_data_i          (),
    // BRAM interface. 
    .bram_cmd_i            (),
    .bram_valid_i          (),
    .bram_rdy_o            (), 
    
    //  MCB INTERFACE  
    .mcb_cmd_en_o	   (p0_mcb_cmd_en_o), 
    .mcb_cmd_instr_o	   (p0_mcb_cmd_instr_o), 
    .mcb_cmd_bl_o	   (p0_mcb_cmd_bl_o), 
    .mcb_cmd_addr_o	   (p0_mcb_cmd_addr_o), 
    .mcb_cmd_full_i	   (p0_mcb_cmd_full_i), 

    .mcb_wr_en_o	   (p0_mcb_wr_en_o), 
    .mcb_wr_mask_o	   (p0_mcb_wr_mask_o), 
    .mcb_wr_data_o	   (p0_mcb_wr_data_o),
    .mcb_wr_data_end_o     (),
    .mcb_wr_full_i	   (p0_mcb_wr_full_i), 
    .mcb_wr_fifo_counts	   (p0_mcb_wr_fifo_counts), 

    .mcb_rd_en_o	   (p0_mcb_rd_en_o), 
    .mcb_rd_data_i	   (p0_mcb_rd_data_i), 
    .mcb_rd_empty_i	   (p0_mcb_rd_empty_i), 
    .mcb_rd_fifo_counts	   (p0_mcb_rd_fifo_counts), 

    // status feedback  
    .counts_rst            (rst0),
    .wr_data_counts        (),
    .rd_data_counts        (),
    .error                 (p0_error),        // asserted whenever the read back data is not correct.  
    .error_status          (p0_error_status),  // TBD how signals mapped  
    .cmp_data              (p0_cmp_data),
    .cmp_data_valid        (p0_cmp_data_valid),
    .cmp_error             (p0_cmp_error),
    .mem_rd_data             (),
    .dq_error_bytelane_cmp   (),
    .cumlative_dq_lane_error ()
   
   );         

       



endmodule
