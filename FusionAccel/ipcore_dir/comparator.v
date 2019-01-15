////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: comparator.v
// /___/   /\     Timestamp: Tue Jan 15 13:17:56 2019
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/comparator.ngc /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/comparator.v 
// Device	: 6slx45fgg484-2
// Input file	: /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/comparator.ngc
// Output file	: /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/comparator.v
// # of Modules	: 1
// Design Name	: comparator
// Xilinx        : /opt/Xilinx/14.7/ISE_DS/ISE/
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module comparator (
  operation_nd, clk, sclr, ce, operation_rfd, invalid_op, rdy, a, b, operation, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  input sclr;
  input ce;
  output operation_rfd;
  output invalid_op;
  output rdy;
  input [15 : 0] a;
  input [15 : 0] b;
  input [5 : 0] operation;
  output [0 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/MET_REG/RTL.delay<0>_0 ;
  wire \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ;
  wire \U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/I_O_REG/RTL.delay<0>_0 ;
  wire \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  wire sig00000001;
  wire sig00000002;
  wire sig00000003;
  wire sig00000004;
  wire sig00000005;
  wire sig00000006;
  wire sig00000007;
  wire sig00000008;
  wire sig00000009;
  wire sig0000000a;
  wire sig0000000b;
  wire sig0000000c;
  wire sig0000000d;
  wire sig0000000e;
  wire sig0000000f;
  wire sig00000010;
  wire sig00000011;
  wire sig00000012;
  wire sig00000013;
  wire sig00000014;
  wire sig00000015;
  wire sig00000016;
  wire sig00000017;
  wire sig00000018;
  wire sig00000019;
  wire sig0000001a;
  wire sig0000001b;
  wire sig0000001c;
  wire sig0000001d;
  wire sig0000001e;
  wire sig0000001f;
  wire sig00000020;
  wire sig00000021;
  wire sig00000022;
  wire sig00000023;
  wire sig00000024;
  wire sig00000025;
  wire sig00000026;
  wire sig00000027;
  wire sig00000028;
  wire sig00000029;
  wire sig0000002a;
  wire sig0000002b;
  wire sig0000002c;
  wire sig0000002d;
  wire sig0000002e;
  wire sig0000002f;
  wire sig00000030;
  wire sig00000031;
  wire sig00000032;
  wire sig00000033;
  wire sig00000034;
  wire sig00000035;
  wire sig00000036;
  wire sig00000037;
  wire sig00000038;
  wire sig00000039;
  wire sig0000003a;
  wire sig0000003b;
  wire sig0000003c;
  wire sig0000003d;
  wire sig0000003e;
  wire sig0000003f;
  wire sig00000040;
  wire sig00000041;
  wire sig00000042;
  wire sig00000043;
  wire sig00000044;
  wire sig00000045;
  wire sig00000046;
  wire sig00000047;
  wire sig00000048;
  assign
    result[0] = \U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/MET_REG/RTL.delay<0>_0 ,
    operation_rfd = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ,
    invalid_op = \U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/I_O_REG/RTL.delay<0>_0 ,
    rdy = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(sig00000001)
  );
  GND   blk00000002 (
    .G(sig00000002)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000003 (
    .C(clk),
    .CE(ce),
    .D(sig00000003),
    .Q(sig00000004)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000004 (
    .C(clk),
    .CE(ce),
    .D(sig0000000a),
    .Q(sig0000002c)
  );
  MUXCY   blk00000005 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000019),
    .O(sig00000005)
  );
  MUXCY   blk00000006 (
    .CI(sig00000005),
    .DI(sig00000002),
    .S(sig0000001a),
    .O(sig00000006)
  );
  MUXCY   blk00000007 (
    .CI(sig00000006),
    .DI(sig00000002),
    .S(sig0000001b),
    .O(sig00000007)
  );
  MUXCY   blk00000008 (
    .CI(sig00000007),
    .DI(sig00000002),
    .S(sig0000001c),
    .O(sig00000008)
  );
  MUXCY   blk00000009 (
    .CI(sig00000008),
    .DI(sig00000002),
    .S(sig0000001d),
    .O(sig00000009)
  );
  MUXCY   blk0000000a (
    .CI(sig00000009),
    .DI(sig00000002),
    .S(sig0000001e),
    .O(sig0000000a)
  );
  MUXCY   blk0000000b (
    .CI(sig00000025),
    .DI(sig00000002),
    .S(sig0000000e),
    .O(sig0000000b)
  );
  MUXCY   blk0000000c (
    .CI(sig00000027),
    .DI(sig00000002),
    .S(sig0000000d),
    .O(sig0000000c)
  );
  MUXCY   blk0000000d (
    .CI(sig00000002),
    .DI(sig00000001),
    .S(sig00000014),
    .O(sig0000000f)
  );
  MUXCY   blk0000000e (
    .CI(sig0000000f),
    .DI(sig00000001),
    .S(sig00000013),
    .O(sig00000025)
  );
  MUXCY   blk0000000f (
    .CI(sig00000002),
    .DI(sig00000001),
    .S(sig00000012),
    .O(sig00000010)
  );
  MUXCY   blk00000010 (
    .CI(sig00000010),
    .DI(sig00000001),
    .S(sig00000011),
    .O(sig00000027)
  );
  MUXCY   blk00000011 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000018),
    .O(sig00000015)
  );
  MUXCY   blk00000012 (
    .CI(sig00000015),
    .DI(sig00000002),
    .S(sig00000017),
    .O(sig00000016)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000013 (
    .C(clk),
    .CE(ce),
    .D(sig00000021),
    .Q(sig00000022)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000014 (
    .C(clk),
    .CE(ce),
    .D(sig0000001f),
    .Q(\U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/I_O_REG/RTL.delay<0>_0 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000015 (
    .C(clk),
    .CE(ce),
    .D(sig00000020),
    .Q(\U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/MET_REG/RTL.delay<0>_0 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000016 (
    .C(clk),
    .CE(ce),
    .D(sig0000000b),
    .Q(sig00000024)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000017 (
    .C(clk),
    .CE(ce),
    .D(sig0000000c),
    .Q(sig00000026)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000018 (
    .C(clk),
    .CE(ce),
    .D(sig00000016),
    .Q(sig00000028)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000019 (
    .C(clk),
    .CE(ce),
    .D(operation[3]),
    .Q(sig00000029)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001a (
    .C(clk),
    .CE(ce),
    .D(operation[4]),
    .Q(sig0000002a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001b (
    .C(clk),
    .CE(ce),
    .D(operation[5]),
    .Q(sig0000002b)
  );
  MUXCY   blk0000001c (
    .CI(sig0000003e),
    .DI(sig0000002d),
    .S(sig0000002e),
    .O(sig0000003d)
  );
  MUXCY   blk0000001d (
    .CI(sig0000003f),
    .DI(sig0000002f),
    .S(sig00000030),
    .O(sig0000003e)
  );
  MUXCY   blk0000001e (
    .CI(sig00000040),
    .DI(sig00000031),
    .S(sig00000032),
    .O(sig0000003f)
  );
  MUXCY   blk0000001f (
    .CI(sig00000041),
    .DI(sig00000033),
    .S(sig00000034),
    .O(sig00000040)
  );
  MUXCY   blk00000020 (
    .CI(sig00000042),
    .DI(sig00000035),
    .S(sig00000036),
    .O(sig00000041)
  );
  MUXCY   blk00000021 (
    .CI(sig00000043),
    .DI(sig00000037),
    .S(sig00000038),
    .O(sig00000042)
  );
  MUXCY   blk00000022 (
    .CI(sig00000044),
    .DI(sig00000039),
    .S(sig0000003a),
    .O(sig00000043)
  );
  MUXCY   blk00000023 (
    .CI(sig00000002),
    .DI(sig0000003b),
    .S(sig0000003c),
    .O(sig00000044)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000024 (
    .C(clk),
    .CE(ce),
    .D(sig0000003d),
    .Q(sig00000023)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000025 (
    .I0(operation_nd),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ),
    .O(sig00000003)
  );
  LUT4 #(
    .INIT ( 16'h6660 ))
  blk00000026 (
    .I0(sig00000029),
    .I1(sig0000002b),
    .I2(sig00000026),
    .I3(sig00000024),
    .O(sig0000001f)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk00000027 (
    .I0(a[12]),
    .I1(b[12]),
    .I2(a[14]),
    .I3(b[14]),
    .I4(a[13]),
    .I5(b[13]),
    .O(sig0000001d)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk00000028 (
    .I0(a[10]),
    .I1(b[10]),
    .I2(a[9]),
    .I3(b[9]),
    .I4(a[11]),
    .I5(b[11]),
    .O(sig0000001c)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk00000029 (
    .I0(a[6]),
    .I1(b[6]),
    .I2(a[8]),
    .I3(b[8]),
    .I4(a[7]),
    .I5(b[7]),
    .O(sig0000001b)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk0000002a (
    .I0(a[3]),
    .I1(b[3]),
    .I2(a[5]),
    .I3(b[5]),
    .I4(a[4]),
    .I5(b[4]),
    .O(sig0000001a)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk0000002b (
    .I0(a[0]),
    .I1(b[0]),
    .I2(a[2]),
    .I3(b[2]),
    .I4(a[1]),
    .I5(b[1]),
    .O(sig00000019)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk0000002c (
    .I0(b[15]),
    .I1(a[15]),
    .O(sig0000001e)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk0000002d (
    .I0(a[10]),
    .I1(a[11]),
    .I2(a[12]),
    .I3(a[13]),
    .I4(a[14]),
    .O(sig0000000d)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk0000002e (
    .I0(b[10]),
    .I1(b[11]),
    .I2(b[12]),
    .I3(b[13]),
    .I4(b[14]),
    .O(sig0000000e)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000002f (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig00000011)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000030 (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig00000012)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000031 (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig00000013)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000032 (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig00000014)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000033 (
    .I0(a[11]),
    .I1(a[12]),
    .I2(a[13]),
    .I3(a[14]),
    .O(sig00000017)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000034 (
    .I0(b[10]),
    .I1(b[11]),
    .I2(b[12]),
    .I3(b[13]),
    .I4(b[14]),
    .I5(a[10]),
    .O(sig00000018)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000035 (
    .I0(a[15]),
    .I1(b[15]),
    .O(sig00000021)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000036 (
    .I0(a[15]),
    .I1(b[15]),
    .I2(a[14]),
    .I3(b[14]),
    .O(sig0000002e)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000037 (
    .I0(a[13]),
    .I1(b[13]),
    .I2(a[12]),
    .I3(b[12]),
    .O(sig00000030)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000038 (
    .I0(a[11]),
    .I1(b[11]),
    .I2(a[10]),
    .I3(b[10]),
    .O(sig00000032)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000039 (
    .I0(a[9]),
    .I1(b[9]),
    .I2(a[8]),
    .I3(b[8]),
    .O(sig00000034)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000003a (
    .I0(a[7]),
    .I1(b[7]),
    .I2(a[6]),
    .I3(b[6]),
    .O(sig00000036)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000003b (
    .I0(a[5]),
    .I1(b[5]),
    .I2(a[4]),
    .I3(b[4]),
    .O(sig00000038)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000003c (
    .I0(a[3]),
    .I1(b[3]),
    .I2(a[2]),
    .I3(b[2]),
    .O(sig0000003a)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000003d (
    .I0(a[1]),
    .I1(b[1]),
    .I2(a[0]),
    .I3(b[0]),
    .O(sig0000003c)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk0000003e (
    .I0(a[15]),
    .I1(b[15]),
    .I2(a[14]),
    .I3(b[14]),
    .O(sig0000002d)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk0000003f (
    .I0(b[13]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(b[12]),
    .O(sig0000002f)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk00000040 (
    .I0(b[11]),
    .I1(a[11]),
    .I2(a[10]),
    .I3(b[10]),
    .O(sig00000031)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk00000041 (
    .I0(b[9]),
    .I1(a[9]),
    .I2(a[8]),
    .I3(b[8]),
    .O(sig00000033)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk00000042 (
    .I0(b[7]),
    .I1(a[7]),
    .I2(a[6]),
    .I3(b[6]),
    .O(sig00000035)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk00000043 (
    .I0(b[5]),
    .I1(a[5]),
    .I2(a[4]),
    .I3(b[4]),
    .O(sig00000037)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk00000044 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(a[2]),
    .I3(b[2]),
    .O(sig00000039)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk00000045 (
    .I0(b[1]),
    .I1(a[1]),
    .I2(a[0]),
    .I3(b[0]),
    .O(sig0000003b)
  );
  FD #(
    .INIT ( 1'b1 ))
  blk00000046 (
    .C(clk),
    .D(sig00000045),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000047 (
    .C(clk),
    .D(sig00000046),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  LUT5 #(
    .INIT ( 32'h45054000 ))
  blk00000048 (
    .I0(sclr),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ),
    .I2(ce),
    .I3(sig00000004),
    .I4(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY ),
    .O(sig00000046)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk00000049 (
    .I0(sclr),
    .I1(ce),
    .I2(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ),
    .O(sig00000045)
  );
  LUT6 #(
    .INIT ( 64'h0FF046F609B90FFF ))
  blk0000004a (
    .I0(sig00000022),
    .I1(sig00000023),
    .I2(sig0000002c),
    .I3(sig0000002a),
    .I4(sig0000002b),
    .I5(sig00000029),
    .O(sig00000047)
  );
  LUT3 #(
    .INIT ( 8'hBE ))
  blk0000004b (
    .I0(sig0000002a),
    .I1(sig0000002b),
    .I2(sig00000029),
    .O(sig00000048)
  );
  LUT6 #(
    .INIT ( 64'h0200FEFC0301FFFD ))
  blk0000004c (
    .I0(sig00000028),
    .I1(sig00000026),
    .I2(sig00000024),
    .I3(sig0000002a),
    .I4(sig00000048),
    .I5(sig00000047),
    .O(sig00000020)
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
