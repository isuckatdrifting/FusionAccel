////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: accum.v
// /___/   /\     Timestamp: Sun Mar 03 14:45:26 2019
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
  wire sig00000148;
  wire sig00000149;
  wire sig0000014a;
  wire sig0000014b;
  wire sig0000014c;
  wire sig0000014d;
  wire sig0000014e;
  wire sig0000014f;
  wire sig00000150;
  wire sig00000151;
  wire sig00000152;
  wire sig00000153;
  wire sig00000154;
  wire sig00000155;
  wire sig00000156;
  wire sig00000157;
  wire sig00000158;
  wire sig00000159;
  wire sig0000015a;
  wire sig0000015b;
  wire sig0000015c;
  wire sig0000015d;
  wire sig0000015e;
  wire sig0000015f;
  wire sig00000160;
  wire sig00000161;
  wire sig00000162;
  wire sig00000163;
  wire sig00000164;
  wire sig00000165;
  wire sig00000166;
  wire sig00000167;
  wire sig00000168;
  wire sig00000169;
  wire sig0000016a;
  wire sig0000016b;
  wire sig0000016c;
  wire sig0000016d;
  wire sig0000016e;
  wire sig0000016f;
  wire sig00000170;
  wire sig00000171;
  wire sig00000172;
  wire sig00000173;
  wire sig00000174;
  wire sig00000175;
  wire sig00000176;
  wire sig00000177;
  wire sig00000178;
  wire sig00000179;
  wire sig0000017a;
  wire sig0000017b;
  wire sig0000017c;
  wire sig0000017d;
  wire sig0000017e;
  wire sig0000017f;
  wire sig00000180;
  wire sig00000181;
  wire sig00000182;
  wire sig00000183;
  wire sig00000184;
  wire sig00000185;
  wire sig00000186;
  wire sig00000187;
  wire sig00000188;
  wire sig00000189;
  wire sig0000018a;
  wire sig0000018b;
  wire sig0000018c;
  wire sig0000018d;
  wire sig0000018e;
  wire sig0000018f;
  wire sig00000190;
  wire sig00000191;
  wire sig00000192;
  wire sig00000193;
  wire sig00000194;
  wire sig00000195;
  wire sig00000196;
  wire sig00000197;
  wire sig00000198;
  wire sig00000199;
  wire sig0000019a;
  wire sig0000019b;
  wire sig0000019c;
  wire sig0000019d;
  wire sig0000019e;
  wire sig0000019f;
  wire sig000001a0;
  wire sig000001a1;
  wire sig000001a2;
  wire sig000001a3;
  wire sig000001a4;
  wire sig000001a5;
  wire sig000001a6;
  wire sig000001a7;
  wire sig000001a8;
  wire sig000001a9;
  wire sig000001aa;
  wire sig000001ab;
  wire sig000001ac;
  wire sig000001ad;
  wire sig000001ae;
  wire sig000001af;
  wire sig000001b0;
  wire sig000001b1;
  wire sig000001b2;
  wire sig000001b3;
  wire sig000001b4;
  wire sig000001b5;
  wire sig000001b6;
  wire sig000001b7;
  wire sig000001b8;
  wire sig000001b9;
  wire sig000001ba;
  wire sig000001bb;
  wire sig000001bc;
  wire sig000001bd;
  wire sig000001be;
  wire sig000001bf;
  wire sig000001c0;
  wire sig000001c1;
  wire sig000001c2;
  wire sig000001c3;
  wire sig000001c4;
  wire sig000001c5;
  wire sig000001c6;
  wire sig000001c7;
  wire sig000001c8;
  wire sig000001c9;
  wire sig000001ca;
  wire sig000001cb;
  wire sig000001cc;
  wire sig000001cd;
  wire sig000001ce;
  wire sig000001cf;
  wire sig000001d0;
  wire sig000001d1;
  wire sig000001d2;
  wire sig000001d3;
  wire sig000001d4;
  wire sig000001d5;
  wire sig000001d6;
  wire sig000001d7;
  wire sig000001d8;
  wire sig000001d9;
  wire sig000001da;
  wire sig000001db;
  wire sig000001dc;
  wire sig000001dd;
  wire sig000001de;
  wire sig000001df;
  wire sig000001e0;
  wire sig000001e1;
  wire sig000001e2;
  wire sig000001e3;
  wire sig000001e4;
  wire sig000001e5;
  wire sig000001e6;
  wire sig000001e7;
  wire sig000001e8;
  wire sig000001e9;
  wire sig000001ea;
  wire sig000001eb;
  wire sig000001ec;
  wire sig000001ed;
  wire sig000001ee;
  wire sig000001ef;
  wire sig000001f0;
  wire sig000001f1;
  wire sig000001f2;
  wire sig000001f3;
  wire sig000001f4;
  wire sig000001f5;
  wire sig000001f6;
  wire sig000001f7;
  wire sig000001f8;
  wire sig000001f9;
  wire sig000001fa;
  wire sig000001fb;
  wire sig000001fc;
  wire sig000001fd;
  wire sig000001fe;
  wire sig000001ff;
  wire sig00000200;
  wire sig00000201;
  wire NLW_blk00000093_Q_UNCONNECTED;
  wire NLW_blk000000d8_O_UNCONNECTED;
  wire NLW_blk0000012b_O_UNCONNECTED;
  wire NLW_blk0000012c_O_UNCONNECTED;
  wire NLW_blk0000012e_O_UNCONNECTED;
  wire NLW_blk00000130_O_UNCONNECTED;
  wire NLW_blk00000132_O_UNCONNECTED;
  wire NLW_blk00000205_Q15_UNCONNECTED;
  wire NLW_blk00000207_Q15_UNCONNECTED;
  wire NLW_blk00000209_Q15_UNCONNECTED;
  wire NLW_blk0000020b_Q15_UNCONNECTED;
  wire NLW_blk0000020d_Q15_UNCONNECTED;
  wire NLW_blk0000020f_Q15_UNCONNECTED;
  wire NLW_blk00000211_Q15_UNCONNECTED;
  wire NLW_blk00000213_Q15_UNCONNECTED;
  wire NLW_blk00000215_Q15_UNCONNECTED;
  wire NLW_blk00000217_Q15_UNCONNECTED;
  wire NLW_blk00000219_Q15_UNCONNECTED;
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
  FDE #(
    .INIT ( 1'b0 ))
  blk00000003 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000002e),
    .Q(sig0000006d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000004 (
    .C(clk),
    .D(sig00000077),
    .Q(sig00000069)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000005 (
    .C(clk),
    .D(sig00000076),
    .Q(sig0000006a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000006 (
    .C(clk),
    .D(sig00000075),
    .Q(sig0000006c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000007 (
    .C(clk),
    .D(sig000000a4),
    .Q(sig00000068)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000008 (
    .C(clk),
    .D(sig000000a5),
    .Q(sig0000006b)
  );
  MUXCY   blk00000009 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000084),
    .O(sig0000007c)
  );
  MUXCY   blk0000000a (
    .CI(sig0000007c),
    .DI(sig00000001),
    .S(sig00000083),
    .O(sig0000007d)
  );
  MUXCY   blk0000000b (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000082),
    .O(sig0000007f)
  );
  MUXCY   blk0000000c (
    .CI(sig0000007f),
    .DI(sig00000001),
    .S(sig00000081),
    .O(sig00000080)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000009f),
    .Q(sig00000063)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000e (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a0),
    .Q(sig00000064)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a1),
    .Q(sig00000065)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000010 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a2),
    .Q(sig00000066)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000011 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a3),
    .Q(sig00000067)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000012 (
    .C(clk),
    .D(sig0000008e),
    .Q(sig00000078)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000013 (
    .C(clk),
    .D(sig000000b2),
    .Q(sig000000ac)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000014 (
    .C(clk),
    .D(sig000000b3),
    .Q(sig000000ad)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000015 (
    .C(clk),
    .D(sig000000b4),
    .Q(sig000000ae)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000016 (
    .C(clk),
    .D(sig000000b5),
    .Q(sig000000af)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000017 (
    .C(clk),
    .D(sig000000b6),
    .Q(sig000000b0)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000018 (
    .C(clk),
    .D(sig000000b7),
    .Q(sig000000b1)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000019 (
    .C(clk),
    .D(sig00000099),
    .Q(sig00000079)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001a (
    .C(clk),
    .D(sig00000093),
    .Q(sig0000006e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001b (
    .C(clk),
    .D(sig00000094),
    .Q(sig0000006f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001c (
    .C(clk),
    .D(sig00000095),
    .Q(sig00000070)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001d (
    .C(clk),
    .D(sig00000096),
    .Q(sig00000071)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001e (
    .C(clk),
    .D(sig00000097),
    .Q(sig00000072)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[15]),
    .Q(sig000000c3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000020 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[15]),
    .Q(sig000000c2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000021 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[10]),
    .Q(sig000000c9)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000022 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[11]),
    .Q(sig000000ca)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000023 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[12]),
    .Q(sig000000cb)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000024 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[13]),
    .Q(sig000000cc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000025 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[14]),
    .Q(sig000000cd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000026 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[10]),
    .Q(sig000000c4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000027 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[11]),
    .Q(sig000000c5)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000028 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[12]),
    .Q(sig000000c6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000029 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[13]),
    .Q(sig000000c7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[14]),
    .Q(sig000000c8)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002b (
    .C(clk),
    .D(sig0000004a),
    .Q(sig0000007a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002c (
    .C(clk),
    .D(sig0000007a),
    .Q(sig000000ce)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000061),
    .Q(sig000000c1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002e (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000090),
    .Q(sig000000c0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000092),
    .Q(sig000000bf)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000030 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000091),
    .Q(sig000000bd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000031 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000008f),
    .Q(sig0000010e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000032 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000009c),
    .Q(sig000000bc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000033 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000009d),
    .Q(sig000000be)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000034 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000009e),
    .Q(sig000000bb)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000035 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000098),
    .Q(sig0000005f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000036 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000088),
    .Q(sig000000cf)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000037 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000087),
    .Q(sig000000d0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000086),
    .Q(sig000000d1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000039 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000085),
    .Q(sig000000d2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000007d),
    .Q(sig0000007b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000080),
    .Q(sig0000007e)
  );
  MUXCY   blk0000003c (
    .CI(sig000000e4),
    .DI(sig000000d3),
    .S(sig000000d4),
    .O(sig000000e3)
  );
  MUXCY   blk0000003d (
    .CI(sig000000e5),
    .DI(sig000000d5),
    .S(sig000000d6),
    .O(sig000000e4)
  );
  MUXCY   blk0000003e (
    .CI(sig000000e6),
    .DI(sig000000d7),
    .S(sig000000d8),
    .O(sig000000e5)
  );
  MUXCY   blk0000003f (
    .CI(sig000000e7),
    .DI(sig000000d9),
    .S(sig000000da),
    .O(sig000000e6)
  );
  MUXCY   blk00000040 (
    .CI(sig000000e8),
    .DI(sig000000db),
    .S(sig000000dc),
    .O(sig000000e7)
  );
  MUXCY   blk00000041 (
    .CI(sig000000e9),
    .DI(sig000000dd),
    .S(sig000000de),
    .O(sig000000e8)
  );
  MUXCY   blk00000042 (
    .CI(sig000000ea),
    .DI(sig000000df),
    .S(sig000000e0),
    .O(sig000000e9)
  );
  MUXCY   blk00000043 (
    .CI(sig00000001),
    .DI(sig000000e1),
    .S(sig000000e2),
    .O(sig000000ea)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000044 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000e3),
    .Q(sig00000062)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000045 (
    .C(clk),
    .D(sig0000009b),
    .Q(sig000000ec)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000046 (
    .C(clk),
    .D(sig0000009a),
    .Q(sig000000eb)
  );
  XORCY   blk00000047 (
    .CI(sig000000ed),
    .LI(sig00000001),
    .O(sig000000b7)
  );
  XORCY   blk00000048 (
    .CI(sig000000ee),
    .LI(sig0000008d),
    .O(sig000000b6)
  );
  MUXCY   blk00000049 (
    .CI(sig000000ee),
    .DI(sig00000001),
    .S(sig0000008d),
    .O(sig000000ed)
  );
  XORCY   blk0000004a (
    .CI(sig000000ef),
    .LI(sig0000008c),
    .O(sig000000b5)
  );
  MUXCY   blk0000004b (
    .CI(sig000000ef),
    .DI(sig00000001),
    .S(sig0000008c),
    .O(sig000000ee)
  );
  XORCY   blk0000004c (
    .CI(sig000000f0),
    .LI(sig0000008b),
    .O(sig000000b4)
  );
  MUXCY   blk0000004d (
    .CI(sig000000f0),
    .DI(sig00000001),
    .S(sig0000008b),
    .O(sig000000ef)
  );
  XORCY   blk0000004e (
    .CI(sig000000f1),
    .LI(sig0000008a),
    .O(sig000000b3)
  );
  MUXCY   blk0000004f (
    .CI(sig000000f1),
    .DI(sig00000001),
    .S(sig0000008a),
    .O(sig000000f0)
  );
  XORCY   blk00000050 (
    .CI(sig00000001),
    .LI(sig00000089),
    .O(sig000000b2)
  );
  MUXCY   blk00000051 (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000089),
    .O(sig000000f1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000052 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[9]),
    .Q(sig00000054)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000053 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[8]),
    .Q(sig00000053)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000054 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[7]),
    .Q(sig00000052)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000055 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[6]),
    .Q(sig00000051)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000056 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[5]),
    .Q(sig00000050)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000057 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[4]),
    .Q(sig0000004f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000058 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[3]),
    .Q(sig0000004e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000059 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[2]),
    .Q(sig0000004d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[1]),
    .Q(sig0000004c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(b[0]),
    .Q(sig0000004b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005c (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[9]),
    .Q(sig0000005e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[8]),
    .Q(sig0000005d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005e (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[7]),
    .Q(sig0000005c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[6]),
    .Q(sig0000005b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000060 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[5]),
    .Q(sig0000005a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000061 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[4]),
    .Q(sig00000059)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000062 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[3]),
    .Q(sig00000058)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000063 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[2]),
    .Q(sig00000057)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000064 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[1]),
    .Q(sig00000056)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000065 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(a[0]),
    .Q(sig00000055)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000066 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000010e),
    .Q(sig00000126)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000067 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000006d),
    .Q(sig00000117)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000068 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000110),
    .Q(sig00000118)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000069 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000111),
    .Q(sig000000f3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000112),
    .Q(sig000000f2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000113),
    .Q(sig00000119)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006c (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000060),
    .Q(sig00000133)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000118),
    .Q(sig00000115)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006e (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000116),
    .Q(sig0000003c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000010f),
    .Q(sig00000114)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000070 (
    .C(clk),
    .D(sig00000132),
    .Q(sig00000125)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000071 (
    .C(clk),
    .D(sig00000131),
    .Q(sig00000124)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000072 (
    .C(clk),
    .D(sig00000130),
    .Q(sig00000123)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000073 (
    .C(clk),
    .D(sig0000012f),
    .Q(sig00000122)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000074 (
    .C(clk),
    .D(sig0000012e),
    .Q(sig00000121)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000075 (
    .C(clk),
    .D(sig0000012d),
    .Q(sig00000120)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000076 (
    .C(clk),
    .D(sig0000012c),
    .Q(sig0000011f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000077 (
    .C(clk),
    .D(sig0000012b),
    .Q(sig0000011e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000078 (
    .C(clk),
    .D(sig0000012a),
    .Q(sig0000011d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000079 (
    .C(clk),
    .D(sig00000129),
    .Q(sig0000011c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007a (
    .C(clk),
    .D(sig00000128),
    .Q(sig0000011b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007b (
    .C(clk),
    .D(sig00000127),
    .Q(sig0000011a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007c (
    .C(clk),
    .D(sig000000f4),
    .Q(sig00000101)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007d (
    .C(clk),
    .D(sig000000f5),
    .Q(sig00000102)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007e (
    .C(clk),
    .D(sig000000f6),
    .Q(sig00000103)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007f (
    .C(clk),
    .D(sig000000f7),
    .Q(sig00000104)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000080 (
    .C(clk),
    .D(sig000000f8),
    .Q(sig00000105)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000081 (
    .C(clk),
    .D(sig000000f9),
    .Q(sig00000106)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000082 (
    .C(clk),
    .D(sig000000fa),
    .Q(sig00000107)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000083 (
    .C(clk),
    .D(sig000000fb),
    .Q(sig00000108)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000084 (
    .C(clk),
    .D(sig000000fc),
    .Q(sig00000109)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000085 (
    .C(clk),
    .D(sig000000fd),
    .Q(sig0000010a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000086 (
    .C(clk),
    .D(sig000000fe),
    .Q(sig0000010b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000087 (
    .C(clk),
    .D(sig000000ff),
    .Q(sig0000010c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000088 (
    .C(clk),
    .D(sig00000100),
    .Q(sig0000010d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000089 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000f3),
    .Q(sig00000147)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000f2),
    .Q(sig00000148)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000143),
    .Q(sig00000149)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008c (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000144),
    .Q(sig0000014c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000145),
    .Q(sig0000014b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008e (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000146),
    .Q(sig0000014a)
  );
  MUXCY   blk0000008f (
    .CI(sig00000151),
    .DI(sig00000001),
    .S(sig00000142),
    .O(sig00000150)
  );
  MUXCY   blk00000090 (
    .CI(sig00000152),
    .DI(sig00000001),
    .S(sig00000141),
    .O(sig00000151)
  );
  MUXCY   blk00000091 (
    .CI(sig00000153),
    .DI(sig00000001),
    .S(sig00000140),
    .O(sig00000152)
  );
  MUXCY   blk00000092 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig0000013f),
    .O(sig00000153)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000093 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000150),
    .Q(NLW_blk00000093_Q_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000094 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000151),
    .Q(sig0000014d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000095 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000152),
    .Q(sig0000014e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000096 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000153),
    .Q(sig0000014f)
  );
  MUXCY   blk00000097 (
    .CI(sig00000176),
    .DI(sig00000001),
    .S(sig00000116),
    .O(sig00000175)
  );
  MUXCY   blk00000098 (
    .CI(sig00000126),
    .DI(sig00000001),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig00000176)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000099 (
    .C(clk),
    .D(sig0000017a),
    .Q(sig00000174)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009a (
    .C(clk),
    .D(sig00000179),
    .Q(sig00000173)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009b (
    .C(clk),
    .D(sig00000178),
    .Q(sig00000172)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009c (
    .C(clk),
    .D(sig00000177),
    .Q(sig00000171)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009d (
    .C(clk),
    .D(sig00000137),
    .Q(sig0000017a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009e (
    .C(clk),
    .D(sig00000136),
    .Q(sig00000179)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009f (
    .C(clk),
    .D(sig00000135),
    .Q(sig00000178)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a0 (
    .C(clk),
    .D(sig00000134),
    .Q(sig00000177)
  );
  XORCY   blk000000a1 (
    .CI(sig0000017d),
    .LI(sig00000160),
    .O(sig0000017b)
  );
  MUXCY   blk000000a2 (
    .CI(sig0000017d),
    .DI(sig00000174),
    .S(sig00000160),
    .O(sig00000170)
  );
  XORCY   blk000000a3 (
    .CI(sig0000017f),
    .LI(sig0000015f),
    .O(sig0000017c)
  );
  MUXCY   blk000000a4 (
    .CI(sig0000017f),
    .DI(sig00000173),
    .S(sig0000015f),
    .O(sig0000017d)
  );
  XORCY   blk000000a5 (
    .CI(sig00000181),
    .LI(sig0000015e),
    .O(sig0000017e)
  );
  MUXCY   blk000000a6 (
    .CI(sig00000181),
    .DI(sig00000172),
    .S(sig0000015e),
    .O(sig0000017f)
  );
  XORCY   blk000000a7 (
    .CI(sig00000183),
    .LI(sig0000015d),
    .O(sig00000180)
  );
  MUXCY   blk000000a8 (
    .CI(sig00000183),
    .DI(sig00000171),
    .S(sig0000015d),
    .O(sig00000181)
  );
  XORCY   blk000000a9 (
    .CI(sig00000185),
    .LI(sig0000015c),
    .O(sig00000182)
  );
  MUXCY   blk000000aa (
    .CI(sig00000185),
    .DI(sig00000001),
    .S(sig0000015c),
    .O(sig00000183)
  );
  XORCY   blk000000ab (
    .CI(sig00000175),
    .LI(sig0000015b),
    .O(sig00000184)
  );
  MUXCY   blk000000ac (
    .CI(sig00000175),
    .DI(sig00000001),
    .S(sig0000015b),
    .O(sig00000185)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ad (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000184),
    .Q(sig0000003d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ae (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000182),
    .Q(sig0000003e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000af (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000180),
    .Q(sig0000003f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b0 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000017e),
    .Q(sig00000040)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b1 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000017c),
    .Q(sig00000041)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b2 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000017b),
    .Q(sig00000042)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b3 (
    .C(clk),
    .D(sig0000018c),
    .Q(sig0000016f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b4 (
    .C(clk),
    .D(sig0000018b),
    .Q(sig0000016e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b5 (
    .C(clk),
    .D(sig0000018a),
    .Q(sig0000016d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b6 (
    .C(clk),
    .D(sig00000189),
    .Q(sig0000016c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b7 (
    .C(clk),
    .D(sig00000188),
    .Q(sig0000016b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b8 (
    .C(clk),
    .D(sig00000187),
    .Q(sig0000016a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b9 (
    .C(clk),
    .D(sig00000186),
    .Q(sig00000169)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ba (
    .C(clk),
    .D(sig0000013e),
    .Q(sig0000018c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bb (
    .C(clk),
    .D(sig0000013d),
    .Q(sig0000018b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bc (
    .C(clk),
    .D(sig0000013c),
    .Q(sig0000018a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bd (
    .C(clk),
    .D(sig0000013b),
    .Q(sig00000189)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000be (
    .C(clk),
    .D(sig0000013a),
    .Q(sig00000188)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bf (
    .C(clk),
    .D(sig00000139),
    .Q(sig00000187)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c0 (
    .C(clk),
    .D(sig00000138),
    .Q(sig00000186)
  );
  XORCY   blk000000c1 (
    .CI(sig0000018d),
    .LI(sig000001f0),
    .O(sig00000168)
  );
  XORCY   blk000000c2 (
    .CI(sig0000018e),
    .LI(sig0000015a),
    .O(sig00000167)
  );
  MUXCY   blk000000c3 (
    .CI(sig0000018e),
    .DI(sig0000016f),
    .S(sig0000015a),
    .O(sig0000018d)
  );
  XORCY   blk000000c4 (
    .CI(sig0000018f),
    .LI(sig00000159),
    .O(sig00000166)
  );
  MUXCY   blk000000c5 (
    .CI(sig0000018f),
    .DI(sig0000016e),
    .S(sig00000159),
    .O(sig0000018e)
  );
  XORCY   blk000000c6 (
    .CI(sig00000190),
    .LI(sig00000158),
    .O(sig00000165)
  );
  MUXCY   blk000000c7 (
    .CI(sig00000190),
    .DI(sig0000016d),
    .S(sig00000158),
    .O(sig0000018f)
  );
  XORCY   blk000000c8 (
    .CI(sig00000191),
    .LI(sig00000157),
    .O(sig00000164)
  );
  MUXCY   blk000000c9 (
    .CI(sig00000191),
    .DI(sig0000016c),
    .S(sig00000157),
    .O(sig00000190)
  );
  XORCY   blk000000ca (
    .CI(sig00000192),
    .LI(sig00000156),
    .O(sig00000163)
  );
  MUXCY   blk000000cb (
    .CI(sig00000192),
    .DI(sig0000016b),
    .S(sig00000156),
    .O(sig00000191)
  );
  XORCY   blk000000cc (
    .CI(sig00000193),
    .LI(sig00000155),
    .O(sig00000162)
  );
  MUXCY   blk000000cd (
    .CI(sig00000193),
    .DI(sig0000016a),
    .S(sig00000155),
    .O(sig00000192)
  );
  XORCY   blk000000ce (
    .CI(sig00000170),
    .LI(sig00000154),
    .O(sig00000161)
  );
  MUXCY   blk000000cf (
    .CI(sig00000170),
    .DI(sig00000169),
    .S(sig00000154),
    .O(sig00000193)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d0 (
    .C(clk),
    .D(sig00000168),
    .Q(sig0000004a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d1 (
    .C(clk),
    .D(sig00000167),
    .Q(sig00000049)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d2 (
    .C(clk),
    .D(sig00000166),
    .Q(sig00000048)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d3 (
    .C(clk),
    .D(sig00000165),
    .Q(sig00000047)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d4 (
    .C(clk),
    .D(sig00000164),
    .Q(sig00000046)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d5 (
    .C(clk),
    .D(sig00000163),
    .Q(sig00000045)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d6 (
    .C(clk),
    .D(sig00000162),
    .Q(sig00000044)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d7 (
    .C(clk),
    .D(sig00000161),
    .Q(sig00000043)
  );
  MUXF7   blk000000d8 (
    .I0(sig00000194),
    .I1(sig00000195),
    .S(sig0000000f),
    .O(NLW_blk000000d8_O_UNCONNECTED)
  );
  MUXF7   blk000000d9 (
    .I0(sig00000196),
    .I1(sig00000198),
    .S(sig0000000f),
    .O(sig0000019a)
  );
  MUXF7   blk000000da (
    .I0(sig00000197),
    .I1(sig00000199),
    .S(sig0000000f),
    .O(sig0000019b)
  );
  MUXCY   blk000000db (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000001a1),
    .O(sig0000019c)
  );
  MUXCY   blk000000dc (
    .CI(sig0000019c),
    .DI(sig00000001),
    .S(sig000001a2),
    .O(sig0000019d)
  );
  MUXCY   blk000000dd (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000001a3),
    .O(sig0000019e)
  );
  MUXCY   blk000000de (
    .CI(sig0000019e),
    .DI(sig00000001),
    .S(sig000001a4),
    .O(sig0000019f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000df (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000019b),
    .Q(sig00000011)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e0 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000019a),
    .Q(sig00000012)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e1 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000019c),
    .Q(sig000001a7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e2 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000019d),
    .Q(sig0000000f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e3 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000019e),
    .Q(sig000001a6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e4 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000019f),
    .Q(sig000001a5)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e5 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000000f),
    .Q(sig0000003b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e6 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000010),
    .Q(sig0000003a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e7 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001a0),
    .Q(sig0000002f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e8 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000002),
    .Q(sig0000002d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e9 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000003),
    .Q(sig0000002c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ea (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000004),
    .Q(sig0000002b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000eb (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000005),
    .Q(sig0000002a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ec (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000006),
    .Q(sig00000029)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ed (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000007),
    .Q(sig00000028)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ee (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000008),
    .Q(sig00000027)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ef (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000009),
    .Q(sig00000026)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f0 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000000a),
    .Q(sig00000025)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f1 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000000b),
    .Q(sig00000024)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f2 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000000c),
    .Q(sig00000023)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f3 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000000d),
    .Q(sig00000022)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f4 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000000e),
    .Q(sig00000021)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f5 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000049),
    .Q(sig00000013)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f6 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000048),
    .Q(sig00000014)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f7 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000047),
    .Q(sig00000015)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f8 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000046),
    .Q(sig00000016)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f9 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000045),
    .Q(sig00000017)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fa (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000044),
    .Q(sig00000018)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fb (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000043),
    .Q(sig00000019)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fc (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000042),
    .Q(sig0000001a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fd (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000041),
    .Q(sig0000001b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fe (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000040),
    .Q(sig0000001c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ff (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000003f),
    .Q(sig0000001d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000100 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000003e),
    .Q(sig0000001e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000101 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000003d),
    .Q(sig0000001f)
  );
  MUXCY   blk00000102 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000001bd),
    .O(sig000001b6)
  );
  MUXCY   blk00000103 (
    .CI(sig000001b6),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig000001bb),
    .O(sig000001b7)
  );
  MUXCY   blk00000104 (
    .CI(sig000001b7),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig000001ef),
    .O(sig000001b8)
  );
  MUXCY   blk00000105 (
    .CI(sig000001b8),
    .DI(sig00000001),
    .S(sig000001bc),
    .O(sig000001b9)
  );
  MUXCY   blk00000106 (
    .CI(sig000001b9),
    .DI(sig00000001),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000001ba)
  );
  MUXCY   blk00000107 (
    .CI(sig000001ba),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000001b5)
  );
  XORCY   blk00000108 (
    .CI(sig000001c0),
    .LI(sig000001b1),
    .O(sig000001be)
  );
  MUXCY   blk00000109 (
    .CI(sig000001c0),
    .DI(sig00000001),
    .S(sig000001b1),
    .O(sig000001b4)
  );
  XORCY   blk0000010a (
    .CI(sig000001c2),
    .LI(sig000001b0),
    .O(sig000001bf)
  );
  MUXCY   blk0000010b (
    .CI(sig000001c2),
    .DI(sig00000001),
    .S(sig000001b0),
    .O(sig000001c0)
  );
  XORCY   blk0000010c (
    .CI(sig000001c4),
    .LI(sig000001af),
    .O(sig000001c1)
  );
  MUXCY   blk0000010d (
    .CI(sig000001c4),
    .DI(sig00000001),
    .S(sig000001af),
    .O(sig000001c2)
  );
  XORCY   blk0000010e (
    .CI(sig000001c6),
    .LI(sig000001ae),
    .O(sig000001c3)
  );
  MUXCY   blk0000010f (
    .CI(sig000001c6),
    .DI(sig00000001),
    .S(sig000001ae),
    .O(sig000001c4)
  );
  XORCY   blk00000110 (
    .CI(sig000001b5),
    .LI(sig000001ad),
    .O(sig000001c5)
  );
  MUXCY   blk00000111 (
    .CI(sig000001b5),
    .DI(sig00000001),
    .S(sig000001ad),
    .O(sig000001c6)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000112 (
    .C(clk),
    .D(sig000001c5),
    .Q(sig00000030)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000113 (
    .C(clk),
    .D(sig000001c3),
    .Q(sig00000031)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000114 (
    .C(clk),
    .D(sig000001c1),
    .Q(sig00000032)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000115 (
    .C(clk),
    .D(sig000001bf),
    .Q(sig00000033)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000116 (
    .C(clk),
    .D(sig000001be),
    .Q(sig00000034)
  );
  XORCY   blk00000117 (
    .CI(sig000001c9),
    .LI(sig00000001),
    .O(sig000001c7)
  );
  XORCY   blk00000118 (
    .CI(sig000001cb),
    .LI(NlwRenamedSig_OI_operation_rfd),
    .O(sig000001c8)
  );
  MUXCY   blk00000119 (
    .CI(sig000001cb),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000001c9)
  );
  XORCY   blk0000011a (
    .CI(sig000001cd),
    .LI(sig000001ac),
    .O(sig000001ca)
  );
  MUXCY   blk0000011b (
    .CI(sig000001cd),
    .DI(sig00000001),
    .S(sig000001ac),
    .O(sig000001cb)
  );
  XORCY   blk0000011c (
    .CI(sig000001cf),
    .LI(sig000001ab),
    .O(sig000001cc)
  );
  MUXCY   blk0000011d (
    .CI(sig000001cf),
    .DI(sig00000001),
    .S(sig000001ab),
    .O(sig000001cd)
  );
  XORCY   blk0000011e (
    .CI(sig000001d1),
    .LI(sig000001aa),
    .O(sig000001ce)
  );
  MUXCY   blk0000011f (
    .CI(sig000001d1),
    .DI(sig00000001),
    .S(sig000001aa),
    .O(sig000001cf)
  );
  XORCY   blk00000120 (
    .CI(sig000001d3),
    .LI(sig000001a9),
    .O(sig000001d0)
  );
  MUXCY   blk00000121 (
    .CI(sig000001d3),
    .DI(sig00000001),
    .S(sig000001a9),
    .O(sig000001d1)
  );
  XORCY   blk00000122 (
    .CI(sig000001b4),
    .LI(sig000001a8),
    .O(sig000001d2)
  );
  MUXCY   blk00000123 (
    .CI(sig000001b4),
    .DI(sig00000001),
    .S(sig000001a8),
    .O(sig000001d3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000124 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001d2),
    .Q(sig00000035)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000125 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001d0),
    .Q(sig00000036)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000126 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001ce),
    .Q(sig00000037)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000127 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001cc),
    .Q(sig00000038)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000128 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001ca),
    .Q(sig00000039)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000129 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001c8),
    .Q(sig000001b3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000012a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001c7),
    .Q(sig000001b2)
  );
  XORCY   blk0000012b (
    .CI(sig000001d4),
    .LI(sig00000001),
    .O(NLW_blk0000012b_O_UNCONNECTED)
  );
  XORCY   blk0000012c (
    .CI(sig000001d5),
    .LI(sig00000001),
    .O(NLW_blk0000012c_O_UNCONNECTED)
  );
  MUXCY   blk0000012d (
    .CI(sig000001d5),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000001d4)
  );
  XORCY   blk0000012e (
    .CI(sig000001d6),
    .LI(sig00000001),
    .O(NLW_blk0000012e_O_UNCONNECTED)
  );
  MUXCY   blk0000012f (
    .CI(sig000001d6),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000001d5)
  );
  XORCY   blk00000130 (
    .CI(sig000001d7),
    .LI(sig00000001),
    .O(NLW_blk00000130_O_UNCONNECTED)
  );
  MUXCY   blk00000131 (
    .CI(sig000001d7),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000001d6)
  );
  XORCY   blk00000132 (
    .CI(sig000001b2),
    .LI(sig00000001),
    .O(NLW_blk00000132_O_UNCONNECTED)
  );
  MUXCY   blk00000133 (
    .CI(sig000001b2),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000001d7)
  );
  FD   blk00000134 (
    .C(clk),
    .D(sig000001dc),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [4])
  );
  FD   blk00000135 (
    .C(clk),
    .D(sig000001db),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [3])
  );
  FD   blk00000136 (
    .C(clk),
    .D(sig000001da),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [2])
  );
  FD   blk00000137 (
    .C(clk),
    .D(sig000001d9),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [1])
  );
  FD   blk00000138 (
    .C(clk),
    .D(sig000001d8),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [0])
  );
  FD   blk00000139 (
    .C(clk),
    .D(sig000001e6),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [9])
  );
  FD   blk0000013a (
    .C(clk),
    .D(sig000001e5),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [8])
  );
  FD   blk0000013b (
    .C(clk),
    .D(sig000001e4),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [7])
  );
  FD   blk0000013c (
    .C(clk),
    .D(sig000001e3),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [6])
  );
  FD   blk0000013d (
    .C(clk),
    .D(sig000001e2),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [5])
  );
  FD   blk0000013e (
    .C(clk),
    .D(sig000001e1),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [4])
  );
  FD   blk0000013f (
    .C(clk),
    .D(sig000001e0),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [3])
  );
  FD   blk00000140 (
    .C(clk),
    .D(sig000001df),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [2])
  );
  FD   blk00000141 (
    .C(clk),
    .D(sig000001de),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [1])
  );
  FD   blk00000142 (
    .C(clk),
    .D(sig000001dd),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [0])
  );
  LUT6 #(
    .INIT ( 64'hF0F0CCCCFF00AAAA ))
  blk00000143 (
    .I0(sig00000013),
    .I1(sig00000017),
    .I2(sig0000001f),
    .I3(sig0000001b),
    .I4(sig0000000f),
    .I5(sig00000010),
    .O(sig0000000e)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000144 (
    .I0(a[10]),
    .I1(b[10]),
    .O(sig0000002e)
  );
  LUT4 #(
    .INIT ( 16'hEA2A ))
  blk00000145 (
    .I0(sig000000c2),
    .I1(sig000000d2),
    .I2(sig0000007b),
    .I3(sig000000c3),
    .O(sig0000009c)
  );
  LUT5 #(
    .INIT ( 32'hFFFF1504 ))
  blk00000146 (
    .I0(sig000000c0),
    .I1(sig000000bf),
    .I2(sig0000010e),
    .I3(sig000000bd),
    .I4(sig000000c1),
    .O(sig0000009b)
  );
  LUT4 #(
    .INIT ( 16'hAA8A ))
  blk00000147 (
    .I0(sig000000b8),
    .I1(sig000000ba),
    .I2(sig0000002f),
    .I3(sig000000b9),
    .O(sig00000098)
  );
  LUT4 #(
    .INIT ( 16'h5554 ))
  blk00000148 (
    .I0(sig000000c1),
    .I1(sig000000bf),
    .I2(sig000000bd),
    .I3(sig000000c0),
    .O(sig0000009a)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk00000149 (
    .I0(sig000000b9),
    .I1(sig000000ba),
    .O(sig00000076)
  );
  LUT3 #(
    .INIT ( 8'h27 ))
  blk0000014a (
    .I0(sig00000072),
    .I1(sig000000c9),
    .I2(sig000000c4),
    .O(sig00000089)
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  blk0000014b (
    .I0(sig000000d0),
    .I1(sig0000007e),
    .I2(sig000000d2),
    .I3(sig0000007b),
    .O(sig00000092)
  );
  LUT4 #(
    .INIT ( 16'hF888 ))
  blk0000014c (
    .I0(sig000000d0),
    .I1(sig0000007e),
    .I2(sig000000d2),
    .I3(sig0000007b),
    .O(sig00000091)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000014d (
    .I0(sig00000062),
    .I1(sig000000c3),
    .I2(sig000000c2),
    .O(sig0000009e)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000014e (
    .I0(sig00000072),
    .I1(sig000000c5),
    .I2(sig000000ca),
    .O(sig0000008a)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000014f (
    .I0(sig00000072),
    .I1(sig000000c6),
    .I2(sig000000cb),
    .O(sig0000008b)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000150 (
    .I0(sig00000072),
    .I1(sig000000c7),
    .I2(sig000000cc),
    .O(sig0000008c)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000151 (
    .I0(sig00000072),
    .I1(sig000000c8),
    .I2(sig000000cd),
    .O(sig0000008d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000152 (
    .I0(sig000000c3),
    .I1(sig000000c2),
    .O(sig0000008f)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000153 (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig00000081)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000154 (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig00000082)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000155 (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig00000083)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000156 (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig00000084)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000157 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000085)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk00000158 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000086)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000159 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000087)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk0000015a (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000088)
  );
  LUT6 #(
    .INIT ( 64'h4000000000000000 ))
  blk0000015b (
    .I0(sig000000b1),
    .I1(sig000000b0),
    .I2(sig000000af),
    .I3(sig000000ae),
    .I4(sig000000ad),
    .I5(sig000000ac),
    .O(sig0000008e)
  );
  LUT4 #(
    .INIT ( 16'h22F2 ))
  blk0000015c (
    .I0(sig000000d2),
    .I1(sig0000007b),
    .I2(sig000000d0),
    .I3(sig0000007e),
    .O(sig00000090)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000015d (
    .I0(sig000000c3),
    .I1(sig000000c2),
    .O(sig0000009d)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  blk0000015e (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .O(sig00000060)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000015f (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .O(sig00000061)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000160 (
    .I0(b[13]),
    .I1(a[13]),
    .I2(b[12]),
    .I3(a[12]),
    .O(sig000000d6)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000161 (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig000000d8)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000162 (
    .I0(b[9]),
    .I1(a[9]),
    .I2(b[8]),
    .I3(a[8]),
    .O(sig000000da)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000163 (
    .I0(b[7]),
    .I1(a[7]),
    .I2(b[6]),
    .I3(a[6]),
    .O(sig000000dc)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000164 (
    .I0(b[5]),
    .I1(a[5]),
    .I2(b[4]),
    .I3(a[4]),
    .O(sig000000de)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000165 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(b[2]),
    .I3(a[2]),
    .O(sig000000e0)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000166 (
    .I0(b[1]),
    .I1(a[1]),
    .I2(b[0]),
    .I3(a[0]),
    .O(sig000000e2)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000167 (
    .I0(b[13]),
    .I1(a[13]),
    .I2(b[12]),
    .I3(a[12]),
    .O(sig000000d5)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000168 (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig000000d7)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000169 (
    .I0(b[9]),
    .I1(a[9]),
    .I2(b[8]),
    .I3(a[8]),
    .O(sig000000d9)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000016a (
    .I0(b[7]),
    .I1(a[7]),
    .I2(b[6]),
    .I3(a[6]),
    .O(sig000000db)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000016b (
    .I0(b[5]),
    .I1(a[5]),
    .I2(b[4]),
    .I3(a[4]),
    .O(sig000000dd)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000016c (
    .I0(b[3]),
    .I1(a[3]),
    .I2(b[2]),
    .I3(a[2]),
    .O(sig000000df)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000016d (
    .I0(b[1]),
    .I1(a[1]),
    .I2(b[0]),
    .I3(a[0]),
    .O(sig000000e1)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk0000016e (
    .I0(b[14]),
    .I1(a[14]),
    .O(sig000000d3)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk0000016f (
    .I0(a[14]),
    .I1(b[14]),
    .O(sig000000d4)
  );
  LUT5 #(
    .INIT ( 32'hEC64A820 ))
  blk00000170 (
    .I0(sig000000f3),
    .I1(sig000000f2),
    .I2(sig0000011d),
    .I3(sig00000125),
    .I4(sig00000121),
    .O(sig00000100)
  );
  LUT5 #(
    .INIT ( 32'h76325410 ))
  blk00000171 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig0000011d),
    .I3(sig00000121),
    .I4(sig00000125),
    .O(sig000000fc)
  );
  LUT4 #(
    .INIT ( 16'hA820 ))
  blk00000172 (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig0000004b),
    .I3(sig00000055),
    .O(sig00000127)
  );
  LUT4 #(
    .INIT ( 16'hFFD8 ))
  blk00000173 (
    .I0(sig00000062),
    .I1(sig0000005e),
    .I2(sig00000054),
    .I3(sig0000006d),
    .O(sig00000131)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000174 (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig0000004c),
    .I3(sig00000056),
    .I4(sig00000055),
    .I5(sig0000004b),
    .O(sig00000128)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000175 (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig0000004d),
    .I3(sig00000057),
    .I4(sig00000056),
    .I5(sig0000004c),
    .O(sig00000129)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000176 (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig0000004e),
    .I3(sig00000058),
    .I4(sig00000057),
    .I5(sig0000004d),
    .O(sig0000012a)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000177 (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig0000004f),
    .I3(sig00000059),
    .I4(sig00000058),
    .I5(sig0000004e),
    .O(sig0000012b)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000178 (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig00000050),
    .I3(sig0000005a),
    .I4(sig00000059),
    .I5(sig0000004f),
    .O(sig0000012c)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000179 (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig00000051),
    .I3(sig0000005b),
    .I4(sig0000005a),
    .I5(sig00000050),
    .O(sig0000012d)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000017a (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig00000052),
    .I3(sig0000005c),
    .I4(sig0000005b),
    .I5(sig00000051),
    .O(sig0000012e)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000017b (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig00000054),
    .I3(sig0000005e),
    .I4(sig0000005d),
    .I5(sig00000053),
    .O(sig00000130)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000017c (
    .I0(sig0000006d),
    .I1(sig00000062),
    .I2(sig00000053),
    .I3(sig0000005d),
    .I4(sig0000005c),
    .I5(sig00000052),
    .O(sig0000012f)
  );
  LUT3 #(
    .INIT ( 8'h6C ))
  blk0000017d (
    .I0(sig00000072),
    .I1(sig0000006e),
    .I2(sig0000006d),
    .O(sig00000110)
  );
  LUT4 #(
    .INIT ( 16'h666C ))
  blk0000017e (
    .I0(sig00000072),
    .I1(sig0000006f),
    .I2(sig0000006e),
    .I3(sig0000006d),
    .O(sig00000111)
  );
  LUT5 #(
    .INIT ( 32'h6666666C ))
  blk0000017f (
    .I0(sig00000072),
    .I1(sig00000070),
    .I2(sig0000006e),
    .I3(sig0000006f),
    .I4(sig0000006d),
    .O(sig00000112)
  );
  LUT6 #(
    .INIT ( 64'h666666666666666C ))
  blk00000180 (
    .I0(sig00000072),
    .I1(sig00000071),
    .I2(sig0000006e),
    .I3(sig0000006f),
    .I4(sig00000070),
    .I5(sig0000006d),
    .O(sig00000113)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000181 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig00000121),
    .I3(sig00000125),
    .O(sig000000f8)
  );
  LUT5 #(
    .INIT ( 32'h76325410 ))
  blk00000182 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig0000011b),
    .I3(sig0000011f),
    .I4(sig00000123),
    .O(sig000000fe)
  );
  LUT5 #(
    .INIT ( 32'h76325410 ))
  blk00000183 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig0000011c),
    .I3(sig00000120),
    .I4(sig00000124),
    .O(sig000000fd)
  );
  LUT5 #(
    .INIT ( 32'h76325410 ))
  blk00000184 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig0000011a),
    .I3(sig0000011e),
    .I4(sig00000122),
    .O(sig000000ff)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000185 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig0000011e),
    .I3(sig00000122),
    .O(sig000000fb)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000186 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig0000011f),
    .I3(sig00000123),
    .O(sig000000fa)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000187 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig00000120),
    .I3(sig00000124),
    .O(sig000000f9)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF8880 ))
  blk00000188 (
    .I0(sig000000f3),
    .I1(sig000000f2),
    .I2(sig00000117),
    .I3(sig00000118),
    .I4(sig00000119),
    .I5(sig00000133),
    .O(sig0000010f)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000189 (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig00000123),
    .O(sig000000f6)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000018a (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig00000124),
    .O(sig000000f5)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000018b (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig00000125),
    .O(sig000000f4)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000018c (
    .I0(sig000000f2),
    .I1(sig000000f3),
    .I2(sig00000122),
    .O(sig000000f7)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  blk0000018d (
    .I0(sig0000011a),
    .I1(sig0000011b),
    .I2(sig0000011c),
    .O(sig0000013f)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000018e (
    .I0(sig0000011d),
    .I1(sig0000011e),
    .I2(sig0000011f),
    .I3(sig00000120),
    .O(sig00000140)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000018f (
    .I0(sig00000121),
    .I1(sig00000122),
    .I2(sig00000123),
    .I3(sig00000124),
    .O(sig00000141)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  blk00000190 (
    .I0(sig00000118),
    .I1(sig0000011a),
    .O(sig00000143)
  );
  LUT3 #(
    .INIT ( 8'h1F ))
  blk00000191 (
    .I0(sig0000011e),
    .I1(sig0000011d),
    .I2(sig00000118),
    .O(sig00000144)
  );
  LUT3 #(
    .INIT ( 8'h1F ))
  blk00000192 (
    .I0(sig00000122),
    .I1(sig00000121),
    .I2(sig00000118),
    .O(sig00000145)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  blk00000193 (
    .I0(sig00000118),
    .I1(sig00000125),
    .O(sig00000146)
  );
  LUT5 #(
    .INIT ( 32'h0FF02DD2 ))
  blk00000194 (
    .I0(sig00000102),
    .I1(sig00000115),
    .I2(sig0000016e),
    .I3(sig00000126),
    .I4(sig00000114),
    .O(sig00000159)
  );
  LUT5 #(
    .INIT ( 32'h0FF02DD2 ))
  blk00000195 (
    .I0(sig00000101),
    .I1(sig00000115),
    .I2(sig00000126),
    .I3(sig0000016f),
    .I4(sig00000114),
    .O(sig0000015a)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk00000196 (
    .I0(sig00000171),
    .I1(sig0000010b),
    .I2(sig00000109),
    .I3(sig00000115),
    .I4(sig00000114),
    .I5(sig00000126),
    .O(sig0000015d)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk00000197 (
    .I0(sig00000172),
    .I1(sig0000010a),
    .I2(sig00000108),
    .I3(sig00000115),
    .I4(sig00000114),
    .I5(sig00000126),
    .O(sig0000015e)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk00000198 (
    .I0(sig00000174),
    .I1(sig00000108),
    .I2(sig00000106),
    .I3(sig00000115),
    .I4(sig00000114),
    .I5(sig00000126),
    .O(sig00000160)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk00000199 (
    .I0(sig00000169),
    .I1(sig00000107),
    .I2(sig00000105),
    .I3(sig00000115),
    .I4(sig00000114),
    .I5(sig00000126),
    .O(sig00000154)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk0000019a (
    .I0(sig00000173),
    .I1(sig00000109),
    .I2(sig00000107),
    .I3(sig00000115),
    .I4(sig00000114),
    .I5(sig00000126),
    .O(sig0000015f)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk0000019b (
    .I0(sig0000016b),
    .I1(sig00000105),
    .I2(sig00000103),
    .I3(sig00000115),
    .I4(sig00000114),
    .I5(sig00000126),
    .O(sig00000156)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk0000019c (
    .I0(sig00000114),
    .I1(sig0000016c),
    .I2(sig00000126),
    .I3(sig00000115),
    .I4(sig00000102),
    .I5(sig00000104),
    .O(sig00000157)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk0000019d (
    .I0(sig0000016a),
    .I1(sig00000106),
    .I2(sig00000104),
    .I3(sig00000115),
    .I4(sig00000114),
    .I5(sig00000126),
    .O(sig00000155)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk0000019e (
    .I0(sig00000114),
    .I1(sig0000016d),
    .I2(sig00000126),
    .I3(sig00000115),
    .I4(sig00000101),
    .I5(sig00000103),
    .O(sig00000158)
  );
  LUT5 #(
    .INIT ( 32'hF3F50C0A ))
  blk0000019f (
    .I0(sig0000010c),
    .I1(sig0000010a),
    .I2(sig00000114),
    .I3(sig00000115),
    .I4(sig00000126),
    .O(sig0000015c)
  );
  LUT5 #(
    .INIT ( 32'hF3F50C0A ))
  blk000001a0 (
    .I0(sig0000010d),
    .I1(sig0000010b),
    .I2(sig00000114),
    .I3(sig00000115),
    .I4(sig00000126),
    .O(sig0000015b)
  );
  LUT5 #(
    .INIT ( 32'h01010100 ))
  blk000001a1 (
    .I0(sig000001a6),
    .I1(sig0000001b),
    .I2(sig0000001a),
    .I3(sig0000001d),
    .I4(sig0000001c),
    .O(sig00000199)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000001a2 (
    .I0(sig000001a6),
    .I1(sig000001a7),
    .I2(sig0000000f),
    .O(sig00000010)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001a3 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .O(sig00000194)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001a4 (
    .I0(sig000001a5),
    .I1(sig000001a6),
    .O(sig00000195)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001a5 (
    .I0(sig0000000f),
    .I1(sig000001a5),
    .O(sig000001a0)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000001a6 (
    .I0(sig0000004a),
    .I1(sig00000049),
    .I2(sig00000048),
    .I3(sig00000047),
    .O(sig000001a1)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000001a7 (
    .I0(sig00000046),
    .I1(sig00000045),
    .I2(sig00000044),
    .I3(sig00000043),
    .O(sig000001a2)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000001a8 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(sig00000042),
    .I3(sig00000041),
    .O(sig000001a3)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk000001a9 (
    .I0(sig0000003e),
    .I1(sig0000003d),
    .O(sig000001a4)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000001aa (
    .I0(sig00000022),
    .I1(sig00000023),
    .I2(sig00000024),
    .I3(sig00000025),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001ab)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000001ab (
    .I0(sig00000021),
    .I1(sig00000022),
    .I2(sig00000023),
    .I3(sig00000024),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001ac)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001ac (
    .I0(sig00000023),
    .I1(sig00000025),
    .I2(sig00000026),
    .I3(sig00000024),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001aa)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001ad (
    .I0(sig00000024),
    .I1(sig00000026),
    .I2(sig00000027),
    .I3(sig00000025),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001a9)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001ae (
    .I0(sig00000025),
    .I1(sig00000027),
    .I2(sig00000028),
    .I3(sig00000026),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001a8)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001af (
    .I0(sig00000026),
    .I1(sig00000028),
    .I2(sig00000029),
    .I3(sig00000027),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001b1)
  );
  LUT6 #(
    .INIT ( 64'hFF00F0F0CCCCAAAA ))
  blk000001b0 (
    .I0(sig00000027),
    .I1(sig00000029),
    .I2(sig00000028),
    .I3(sig0000002a),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001b0)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000001b1 (
    .I0(sig00000028),
    .I1(sig00000029),
    .I2(sig0000002a),
    .I3(sig0000002b),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001af)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001b2 (
    .I0(sig00000029),
    .I1(sig0000002b),
    .I2(sig0000002c),
    .I3(sig0000002a),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001ae)
  );
  LUT6 #(
    .INIT ( 64'hAAAAFF00F0F0CCCC ))
  blk000001b3 (
    .I0(sig0000002d),
    .I1(sig0000002a),
    .I2(sig0000002c),
    .I3(sig0000002b),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001ad)
  );
  LUT6 #(
    .INIT ( 64'hAAAAFF00F0F0CCCC ))
  blk000001b4 (
    .I0(sig0000002d),
    .I1(sig0000002a),
    .I2(sig0000002c),
    .I3(sig0000002b),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001bd)
  );
  LUT5 #(
    .INIT ( 32'h00CCAAF0 ))
  blk000001b5 (
    .I0(sig0000002d),
    .I1(sig0000002c),
    .I2(sig0000002b),
    .I3(sig00000011),
    .I4(sig00000012),
    .O(sig000001bc)
  );
  LUT4 #(
    .INIT ( 16'hF5F1 ))
  blk000001b6 (
    .I0(sig0000002d),
    .I1(sig0000002c),
    .I2(sig00000011),
    .I3(sig00000012),
    .O(sig000001bb)
  );
  LUT4 #(
    .INIT ( 16'h5445 ))
  blk000001b7 (
    .I0(sig00000069),
    .I1(sig00000068),
    .I2(sig00000063),
    .I3(sig000001b3),
    .O(sig000001d8)
  );
  LUT5 #(
    .INIT ( 32'h54544554 ))
  blk000001b8 (
    .I0(sig00000069),
    .I1(sig00000068),
    .I2(sig00000064),
    .I3(sig00000063),
    .I4(sig000001b3),
    .O(sig000001d9)
  );
  LUT6 #(
    .INIT ( 64'h5544554445545544 ))
  blk000001b9 (
    .I0(sig00000069),
    .I1(sig00000068),
    .I2(sig00000064),
    .I3(sig00000065),
    .I4(sig00000063),
    .I5(sig000001b3),
    .O(sig000001da)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001ba (
    .I0(sig00000030),
    .I1(sig0000006c),
    .O(sig000001dd)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001bb (
    .I0(sig00000031),
    .I1(sig0000006c),
    .O(sig000001de)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001bc (
    .I0(sig00000033),
    .I1(sig0000006c),
    .O(sig000001e0)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001bd (
    .I0(sig00000034),
    .I1(sig0000006c),
    .O(sig000001e1)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001be (
    .I0(sig00000032),
    .I1(sig0000006c),
    .O(sig000001df)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001bf (
    .I0(sig00000036),
    .I1(sig0000006c),
    .O(sig000001e3)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001c0 (
    .I0(sig00000037),
    .I1(sig0000006c),
    .O(sig000001e4)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001c1 (
    .I0(sig00000035),
    .I1(sig0000006c),
    .O(sig000001e2)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000001c2 (
    .I0(sig00000038),
    .I1(sig0000006c),
    .O(sig000001e5)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk000001c3 (
    .I0(sig0000006b),
    .I1(sig0000006a),
    .I2(sig00000039),
    .O(sig000001e6)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk000001c4 (
    .I0(sig000000bd),
    .I1(sig000000bb),
    .I2(sig000000bc),
    .O(sig000001e8)
  );
  LUT5 #(
    .INIT ( 32'hAA0BAA08 ))
  blk000001c5 (
    .I0(sig000000be),
    .I1(sig000000bf),
    .I2(sig000000c0),
    .I3(sig000000c1),
    .I4(sig000001e8),
    .O(sig00000099)
  );
  LUT5 #(
    .INIT ( 32'h8888F000 ))
  blk000001c6 (
    .I0(sig0000014a),
    .I1(sig0000014d),
    .I2(sig0000014c),
    .I3(sig0000014f),
    .I4(sig00000148),
    .O(sig000001e9)
  );
  LUT6 #(
    .INIT ( 64'hFBBBEAAA51114000 ))
  blk000001c7 (
    .I0(sig00000147),
    .I1(sig00000148),
    .I2(sig0000014e),
    .I3(sig0000014b),
    .I4(sig00000149),
    .I5(sig000001e9),
    .O(sig00000116)
  );
  LUT4 #(
    .INIT ( 16'hFF45 ))
  blk000001c8 (
    .I0(sig00000013),
    .I1(sig00000014),
    .I2(sig00000015),
    .I3(sig0000007a),
    .O(sig000001ea)
  );
  LUT6 #(
    .INIT ( 64'h2222020077775755 ))
  blk000001c9 (
    .I0(sig000001a7),
    .I1(sig00000016),
    .I2(sig00000018),
    .I3(sig00000019),
    .I4(sig00000017),
    .I5(sig000001ea),
    .O(sig00000196)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk000001ca (
    .I0(sig0000007a),
    .I1(sig00000014),
    .I2(sig00000015),
    .I3(sig00000013),
    .O(sig000001eb)
  );
  LUT6 #(
    .INIT ( 64'h0404040037373733 ))
  blk000001cb (
    .I0(sig00000016),
    .I1(sig000001a7),
    .I2(sig00000017),
    .I3(sig00000019),
    .I4(sig00000018),
    .I5(sig000001eb),
    .O(sig00000197)
  );
  LUT2 #(
    .INIT ( 4'hB ))
  blk000001cc (
    .I0(sig0000001e),
    .I1(sig0000001f),
    .O(sig000001ec)
  );
  LUT6 #(
    .INIT ( 64'h10111010DCDDDCDC ))
  blk000001cd (
    .I0(sig0000001a),
    .I1(sig000001a6),
    .I2(sig0000001b),
    .I3(sig0000001c),
    .I4(sig0000001d),
    .I5(sig000001ec),
    .O(sig00000198)
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  blk000001ce (
    .I0(sig00000066),
    .I1(sig00000065),
    .I2(sig00000064),
    .O(sig000001ed)
  );
  LUT6 #(
    .INIT ( 64'h0000FF9A0000FFAA ))
  blk000001cf (
    .I0(sig00000067),
    .I1(sig000001b3),
    .I2(sig00000063),
    .I3(sig00000068),
    .I4(sig00000069),
    .I5(sig000001ed),
    .O(sig000001dc)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001d0 (
    .I0(sig00000065),
    .I1(sig00000064),
    .O(sig000001ee)
  );
  LUT6 #(
    .INIT ( 64'h0000FF9A0000FFAA ))
  blk000001d1 (
    .I0(sig00000066),
    .I1(sig000001b3),
    .I2(sig00000063),
    .I3(sig00000068),
    .I4(sig00000069),
    .I5(sig000001ee),
    .O(sig000001db)
  );
  FD   blk000001d2 (
    .C(clk),
    .D(sig0000005f),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/sign_op )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000001d3 (
    .I0(sig00000020),
    .O(sig000001ef)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000001d4 (
    .I0(sig00000126),
    .O(sig000001f0)
  );
  LUT6 #(
    .INIT ( 64'hDDDD4D4D4DDD444D ))
  blk000001d5 (
    .I0(sig000000a9),
    .I1(sig0000003a),
    .I2(sig000000a8),
    .I3(sig000000a7),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig000001e7)
  );
  LUT4 #(
    .INIT ( 16'hFFF8 ))
  blk000001d6 (
    .I0(sig000000a6),
    .I1(sig000000ce),
    .I2(sig000000ba),
    .I3(sig000000b9),
    .O(sig000001f1)
  );
  LUT2 #(
    .INIT ( 4'hB ))
  blk000001d7 (
    .I0(sig000000ba),
    .I1(sig000000b9),
    .O(sig000001f2)
  );
  LUT5 #(
    .INIT ( 32'hFF00FFF8 ))
  blk000001d8 (
    .I0(sig000000a6),
    .I1(sig000000ce),
    .I2(sig0000002f),
    .I3(sig000000ba),
    .I4(sig000000b9),
    .O(sig000001f3)
  );
  LUT4 #(
    .INIT ( 16'h0008 ))
  blk000001d9 (
    .I0(sig000000a6),
    .I1(sig000000ce),
    .I2(sig0000002f),
    .I3(sig000000ba),
    .O(sig000001f4)
  );
  LUT6 #(
    .INIT ( 64'h2BBB222B2B2B2222 ))
  blk000001da (
    .I0(sig0000003a),
    .I1(sig000000a9),
    .I2(sig000000a8),
    .I3(sig000000a7),
    .I4(sig00000011),
    .I5(sig00000012),
    .O(sig00000074)
  );
  LUT4 #(
    .INIT ( 16'h599A ))
  blk000001db (
    .I0(sig000000ab),
    .I1(sig000000aa),
    .I2(sig0000003b),
    .I3(sig00000074),
    .O(sig000000a3)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  blk000001dc (
    .I0(sig000000aa),
    .I1(sig0000003b),
    .I2(sig00000074),
    .O(sig000000a2)
  );
  LUT6 #(
    .INIT ( 64'h6999696966696666 ))
  blk000001dd (
    .I0(sig0000003a),
    .I1(sig000000a9),
    .I2(sig000000a8),
    .I3(sig000000a7),
    .I4(sig00000012),
    .I5(sig00000011),
    .O(sig000000a1)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000001de (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig0000001b),
    .I3(sig0000001f),
    .O(sig00000006)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000001df (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig0000001a),
    .I3(sig0000001e),
    .O(sig00000007)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000001e0 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig00000018),
    .I3(sig0000001c),
    .O(sig00000009)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000001e1 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig00000019),
    .I3(sig0000001d),
    .O(sig00000008)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001e2 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig0000001c),
    .O(sig00000005)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001e3 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig0000001d),
    .O(sig00000004)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001e4 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig0000001e),
    .O(sig00000003)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001e5 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig0000001f),
    .O(sig00000002)
  );
  LUT6 #(
    .INIT ( 64'h5140FBEA51405140 ))
  blk000001e6 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig00000018),
    .I3(sig00000014),
    .I4(sig000001a6),
    .I5(sig0000001c),
    .O(sig0000000d)
  );
  LUT6 #(
    .INIT ( 64'h5140FBEA51405140 ))
  blk000001e7 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig00000019),
    .I3(sig00000015),
    .I4(sig000001a6),
    .I5(sig0000001d),
    .O(sig0000000c)
  );
  LUT6 #(
    .INIT ( 64'h5140FBEA51405140 ))
  blk000001e8 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig0000001a),
    .I3(sig00000016),
    .I4(sig000001a6),
    .I5(sig0000001e),
    .O(sig0000000b)
  );
  LUT6 #(
    .INIT ( 64'h5140FBEA51405140 ))
  blk000001e9 (
    .I0(sig0000000f),
    .I1(sig000001a7),
    .I2(sig0000001b),
    .I3(sig00000017),
    .I4(sig000001a6),
    .I5(sig0000001f),
    .O(sig0000000a)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000001ea (
    .I0(sig000000a7),
    .I1(sig00000012),
    .O(sig0000009f)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001eb (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig00000055),
    .I4(sig0000004b),
    .O(sig00000134)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001ec (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig00000056),
    .I4(sig0000004c),
    .O(sig00000135)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001ed (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig00000057),
    .I4(sig0000004d),
    .O(sig00000136)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001ee (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig00000058),
    .I4(sig0000004e),
    .O(sig00000137)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001ef (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig00000059),
    .I4(sig0000004f),
    .O(sig00000138)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001f0 (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig0000005a),
    .I4(sig00000050),
    .O(sig00000139)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001f1 (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig0000005b),
    .I4(sig00000051),
    .O(sig0000013a)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001f2 (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig0000005c),
    .I4(sig00000052),
    .O(sig0000013b)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001f3 (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig0000005d),
    .I4(sig00000053),
    .O(sig0000013c)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000001f4 (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .I2(sig00000062),
    .I3(sig0000005e),
    .I4(sig00000054),
    .O(sig0000013d)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  blk000001f5 (
    .I0(sig000000cf),
    .I1(sig000000d1),
    .O(sig0000013e)
  );
  LUT6 #(
    .INIT ( 64'hFFFFBABBFFFFAABA ))
  blk000001f6 (
    .I0(sig0000002f),
    .I1(sig000000ab),
    .I2(sig0000003b),
    .I3(sig000000aa),
    .I4(sig000001f1),
    .I5(sig000001e7),
    .O(sig00000075)
  );
  LUT6 #(
    .INIT ( 64'hFFBA4500FFFB0400 ))
  blk000001f7 (
    .I0(sig000000ab),
    .I1(sig0000003b),
    .I2(sig000000aa),
    .I3(sig000001f2),
    .I4(sig000001f3),
    .I5(sig000001e7),
    .O(sig000000a5)
  );
  LUT6 #(
    .INIT ( 64'hFFBAFF00FFFBFF00 ))
  blk000001f8 (
    .I0(sig000000ab),
    .I1(sig0000003b),
    .I2(sig000000aa),
    .I3(sig000000b9),
    .I4(sig000001f4),
    .I5(sig000001e7),
    .O(sig000000a4)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  blk000001f9 (
    .I0(b[13]),
    .I1(a[13]),
    .I2(sig00000073),
    .O(sig00000095)
  );
  LUT5 #(
    .INIT ( 32'hF7755110 ))
  blk000001fa (
    .I0(b[14]),
    .I1(b[13]),
    .I2(a[13]),
    .I3(sig00000073),
    .I4(a[14]),
    .O(sig00000097)
  );
  LUT4 #(
    .INIT ( 16'h6696 ))
  blk000001fb (
    .I0(sig000000a8),
    .I1(sig00000011),
    .I2(sig00000012),
    .I3(sig000000a7),
    .O(sig000000a0)
  );
  LUT5 #(
    .INIT ( 32'h99696966 ))
  blk000001fc (
    .I0(b[14]),
    .I1(a[14]),
    .I2(b[13]),
    .I3(a[13]),
    .I4(sig00000073),
    .O(sig00000096)
  );
  LUT4 #(
    .INIT ( 16'h6696 ))
  blk000001fd (
    .I0(b[11]),
    .I1(a[11]),
    .I2(a[10]),
    .I3(b[10]),
    .O(sig00000093)
  );
  LUT6 #(
    .INIT ( 64'h6999696966696666 ))
  blk000001fe (
    .I0(b[12]),
    .I1(a[12]),
    .I2(b[11]),
    .I3(b[10]),
    .I4(a[10]),
    .I5(a[11]),
    .O(sig00000094)
  );
  LUT6 #(
    .INIT ( 64'h08FF0008AEFF00AE ))
  blk000001ff (
    .I0(a[11]),
    .I1(a[10]),
    .I2(b[10]),
    .I3(b[12]),
    .I4(a[12]),
    .I5(b[11]),
    .O(sig00000073)
  );
  MUXF7   blk00000200 (
    .I0(sig000001f5),
    .I1(sig000001f6),
    .S(sig000001e7),
    .O(sig00000077)
  );
  LUT6 #(
    .INIT ( 64'h5454545554545454 ))
  blk00000201 (
    .I0(sig000000b9),
    .I1(sig000000ba),
    .I2(sig0000002f),
    .I3(sig000000ab),
    .I4(sig000000aa),
    .I5(sig0000003b),
    .O(sig000001f5)
  );
  LUT6 #(
    .INIT ( 64'h5555555555551101 ))
  blk00000202 (
    .I0(sig000000b9),
    .I1(sig000000ab),
    .I2(sig000000aa),
    .I3(sig0000003b),
    .I4(sig0000002f),
    .I5(sig000000ba),
    .O(sig000001f6)
  );
  INV   blk00000203 (
    .I(sig0000006d),
    .O(sig00000132)
  );
  INV   blk00000204 (
    .I(sig00000125),
    .O(sig00000142)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000205 (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig00000079),
    .Q(sig000001f7),
    .Q15(NLW_blk00000205_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000206 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001f7),
    .Q(sig000000b8)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000207 (
    .A0(sig00000001),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig0000003c),
    .Q(sig000001f8),
    .Q15(NLW_blk00000207_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000208 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001f8),
    .Q(sig00000020)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000209 (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig00000078),
    .Q(sig000001f9),
    .Q15(NLW_blk00000209_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000020a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001f9),
    .Q(sig000000a6)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000020b (
    .A0(sig00000001),
    .A1(NlwRenamedSig_OI_operation_rfd),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000b0),
    .Q(sig000001fa),
    .Q15(NLW_blk0000020b_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000020c (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001fa),
    .Q(sig000000ab)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000020d (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000ec),
    .Q(sig000001fb),
    .Q15(NLW_blk0000020d_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000020e (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001fb),
    .Q(sig000000ba)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000020f (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000eb),
    .Q(sig000001fc),
    .Q15(NLW_blk0000020f_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000210 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001fc),
    .Q(sig000000b9)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000211 (
    .A0(sig00000001),
    .A1(NlwRenamedSig_OI_operation_rfd),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000ad),
    .Q(sig000001fd),
    .Q15(NLW_blk00000211_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000212 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001fd),
    .Q(sig000000a8)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000213 (
    .A0(sig00000001),
    .A1(NlwRenamedSig_OI_operation_rfd),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000af),
    .Q(sig000001fe),
    .Q15(NLW_blk00000213_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000214 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001fe),
    .Q(sig000000aa)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000215 (
    .A0(sig00000001),
    .A1(NlwRenamedSig_OI_operation_rfd),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000ae),
    .Q(sig000001ff),
    .Q15(NLW_blk00000215_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000216 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000001ff),
    .Q(sig000000a9)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000217 (
    .A0(sig00000001),
    .A1(NlwRenamedSig_OI_operation_rfd),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000ac),
    .Q(sig00000200),
    .Q15(NLW_blk00000217_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000218 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000200),
    .Q(sig000000a7)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000219 (
    .A0(sig00000001),
    .A1(NlwRenamedSig_OI_operation_rfd),
    .A2(NlwRenamedSig_OI_operation_rfd),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(operation_nd),
    .Q(sig00000201),
    .Q15(NLW_blk00000219_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000021a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000201),
    .Q(\U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
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
