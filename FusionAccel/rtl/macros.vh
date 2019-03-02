`ifndef __MACROS__
`define __MACROS__
`define LSB 4
`define BURST_LEN 16
`define BLOB_BURST_LEN 32  // Number of 32bit(Port size) user words per DRAM command (Must be Multiple of 2)
`define BLOCK_BURST_LEN 1 
`define CMD_BURST_LEN 8
`endif