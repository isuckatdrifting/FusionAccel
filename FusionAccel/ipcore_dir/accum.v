////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: accum.v
// /___/   /\     Timestamp: Sat Mar 02 23:07:51 2019
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/accum.ngc C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/accum.v 
// Device	: 6slx45fgg484-2
// Input file	: C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/accum.ngc
// Output file	: C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/accum.v
// # of Modules	: 1
// Design Name	: accum
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

module accum (
  operation_nd, clk, operation_rfd, rdy, a, b, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  output operation_rfd;
  output rdy;
  input [15 : 0] a;
  input [15 : 0] b;
  output [15 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/sign_op ;
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
  wire sig00000041;
  wire sig00000042;
  wire sig00000043;
  wire sig00000044;
  wire sig00000045;
  wire sig00000046;
  wire sig00000047;
  wire sig00000048;
  wire sig00000049;
  wire sig0000004a;
  wire sig0000004b;
  wire sig0000004c;
  wire sig0000004d;
  wire sig0000004e;
  wire sig0000004f;
  wire sig00000050;
  wire sig00000051;
  wire sig00000052;
  wire sig00000053;
  wire sig00000054;
  wire sig00000055;
  wire sig00000056;
  wire sig00000057;
  wire sig00000058;
  wire sig00000059;
  wire sig0000005a;
  wire sig0000005b;
  wire sig0000005c;
  wire sig0000005d;
  wire sig0000005e;
  wire sig0000005f;
  wire sig00000060;
  wire sig00000061;
  wire sig00000062;
  wire sig00000063;
  wire sig00000064;
  wire sig00000065;
  wire sig00000066;
  wire sig00000067;
  wire sig00000068;
  wire sig00000069;
  wire sig0000006a;
  wire sig0000006b;
  wire sig0000006c;
  wire sig0000006d;
  wire sig0000006e;
  wire sig0000006f;
  wire sig00000070;
  wire sig00000071;
  wire sig00000072;
  wire sig00000073;
  wire sig00000074;
  wire sig00000075;
  wire sig00000076;
  wire sig00000077;
  wire sig00000078;
  wire sig00000079;
  wire sig0000007a;
  wire sig0000007b;
  wire sig0000007c;
  wire sig0000007d;
  wire sig0000007e;
  wire sig0000007f;
  wire sig00000080;
  wire sig00000081;
  wire sig00000082;
  wire sig00000083;
  wire sig00000084;
  wire sig00000085;
  wire sig00000086;
  wire sig00000087;
  wire sig00000088;
  wire sig00000089;
  wire sig0000008a;
  wire sig0000008b;
  wire sig0000008c;
  wire sig0000008d;
  wire sig0000008e;
  wire sig0000008f;
  wire sig00000090;
  wire sig00000091;
  wire sig00000092;
  wire sig00000093;
  wire sig00000094;
  wire sig00000095;
  wire sig00000096;
  wire sig00000097;
  wire sig00000098;
  wire sig00000099;
  wire sig0000009a;
  wire sig0000009b;
  wire sig0000009c;
  wire sig0000009d;
  wire sig0000009e;
  wire sig0000009f;
  wire sig000000a0;
  wire sig000000a1;
  wire sig000000a2;
  wire sig000000a3;
  wire sig000000a4;
  wire sig000000a5;
  wire sig000000a6;
  wire sig000000a7;
  wire sig000000a8;
  wire sig000000a9;
  wire sig000000aa;
  wire sig000000ab;
  wire sig000000ac;
  wire sig000000ad;
  wire sig000000ae;
  wire sig000000af;
  wire sig000000b0;
  wire sig000000b1;
  wire sig000000b2;
  wire sig000000b3;
  wire sig000000b4;
  wire sig000000b5;
  wire sig000000b6;
  wire sig000000b7;
  wire sig000000b8;
  wire sig000000b9;
  wire sig000000ba;
  wire sig000000bb;
  wire sig000000bc;
  wire sig000000bd;
  wire sig000000be;
  wire sig000000bf;
  wire sig000000c0;
  wire sig000000c1;
  wire sig000000c2;
  wire sig000000c3;
  wire sig000000c4;
  wire sig000000c5;
  wire sig000000c6;
  wire sig000000c7;
  wire sig000000c8;
  wire sig000000c9;
  wire sig000000ca;
  wire sig000000cb;
  wire sig000000cc;
  wire sig000000cd;
  wire sig000000ce;
  wire sig000000cf;
  wire sig000000d0;
  wire sig000000d1;
  wire sig000000d2;
  wire sig000000d3;
  wire sig000000d4;
  wire sig000000d5;
  wire sig000000d6;
  wire sig000000d7;
  wire sig000000d8;
  wire sig000000d9;
  wire sig000000da;
  wire sig000000db;
  wire sig000000dc;
  wire sig000000dd;
  wire sig000000de;
  wire sig000000df;
  wire sig000000e0;
  wire sig000000e1;
  wire sig000000e2;
  wire sig000000e3;
  wire sig000000e4;
  wire sig000000e5;
  wire sig000000e6;
  wire sig000000e7;
  wire sig000000e8;
  wire sig000000e9;
  wire sig000000ea;
  wire sig000000eb;
  wire sig000000ec;
  wire sig000000ed;
  wire sig000000ee;
  wire sig000000ef;
  wire sig000000f0;
  wire sig000000f1;
  wire sig000000f2;
  wire sig000000f3;
  wire sig000000f4;
  wire sig000000f5;
  wire sig000000f6;
  wire sig000000f7;
  wire sig000000f8;
  wire sig000000f9;
  wire sig000000fa;
  wire sig000000fb;
  wire sig000000fc;
  wire sig000000fd;
  wire sig000000fe;
  wire sig000000ff;
  wire sig00000100;
  wire sig00000101;
  wire sig00000102;
  wire sig00000103;
  wire sig00000104;
  wire sig00000105;
  wire sig00000106;
  wire sig00000107;
  wire sig00000108;
  wire sig00000109;
  wire sig0000010a;
  wire sig0000010b;
  wire sig0000010c;
  wire sig0000010d;
  wire sig0000010e;
  wire sig0000010f;
  wire sig00000110;
  wire sig00000111;
  wire sig00000112;
  wire sig00000113;
  wire sig00000114;
  wire sig00000115;
  wire sig00000116;
  wire sig00000117;
  wire sig00000118;
  wire sig00000119;
  wire sig0000011a;
  wire sig0000011b;
  wire sig0000011c;
  wire sig0000011d;
  wire sig0000011e;
  wire sig0000011f;
  wire sig00000120;
  wire sig00000121;
  wire sig00000122;
  wire sig00000123;
  wire sig00000124;
  wire sig00000125;
  wire sig00000126;
  wire sig00000127;
  wire sig00000128;
  wire sig00000129;
  wire sig0000012a;
  wire sig0000012b;
  wire sig0000012c;
  wire sig0000012d;
  wire sig0000012e;
  wire sig0000012f;
  wire sig00000130;
  wire sig00000131;
  wire sig00000132;
  wire sig00000133;
  wire sig00000134;
  wire sig00000135;
  wire sig00000136;
  wire sig00000137;
  wire sig00000138;
  wire sig00000139;
  wire sig0000013a;
  wire sig0000013b;
  wire sig0000013c;
  wire sig0000013d;
  wire sig0000013e;
  wire sig0000013f;
  wire sig00000140;
  wire sig00000141;
  wire sig00000142;
  wire sig00000143;
  wire sig00000144;
  wire sig00000145;
  wire sig00000146;
  wire sig00000147;
  wire NLW_blk00000029_O_UNCONNECTED;
  wire NLW_blk00000055_O_UNCONNECTED;
  wire NLW_blk00000078_O_UNCONNECTED;
  wire NLW_blk00000079_O_UNCONNECTED;
  wire NLW_blk0000007b_O_UNCONNECTED;
  wire NLW_blk0000007d_O_UNCONNECTED;
  wire NLW_blk0000007f_O_UNCONNECTED;
  wire [4 : 0] \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op ;
  wire [9 : 0] \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op ;
  assign
    result[15] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/sign_op ,
    result[14] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [4],
    result[13] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [3],
    result[12] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [2],
    result[11] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [1],
    result[10] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [0],
    result[9] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [9],
    result[8] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [8],
    result[7] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [7],
    result[6] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [6],
    result[5] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [5],
    result[4] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [4],
    result[3] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [3],
    result[2] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [2],
    result[1] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [1],
    result[0] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [0],
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
  MUXCY   blk00000005 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000041),
    .O(sig0000003c)
  );
  MUXCY   blk00000006 (
    .CI(sig0000003c),
    .DI(sig00000001),
    .S(sig00000040),
    .O(sig00000061)
  );
  MUXCY   blk00000007 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig0000003f),
    .O(sig0000003d)
  );
  MUXCY   blk00000008 (
    .CI(sig0000003d),
    .DI(sig00000001),
    .S(sig0000003e),
    .O(sig00000062)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000007f),
    .Q(sig00000075)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000a (
    .C(clk),
    .D(sig0000006f),
    .Q(sig00000074)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000b (
    .C(clk),
    .D(sig0000006e),
    .Q(sig00000073)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000c (
    .C(clk),
    .D(sig0000006d),
    .Q(sig00000072)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000d (
    .C(clk),
    .D(sig0000006c),
    .Q(sig00000071)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000e (
    .C(clk),
    .D(sig0000006b),
    .Q(sig00000070)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000007c),
    .Q(sig00000069)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000010 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000005f),
    .Q(sig0000008f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000011 (
    .C(clk),
    .D(sig0000007b),
    .Q(sig00000068)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000012 (
    .C(clk),
    .D(sig0000007a),
    .Q(sig00000067)
  );
  MUXCY   blk00000013 (
    .CI(sig000000a1),
    .DI(sig00000091),
    .S(sig00000092),
    .O(sig00000090)
  );
  MUXCY   blk00000014 (
    .CI(sig000000a2),
    .DI(sig00000093),
    .S(sig00000094),
    .O(sig000000a1)
  );
  MUXCY   blk00000015 (
    .CI(sig000000a3),
    .DI(sig00000095),
    .S(sig00000096),
    .O(sig000000a2)
  );
  MUXCY   blk00000016 (
    .CI(sig000000a4),
    .DI(sig00000097),
    .S(sig00000098),
    .O(sig000000a3)
  );
  MUXCY   blk00000017 (
    .CI(sig000000a5),
    .DI(sig00000099),
    .S(sig0000009a),
    .O(sig000000a4)
  );
  MUXCY   blk00000018 (
    .CI(sig000000a6),
    .DI(sig0000009b),
    .S(sig0000009c),
    .O(sig000000a5)
  );
  MUXCY   blk00000019 (
    .CI(sig000000a7),
    .DI(sig0000009d),
    .S(sig0000009e),
    .O(sig000000a6)
  );
  MUXCY   blk0000001a (
    .CI(sig00000001),
    .DI(sig0000009f),
    .S(sig000000a0),
    .O(sig000000a7)
  );
  XORCY   blk0000001b (
    .CI(sig000000a8),
    .LI(sig00000001),
    .O(sig0000006a)
  );
  XORCY   blk0000001c (
    .CI(sig000000a9),
    .LI(sig00000080),
    .O(sig0000006b)
  );
  MUXCY   blk0000001d (
    .CI(sig000000a9),
    .DI(sig00000001),
    .S(sig00000080),
    .O(sig000000a8)
  );
  XORCY   blk0000001e (
    .CI(sig000000aa),
    .LI(sig00000081),
    .O(sig0000006c)
  );
  MUXCY   blk0000001f (
    .CI(sig000000aa),
    .DI(sig00000001),
    .S(sig00000081),
    .O(sig000000a9)
  );
  XORCY   blk00000020 (
    .CI(sig000000ab),
    .LI(sig00000082),
    .O(sig0000006d)
  );
  MUXCY   blk00000021 (
    .CI(sig000000ab),
    .DI(sig00000001),
    .S(sig00000082),
    .O(sig000000aa)
  );
  XORCY   blk00000022 (
    .CI(sig000000ac),
    .LI(sig00000083),
    .O(sig0000006e)
  );
  MUXCY   blk00000023 (
    .CI(sig000000ac),
    .DI(sig00000001),
    .S(sig00000083),
    .O(sig000000ab)
  );
  XORCY   blk00000024 (
    .CI(sig00000001),
    .LI(sig00000084),
    .O(sig0000006f)
  );
  MUXCY   blk00000025 (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000084),
    .O(sig000000ac)
  );
  MUXCY   blk00000026 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000b3),
    .O(sig000000af)
  );
  MUXCY   blk00000027 (
    .CI(sig000000af),
    .DI(sig00000001),
    .S(sig000000b2),
    .O(sig000000ae)
  );
  MUXCY   blk00000028 (
    .CI(sig000000ae),
    .DI(sig00000001),
    .S(sig000000b1),
    .O(sig000000ad)
  );
  MUXCY   blk00000029 (
    .CI(sig000000ad),
    .DI(sig00000001),
    .S(sig000000b0),
    .O(NLW_blk00000029_O_UNCONNECTED)
  );
  MUXCY   blk0000002a (
    .CI(sig000000cb),
    .DI(sig00000001),
    .S(sig0000005f),
    .O(sig000000ca)
  );
  MUXCY   blk0000002b (
    .CI(sig00000066),
    .DI(sig00000001),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000cb)
  );
  XORCY   blk0000002c (
    .CI(sig000000ce),
    .LI(sig000000c0),
    .O(sig000000cc)
  );
  MUXCY   blk0000002d (
    .CI(sig000000ce),
    .DI(sig0000004d),
    .S(sig000000c0),
    .O(sig000000c9)
  );
  XORCY   blk0000002e (
    .CI(sig000000d0),
    .LI(sig000000bf),
    .O(sig000000cd)
  );
  MUXCY   blk0000002f (
    .CI(sig000000d0),
    .DI(sig0000004e),
    .S(sig000000bf),
    .O(sig000000ce)
  );
  XORCY   blk00000030 (
    .CI(sig000000d2),
    .LI(sig000000be),
    .O(sig000000cf)
  );
  MUXCY   blk00000031 (
    .CI(sig000000d2),
    .DI(sig0000004f),
    .S(sig000000be),
    .O(sig000000d0)
  );
  XORCY   blk00000032 (
    .CI(sig000000d4),
    .LI(sig000000bd),
    .O(sig000000d1)
  );
  MUXCY   blk00000033 (
    .CI(sig000000d4),
    .DI(sig00000050),
    .S(sig000000bd),
    .O(sig000000d2)
  );
  XORCY   blk00000034 (
    .CI(sig000000d6),
    .LI(sig000000bc),
    .O(sig000000d3)
  );
  MUXCY   blk00000035 (
    .CI(sig000000d6),
    .DI(sig00000001),
    .S(sig000000bc),
    .O(sig000000d4)
  );
  XORCY   blk00000036 (
    .CI(sig000000ca),
    .LI(sig000000bb),
    .O(sig000000d5)
  );
  MUXCY   blk00000037 (
    .CI(sig000000ca),
    .DI(sig00000001),
    .S(sig000000bb),
    .O(sig000000d6)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .D(sig000000d5),
    .Q(sig00000022)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000039 (
    .C(clk),
    .D(sig000000d3),
    .Q(sig00000021)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003a (
    .C(clk),
    .D(sig000000d1),
    .Q(sig00000020)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003b (
    .C(clk),
    .D(sig000000cf),
    .Q(sig0000001f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003c (
    .C(clk),
    .D(sig000000cd),
    .Q(sig0000001e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003d (
    .C(clk),
    .D(sig000000cc),
    .Q(sig0000001d)
  );
  XORCY   blk0000003e (
    .CI(sig000000d7),
    .LI(sig00000129),
    .O(sig000000c8)
  );
  XORCY   blk0000003f (
    .CI(sig000000d8),
    .LI(sig000000ba),
    .O(sig000000c7)
  );
  MUXCY   blk00000040 (
    .CI(sig000000d8),
    .DI(sig00000046),
    .S(sig000000ba),
    .O(sig000000d7)
  );
  XORCY   blk00000041 (
    .CI(sig000000d9),
    .LI(sig000000b9),
    .O(sig000000c6)
  );
  MUXCY   blk00000042 (
    .CI(sig000000d9),
    .DI(sig00000047),
    .S(sig000000b9),
    .O(sig000000d8)
  );
  XORCY   blk00000043 (
    .CI(sig000000da),
    .LI(sig000000b8),
    .O(sig000000c5)
  );
  MUXCY   blk00000044 (
    .CI(sig000000da),
    .DI(sig00000048),
    .S(sig000000b8),
    .O(sig000000d9)
  );
  XORCY   blk00000045 (
    .CI(sig000000db),
    .LI(sig000000b7),
    .O(sig000000c4)
  );
  MUXCY   blk00000046 (
    .CI(sig000000db),
    .DI(sig00000049),
    .S(sig000000b7),
    .O(sig000000da)
  );
  XORCY   blk00000047 (
    .CI(sig000000dc),
    .LI(sig000000b6),
    .O(sig000000c3)
  );
  MUXCY   blk00000048 (
    .CI(sig000000dc),
    .DI(sig0000004a),
    .S(sig000000b6),
    .O(sig000000db)
  );
  XORCY   blk00000049 (
    .CI(sig000000dd),
    .LI(sig000000b5),
    .O(sig000000c2)
  );
  MUXCY   blk0000004a (
    .CI(sig000000dd),
    .DI(sig0000004b),
    .S(sig000000b5),
    .O(sig000000dc)
  );
  XORCY   blk0000004b (
    .CI(sig000000c9),
    .LI(sig000000b4),
    .O(sig000000c1)
  );
  MUXCY   blk0000004c (
    .CI(sig000000c9),
    .DI(sig0000004c),
    .S(sig000000b4),
    .O(sig000000dd)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004d (
    .C(clk),
    .D(sig000000c8),
    .Q(sig00000015)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004e (
    .C(clk),
    .D(sig000000c7),
    .Q(sig00000016)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004f (
    .C(clk),
    .D(sig000000c6),
    .Q(sig00000017)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000050 (
    .C(clk),
    .D(sig000000c5),
    .Q(sig00000018)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000051 (
    .C(clk),
    .D(sig000000c4),
    .Q(sig00000019)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000052 (
    .C(clk),
    .D(sig000000c3),
    .Q(sig0000001a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000053 (
    .C(clk),
    .D(sig000000c2),
    .Q(sig0000001b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000054 (
    .C(clk),
    .D(sig000000c1),
    .Q(sig0000001c)
  );
  MUXF7   blk00000055 (
    .I0(sig000000de),
    .I1(sig000000df),
    .S(sig00000012),
    .O(NLW_blk00000055_O_UNCONNECTED)
  );
  MUXF7   blk00000056 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .S(sig00000012),
    .O(sig00000014)
  );
  MUXF7   blk00000057 (
    .I0(sig000000e1),
    .I1(sig000000e3),
    .S(sig00000012),
    .O(sig00000013)
  );
  MUXCY   blk00000058 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000e4),
    .O(sig000000ea)
  );
  MUXCY   blk00000059 (
    .CI(sig000000ea),
    .DI(sig00000001),
    .S(sig000000e5),
    .O(sig00000012)
  );
  MUXCY   blk0000005a (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000e6),
    .O(sig000000e9)
  );
  MUXCY   blk0000005b (
    .CI(sig000000e9),
    .DI(sig00000001),
    .S(sig000000e7),
    .O(sig000000e8)
  );
  MUXCY   blk0000005c (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000100),
    .O(sig000000f9)
  );
  MUXCY   blk0000005d (
    .CI(sig000000f9),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig000000fe),
    .O(sig000000fa)
  );
  MUXCY   blk0000005e (
    .CI(sig000000fa),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000128),
    .O(sig000000fb)
  );
  MUXCY   blk0000005f (
    .CI(sig000000fb),
    .DI(sig00000001),
    .S(sig000000ff),
    .O(sig000000fc)
  );
  MUXCY   blk00000060 (
    .CI(sig000000fc),
    .DI(sig00000001),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000fd)
  );
  MUXCY   blk00000061 (
    .CI(sig000000fd),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000f8)
  );
  XORCY   blk00000062 (
    .CI(sig00000101),
    .LI(sig000000f4),
    .O(sig00000089)
  );
  MUXCY   blk00000063 (
    .CI(sig00000101),
    .DI(sig00000001),
    .S(sig000000f4),
    .O(sig000000f7)
  );
  XORCY   blk00000064 (
    .CI(sig00000102),
    .LI(sig000000f3),
    .O(sig00000088)
  );
  MUXCY   blk00000065 (
    .CI(sig00000102),
    .DI(sig00000001),
    .S(sig000000f3),
    .O(sig00000101)
  );
  XORCY   blk00000066 (
    .CI(sig00000103),
    .LI(sig000000f2),
    .O(sig00000087)
  );
  MUXCY   blk00000067 (
    .CI(sig00000103),
    .DI(sig00000001),
    .S(sig000000f2),
    .O(sig00000102)
  );
  XORCY   blk00000068 (
    .CI(sig00000104),
    .LI(sig000000f1),
    .O(sig00000086)
  );
  MUXCY   blk00000069 (
    .CI(sig00000104),
    .DI(sig00000001),
    .S(sig000000f1),
    .O(sig00000103)
  );
  XORCY   blk0000006a (
    .CI(sig000000f8),
    .LI(sig000000f0),
    .O(sig00000085)
  );
  MUXCY   blk0000006b (
    .CI(sig000000f8),
    .DI(sig00000001),
    .S(sig000000f0),
    .O(sig00000104)
  );
  XORCY   blk0000006c (
    .CI(sig00000105),
    .LI(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000f6)
  );
  MUXCY   blk0000006d (
    .CI(sig00000105),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000f5)
  );
  XORCY   blk0000006e (
    .CI(sig00000106),
    .LI(sig000000ef),
    .O(sig0000008e)
  );
  MUXCY   blk0000006f (
    .CI(sig00000106),
    .DI(sig00000001),
    .S(sig000000ef),
    .O(sig00000105)
  );
  XORCY   blk00000070 (
    .CI(sig00000107),
    .LI(sig000000ee),
    .O(sig0000008d)
  );
  MUXCY   blk00000071 (
    .CI(sig00000107),
    .DI(sig00000001),
    .S(sig000000ee),
    .O(sig00000106)
  );
  XORCY   blk00000072 (
    .CI(sig00000108),
    .LI(sig000000ed),
    .O(sig0000008c)
  );
  MUXCY   blk00000073 (
    .CI(sig00000108),
    .DI(sig00000001),
    .S(sig000000ed),
    .O(sig00000107)
  );
  XORCY   blk00000074 (
    .CI(sig00000109),
    .LI(sig000000ec),
    .O(sig0000008b)
  );
  MUXCY   blk00000075 (
    .CI(sig00000109),
    .DI(sig00000001),
    .S(sig000000ec),
    .O(sig00000108)
  );
  XORCY   blk00000076 (
    .CI(sig000000f7),
    .LI(sig000000eb),
    .O(sig0000008a)
  );
  MUXCY   blk00000077 (
    .CI(sig000000f7),
    .DI(sig00000001),
    .S(sig000000eb),
    .O(sig00000109)
  );
  XORCY   blk00000078 (
    .CI(sig0000010a),
    .LI(sig00000001),
    .O(NLW_blk00000078_O_UNCONNECTED)
  );
  XORCY   blk00000079 (
    .CI(sig0000010b),
    .LI(sig00000001),
    .O(NLW_blk00000079_O_UNCONNECTED)
  );
  MUXCY   blk0000007a (
    .CI(sig0000010b),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig0000010a)
  );
  XORCY   blk0000007b (
    .CI(sig0000010c),
    .LI(sig00000001),
    .O(NLW_blk0000007b_O_UNCONNECTED)
  );
  MUXCY   blk0000007c (
    .CI(sig0000010c),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig0000010b)
  );
  XORCY   blk0000007d (
    .CI(sig0000010d),
    .LI(sig00000001),
    .O(NLW_blk0000007d_O_UNCONNECTED)
  );
  MUXCY   blk0000007e (
    .CI(sig0000010d),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig0000010c)
  );
  XORCY   blk0000007f (
    .CI(sig000000f5),
    .LI(sig00000001),
    .O(NLW_blk0000007f_O_UNCONNECTED)
  );
  MUXCY   blk00000080 (
    .CI(sig000000f5),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig0000010d)
  );
  FD   blk00000081 (
    .C(clk),
    .D(sig00000112),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [4])
  );
  FD   blk00000082 (
    .C(clk),
    .D(sig00000111),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [3])
  );
  FD   blk00000083 (
    .C(clk),
    .D(sig00000110),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [2])
  );
  FD   blk00000084 (
    .C(clk),
    .D(sig0000010f),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [1])
  );
  FD   blk00000085 (
    .C(clk),
    .D(sig0000010e),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [0])
  );
  FD   blk00000086 (
    .C(clk),
    .D(sig0000011c),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [9])
  );
  FD   blk00000087 (
    .C(clk),
    .D(sig0000011b),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [8])
  );
  FD   blk00000088 (
    .C(clk),
    .D(sig0000011a),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [7])
  );
  FD   blk00000089 (
    .C(clk),
    .D(sig00000119),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [6])
  );
  FD   blk0000008a (
    .C(clk),
    .D(sig00000118),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [5])
  );
  FD   blk0000008b (
    .C(clk),
    .D(sig00000117),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [4])
  );
  FD   blk0000008c (
    .C(clk),
    .D(sig00000116),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [3])
  );
  FD   blk0000008d (
    .C(clk),
    .D(sig00000115),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [2])
  );
  FD   blk0000008e (
    .C(clk),
    .D(sig00000114),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [1])
  );
  FD   blk0000008f (
    .C(clk),
    .D(sig00000113),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [0])
  );
  LUT6 #(
    .INIT ( 64'h6669666966699969 ))
  blk00000090 (
    .I0(sig0000000b),
    .I1(sig0000000e),
    .I2(b[11]),
    .I3(sig0000000f),
    .I4(b[10]),
    .I5(sig00000010),
    .O(sig0000000a)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000091 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[1]),
    .I3(a[1]),
    .I4(a[0]),
    .I5(b[0]),
    .O(sig0000005a)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000092 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[2]),
    .I3(a[2]),
    .I4(a[1]),
    .I5(b[1]),
    .O(sig00000059)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000093 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[9]),
    .I3(a[9]),
    .I4(a[8]),
    .I5(b[8]),
    .O(sig00000052)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000094 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[8]),
    .I3(a[8]),
    .I4(a[7]),
    .I5(b[7]),
    .O(sig00000053)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000095 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[5]),
    .I3(a[5]),
    .I4(a[4]),
    .I5(b[4]),
    .O(sig00000056)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000096 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[6]),
    .I3(a[6]),
    .I4(a[5]),
    .I5(b[5]),
    .O(sig00000055)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000097 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[4]),
    .I3(a[4]),
    .I4(a[3]),
    .I5(b[3]),
    .O(sig00000057)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000098 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[3]),
    .I3(a[3]),
    .I4(a[2]),
    .I5(b[2]),
    .O(sig00000058)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000099 (
    .I0(sig000000b0),
    .I1(sig00000090),
    .I2(b[7]),
    .I3(a[7]),
    .I4(a[6]),
    .I5(b[6]),
    .O(sig00000054)
  );
  LUT6 #(
    .INIT ( 64'hAFEAAAEAEFEAAAEA ))
  blk0000009a (
    .I0(sig00000065),
    .I1(sig00000061),
    .I2(sig00000042),
    .I3(sig00000044),
    .I4(sig00000062),
    .I5(sig00000066),
    .O(sig0000007a)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000009b (
    .I0(sig0000000b),
    .I1(a[11]),
    .I2(b[11]),
    .O(sig00000083)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000009c (
    .I0(sig0000000b),
    .I1(a[12]),
    .I2(b[12]),
    .O(sig00000082)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000009d (
    .I0(sig0000000b),
    .I1(a[13]),
    .I2(b[13]),
    .O(sig00000081)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000009e (
    .I0(sig0000000b),
    .I1(a[14]),
    .I2(b[14]),
    .O(sig00000080)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000009f (
    .I0(a[10]),
    .I1(b[10]),
    .O(sig000000b0)
  );
  LUT3 #(
    .INIT ( 8'h27 ))
  blk000000a0 (
    .I0(sig0000000b),
    .I1(b[10]),
    .I2(a[10]),
    .O(sig00000084)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000a1 (
    .I0(a[15]),
    .I1(b[15]),
    .O(sig00000066)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000a2 (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig0000003e)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk000000a3 (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig0000003f)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000a4 (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig00000040)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk000000a5 (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig00000041)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk000000a6 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000042)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk000000a7 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000043)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk000000a8 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000044)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk000000a9 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000045)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000aa (
    .I0(sig00000075),
    .I1(sig00000015),
    .O(sig0000007e)
  );
  LUT6 #(
    .INIT ( 64'h4000000000000000 ))
  blk000000ab (
    .I0(sig0000006a),
    .I1(sig0000006b),
    .I2(sig0000006c),
    .I3(sig0000006d),
    .I4(sig0000006e),
    .I5(sig0000006f),
    .O(sig0000007f)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000ac (
    .I0(sig00000071),
    .I1(sig00000012),
    .O(sig00000005)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000ad (
    .I0(sig00000073),
    .I1(sig00000013),
    .O(sig00000007)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000ae (
    .I0(b[14]),
    .I1(a[14]),
    .O(sig0000000c)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000af (
    .I0(b[12]),
    .I1(a[12]),
    .O(sig0000000e)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000b0 (
    .I0(b[11]),
    .I1(a[11]),
    .O(sig0000000f)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000b1 (
    .I0(b[10]),
    .I1(a[10]),
    .O(sig00000010)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk000000b2 (
    .I0(b[13]),
    .I1(a[13]),
    .I2(b[12]),
    .I3(a[12]),
    .O(sig00000094)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk000000b3 (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig00000096)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk000000b4 (
    .I0(b[9]),
    .I1(a[9]),
    .I2(b[8]),
    .I3(a[8]),
    .O(sig00000098)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk000000b5 (
    .I0(b[7]),
    .I1(a[7]),
    .I2(b[6]),
    .I3(a[6]),
    .O(sig0000009a)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk000000b6 (
    .I0(b[5]),
    .I1(a[5]),
    .I2(b[4]),
    .I3(a[4]),
    .O(sig0000009c)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk000000b7 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(b[2]),
    .I3(a[2]),
    .O(sig0000009e)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk000000b8 (
    .I0(b[1]),
    .I1(a[1]),
    .I2(b[0]),
    .I3(a[0]),
    .O(sig000000a0)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk000000b9 (
    .I0(b[13]),
    .I1(a[13]),
    .I2(b[12]),
    .I3(a[12]),
    .O(sig00000093)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk000000ba (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig00000095)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk000000bb (
    .I0(b[9]),
    .I1(a[9]),
    .I2(b[8]),
    .I3(a[8]),
    .O(sig00000097)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk000000bc (
    .I0(b[7]),
    .I1(a[7]),
    .I2(b[6]),
    .I3(a[6]),
    .O(sig00000099)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk000000bd (
    .I0(b[5]),
    .I1(a[5]),
    .I2(b[4]),
    .I3(a[4]),
    .O(sig0000009b)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk000000be (
    .I0(b[3]),
    .I1(a[3]),
    .I2(b[2]),
    .I3(a[2]),
    .O(sig0000009d)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk000000bf (
    .I0(b[1]),
    .I1(a[1]),
    .I2(b[0]),
    .I3(a[0]),
    .O(sig0000009f)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000c0 (
    .I0(b[14]),
    .I1(a[14]),
    .O(sig00000091)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000c1 (
    .I0(a[14]),
    .I1(b[14]),
    .O(sig00000092)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000c2 (
    .I0(sig00000054),
    .I1(sig00000053),
    .I2(sig00000052),
    .I3(sig00000051),
    .O(sig000000b1)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000c3 (
    .I0(sig00000058),
    .I1(sig00000057),
    .I2(sig00000056),
    .I3(sig00000055),
    .O(sig000000b2)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  blk000000c4 (
    .I0(sig0000005b),
    .I1(sig0000005a),
    .I2(sig00000059),
    .O(sig000000b3)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000c5 (
    .I0(sig00000060),
    .I1(sig00000050),
    .I2(sig00000066),
    .I3(sig0000005e),
    .I4(sig00000037),
    .I5(sig00000039),
    .O(sig000000bd)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000c6 (
    .I0(sig00000060),
    .I1(sig0000004f),
    .I2(sig00000066),
    .I3(sig0000005e),
    .I4(sig00000036),
    .I5(sig00000038),
    .O(sig000000be)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000c7 (
    .I0(sig00000060),
    .I1(sig0000004d),
    .I2(sig00000066),
    .I3(sig0000005e),
    .I4(sig00000034),
    .I5(sig00000036),
    .O(sig000000c0)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000c8 (
    .I0(sig00000060),
    .I1(sig0000004c),
    .I2(sig00000066),
    .I3(sig0000005e),
    .I4(sig00000033),
    .I5(sig00000035),
    .O(sig000000b4)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000c9 (
    .I0(sig00000060),
    .I1(sig0000004e),
    .I2(sig00000066),
    .I3(sig0000005e),
    .I4(sig00000035),
    .I5(sig00000037),
    .O(sig000000bf)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000ca (
    .I0(sig00000060),
    .I1(sig0000004a),
    .I2(sig00000066),
    .I3(sig0000005e),
    .I4(sig00000031),
    .I5(sig00000033),
    .O(sig000000b6)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000cb (
    .I0(sig00000060),
    .I1(sig00000066),
    .I2(sig00000049),
    .I3(sig0000005e),
    .I4(sig00000030),
    .I5(sig00000032),
    .O(sig000000b7)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000cc (
    .I0(sig00000060),
    .I1(sig0000004b),
    .I2(sig00000066),
    .I3(sig0000005e),
    .I4(sig00000032),
    .I5(sig00000034),
    .O(sig000000b5)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000cd (
    .I0(sig00000060),
    .I1(sig00000066),
    .I2(sig00000048),
    .I3(sig0000005e),
    .I4(sig0000002f),
    .I5(sig00000031),
    .O(sig000000b8)
  );
  LUT5 #(
    .INIT ( 32'h00000504 ))
  blk000000ce (
    .I0(sig0000001d),
    .I1(sig0000001f),
    .I2(sig0000001e),
    .I3(sig00000020),
    .I4(sig000000e9),
    .O(sig000000e3)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000cf (
    .I0(sig00000012),
    .I1(sig000000ea),
    .O(sig000000de)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000d0 (
    .I0(sig000000e8),
    .I1(sig000000e9),
    .O(sig000000df)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000d1 (
    .I0(sig000000e8),
    .I1(sig00000012),
    .O(sig00000064)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000d2 (
    .I0(sig00000018),
    .I1(sig00000017),
    .I2(sig00000016),
    .I3(sig00000015),
    .O(sig000000e4)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000d3 (
    .I0(sig00000019),
    .I1(sig0000001a),
    .I2(sig0000001b),
    .I3(sig0000001c),
    .O(sig000000e5)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000d4 (
    .I0(sig0000001d),
    .I1(sig0000001e),
    .I2(sig0000001f),
    .I3(sig00000020),
    .O(sig000000e6)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk000000d5 (
    .I0(sig00000021),
    .I1(sig00000022),
    .O(sig000000e7)
  );
  LUT6 #(
    .INIT ( 64'hF0F0AAAACCCCFF00 ))
  blk000000d6 (
    .I0(sig00000024),
    .I1(sig00000025),
    .I2(sig00000026),
    .I3(sig00000023),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000ee)
  );
  LUT6 #(
    .INIT ( 64'hFF00F0F0CCCCAAAA ))
  blk000000d7 (
    .I0(sig00000024),
    .I1(sig00000026),
    .I2(sig00000025),
    .I3(sig00000027),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000ed)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000000d8 (
    .I0(sig00000025),
    .I1(sig00000026),
    .I2(sig00000027),
    .I3(sig00000028),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000ec)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000000d9 (
    .I0(sig00000026),
    .I1(sig00000028),
    .I2(sig00000029),
    .I3(sig00000027),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000eb)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000000da (
    .I0(sig00000027),
    .I1(sig00000029),
    .I2(sig0000002a),
    .I3(sig00000028),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000f4)
  );
  LUT6 #(
    .INIT ( 64'hAAAAFF00F0F0CCCC ))
  blk000000db (
    .I0(sig0000002b),
    .I1(sig00000028),
    .I2(sig0000002a),
    .I3(sig00000029),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000f3)
  );
  LUT6 #(
    .INIT ( 64'hAAAAFF00CCCCF0F0 ))
  blk000000dc (
    .I0(sig0000002c),
    .I1(sig0000002b),
    .I2(sig00000029),
    .I3(sig0000002a),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000f2)
  );
  LUT6 #(
    .INIT ( 64'hAAAAF0F0CCCCFF00 ))
  blk000000dd (
    .I0(sig0000002d),
    .I1(sig0000002c),
    .I2(sig0000002b),
    .I3(sig0000002a),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000f1)
  );
  LUT6 #(
    .INIT ( 64'hAAAAF0F0CCCCFF00 ))
  blk000000de (
    .I0(sig0000002e),
    .I1(sig0000002d),
    .I2(sig0000002c),
    .I3(sig0000002b),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000f0)
  );
  LUT6 #(
    .INIT ( 64'hAAAAF0F0CCCCFF00 ))
  blk000000df (
    .I0(sig0000002e),
    .I1(sig0000002d),
    .I2(sig0000002c),
    .I3(sig0000002b),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig00000100)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF8788 ))
  blk000000e0 (
    .I0(sig00000009),
    .I1(sig00000008),
    .I2(sig0000000c),
    .I3(sig00000003),
    .I4(sig00000043),
    .I5(sig00000045),
    .O(sig0000011d)
  );
  LUT6 #(
    .INIT ( 64'h0404040404440404 ))
  blk000000e1 (
    .I0(sig0000005c),
    .I1(sig000000af),
    .I2(sig0000005e),
    .I3(sig00000057),
    .I4(sig0000005d),
    .I5(sig00000058),
    .O(sig0000011e)
  );
  LUT6 #(
    .INIT ( 64'h232323A32F2F2FAF ))
  blk000000e2 (
    .I0(sig000000ae),
    .I1(sig0000005e),
    .I2(sig0000005c),
    .I3(sig00000053),
    .I4(sig00000054),
    .I5(sig0000005b),
    .O(sig00000120)
  );
  LUT6 #(
    .INIT ( 64'hFFFFD555FFFF8000 ))
  blk000000e3 (
    .I0(sig0000005d),
    .I1(sig0000005c),
    .I2(sig000000ad),
    .I3(sig0000011f),
    .I4(sig0000011e),
    .I5(sig00000120),
    .O(sig0000005f)
  );
  LUT4 #(
    .INIT ( 16'hAAFB ))
  blk000000e4 (
    .I0(sig00000019),
    .I1(sig0000001c),
    .I2(sig0000001b),
    .I3(sig0000001a),
    .O(sig00000121)
  );
  LUT6 #(
    .INIT ( 64'h0000FFFF00AE00AE ))
  blk000000e5 (
    .I0(sig00000016),
    .I1(sig00000018),
    .I2(sig00000017),
    .I3(sig00000015),
    .I4(sig00000121),
    .I5(sig000000ea),
    .O(sig000000e0)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk000000e6 (
    .I0(sig00000019),
    .I1(sig0000001b),
    .I2(sig0000001c),
    .I3(sig0000001a),
    .O(sig00000122)
  );
  LUT6 #(
    .INIT ( 64'h0000FFFF000E000E ))
  blk000000e7 (
    .I0(sig00000017),
    .I1(sig00000018),
    .I2(sig00000016),
    .I3(sig00000015),
    .I4(sig00000122),
    .I5(sig000000ea),
    .O(sig000000e1)
  );
  LUT2 #(
    .INIT ( 4'hB ))
  blk000000e8 (
    .I0(sig00000021),
    .I1(sig00000022),
    .O(sig00000123)
  );
  LUT6 #(
    .INIT ( 64'h0000FFFF45444544 ))
  blk000000e9 (
    .I0(sig0000001d),
    .I1(sig0000001e),
    .I2(sig0000001f),
    .I3(sig00000020),
    .I4(sig00000123),
    .I5(sig000000e9),
    .O(sig000000e2)
  );
  LUT6 #(
    .INIT ( 64'hF0F0AAAACCCC00FF ))
  blk000000ea (
    .I0(sig00000023),
    .I1(sig00000024),
    .I2(sig00000025),
    .I3(sig00000124),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000ef)
  );
  LUT6 #(
    .INIT ( 64'h0000FFFF0000AAA6 ))
  blk000000eb (
    .I0(sig00000077),
    .I1(sig00000078),
    .I2(sig00000125),
    .I3(sig000000f6),
    .I4(sig00000011),
    .I5(sig00000076),
    .O(sig00000112)
  );
  LUT6 #(
    .INIT ( 64'h0000FFFF0000CC9C ))
  blk000000ec (
    .I0(sig00000126),
    .I1(sig00000078),
    .I2(sig00000079),
    .I3(sig000000f6),
    .I4(sig00000011),
    .I5(sig00000076),
    .O(sig00000111)
  );
  LUT6 #(
    .INIT ( 64'h2223222222222222 ))
  blk000000ed (
    .I0(sig00000068),
    .I1(sig00000067),
    .I2(sig00000127),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig0000008e),
    .O(sig0000011c)
  );
  FD   blk000000ee (
    .C(clk),
    .D(sig0000007d),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/sign_op )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000ef (
    .I0(sig0000008f),
    .O(sig00000128)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000f0 (
    .I0(a[15]),
    .I1(b[15]),
    .O(sig00000129)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  blk000000f1 (
    .I0(sig00000020),
    .I1(sig000000ea),
    .I2(sig00000012),
    .O(sig0000002c)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  blk000000f2 (
    .I0(sig0000001f),
    .I1(sig000000ea),
    .I2(sig00000012),
    .O(sig0000002b)
  );
  LUT6 #(
    .INIT ( 64'hAAEEAAAAAAFAAAAA ))
  blk000000f3 (
    .I0(sig00000068),
    .I1(sig0000012b),
    .I2(sig0000012a),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig000000f6),
    .O(sig0000010f)
  );
  LUT6 #(
    .INIT ( 64'hBABAAABABAAAAAAA ))
  blk000000f4 (
    .I0(sig00000068),
    .I1(sig00000063),
    .I2(sig00000004),
    .I3(sig000000f6),
    .I4(sig0000012d),
    .I5(sig0000012c),
    .O(sig00000110)
  );
  LUT6 #(
    .INIT ( 64'hAAFAAAAAAAEEAAAA ))
  blk000000f5 (
    .I0(sig00000068),
    .I1(sig0000012e),
    .I2(sig0000012f),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig000000f6),
    .O(sig0000010e)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  blk000000f6 (
    .I0(sig00000067),
    .I1(sig00000068),
    .O(sig00000130)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000f7 (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig00000085),
    .O(sig00000113)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000f8 (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig00000086),
    .O(sig00000114)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000f9 (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig00000088),
    .O(sig00000116)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000fa (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig00000089),
    .O(sig00000117)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000fb (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig00000087),
    .O(sig00000115)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000fc (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig0000008b),
    .O(sig00000119)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000fd (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig0000008c),
    .O(sig0000011a)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000fe (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig0000008a),
    .O(sig00000118)
  );
  LUT6 #(
    .INIT ( 64'h0001000000000000 ))
  blk000000ff (
    .I0(sig0000007e),
    .I1(sig00000130),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig00000004),
    .I5(sig0000008d),
    .O(sig0000011b)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  blk00000100 (
    .I0(sig00000022),
    .I1(sig000000ea),
    .I2(sig00000012),
    .O(sig0000002e)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  blk00000101 (
    .I0(sig00000021),
    .I1(sig000000ea),
    .I2(sig00000012),
    .O(sig0000002d)
  );
  LUT4 #(
    .INIT ( 16'h99A5 ))
  blk00000102 (
    .I0(sig00000072),
    .I1(sig000000e9),
    .I2(sig000000ea),
    .I3(sig00000012),
    .O(sig00000006)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk00000103 (
    .I0(sig0000001e),
    .I1(sig00000022),
    .I2(sig000000ea),
    .I3(sig00000012),
    .O(sig0000002a)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk00000104 (
    .I0(sig0000001d),
    .I1(sig00000021),
    .I2(sig000000ea),
    .I3(sig00000012),
    .O(sig00000029)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk00000105 (
    .I0(sig0000001c),
    .I1(sig00000020),
    .I2(sig000000ea),
    .I3(sig00000012),
    .O(sig00000028)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk00000106 (
    .I0(sig0000001b),
    .I1(sig0000001f),
    .I2(sig000000ea),
    .I3(sig00000012),
    .O(sig00000027)
  );
  LUT6 #(
    .INIT ( 64'h00F000F0CCCCAAAA ))
  blk00000107 (
    .I0(sig0000001a),
    .I1(sig0000001e),
    .I2(sig00000022),
    .I3(sig000000e9),
    .I4(sig000000ea),
    .I5(sig00000012),
    .O(sig00000026)
  );
  LUT6 #(
    .INIT ( 64'h00F000F0CCCCAAAA ))
  blk00000108 (
    .I0(sig00000019),
    .I1(sig0000001d),
    .I2(sig00000021),
    .I3(sig000000e9),
    .I4(sig000000ea),
    .I5(sig00000012),
    .O(sig00000025)
  );
  LUT6 #(
    .INIT ( 64'h00F000F0CCCCAAAA ))
  blk00000109 (
    .I0(sig00000018),
    .I1(sig0000001c),
    .I2(sig00000020),
    .I3(sig000000e9),
    .I4(sig000000ea),
    .I5(sig00000012),
    .O(sig00000024)
  );
  LUT6 #(
    .INIT ( 64'h00F000F0CCCCAAAA ))
  blk0000010a (
    .I0(sig00000017),
    .I1(sig0000001b),
    .I2(sig0000001f),
    .I3(sig000000e9),
    .I4(sig000000ea),
    .I5(sig00000012),
    .O(sig00000023)
  );
  LUT3 #(
    .INIT ( 8'h59 ))
  blk0000010b (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig00000014),
    .O(sig00000131)
  );
  LUT6 #(
    .INIT ( 64'h0045005400450045 ))
  blk0000010c (
    .I0(sig00000067),
    .I1(sig0000007e),
    .I2(sig00000006),
    .I3(sig00000064),
    .I4(sig00000007),
    .I5(sig00000131),
    .O(sig0000012c)
  );
  LUT6 #(
    .INIT ( 64'hEAEEEAEEFEFEFFFF ))
  blk0000010d (
    .I0(sig00000070),
    .I1(sig00000071),
    .I2(sig00000072),
    .I3(sig000000e9),
    .I4(sig000000ea),
    .I5(sig00000012),
    .O(sig00000132)
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAEAEEEEFEFE ))
  blk0000010e (
    .I0(sig00000070),
    .I1(sig00000071),
    .I2(sig00000072),
    .I3(sig000000e9),
    .I4(sig000000ea),
    .I5(sig00000012),
    .O(sig00000133)
  );
  LUT6 #(
    .INIT ( 64'hF870FE10FA50FF00 ))
  blk0000010f (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig00000133),
    .I3(sig00000132),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig00000004)
  );
  LUT3 #(
    .INIT ( 8'hCA ))
  blk00000110 (
    .I0(sig00000016),
    .I1(sig0000001a),
    .I2(sig000000ea),
    .O(sig00000134)
  );
  LUT5 #(
    .INIT ( 32'h028A57DF ))
  blk00000111 (
    .I0(sig00000012),
    .I1(sig000000e9),
    .I2(sig0000001e),
    .I3(sig00000022),
    .I4(sig00000134),
    .O(sig00000124)
  );
  LUT6 #(
    .INIT ( 64'hFEEEAEEEAAAAAAAA ))
  blk00000112 (
    .I0(sig00000068),
    .I1(sig00000135),
    .I2(sig00000005),
    .I3(sig00000007),
    .I4(sig00000136),
    .I5(sig00000004),
    .O(sig00000076)
  );
  LUT3 #(
    .INIT ( 8'h15 ))
  blk00000113 (
    .I0(sig00000067),
    .I1(sig000000e8),
    .I2(sig00000012),
    .O(sig00000137)
  );
  LUT6 #(
    .INIT ( 64'h0111511155555555 ))
  blk00000114 (
    .I0(sig00000068),
    .I1(sig00000137),
    .I2(sig00000005),
    .I3(sig00000007),
    .I4(sig00000138),
    .I5(sig00000004),
    .O(sig00000011)
  );
  LUT4 #(
    .INIT ( 16'h7150 ))
  blk00000115 (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig00000013),
    .I3(sig00000014),
    .O(sig00000139)
  );
  LUT6 #(
    .INIT ( 64'h0555044404440555 ))
  blk00000116 (
    .I0(sig00000067),
    .I1(sig0000007e),
    .I2(sig000000e8),
    .I3(sig00000012),
    .I4(sig00000006),
    .I5(sig00000139),
    .O(sig0000012d)
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  blk00000117 (
    .I0(sig00000067),
    .I1(sig000000e8),
    .I2(sig00000012),
    .O(sig0000013a)
  );
  LUT6 #(
    .INIT ( 64'h00F500FA00F900F6 ))
  blk00000118 (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig0000007e),
    .I3(sig0000013a),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig0000012a)
  );
  LUT4 #(
    .INIT ( 16'hDEB7 ))
  blk00000119 (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig00000013),
    .I3(sig00000014),
    .O(sig00000126)
  );
  LUT5 #(
    .INIT ( 32'hDFEFBFF7 ))
  blk0000011a (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig00000006),
    .I3(sig00000013),
    .I4(sig00000014),
    .O(sig00000125)
  );
  LUT3 #(
    .INIT ( 8'h53 ))
  blk0000011b (
    .I0(sig000000e9),
    .I1(sig000000ea),
    .I2(sig00000012),
    .O(sig0000013b)
  );
  LUT6 #(
    .INIT ( 64'h956AA9569966AA55 ))
  blk0000011c (
    .I0(sig00000072),
    .I1(sig00000073),
    .I2(sig00000074),
    .I3(sig0000013b),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig00000079)
  );
  LUT6 #(
    .INIT ( 64'h00F600F900F500FA ))
  blk0000011d (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig0000007e),
    .I3(sig0000013a),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig0000012b)
  );
  LUT5 #(
    .INIT ( 32'hBEBEBBEE ))
  blk0000011e (
    .I0(sig00000070),
    .I1(sig00000072),
    .I2(sig000000e9),
    .I3(sig000000ea),
    .I4(sig00000012),
    .O(sig0000013c)
  );
  LUT6 #(
    .INIT ( 64'h0080004000200010 ))
  blk0000011f (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig00000005),
    .I3(sig0000013c),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig00000063)
  );
  LUT6 #(
    .INIT ( 64'h00B000F000E000F0 ))
  blk00000120 (
    .I0(sig00000070),
    .I1(sig00000074),
    .I2(sig0000007e),
    .I3(sig0000013a),
    .I4(sig00000006),
    .I5(sig00000014),
    .O(sig00000136)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFF3FFFFFFF1 ))
  blk00000121 (
    .I0(sig00000021),
    .I1(sig00000022),
    .I2(sig000000ea),
    .I3(sig00000012),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000fe)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk00000122 (
    .I0(sig00000020),
    .I1(sig000000ea),
    .O(sig0000013d)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk00000123 (
    .I0(sig00000021),
    .I1(sig000000ea),
    .O(sig0000013e)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk00000124 (
    .I0(sig00000022),
    .I1(sig000000ea),
    .O(sig0000013f)
  );
  LUT6 #(
    .INIT ( 64'h0000111100550505 ))
  blk00000125 (
    .I0(sig00000012),
    .I1(sig0000013e),
    .I2(sig0000013d),
    .I3(sig0000013f),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig000000ff)
  );
  LUT5 #(
    .INIT ( 32'h9A9A6655 ))
  blk00000126 (
    .I0(sig00000071),
    .I1(sig00000072),
    .I2(sig000000e9),
    .I3(sig000000ea),
    .I4(sig00000012),
    .O(sig00000140)
  );
  LUT5 #(
    .INIT ( 32'h5959AA66 ))
  blk00000127 (
    .I0(sig00000071),
    .I1(sig00000072),
    .I2(sig000000e9),
    .I3(sig000000ea),
    .I4(sig00000012),
    .O(sig00000141)
  );
  LUT6 #(
    .INIT ( 64'h078F01EF05AF00FF ))
  blk00000128 (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig00000141),
    .I3(sig00000140),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig00000078)
  );
  LUT6 #(
    .INIT ( 64'h93999399C9C9CCCC ))
  blk00000129 (
    .I0(sig00000071),
    .I1(sig00000070),
    .I2(sig00000072),
    .I3(sig000000e9),
    .I4(sig000000ea),
    .I5(sig00000012),
    .O(sig00000142)
  );
  LUT6 #(
    .INIT ( 64'h339333939999C9C9 ))
  blk0000012a (
    .I0(sig00000071),
    .I1(sig00000070),
    .I2(sig00000072),
    .I3(sig000000e9),
    .I4(sig000000ea),
    .I5(sig00000012),
    .O(sig00000143)
  );
  LUT6 #(
    .INIT ( 64'hF870FE10FA50FF00 ))
  blk0000012b (
    .I0(sig00000073),
    .I1(sig00000074),
    .I2(sig00000143),
    .I3(sig00000142),
    .I4(sig00000013),
    .I5(sig00000014),
    .O(sig00000077)
  );
  LUT6 #(
    .INIT ( 64'h0054545400515151 ))
  blk0000012c (
    .I0(sig00000067),
    .I1(sig00000074),
    .I2(sig0000007e),
    .I3(sig000000e8),
    .I4(sig00000012),
    .I5(sig00000014),
    .O(sig0000012e)
  );
  LUT6 #(
    .INIT ( 64'h0051515100545454 ))
  blk0000012d (
    .I0(sig00000067),
    .I1(sig00000074),
    .I2(sig0000007e),
    .I3(sig000000e8),
    .I4(sig00000012),
    .I5(sig00000014),
    .O(sig0000012f)
  );
  LUT5 #(
    .INIT ( 32'h00404040 ))
  blk0000012e (
    .I0(sig00000067),
    .I1(sig00000075),
    .I2(sig00000015),
    .I3(sig000000e8),
    .I4(sig00000012),
    .O(sig00000135)
  );
  MUXF7   blk0000012f (
    .I0(sig00000144),
    .I1(sig00000145),
    .S(sig00000006),
    .O(sig00000138)
  );
  LUT3 #(
    .INIT ( 8'h15 ))
  blk00000130 (
    .I0(sig00000067),
    .I1(sig000000e8),
    .I2(sig00000012),
    .O(sig00000144)
  );
  LUT6 #(
    .INIT ( 64'h0023232300323232 ))
  blk00000131 (
    .I0(sig00000070),
    .I1(sig00000067),
    .I2(sig00000074),
    .I3(sig000000e8),
    .I4(sig00000012),
    .I5(sig00000014),
    .O(sig00000145)
  );
  LUT5 #(
    .INIT ( 32'hAAAAAA2A ))
  blk00000132 (
    .I0(sig00000069),
    .I1(sig00000012),
    .I2(sig000000e8),
    .I3(sig00000067),
    .I4(sig00000068),
    .O(sig0000007d)
  );
  LUT4 #(
    .INIT ( 16'hF888 ))
  blk00000133 (
    .I0(sig00000075),
    .I1(sig00000015),
    .I2(sig00000012),
    .I3(sig000000e8),
    .O(sig00000127)
  );
  LUT4 #(
    .INIT ( 16'h95A9 ))
  blk00000134 (
    .I0(b[14]),
    .I1(sig0000000d),
    .I2(b[13]),
    .I3(a[13]),
    .O(sig00000003)
  );
  LUT5 #(
    .INIT ( 32'hDFFD8FF8 ))
  blk00000135 (
    .I0(sig00000090),
    .I1(a[9]),
    .I2(a[10]),
    .I3(b[10]),
    .I4(b[9]),
    .O(sig00000051)
  );
  LUT5 #(
    .INIT ( 32'h66600600 ))
  blk00000136 (
    .I0(a[10]),
    .I1(b[10]),
    .I2(sig00000090),
    .I3(b[0]),
    .I4(a[0]),
    .O(sig0000005b)
  );
  LUT6 #(
    .INIT ( 64'h9614BE3C8200AA28 ))
  blk00000137 (
    .I0(sig0000005d),
    .I1(sig00000008),
    .I2(sig00000009),
    .I3(sig00000058),
    .I4(sig000000b0),
    .I5(sig00000054),
    .O(sig0000003b)
  );
  LUT4 #(
    .INIT ( 16'h7770 ))
  blk00000138 (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000042),
    .I3(sig00000044),
    .O(sig0000007b)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000139 (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[0]),
    .I4(b[0]),
    .O(sig00000050)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk0000013a (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[1]),
    .I4(b[1]),
    .O(sig0000004f)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk0000013b (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[2]),
    .I4(b[2]),
    .O(sig0000004e)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk0000013c (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[3]),
    .I4(b[3]),
    .O(sig0000004d)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk0000013d (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[4]),
    .I4(b[4]),
    .O(sig0000004c)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk0000013e (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[5]),
    .I4(b[5]),
    .O(sig0000004b)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk0000013f (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[6]),
    .I4(b[6]),
    .O(sig0000004a)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000140 (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[7]),
    .I4(b[7]),
    .O(sig00000049)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000141 (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[8]),
    .I4(b[8]),
    .O(sig00000048)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000142 (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000090),
    .I3(a[9]),
    .I4(b[9]),
    .O(sig00000047)
  );
  LUT6 #(
    .INIT ( 64'h9F0F960699099000 ))
  blk00000143 (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000005d),
    .I3(sig00000057),
    .I4(sig0000005b),
    .I5(sig00000053),
    .O(sig0000003a)
  );
  LUT6 #(
    .INIT ( 64'h9F0F960699099000 ))
  blk00000144 (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000005d),
    .I3(sig00000056),
    .I4(sig0000005a),
    .I5(sig00000052),
    .O(sig00000039)
  );
  LUT6 #(
    .INIT ( 64'h9F0F960699099000 ))
  blk00000145 (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000005d),
    .I3(sig00000055),
    .I4(sig00000059),
    .I5(sig00000051),
    .O(sig00000038)
  );
  LUT6 #(
    .INIT ( 64'hC382D79641005514 ))
  blk00000146 (
    .I0(sig0000005d),
    .I1(sig00000008),
    .I2(sig00000009),
    .I3(sig00000058),
    .I4(sig000000b0),
    .I5(sig00000054),
    .O(sig00000037)
  );
  LUT5 #(
    .INIT ( 32'h99900900 ))
  blk00000147 (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000005d),
    .I3(sig00000057),
    .I4(sig00000053),
    .O(sig00000036)
  );
  LUT5 #(
    .INIT ( 32'h99900900 ))
  blk00000148 (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000005d),
    .I3(sig00000056),
    .I4(sig00000052),
    .O(sig00000035)
  );
  LUT5 #(
    .INIT ( 32'h99900900 ))
  blk00000149 (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000005d),
    .I3(sig00000055),
    .I4(sig00000051),
    .O(sig00000034)
  );
  LUT4 #(
    .INIT ( 16'h4004 ))
  blk0000014a (
    .I0(sig0000005d),
    .I1(sig00000052),
    .I2(sig00000009),
    .I3(sig00000008),
    .O(sig00000031)
  );
  LUT4 #(
    .INIT ( 16'h4004 ))
  blk0000014b (
    .I0(sig0000005d),
    .I1(sig00000051),
    .I2(sig00000009),
    .I3(sig00000008),
    .O(sig00000030)
  );
  LUT4 #(
    .INIT ( 16'h4004 ))
  blk0000014c (
    .I0(sig0000005d),
    .I1(sig00000053),
    .I2(sig00000009),
    .I3(sig00000008),
    .O(sig00000032)
  );
  LUT6 #(
    .INIT ( 64'hF00F0FF0D22D2DD2 ))
  blk0000014d (
    .I0(sig00000030),
    .I1(sig0000005e),
    .I2(a[15]),
    .I3(b[15]),
    .I4(sig00000047),
    .I5(sig00000060),
    .O(sig000000b9)
  );
  LUT6 #(
    .INIT ( 64'hC03FC03F956AC03F ))
  blk0000014e (
    .I0(sig0000005e),
    .I1(sig00000045),
    .I2(sig00000043),
    .I3(sig00000066),
    .I4(sig0000002f),
    .I5(sig00000060),
    .O(sig000000ba)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk0000014f (
    .I0(sig00000060),
    .I1(b[15]),
    .I2(a[15]),
    .I3(sig0000005e),
    .I4(sig00000038),
    .I5(sig0000003a),
    .O(sig000000bc)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk00000150 (
    .I0(sig00000060),
    .I1(b[15]),
    .I2(a[15]),
    .I3(sig0000005e),
    .I4(sig00000039),
    .I5(sig0000003b),
    .O(sig000000bb)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA66AAAA69 ))
  blk00000151 (
    .I0(sig0000000a),
    .I1(sig0000000f),
    .I2(sig00000010),
    .I3(a[10]),
    .I4(b[10]),
    .I5(sig0000000b),
    .O(sig0000005d)
  );
  LUT6 #(
    .INIT ( 64'h4004000040000004 ))
  blk00000152 (
    .I0(sig0000000b),
    .I1(sig0000000a),
    .I2(a[10]),
    .I3(b[10]),
    .I4(sig0000000f),
    .I5(sig00000010),
    .O(sig00000009)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000002 ))
  blk00000153 (
    .I0(sig00000043),
    .I1(b[14]),
    .I2(b[13]),
    .I3(b[12]),
    .I4(b[11]),
    .I5(b[10]),
    .O(sig00000065)
  );
  LUT6 #(
    .INIT ( 64'h9990090009009990 ))
  blk00000154 (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000005d),
    .I3(sig00000054),
    .I4(a[10]),
    .I5(b[10]),
    .O(sig00000033)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFEF ))
  blk00000155 (
    .I0(b[12]),
    .I1(b[13]),
    .I2(sig00000043),
    .I3(b[11]),
    .I4(b[10]),
    .I5(b[14]),
    .O(sig00000046)
  );
  LUT5 #(
    .INIT ( 32'h09000009 ))
  blk00000156 (
    .I0(b[10]),
    .I1(a[10]),
    .I2(sig0000005d),
    .I3(sig00000008),
    .I4(sig00000009),
    .O(sig0000002f)
  );
  LUT5 #(
    .INIT ( 32'hB2BB22B2 ))
  blk00000157 (
    .I0(b[14]),
    .I1(a[14]),
    .I2(b[13]),
    .I3(a[13]),
    .I4(sig0000000d),
    .O(sig0000000b)
  );
  LUT5 #(
    .INIT ( 32'h422DB442 ))
  blk00000158 (
    .I0(b[14]),
    .I1(a[14]),
    .I2(sig0000000d),
    .I3(b[13]),
    .I4(a[13]),
    .O(sig00000008)
  );
  LUT6 #(
    .INIT ( 64'hFF777F5755111501 ))
  blk00000159 (
    .I0(a[12]),
    .I1(a[11]),
    .I2(a[10]),
    .I3(b[11]),
    .I4(b[10]),
    .I5(b[12]),
    .O(sig0000000d)
  );
  LUT6 #(
    .INIT ( 64'hBDD24BBD422DB442 ))
  blk0000015a (
    .I0(b[14]),
    .I1(a[14]),
    .I2(sig0000000d),
    .I3(b[13]),
    .I4(a[13]),
    .I5(sig00000009),
    .O(sig0000005c)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF08808888 ))
  blk0000015b (
    .I0(sig0000005c),
    .I1(sig0000005d),
    .I2(b[10]),
    .I3(a[10]),
    .I4(sig0000000f),
    .I5(sig0000011d),
    .O(sig00000060)
  );
  LUT4 #(
    .INIT ( 16'h9FF9 ))
  blk0000015c (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig0000011f)
  );
  LUT5 #(
    .INIT ( 32'h66699666 ))
  blk0000015d (
    .I0(b[11]),
    .I1(a[11]),
    .I2(sig0000000b),
    .I3(a[10]),
    .I4(b[10]),
    .O(sig0000005e)
  );
  MUXF7   blk0000015e (
    .I0(sig00000146),
    .I1(sig00000147),
    .S(sig00000044),
    .O(sig0000007c)
  );
  LUT6 #(
    .INIT ( 64'hAABA88BA22020002 ))
  blk0000015f (
    .I0(a[15]),
    .I1(sig00000065),
    .I2(sig00000090),
    .I3(sig00000042),
    .I4(sig00000061),
    .I5(b[15]),
    .O(sig00000146)
  );
  LUT6 #(
    .INIT ( 64'h888080808A808A80 ))
  blk00000160 (
    .I0(b[15]),
    .I1(a[15]),
    .I2(sig00000065),
    .I3(sig00000062),
    .I4(sig00000061),
    .I5(sig00000042),
    .O(sig00000147)
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
