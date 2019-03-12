////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: comparator.v
// /___/   /\     Timestamp: Thu Mar 14 19:04:30 2019
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/comparator.ngc C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/comparator.v 
// Device	: 6slx45fgg484-2
// Input file	: C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/comparator.ngc
// Output file	: C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/comparator.v
// # of Modules	: 1
// Design Name	: comparator
// Xilinx        : C:\Xilinx\14.7\ISE_DS\ISE\
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
  operation_nd, clk, operation_rfd, rdy, a, b, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  output operation_rfd;
  output rdy;
  input [15 : 0] a;
  input [15 : 0] b;
  output [0 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/MET_REG/RTL.delay<0>_0 ;
  wire \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  wire NlwRenamedSig_OI_operation_rfd;
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
  assign
    result[0] = \U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/MET_REG/RTL.delay<0>_0 ,
    operation_rfd = NlwRenamedSig_OI_operation_rfd,
    rdy = \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(NlwRenamedSig_OI_operation_rfd)
  );
  GND   blk00000002 (
    .G(sig00000001)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000003 (
    .C(clk),
    .D(operation_nd),
    .Q(sig00000002)
  );
  FDR #(
    .INIT ( 1'b0 ))
  blk00000004 (
    .C(clk),
    .D(sig00000002),
    .R(sig00000001),
    .Q(\U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000005 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000008),
    .Q(sig00000027)
  );
  MUXCY   blk00000006 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000017),
    .O(sig00000003)
  );
  MUXCY   blk00000007 (
    .CI(sig00000003),
    .DI(sig00000001),
    .S(sig00000018),
    .O(sig00000004)
  );
  MUXCY   blk00000008 (
    .CI(sig00000004),
    .DI(sig00000001),
    .S(sig00000019),
    .O(sig00000005)
  );
  MUXCY   blk00000009 (
    .CI(sig00000005),
    .DI(sig00000001),
    .S(sig0000001a),
    .O(sig00000006)
  );
  MUXCY   blk0000000a (
    .CI(sig00000006),
    .DI(sig00000001),
    .S(sig0000001b),
    .O(sig00000007)
  );
  MUXCY   blk0000000b (
    .CI(sig00000007),
    .DI(sig00000001),
    .S(sig0000001c),
    .O(sig00000008)
  );
  MUXCY   blk0000000c (
    .CI(sig00000022),
    .DI(sig00000001),
    .S(sig0000000c),
    .O(sig00000009)
  );
  MUXCY   blk0000000d (
    .CI(sig00000024),
    .DI(sig00000001),
    .S(sig0000000b),
    .O(sig0000000a)
  );
  MUXCY   blk0000000e (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000012),
    .O(sig0000000d)
  );
  MUXCY   blk0000000f (
    .CI(sig0000000d),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000011),
    .O(sig00000022)
  );
  MUXCY   blk00000010 (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000010),
    .O(sig0000000e)
  );
  MUXCY   blk00000011 (
    .CI(sig0000000e),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig0000000f),
    .O(sig00000024)
  );
  MUXCY   blk00000012 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000016),
    .O(sig00000013)
  );
  MUXCY   blk00000013 (
    .CI(sig00000013),
    .DI(sig00000001),
    .S(sig00000015),
    .O(sig00000014)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000014 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000001e),
    .Q(sig0000001f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000015 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000001d),
    .Q(\U0/op_inst/FLT_PT_OP/COMP_OP.SPD.OP/MET_REG/RTL.delay<0>_0 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000016 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000009),
    .Q(sig00000021)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000017 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000000a),
    .Q(sig00000023)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000018 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000014),
    .Q(sig00000025)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000019 (
    .C(clk),
    .D(NlwRenamedSig_OI_operation_rfd),
    .Q(sig00000026)
  );
  MUXCY   blk0000001a (
    .CI(sig00000039),
    .DI(sig00000028),
    .S(sig00000029),
    .O(sig00000038)
  );
  MUXCY   blk0000001b (
    .CI(sig0000003a),
    .DI(sig0000002a),
    .S(sig0000002b),
    .O(sig00000039)
  );
  MUXCY   blk0000001c (
    .CI(sig0000003b),
    .DI(sig0000002c),
    .S(sig0000002d),
    .O(sig0000003a)
  );
  MUXCY   blk0000001d (
    .CI(sig0000003c),
    .DI(sig0000002e),
    .S(sig0000002f),
    .O(sig0000003b)
  );
  MUXCY   blk0000001e (
    .CI(sig0000003d),
    .DI(sig00000030),
    .S(sig00000031),
    .O(sig0000003c)
  );
  MUXCY   blk0000001f (
    .CI(sig0000003e),
    .DI(sig00000032),
    .S(sig00000033),
    .O(sig0000003d)
  );
  MUXCY   blk00000020 (
    .CI(sig0000003f),
    .DI(sig00000034),
    .S(sig00000035),
    .O(sig0000003e)
  );
  MUXCY   blk00000021 (
    .CI(sig00000001),
    .DI(sig00000036),
    .S(sig00000037),
    .O(sig0000003f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000022 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000038),
    .Q(sig00000020)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk00000023 (
    .I0(a[12]),
    .I1(b[12]),
    .I2(a[14]),
    .I3(b[14]),
    .I4(a[13]),
    .I5(b[13]),
    .O(sig0000001b)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk00000024 (
    .I0(a[10]),
    .I1(b[10]),
    .I2(a[9]),
    .I3(b[9]),
    .I4(a[11]),
    .I5(b[11]),
    .O(sig0000001a)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk00000025 (
    .I0(a[6]),
    .I1(b[6]),
    .I2(a[8]),
    .I3(b[8]),
    .I4(a[7]),
    .I5(b[7]),
    .O(sig00000019)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk00000026 (
    .I0(a[3]),
    .I1(b[3]),
    .I2(a[5]),
    .I3(b[5]),
    .I4(a[4]),
    .I5(b[4]),
    .O(sig00000018)
  );
  LUT6 #(
    .INIT ( 64'h9009000000009009 ))
  blk00000027 (
    .I0(a[0]),
    .I1(b[0]),
    .I2(a[2]),
    .I3(b[2]),
    .I4(a[1]),
    .I5(b[1]),
    .O(sig00000017)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000028 (
    .I0(b[15]),
    .I1(a[15]),
    .O(sig0000001c)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000029 (
    .I0(a[10]),
    .I1(a[11]),
    .I2(a[12]),
    .I3(a[13]),
    .I4(a[14]),
    .O(sig0000000b)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk0000002a (
    .I0(b[10]),
    .I1(b[11]),
    .I2(b[12]),
    .I3(b[13]),
    .I4(b[14]),
    .O(sig0000000c)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000002b (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig0000000f)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000002c (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig00000010)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000002d (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig00000011)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000002e (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig00000012)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000002f (
    .I0(a[11]),
    .I1(a[12]),
    .I2(a[13]),
    .I3(a[14]),
    .O(sig00000015)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000030 (
    .I0(b[10]),
    .I1(b[11]),
    .I2(b[12]),
    .I3(b[13]),
    .I4(b[14]),
    .I5(a[10]),
    .O(sig00000016)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000031 (
    .I0(a[15]),
    .I1(b[15]),
    .O(sig0000001e)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000032 (
    .I0(a[15]),
    .I1(b[15]),
    .I2(a[14]),
    .I3(b[14]),
    .O(sig00000029)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000033 (
    .I0(a[13]),
    .I1(b[13]),
    .I2(a[12]),
    .I3(b[12]),
    .O(sig0000002b)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000034 (
    .I0(a[11]),
    .I1(b[11]),
    .I2(a[10]),
    .I3(b[10]),
    .O(sig0000002d)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000035 (
    .I0(a[9]),
    .I1(b[9]),
    .I2(a[8]),
    .I3(b[8]),
    .O(sig0000002f)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000036 (
    .I0(a[7]),
    .I1(b[7]),
    .I2(a[6]),
    .I3(b[6]),
    .O(sig00000031)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000037 (
    .I0(a[5]),
    .I1(b[5]),
    .I2(a[4]),
    .I3(b[4]),
    .O(sig00000033)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000038 (
    .I0(a[3]),
    .I1(b[3]),
    .I2(a[2]),
    .I3(b[2]),
    .O(sig00000035)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000039 (
    .I0(a[1]),
    .I1(b[1]),
    .I2(a[0]),
    .I3(b[0]),
    .O(sig00000037)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk0000003a (
    .I0(a[15]),
    .I1(b[15]),
    .I2(a[14]),
    .I3(b[14]),
    .O(sig00000028)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk0000003b (
    .I0(b[13]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(b[12]),
    .O(sig0000002a)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk0000003c (
    .I0(b[11]),
    .I1(a[11]),
    .I2(a[10]),
    .I3(b[10]),
    .O(sig0000002c)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk0000003d (
    .I0(b[9]),
    .I1(a[9]),
    .I2(a[8]),
    .I3(b[8]),
    .O(sig0000002e)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk0000003e (
    .I0(b[7]),
    .I1(a[7]),
    .I2(a[6]),
    .I3(b[6]),
    .O(sig00000030)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk0000003f (
    .I0(b[5]),
    .I1(a[5]),
    .I2(a[4]),
    .I3(b[4]),
    .O(sig00000032)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk00000040 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(a[2]),
    .I3(b[2]),
    .O(sig00000034)
  );
  LUT4 #(
    .INIT ( 16'h44D4 ))
  blk00000041 (
    .I0(b[1]),
    .I1(a[1]),
    .I2(a[0]),
    .I3(b[0]),
    .O(sig00000036)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk00000042 (
    .I0(sig00000021),
    .I1(sig00000023),
    .O(sig00000040)
  );
  LUT6 #(
    .INIT ( 64'h001C00000000FFFF ))
  blk00000043 (
    .I0(sig00000027),
    .I1(sig00000020),
    .I2(sig0000001f),
    .I3(sig00000025),
    .I4(sig00000026),
    .I5(sig00000040),
    .O(sig0000001d)
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
