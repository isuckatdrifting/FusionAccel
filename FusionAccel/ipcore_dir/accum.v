////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: accum.v
// /___/   /\     Timestamp: Tue Jan 15 10:39:32 2019
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/accum.ngc /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/accum.v 
// Device	: 6slx45fgg484-2
// Input file	: /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/accum.ngc
// Output file	: /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/accum.v
// # of Modules	: 1
// Design Name	: accum
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

module accum (
  operation_nd, clk, sclr, ce, operation_rfd, underflow, overflow, invalid_op, rdy, a, b, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  input sclr;
  input ce;
  output operation_rfd;
  output underflow;
  output overflow;
  output invalid_op;
  output rdy;
  input [15 : 0] a;
  input [15 : 0] b;
  output [15 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/sign_op ;
  wire \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ;
  wire \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/UNDERFLOW ;
  wire \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/OVERFLOW ;
  wire \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/FLAGS_REG.IV_OP_REG/RTL.delay_0 ;
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
  wire sig00000202;
  wire sig00000203;
  wire sig00000204;
  wire sig00000205;
  wire sig00000206;
  wire sig00000207;
  wire sig00000208;
  wire sig00000209;
  wire sig0000020a;
  wire sig0000020b;
  wire sig0000020c;
  wire sig0000020d;
  wire sig0000020e;
  wire sig0000020f;
  wire sig00000210;
  wire sig00000211;
  wire sig00000212;
  wire sig00000213;
  wire sig00000214;
  wire sig00000215;
  wire sig00000216;
  wire sig00000217;
  wire sig00000218;
  wire sig00000219;
  wire sig0000021a;
  wire sig0000021b;
  wire sig0000021c;
  wire sig0000021d;
  wire sig0000021e;
  wire sig0000021f;
  wire sig00000220;
  wire sig00000221;
  wire sig00000222;
  wire sig00000223;
  wire sig00000224;
  wire sig00000225;
  wire NLW_blk0000009a_Q_UNCONNECTED;
  wire NLW_blk000000df_O_UNCONNECTED;
  wire NLW_blk00000131_O_UNCONNECTED;
  wire NLW_blk00000132_O_UNCONNECTED;
  wire NLW_blk00000134_O_UNCONNECTED;
  wire NLW_blk00000136_O_UNCONNECTED;
  wire NLW_blk00000138_O_UNCONNECTED;
  wire NLW_blk0000022a_Q15_UNCONNECTED;
  wire NLW_blk0000022c_Q15_UNCONNECTED;
  wire NLW_blk0000022e_Q15_UNCONNECTED;
  wire NLW_blk00000230_Q15_UNCONNECTED;
  wire NLW_blk00000232_Q15_UNCONNECTED;
  wire NLW_blk00000234_Q15_UNCONNECTED;
  wire NLW_blk00000236_Q15_UNCONNECTED;
  wire NLW_blk00000238_Q15_UNCONNECTED;
  wire NLW_blk0000023a_Q15_UNCONNECTED;
  wire NLW_blk0000023c_Q15_UNCONNECTED;
  wire NLW_blk0000023e_Q15_UNCONNECTED;
  wire NLW_blk00000240_Q15_UNCONNECTED;
  wire [4 : 0] \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op ;
  wire [9 : 0] \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op ;
  assign
    result[15] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/sign_op ,
    result[14] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [4],
    result[13] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [3],
    result[12] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [2],
    result[11] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [1],
    result[10] = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [0],
    result[9] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [9],
    result[8] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [8],
    result[7] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [7],
    result[6] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [6],
    result[5] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [5],
    result[4] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [4],
    result[3] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [3],
    result[2] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [2],
    result[1] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [1],
    result[0] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [0],
    operation_rfd = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ,
    underflow = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/UNDERFLOW ,
    overflow = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/OVERFLOW ,
    invalid_op = \U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/FLAGS_REG.IV_OP_REG/RTL.delay_0 ,
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
    .D(sig0000002e),
    .Q(sig00000071)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000004 (
    .C(clk),
    .CE(ce),
    .D(sig00000080),
    .Q(sig0000006d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000005 (
    .C(clk),
    .CE(ce),
    .D(sig0000007f),
    .Q(sig0000006e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000006 (
    .C(clk),
    .CE(ce),
    .D(sig0000007e),
    .Q(sig00000070)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000007 (
    .C(clk),
    .CE(ce),
    .D(sig000000b4),
    .Q(sig0000006c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000008 (
    .C(clk),
    .CE(ce),
    .D(sig000000b5),
    .Q(sig0000006f)
  );
  MUXCY   blk00000009 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig0000008f),
    .O(sig00000087)
  );
  MUXCY   blk0000000a (
    .CI(sig00000087),
    .DI(sig00000002),
    .S(sig0000008e),
    .O(sig00000088)
  );
  MUXCY   blk0000000b (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig0000008d),
    .O(sig0000008a)
  );
  MUXCY   blk0000000c (
    .CI(sig0000008a),
    .DI(sig00000002),
    .S(sig0000008c),
    .O(sig0000008b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000d (
    .C(clk),
    .CE(ce),
    .D(sig000000af),
    .Q(sig00000067)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000e (
    .C(clk),
    .CE(ce),
    .D(sig000000b0),
    .Q(sig00000068)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000f (
    .C(clk),
    .CE(ce),
    .D(sig000000b1),
    .Q(sig00000069)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000010 (
    .C(clk),
    .CE(ce),
    .D(sig000000b2),
    .Q(sig0000006a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000011 (
    .C(clk),
    .CE(ce),
    .D(sig000000b3),
    .Q(sig0000006b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000012 (
    .C(clk),
    .CE(ce),
    .D(sig0000009b),
    .Q(sig00000063)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000013 (
    .C(clk),
    .CE(ce),
    .D(sig0000009c),
    .Q(sig00000064)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000014 (
    .C(clk),
    .CE(ce),
    .D(sig0000009d),
    .Q(sig00000065)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000015 (
    .C(clk),
    .CE(ce),
    .D(sig0000009e),
    .Q(sig00000066)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000016 (
    .C(clk),
    .CE(ce),
    .D(sig00000099),
    .Q(sig00000081)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000017 (
    .C(clk),
    .CE(ce),
    .D(sig000000c2),
    .Q(sig000000bc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000018 (
    .C(clk),
    .CE(ce),
    .D(sig000000c3),
    .Q(sig000000bd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000019 (
    .C(clk),
    .CE(ce),
    .D(sig000000c4),
    .Q(sig000000be)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001a (
    .C(clk),
    .CE(ce),
    .D(sig000000c5),
    .Q(sig000000bf)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001b (
    .C(clk),
    .CE(ce),
    .D(sig000000c6),
    .Q(sig000000c0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001c (
    .C(clk),
    .CE(ce),
    .D(sig000000c7),
    .Q(sig000000c1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001d (
    .C(clk),
    .CE(ce),
    .D(sig000000a9),
    .Q(sig00000082)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001e (
    .C(clk),
    .CE(ce),
    .D(sig000000a8),
    .Q(sig00000083)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001f (
    .C(clk),
    .CE(ce),
    .D(sig000000a2),
    .Q(sig00000072)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000020 (
    .C(clk),
    .CE(ce),
    .D(sig000000a3),
    .Q(sig00000073)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000021 (
    .C(clk),
    .CE(ce),
    .D(sig000000a4),
    .Q(sig00000074)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000022 (
    .C(clk),
    .CE(ce),
    .D(sig000000a5),
    .Q(sig00000075)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000023 (
    .C(clk),
    .CE(ce),
    .D(sig000000a6),
    .Q(sig00000076)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000024 (
    .C(clk),
    .CE(ce),
    .D(a[15]),
    .Q(sig000000d3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000025 (
    .C(clk),
    .CE(ce),
    .D(b[15]),
    .Q(sig000000d2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000026 (
    .C(clk),
    .CE(ce),
    .D(a[10]),
    .Q(sig000000d9)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000027 (
    .C(clk),
    .CE(ce),
    .D(a[11]),
    .Q(sig000000da)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000028 (
    .C(clk),
    .CE(ce),
    .D(a[12]),
    .Q(sig000000db)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000029 (
    .C(clk),
    .CE(ce),
    .D(a[13]),
    .Q(sig000000dc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002a (
    .C(clk),
    .CE(ce),
    .D(a[14]),
    .Q(sig000000dd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002b (
    .C(clk),
    .CE(ce),
    .D(b[10]),
    .Q(sig000000d4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002c (
    .C(clk),
    .CE(ce),
    .D(b[11]),
    .Q(sig000000d5)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002d (
    .C(clk),
    .CE(ce),
    .D(b[12]),
    .Q(sig000000d6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002e (
    .C(clk),
    .CE(ce),
    .D(b[13]),
    .Q(sig000000d7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002f (
    .C(clk),
    .CE(ce),
    .D(b[14]),
    .Q(sig000000d8)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000030 (
    .C(clk),
    .CE(ce),
    .D(sig00000049),
    .Q(sig00000085)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000031 (
    .C(clk),
    .CE(ce),
    .D(sig0000004a),
    .Q(sig00000084)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000032 (
    .C(clk),
    .CE(ce),
    .D(sig00000085),
    .Q(sig000000de)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000033 (
    .C(clk),
    .CE(ce),
    .D(sig00000084),
    .Q(sig000000df)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000034 (
    .C(clk),
    .CE(ce),
    .D(sig00000061),
    .Q(sig000000d1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000035 (
    .C(clk),
    .CE(ce),
    .D(sig0000009f),
    .Q(sig000000d0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000036 (
    .C(clk),
    .CE(ce),
    .D(sig000000a1),
    .Q(sig000000cf)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000037 (
    .C(clk),
    .CE(ce),
    .D(sig000000a0),
    .Q(sig000000cd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .CE(ce),
    .D(sig0000009a),
    .Q(sig0000011f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000039 (
    .C(clk),
    .CE(ce),
    .D(sig000000ac),
    .Q(sig000000cc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003a (
    .C(clk),
    .CE(ce),
    .D(sig000000ad),
    .Q(sig000000ce)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003b (
    .C(clk),
    .CE(ce),
    .D(sig000000ae),
    .Q(sig000000cb)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003c (
    .C(clk),
    .CE(ce),
    .D(sig000000a7),
    .Q(sig0000005f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003d (
    .C(clk),
    .CE(ce),
    .D(sig00000093),
    .Q(sig000000e0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003e (
    .C(clk),
    .CE(ce),
    .D(sig00000092),
    .Q(sig000000e1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003f (
    .C(clk),
    .CE(ce),
    .D(sig00000091),
    .Q(sig000000e2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000040 (
    .C(clk),
    .CE(ce),
    .D(sig00000090),
    .Q(sig000000e3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000041 (
    .C(clk),
    .CE(ce),
    .D(sig00000088),
    .Q(sig00000086)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000042 (
    .C(clk),
    .CE(ce),
    .D(sig0000008b),
    .Q(sig00000089)
  );
  MUXCY   blk00000043 (
    .CI(sig000000f5),
    .DI(sig000000e4),
    .S(sig000000e5),
    .O(sig000000f4)
  );
  MUXCY   blk00000044 (
    .CI(sig000000f6),
    .DI(sig000000e6),
    .S(sig000000e7),
    .O(sig000000f5)
  );
  MUXCY   blk00000045 (
    .CI(sig000000f7),
    .DI(sig000000e8),
    .S(sig000000e9),
    .O(sig000000f6)
  );
  MUXCY   blk00000046 (
    .CI(sig000000f8),
    .DI(sig000000ea),
    .S(sig000000eb),
    .O(sig000000f7)
  );
  MUXCY   blk00000047 (
    .CI(sig000000f9),
    .DI(sig000000ec),
    .S(sig000000ed),
    .O(sig000000f8)
  );
  MUXCY   blk00000048 (
    .CI(sig000000fa),
    .DI(sig000000ee),
    .S(sig000000ef),
    .O(sig000000f9)
  );
  MUXCY   blk00000049 (
    .CI(sig000000fb),
    .DI(sig000000f0),
    .S(sig000000f1),
    .O(sig000000fa)
  );
  MUXCY   blk0000004a (
    .CI(sig00000002),
    .DI(sig000000f2),
    .S(sig000000f3),
    .O(sig000000fb)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004b (
    .C(clk),
    .CE(ce),
    .D(sig000000f4),
    .Q(sig00000062)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004c (
    .C(clk),
    .CE(ce),
    .D(sig000000ab),
    .Q(sig000000fd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004d (
    .C(clk),
    .CE(ce),
    .D(sig000000aa),
    .Q(sig000000fc)
  );
  XORCY   blk0000004e (
    .CI(sig000000fe),
    .LI(sig00000002),
    .O(sig000000c7)
  );
  XORCY   blk0000004f (
    .CI(sig000000ff),
    .LI(sig00000098),
    .O(sig000000c6)
  );
  MUXCY   blk00000050 (
    .CI(sig000000ff),
    .DI(sig00000002),
    .S(sig00000098),
    .O(sig000000fe)
  );
  XORCY   blk00000051 (
    .CI(sig00000100),
    .LI(sig00000097),
    .O(sig000000c5)
  );
  MUXCY   blk00000052 (
    .CI(sig00000100),
    .DI(sig00000002),
    .S(sig00000097),
    .O(sig000000ff)
  );
  XORCY   blk00000053 (
    .CI(sig00000101),
    .LI(sig00000096),
    .O(sig000000c4)
  );
  MUXCY   blk00000054 (
    .CI(sig00000101),
    .DI(sig00000002),
    .S(sig00000096),
    .O(sig00000100)
  );
  XORCY   blk00000055 (
    .CI(sig00000102),
    .LI(sig00000095),
    .O(sig000000c3)
  );
  MUXCY   blk00000056 (
    .CI(sig00000102),
    .DI(sig00000002),
    .S(sig00000095),
    .O(sig00000101)
  );
  XORCY   blk00000057 (
    .CI(sig00000002),
    .LI(sig00000094),
    .O(sig000000c2)
  );
  MUXCY   blk00000058 (
    .CI(sig00000002),
    .DI(sig00000001),
    .S(sig00000094),
    .O(sig00000102)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000059 (
    .C(clk),
    .CE(ce),
    .D(b[9]),
    .Q(sig00000054)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005a (
    .C(clk),
    .CE(ce),
    .D(b[8]),
    .Q(sig00000053)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005b (
    .C(clk),
    .CE(ce),
    .D(b[7]),
    .Q(sig00000052)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005c (
    .C(clk),
    .CE(ce),
    .D(b[6]),
    .Q(sig00000051)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005d (
    .C(clk),
    .CE(ce),
    .D(b[5]),
    .Q(sig00000050)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005e (
    .C(clk),
    .CE(ce),
    .D(b[4]),
    .Q(sig0000004f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005f (
    .C(clk),
    .CE(ce),
    .D(b[3]),
    .Q(sig0000004e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000060 (
    .C(clk),
    .CE(ce),
    .D(b[2]),
    .Q(sig0000004d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000061 (
    .C(clk),
    .CE(ce),
    .D(b[1]),
    .Q(sig0000004c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000062 (
    .C(clk),
    .CE(ce),
    .D(b[0]),
    .Q(sig0000004b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000063 (
    .C(clk),
    .CE(ce),
    .D(a[9]),
    .Q(sig0000005e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000064 (
    .C(clk),
    .CE(ce),
    .D(a[8]),
    .Q(sig0000005d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000065 (
    .C(clk),
    .CE(ce),
    .D(a[7]),
    .Q(sig0000005c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000066 (
    .C(clk),
    .CE(ce),
    .D(a[6]),
    .Q(sig0000005b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000067 (
    .C(clk),
    .CE(ce),
    .D(a[5]),
    .Q(sig0000005a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000068 (
    .C(clk),
    .CE(ce),
    .D(a[4]),
    .Q(sig00000059)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000069 (
    .C(clk),
    .CE(ce),
    .D(a[3]),
    .Q(sig00000058)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006a (
    .C(clk),
    .CE(ce),
    .D(a[2]),
    .Q(sig00000057)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006b (
    .C(clk),
    .CE(ce),
    .D(a[1]),
    .Q(sig00000056)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006c (
    .C(clk),
    .CE(ce),
    .D(a[0]),
    .Q(sig00000055)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006d (
    .C(clk),
    .CE(ce),
    .D(sig0000011f),
    .Q(sig00000137)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006e (
    .C(clk),
    .CE(ce),
    .D(sig00000071),
    .Q(sig00000128)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006f (
    .C(clk),
    .CE(ce),
    .D(sig00000121),
    .Q(sig00000129)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000070 (
    .C(clk),
    .CE(ce),
    .D(sig00000122),
    .Q(sig00000104)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000071 (
    .C(clk),
    .CE(ce),
    .D(sig00000123),
    .Q(sig00000103)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000072 (
    .C(clk),
    .CE(ce),
    .D(sig00000124),
    .Q(sig0000012a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000073 (
    .C(clk),
    .CE(ce),
    .D(sig00000060),
    .Q(sig00000144)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000074 (
    .C(clk),
    .CE(ce),
    .D(sig00000129),
    .Q(sig00000126)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000075 (
    .C(clk),
    .CE(ce),
    .D(sig00000127),
    .Q(sig0000003c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000076 (
    .C(clk),
    .CE(ce),
    .D(sig00000120),
    .Q(sig00000125)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000077 (
    .C(clk),
    .CE(ce),
    .D(sig00000143),
    .Q(sig00000136)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000078 (
    .C(clk),
    .CE(ce),
    .D(sig00000142),
    .Q(sig00000135)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000079 (
    .C(clk),
    .CE(ce),
    .D(sig00000141),
    .Q(sig00000134)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007a (
    .C(clk),
    .CE(ce),
    .D(sig00000140),
    .Q(sig00000133)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007b (
    .C(clk),
    .CE(ce),
    .D(sig0000013f),
    .Q(sig00000132)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007c (
    .C(clk),
    .CE(ce),
    .D(sig0000013e),
    .Q(sig00000131)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007d (
    .C(clk),
    .CE(ce),
    .D(sig0000013d),
    .Q(sig00000130)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007e (
    .C(clk),
    .CE(ce),
    .D(sig0000013c),
    .Q(sig0000012f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007f (
    .C(clk),
    .CE(ce),
    .D(sig0000013b),
    .Q(sig0000012e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000080 (
    .C(clk),
    .CE(ce),
    .D(sig0000013a),
    .Q(sig0000012d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000081 (
    .C(clk),
    .CE(ce),
    .D(sig00000139),
    .Q(sig0000012c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000082 (
    .C(clk),
    .CE(ce),
    .D(sig00000138),
    .Q(sig0000012b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000083 (
    .C(clk),
    .CE(ce),
    .D(sig00000105),
    .Q(sig00000112)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000084 (
    .C(clk),
    .CE(ce),
    .D(sig00000106),
    .Q(sig00000113)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000085 (
    .C(clk),
    .CE(ce),
    .D(sig00000107),
    .Q(sig00000114)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000086 (
    .C(clk),
    .CE(ce),
    .D(sig00000108),
    .Q(sig00000115)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000087 (
    .C(clk),
    .CE(ce),
    .D(sig00000109),
    .Q(sig00000116)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000088 (
    .C(clk),
    .CE(ce),
    .D(sig0000010a),
    .Q(sig00000117)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000089 (
    .C(clk),
    .CE(ce),
    .D(sig0000010b),
    .Q(sig00000118)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008a (
    .C(clk),
    .CE(ce),
    .D(sig0000010c),
    .Q(sig00000119)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008b (
    .C(clk),
    .CE(ce),
    .D(sig0000010d),
    .Q(sig0000011a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008c (
    .C(clk),
    .CE(ce),
    .D(sig0000010e),
    .Q(sig0000011b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008d (
    .C(clk),
    .CE(ce),
    .D(sig0000010f),
    .Q(sig0000011c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008e (
    .C(clk),
    .CE(ce),
    .D(sig00000110),
    .Q(sig0000011d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008f (
    .C(clk),
    .CE(ce),
    .D(sig00000111),
    .Q(sig0000011e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000090 (
    .C(clk),
    .CE(ce),
    .D(sig00000104),
    .Q(sig00000158)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000091 (
    .C(clk),
    .CE(ce),
    .D(sig00000103),
    .Q(sig00000159)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000092 (
    .C(clk),
    .CE(ce),
    .D(sig00000154),
    .Q(sig0000015a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000093 (
    .C(clk),
    .CE(ce),
    .D(sig00000155),
    .Q(sig0000015d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000094 (
    .C(clk),
    .CE(ce),
    .D(sig00000156),
    .Q(sig0000015c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000095 (
    .C(clk),
    .CE(ce),
    .D(sig00000157),
    .Q(sig0000015b)
  );
  MUXCY   blk00000096 (
    .CI(sig00000162),
    .DI(sig00000002),
    .S(sig00000153),
    .O(sig00000161)
  );
  MUXCY   blk00000097 (
    .CI(sig00000163),
    .DI(sig00000002),
    .S(sig00000152),
    .O(sig00000162)
  );
  MUXCY   blk00000098 (
    .CI(sig00000164),
    .DI(sig00000002),
    .S(sig00000151),
    .O(sig00000163)
  );
  MUXCY   blk00000099 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000150),
    .O(sig00000164)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009a (
    .C(clk),
    .CE(ce),
    .D(sig00000161),
    .Q(NLW_blk0000009a_Q_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009b (
    .C(clk),
    .CE(ce),
    .D(sig00000162),
    .Q(sig0000015e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009c (
    .C(clk),
    .CE(ce),
    .D(sig00000163),
    .Q(sig0000015f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009d (
    .C(clk),
    .CE(ce),
    .D(sig00000164),
    .Q(sig00000160)
  );
  MUXCY   blk0000009e (
    .CI(sig00000187),
    .DI(sig00000002),
    .S(sig00000127),
    .O(sig00000186)
  );
  MUXCY   blk0000009f (
    .CI(sig00000137),
    .DI(sig00000002),
    .S(sig00000001),
    .O(sig00000187)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a0 (
    .C(clk),
    .CE(ce),
    .D(sig0000018b),
    .Q(sig00000185)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a1 (
    .C(clk),
    .CE(ce),
    .D(sig0000018a),
    .Q(sig00000184)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a2 (
    .C(clk),
    .CE(ce),
    .D(sig00000189),
    .Q(sig00000183)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a3 (
    .C(clk),
    .CE(ce),
    .D(sig00000188),
    .Q(sig00000182)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a4 (
    .C(clk),
    .CE(ce),
    .D(sig00000148),
    .Q(sig0000018b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a5 (
    .C(clk),
    .CE(ce),
    .D(sig00000147),
    .Q(sig0000018a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a6 (
    .C(clk),
    .CE(ce),
    .D(sig00000146),
    .Q(sig00000189)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a7 (
    .C(clk),
    .CE(ce),
    .D(sig00000145),
    .Q(sig00000188)
  );
  XORCY   blk000000a8 (
    .CI(sig0000018e),
    .LI(sig00000171),
    .O(sig0000018c)
  );
  MUXCY   blk000000a9 (
    .CI(sig0000018e),
    .DI(sig00000185),
    .S(sig00000171),
    .O(sig00000181)
  );
  XORCY   blk000000aa (
    .CI(sig00000190),
    .LI(sig00000170),
    .O(sig0000018d)
  );
  MUXCY   blk000000ab (
    .CI(sig00000190),
    .DI(sig00000184),
    .S(sig00000170),
    .O(sig0000018e)
  );
  XORCY   blk000000ac (
    .CI(sig00000192),
    .LI(sig0000016f),
    .O(sig0000018f)
  );
  MUXCY   blk000000ad (
    .CI(sig00000192),
    .DI(sig00000183),
    .S(sig0000016f),
    .O(sig00000190)
  );
  XORCY   blk000000ae (
    .CI(sig00000194),
    .LI(sig0000016e),
    .O(sig00000191)
  );
  MUXCY   blk000000af (
    .CI(sig00000194),
    .DI(sig00000182),
    .S(sig0000016e),
    .O(sig00000192)
  );
  XORCY   blk000000b0 (
    .CI(sig00000196),
    .LI(sig0000016d),
    .O(sig00000193)
  );
  MUXCY   blk000000b1 (
    .CI(sig00000196),
    .DI(sig00000002),
    .S(sig0000016d),
    .O(sig00000194)
  );
  XORCY   blk000000b2 (
    .CI(sig00000186),
    .LI(sig0000016c),
    .O(sig00000195)
  );
  MUXCY   blk000000b3 (
    .CI(sig00000186),
    .DI(sig00000002),
    .S(sig0000016c),
    .O(sig00000196)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b4 (
    .C(clk),
    .CE(ce),
    .D(sig00000195),
    .Q(sig0000003d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b5 (
    .C(clk),
    .CE(ce),
    .D(sig00000193),
    .Q(sig0000003e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b6 (
    .C(clk),
    .CE(ce),
    .D(sig00000191),
    .Q(sig0000003f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b7 (
    .C(clk),
    .CE(ce),
    .D(sig0000018f),
    .Q(sig00000040)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b8 (
    .C(clk),
    .CE(ce),
    .D(sig0000018d),
    .Q(sig00000041)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b9 (
    .C(clk),
    .CE(ce),
    .D(sig0000018c),
    .Q(sig00000042)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ba (
    .C(clk),
    .CE(ce),
    .D(sig0000019d),
    .Q(sig00000180)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000bb (
    .C(clk),
    .CE(ce),
    .D(sig0000019c),
    .Q(sig0000017f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000bc (
    .C(clk),
    .CE(ce),
    .D(sig0000019b),
    .Q(sig0000017e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000bd (
    .C(clk),
    .CE(ce),
    .D(sig0000019a),
    .Q(sig0000017d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000be (
    .C(clk),
    .CE(ce),
    .D(sig00000199),
    .Q(sig0000017c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000bf (
    .C(clk),
    .CE(ce),
    .D(sig00000198),
    .Q(sig0000017b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c0 (
    .C(clk),
    .CE(ce),
    .D(sig00000197),
    .Q(sig0000017a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c1 (
    .C(clk),
    .CE(ce),
    .D(sig0000014f),
    .Q(sig0000019d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c2 (
    .C(clk),
    .CE(ce),
    .D(sig0000014e),
    .Q(sig0000019c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c3 (
    .C(clk),
    .CE(ce),
    .D(sig0000014d),
    .Q(sig0000019b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c4 (
    .C(clk),
    .CE(ce),
    .D(sig0000014c),
    .Q(sig0000019a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c5 (
    .C(clk),
    .CE(ce),
    .D(sig0000014b),
    .Q(sig00000199)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c6 (
    .C(clk),
    .CE(ce),
    .D(sig0000014a),
    .Q(sig00000198)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c7 (
    .C(clk),
    .CE(ce),
    .D(sig00000149),
    .Q(sig00000197)
  );
  XORCY   blk000000c8 (
    .CI(sig0000019e),
    .LI(sig00000211),
    .O(sig00000179)
  );
  XORCY   blk000000c9 (
    .CI(sig0000019f),
    .LI(sig0000016b),
    .O(sig00000178)
  );
  MUXCY   blk000000ca (
    .CI(sig0000019f),
    .DI(sig00000180),
    .S(sig0000016b),
    .O(sig0000019e)
  );
  XORCY   blk000000cb (
    .CI(sig000001a0),
    .LI(sig0000016a),
    .O(sig00000177)
  );
  MUXCY   blk000000cc (
    .CI(sig000001a0),
    .DI(sig0000017f),
    .S(sig0000016a),
    .O(sig0000019f)
  );
  XORCY   blk000000cd (
    .CI(sig000001a1),
    .LI(sig00000169),
    .O(sig00000176)
  );
  MUXCY   blk000000ce (
    .CI(sig000001a1),
    .DI(sig0000017e),
    .S(sig00000169),
    .O(sig000001a0)
  );
  XORCY   blk000000cf (
    .CI(sig000001a2),
    .LI(sig00000168),
    .O(sig00000175)
  );
  MUXCY   blk000000d0 (
    .CI(sig000001a2),
    .DI(sig0000017d),
    .S(sig00000168),
    .O(sig000001a1)
  );
  XORCY   blk000000d1 (
    .CI(sig000001a3),
    .LI(sig00000167),
    .O(sig00000174)
  );
  MUXCY   blk000000d2 (
    .CI(sig000001a3),
    .DI(sig0000017c),
    .S(sig00000167),
    .O(sig000001a2)
  );
  XORCY   blk000000d3 (
    .CI(sig000001a4),
    .LI(sig00000166),
    .O(sig00000173)
  );
  MUXCY   blk000000d4 (
    .CI(sig000001a4),
    .DI(sig0000017b),
    .S(sig00000166),
    .O(sig000001a3)
  );
  XORCY   blk000000d5 (
    .CI(sig00000181),
    .LI(sig00000165),
    .O(sig00000172)
  );
  MUXCY   blk000000d6 (
    .CI(sig00000181),
    .DI(sig0000017a),
    .S(sig00000165),
    .O(sig000001a4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d7 (
    .C(clk),
    .CE(ce),
    .D(sig00000179),
    .Q(sig0000004a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d8 (
    .C(clk),
    .CE(ce),
    .D(sig00000178),
    .Q(sig00000049)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d9 (
    .C(clk),
    .CE(ce),
    .D(sig00000177),
    .Q(sig00000048)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000da (
    .C(clk),
    .CE(ce),
    .D(sig00000176),
    .Q(sig00000047)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000db (
    .C(clk),
    .CE(ce),
    .D(sig00000175),
    .Q(sig00000046)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000dc (
    .C(clk),
    .CE(ce),
    .D(sig00000174),
    .Q(sig00000045)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000dd (
    .C(clk),
    .CE(ce),
    .D(sig00000173),
    .Q(sig00000044)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000de (
    .C(clk),
    .CE(ce),
    .D(sig00000172),
    .Q(sig00000043)
  );
  MUXF7   blk000000df (
    .I0(sig000001a5),
    .I1(sig000001a6),
    .S(sig00000010),
    .O(NLW_blk000000df_O_UNCONNECTED)
  );
  MUXF7   blk000000e0 (
    .I0(sig000001a7),
    .I1(sig000001a9),
    .S(sig00000010),
    .O(sig000001ab)
  );
  MUXF7   blk000000e1 (
    .I0(sig000001a8),
    .I1(sig000001aa),
    .S(sig00000010),
    .O(sig000001ac)
  );
  MUXCY   blk000000e2 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig000001b2),
    .O(sig000001ad)
  );
  MUXCY   blk000000e3 (
    .CI(sig000001ad),
    .DI(sig00000002),
    .S(sig000001b3),
    .O(sig000001ae)
  );
  MUXCY   blk000000e4 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig000001b4),
    .O(sig000001af)
  );
  MUXCY   blk000000e5 (
    .CI(sig000001af),
    .DI(sig00000002),
    .S(sig000001b5),
    .O(sig000001b0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e6 (
    .C(clk),
    .CE(ce),
    .D(sig000001ac),
    .Q(sig00000012)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e7 (
    .C(clk),
    .CE(ce),
    .D(sig000001ab),
    .Q(sig00000013)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e8 (
    .C(clk),
    .CE(ce),
    .D(sig000001ad),
    .Q(sig000001b8)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e9 (
    .C(clk),
    .CE(ce),
    .D(sig000001ae),
    .Q(sig00000010)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ea (
    .C(clk),
    .CE(ce),
    .D(sig000001af),
    .Q(sig000001b7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000eb (
    .C(clk),
    .CE(ce),
    .D(sig000001b0),
    .Q(sig000001b6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ec (
    .C(clk),
    .CE(ce),
    .D(sig00000010),
    .Q(sig0000003b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ed (
    .C(clk),
    .CE(ce),
    .D(sig00000011),
    .Q(sig0000003a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ee (
    .C(clk),
    .CE(ce),
    .D(sig000001b1),
    .Q(sig0000002f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ef (
    .C(clk),
    .CE(ce),
    .D(sig00000003),
    .Q(sig0000002d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f0 (
    .C(clk),
    .CE(ce),
    .D(sig00000004),
    .Q(sig0000002c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f1 (
    .C(clk),
    .CE(ce),
    .D(sig00000005),
    .Q(sig0000002b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f2 (
    .C(clk),
    .CE(ce),
    .D(sig00000006),
    .Q(sig0000002a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f3 (
    .C(clk),
    .CE(ce),
    .D(sig00000007),
    .Q(sig00000029)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f4 (
    .C(clk),
    .CE(ce),
    .D(sig00000008),
    .Q(sig00000028)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f5 (
    .C(clk),
    .CE(ce),
    .D(sig00000009),
    .Q(sig00000027)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f6 (
    .C(clk),
    .CE(ce),
    .D(sig0000000a),
    .Q(sig00000026)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f7 (
    .C(clk),
    .CE(ce),
    .D(sig0000000b),
    .Q(sig00000025)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f8 (
    .C(clk),
    .CE(ce),
    .D(sig0000000c),
    .Q(sig00000024)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f9 (
    .C(clk),
    .CE(ce),
    .D(sig0000000d),
    .Q(sig00000023)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fa (
    .C(clk),
    .CE(ce),
    .D(sig0000000e),
    .Q(sig00000022)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fb (
    .C(clk),
    .CE(ce),
    .D(sig0000000f),
    .Q(sig00000021)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fc (
    .C(clk),
    .CE(ce),
    .D(sig00000048),
    .Q(sig00000014)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fd (
    .C(clk),
    .CE(ce),
    .D(sig00000047),
    .Q(sig00000015)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fe (
    .C(clk),
    .CE(ce),
    .D(sig00000046),
    .Q(sig00000016)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ff (
    .C(clk),
    .CE(ce),
    .D(sig00000045),
    .Q(sig00000017)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000100 (
    .C(clk),
    .CE(ce),
    .D(sig00000044),
    .Q(sig00000018)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000101 (
    .C(clk),
    .CE(ce),
    .D(sig00000043),
    .Q(sig00000019)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000102 (
    .C(clk),
    .CE(ce),
    .D(sig00000042),
    .Q(sig0000001a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000103 (
    .C(clk),
    .CE(ce),
    .D(sig00000041),
    .Q(sig0000001b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000104 (
    .C(clk),
    .CE(ce),
    .D(sig00000040),
    .Q(sig0000001c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000105 (
    .C(clk),
    .CE(ce),
    .D(sig0000003f),
    .Q(sig0000001d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000106 (
    .C(clk),
    .CE(ce),
    .D(sig0000003e),
    .Q(sig0000001e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000107 (
    .C(clk),
    .CE(ce),
    .D(sig0000003d),
    .Q(sig0000001f)
  );
  MUXCY   blk00000108 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig000001ce),
    .O(sig000001c7)
  );
  MUXCY   blk00000109 (
    .CI(sig000001c7),
    .DI(sig00000001),
    .S(sig000001cc),
    .O(sig000001c8)
  );
  MUXCY   blk0000010a (
    .CI(sig000001c8),
    .DI(sig00000001),
    .S(sig00000210),
    .O(sig000001c9)
  );
  MUXCY   blk0000010b (
    .CI(sig000001c9),
    .DI(sig00000002),
    .S(sig000001cd),
    .O(sig000001ca)
  );
  MUXCY   blk0000010c (
    .CI(sig000001ca),
    .DI(sig00000002),
    .S(sig00000001),
    .O(sig000001cb)
  );
  MUXCY   blk0000010d (
    .CI(sig000001cb),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000001c6)
  );
  XORCY   blk0000010e (
    .CI(sig000001d1),
    .LI(sig000001c2),
    .O(sig000001cf)
  );
  MUXCY   blk0000010f (
    .CI(sig000001d1),
    .DI(sig00000002),
    .S(sig000001c2),
    .O(sig000001c5)
  );
  XORCY   blk00000110 (
    .CI(sig000001d3),
    .LI(sig000001c1),
    .O(sig000001d0)
  );
  MUXCY   blk00000111 (
    .CI(sig000001d3),
    .DI(sig00000002),
    .S(sig000001c1),
    .O(sig000001d1)
  );
  XORCY   blk00000112 (
    .CI(sig000001d5),
    .LI(sig000001c0),
    .O(sig000001d2)
  );
  MUXCY   blk00000113 (
    .CI(sig000001d5),
    .DI(sig00000002),
    .S(sig000001c0),
    .O(sig000001d3)
  );
  XORCY   blk00000114 (
    .CI(sig000001d7),
    .LI(sig000001bf),
    .O(sig000001d4)
  );
  MUXCY   blk00000115 (
    .CI(sig000001d7),
    .DI(sig00000002),
    .S(sig000001bf),
    .O(sig000001d5)
  );
  XORCY   blk00000116 (
    .CI(sig000001c6),
    .LI(sig000001be),
    .O(sig000001d6)
  );
  MUXCY   blk00000117 (
    .CI(sig000001c6),
    .DI(sig00000002),
    .S(sig000001be),
    .O(sig000001d7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000118 (
    .C(clk),
    .CE(ce),
    .D(sig000001d6),
    .Q(sig00000030)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000119 (
    .C(clk),
    .CE(ce),
    .D(sig000001d4),
    .Q(sig00000031)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000011a (
    .C(clk),
    .CE(ce),
    .D(sig000001d2),
    .Q(sig00000032)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000011b (
    .C(clk),
    .CE(ce),
    .D(sig000001d0),
    .Q(sig00000033)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000011c (
    .C(clk),
    .CE(ce),
    .D(sig000001cf),
    .Q(sig00000034)
  );
  XORCY   blk0000011d (
    .CI(sig000001da),
    .LI(sig00000002),
    .O(sig000001d8)
  );
  XORCY   blk0000011e (
    .CI(sig000001dc),
    .LI(sig00000001),
    .O(sig000001d9)
  );
  MUXCY   blk0000011f (
    .CI(sig000001dc),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000001da)
  );
  XORCY   blk00000120 (
    .CI(sig000001de),
    .LI(sig000001bd),
    .O(sig000001db)
  );
  MUXCY   blk00000121 (
    .CI(sig000001de),
    .DI(sig00000002),
    .S(sig000001bd),
    .O(sig000001dc)
  );
  XORCY   blk00000122 (
    .CI(sig000001e0),
    .LI(sig000001bc),
    .O(sig000001dd)
  );
  MUXCY   blk00000123 (
    .CI(sig000001e0),
    .DI(sig00000002),
    .S(sig000001bc),
    .O(sig000001de)
  );
  XORCY   blk00000124 (
    .CI(sig000001e2),
    .LI(sig000001bb),
    .O(sig000001df)
  );
  MUXCY   blk00000125 (
    .CI(sig000001e2),
    .DI(sig00000002),
    .S(sig000001bb),
    .O(sig000001e0)
  );
  XORCY   blk00000126 (
    .CI(sig000001e4),
    .LI(sig000001ba),
    .O(sig000001e1)
  );
  MUXCY   blk00000127 (
    .CI(sig000001e4),
    .DI(sig00000002),
    .S(sig000001ba),
    .O(sig000001e2)
  );
  XORCY   blk00000128 (
    .CI(sig000001c5),
    .LI(sig000001b9),
    .O(sig000001e3)
  );
  MUXCY   blk00000129 (
    .CI(sig000001c5),
    .DI(sig00000002),
    .S(sig000001b9),
    .O(sig000001e4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000012a (
    .C(clk),
    .CE(ce),
    .D(sig000001e3),
    .Q(sig00000035)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000012b (
    .C(clk),
    .CE(ce),
    .D(sig000001e1),
    .Q(sig00000036)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000012c (
    .C(clk),
    .CE(ce),
    .D(sig000001df),
    .Q(sig00000037)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000012d (
    .C(clk),
    .CE(ce),
    .D(sig000001dd),
    .Q(sig00000038)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000012e (
    .C(clk),
    .CE(ce),
    .D(sig000001db),
    .Q(sig00000039)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000012f (
    .C(clk),
    .CE(ce),
    .D(sig000001d9),
    .Q(sig000001c4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000130 (
    .C(clk),
    .CE(ce),
    .D(sig000001d8),
    .Q(sig000001c3)
  );
  XORCY   blk00000131 (
    .CI(sig000001e5),
    .LI(sig00000002),
    .O(NLW_blk00000131_O_UNCONNECTED)
  );
  XORCY   blk00000132 (
    .CI(sig000001e6),
    .LI(sig00000002),
    .O(NLW_blk00000132_O_UNCONNECTED)
  );
  MUXCY   blk00000133 (
    .CI(sig000001e6),
    .DI(sig00000002),
    .S(sig00000002),
    .O(sig000001e5)
  );
  XORCY   blk00000134 (
    .CI(sig000001e7),
    .LI(sig00000002),
    .O(NLW_blk00000134_O_UNCONNECTED)
  );
  MUXCY   blk00000135 (
    .CI(sig000001e7),
    .DI(sig00000002),
    .S(sig00000002),
    .O(sig000001e6)
  );
  XORCY   blk00000136 (
    .CI(sig000001e8),
    .LI(sig00000002),
    .O(NLW_blk00000136_O_UNCONNECTED)
  );
  MUXCY   blk00000137 (
    .CI(sig000001e8),
    .DI(sig00000002),
    .S(sig00000002),
    .O(sig000001e7)
  );
  XORCY   blk00000138 (
    .CI(sig000001c3),
    .LI(sig00000002),
    .O(NLW_blk00000138_O_UNCONNECTED)
  );
  MUXCY   blk00000139 (
    .CI(sig000001c3),
    .DI(sig00000002),
    .S(sig00000002),
    .O(sig000001e8)
  );
  FDE   blk0000013a (
    .C(clk),
    .CE(ce),
    .D(sig000001ed),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [4])
  );
  FDE   blk0000013b (
    .C(clk),
    .CE(ce),
    .D(sig000001ec),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [3])
  );
  FDE   blk0000013c (
    .C(clk),
    .CE(ce),
    .D(sig000001eb),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [2])
  );
  FDE   blk0000013d (
    .C(clk),
    .CE(ce),
    .D(sig000001ea),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [1])
  );
  FDE   blk0000013e (
    .C(clk),
    .CE(ce),
    .D(sig000001e9),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/exp_op [0])
  );
  FD   blk0000013f (
    .C(clk),
    .D(sig000001f7),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [9])
  );
  FD   blk00000140 (
    .C(clk),
    .D(sig000001f6),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [8])
  );
  FD   blk00000141 (
    .C(clk),
    .D(sig000001f5),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [7])
  );
  FD   blk00000142 (
    .C(clk),
    .D(sig000001f4),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [6])
  );
  FD   blk00000143 (
    .C(clk),
    .D(sig000001f3),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [5])
  );
  FD   blk00000144 (
    .C(clk),
    .D(sig000001f2),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [4])
  );
  FD   blk00000145 (
    .C(clk),
    .D(sig000001f1),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [3])
  );
  FD   blk00000146 (
    .C(clk),
    .D(sig000001f0),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [2])
  );
  FD   blk00000147 (
    .C(clk),
    .D(sig000001ef),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [1])
  );
  FD   blk00000148 (
    .C(clk),
    .D(sig000001ee),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000149 (
    .C(clk),
    .CE(ce),
    .D(sig000001f9),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/OVERFLOW )
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000014a (
    .C(clk),
    .CE(ce),
    .D(sig000001f8),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/UNDERFLOW )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  blk0000014b (
    .C(clk),
    .CE(sig00000201),
    .D(sig000001fd),
    .R(sclr),
    .Q(sig00000204)
  );
  FDSE #(
    .INIT ( 1'b1 ))
  blk0000014c (
    .C(clk),
    .CE(sig00000201),
    .D(sig000001fe),
    .S(sclr),
    .Q(sig000001fb)
  );
  FDSE #(
    .INIT ( 1'b1 ))
  blk0000014d (
    .C(clk),
    .CE(sig00000201),
    .D(sig00000200),
    .S(sclr),
    .Q(sig000001fa)
  );
  FDRE #(
    .INIT ( 1'b0 ))
  blk0000014e (
    .C(clk),
    .CE(sig00000201),
    .D(sig000001ff),
    .R(sclr),
    .Q(sig000001fc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000014f (
    .C(clk),
    .CE(ce),
    .D(sig00000206),
    .Q(sig00000202)
  );
  LUT6 #(
    .INIT ( 64'hF0F0CCCCFF00AAAA ))
  blk00000150 (
    .I0(sig00000085),
    .I1(sig00000017),
    .I2(sig0000001f),
    .I3(sig0000001b),
    .I4(sig00000010),
    .I5(sig00000011),
    .O(sig0000000f)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000151 (
    .I0(a[10]),
    .I1(b[10]),
    .O(sig0000002e)
  );
  LUT4 #(
    .INIT ( 16'hEA2A ))
  blk00000152 (
    .I0(sig000000d2),
    .I1(sig000000e3),
    .I2(sig00000086),
    .I3(sig000000d3),
    .O(sig000000ac)
  );
  LUT5 #(
    .INIT ( 32'hFFFF1504 ))
  blk00000153 (
    .I0(sig000000d0),
    .I1(sig000000cf),
    .I2(sig0000011f),
    .I3(sig000000cd),
    .I4(sig000000d1),
    .O(sig000000ab)
  );
  LUT4 #(
    .INIT ( 16'hAA8A ))
  blk00000154 (
    .I0(sig000000c8),
    .I1(sig000000ca),
    .I2(sig0000002f),
    .I3(sig000000c9),
    .O(sig000000a7)
  );
  LUT4 #(
    .INIT ( 16'h5554 ))
  blk00000155 (
    .I0(sig000000d1),
    .I1(sig000000cf),
    .I2(sig000000cd),
    .I3(sig000000d0),
    .O(sig000000aa)
  );
  LUT6 #(
    .INIT ( 64'h4000000000000000 ))
  blk00000156 (
    .I0(sig000000bb),
    .I1(sig0000007b),
    .I2(sig0000007a),
    .I3(sig0000007c),
    .I4(sig00000077),
    .I5(sig0000007d),
    .O(sig0000009e)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  blk00000157 (
    .I0(sig000000ca),
    .I1(sig000000c9),
    .I2(sig0000002f),
    .O(sig00000077)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk00000158 (
    .I0(sig000000c9),
    .I1(sig000000ca),
    .O(sig0000007f)
  );
  LUT3 #(
    .INIT ( 8'h27 ))
  blk00000159 (
    .I0(sig00000076),
    .I1(sig000000d9),
    .I2(sig000000d4),
    .O(sig00000094)
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  blk0000015a (
    .I0(sig000000e1),
    .I1(sig00000089),
    .I2(sig000000e3),
    .I3(sig00000086),
    .O(sig000000a1)
  );
  LUT4 #(
    .INIT ( 16'hF888 ))
  blk0000015b (
    .I0(sig000000e1),
    .I1(sig00000089),
    .I2(sig000000e3),
    .I3(sig00000086),
    .O(sig000000a0)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000015c (
    .I0(sig00000062),
    .I1(sig000000d3),
    .I2(sig000000d2),
    .O(sig000000ae)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000015d (
    .I0(sig00000076),
    .I1(sig000000d5),
    .I2(sig000000da),
    .O(sig00000095)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000015e (
    .I0(sig00000076),
    .I1(sig000000d6),
    .I2(sig000000db),
    .O(sig00000096)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000015f (
    .I0(sig00000076),
    .I1(sig000000d7),
    .I2(sig000000dc),
    .O(sig00000097)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000160 (
    .I0(sig00000076),
    .I1(sig000000d8),
    .I2(sig000000dd),
    .O(sig00000098)
  );
  LUT4 #(
    .INIT ( 16'h1000 ))
  blk00000161 (
    .I0(sig000000d1),
    .I1(sig000000d0),
    .I2(sig000000cf),
    .I3(sig0000011f),
    .O(sig000000a8)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000162 (
    .I0(sig000000d3),
    .I1(sig000000d2),
    .O(sig0000009a)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000163 (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig0000008c)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000164 (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig0000008d)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000165 (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig0000008e)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000166 (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig0000008f)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000167 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000090)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk00000168 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000091)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000169 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000092)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk0000016a (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000093)
  );
  LUT6 #(
    .INIT ( 64'h0000800000000000 ))
  blk0000016b (
    .I0(sig000000bd),
    .I1(sig000000c0),
    .I2(sig000000bf),
    .I3(sig000000be),
    .I4(sig000000c1),
    .I5(sig000000bc),
    .O(sig00000099)
  );
  LUT4 #(
    .INIT ( 16'h22F2 ))
  blk0000016c (
    .I0(sig000000e3),
    .I1(sig00000086),
    .I2(sig000000e1),
    .I3(sig00000089),
    .O(sig0000009f)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000016d (
    .I0(sig000000d3),
    .I1(sig000000d2),
    .O(sig000000ad)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  blk0000016e (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .O(sig00000060)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000016f (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .O(sig00000061)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000170 (
    .I0(sig000000ba),
    .I1(sig0000003b),
    .O(sig0000007a)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000171 (
    .I0(sig000000b9),
    .I1(sig0000003a),
    .O(sig0000007b)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000172 (
    .I0(sig000000b8),
    .I1(sig00000012),
    .O(sig0000007c)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000173 (
    .I0(sig000000b7),
    .I1(sig00000013),
    .O(sig0000007d)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000174 (
    .I0(b[13]),
    .I1(a[13]),
    .I2(b[12]),
    .I3(a[12]),
    .O(sig000000e7)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000175 (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig000000e9)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000176 (
    .I0(b[9]),
    .I1(a[9]),
    .I2(b[8]),
    .I3(a[8]),
    .O(sig000000eb)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000177 (
    .I0(b[7]),
    .I1(a[7]),
    .I2(b[6]),
    .I3(a[6]),
    .O(sig000000ed)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000178 (
    .I0(b[5]),
    .I1(a[5]),
    .I2(b[4]),
    .I3(a[4]),
    .O(sig000000ef)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000179 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(b[2]),
    .I3(a[2]),
    .O(sig000000f1)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000017a (
    .I0(b[1]),
    .I1(a[1]),
    .I2(b[0]),
    .I3(a[0]),
    .O(sig000000f3)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000017b (
    .I0(b[13]),
    .I1(a[13]),
    .I2(b[12]),
    .I3(a[12]),
    .O(sig000000e6)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000017c (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig000000e8)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000017d (
    .I0(b[9]),
    .I1(a[9]),
    .I2(b[8]),
    .I3(a[8]),
    .O(sig000000ea)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000017e (
    .I0(b[7]),
    .I1(a[7]),
    .I2(b[6]),
    .I3(a[6]),
    .O(sig000000ec)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk0000017f (
    .I0(b[5]),
    .I1(a[5]),
    .I2(b[4]),
    .I3(a[4]),
    .O(sig000000ee)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000180 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(b[2]),
    .I3(a[2]),
    .O(sig000000f0)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000181 (
    .I0(b[1]),
    .I1(a[1]),
    .I2(b[0]),
    .I3(a[0]),
    .O(sig000000f2)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk00000182 (
    .I0(b[14]),
    .I1(a[14]),
    .O(sig000000e4)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000183 (
    .I0(a[14]),
    .I1(b[14]),
    .O(sig000000e5)
  );
  LUT5 #(
    .INIT ( 32'hEC64A820 ))
  blk00000184 (
    .I0(sig00000104),
    .I1(sig00000103),
    .I2(sig0000012e),
    .I3(sig00000136),
    .I4(sig00000132),
    .O(sig00000111)
  );
  LUT5 #(
    .INIT ( 32'h76325410 ))
  blk00000185 (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig0000012e),
    .I3(sig00000132),
    .I4(sig00000136),
    .O(sig0000010d)
  );
  LUT4 #(
    .INIT ( 16'hA820 ))
  blk00000186 (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig0000004b),
    .I3(sig00000055),
    .O(sig00000138)
  );
  LUT4 #(
    .INIT ( 16'hFFD8 ))
  blk00000187 (
    .I0(sig00000062),
    .I1(sig0000005e),
    .I2(sig00000054),
    .I3(sig00000071),
    .O(sig00000142)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000188 (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig0000004c),
    .I3(sig00000056),
    .I4(sig00000055),
    .I5(sig0000004b),
    .O(sig00000139)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000189 (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig0000004d),
    .I3(sig00000057),
    .I4(sig00000056),
    .I5(sig0000004c),
    .O(sig0000013a)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000018a (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig0000004e),
    .I3(sig00000058),
    .I4(sig00000057),
    .I5(sig0000004d),
    .O(sig0000013b)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000018b (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig0000004f),
    .I3(sig00000059),
    .I4(sig00000058),
    .I5(sig0000004e),
    .O(sig0000013c)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000018c (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig00000050),
    .I3(sig0000005a),
    .I4(sig00000059),
    .I5(sig0000004f),
    .O(sig0000013d)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000018d (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig00000051),
    .I3(sig0000005b),
    .I4(sig0000005a),
    .I5(sig00000050),
    .O(sig0000013e)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000018e (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig00000052),
    .I3(sig0000005c),
    .I4(sig0000005b),
    .I5(sig00000051),
    .O(sig0000013f)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000018f (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig00000054),
    .I3(sig0000005e),
    .I4(sig0000005d),
    .I5(sig00000053),
    .O(sig00000141)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000190 (
    .I0(sig00000071),
    .I1(sig00000062),
    .I2(sig00000053),
    .I3(sig0000005d),
    .I4(sig0000005c),
    .I5(sig00000052),
    .O(sig00000140)
  );
  LUT3 #(
    .INIT ( 8'h6C ))
  blk00000191 (
    .I0(sig00000076),
    .I1(sig00000072),
    .I2(sig00000071),
    .O(sig00000121)
  );
  LUT4 #(
    .INIT ( 16'h666C ))
  blk00000192 (
    .I0(sig00000076),
    .I1(sig00000073),
    .I2(sig00000072),
    .I3(sig00000071),
    .O(sig00000122)
  );
  LUT5 #(
    .INIT ( 32'h6666666C ))
  blk00000193 (
    .I0(sig00000076),
    .I1(sig00000074),
    .I2(sig00000072),
    .I3(sig00000073),
    .I4(sig00000071),
    .O(sig00000123)
  );
  LUT6 #(
    .INIT ( 64'h666666666666666C ))
  blk00000194 (
    .I0(sig00000076),
    .I1(sig00000075),
    .I2(sig00000072),
    .I3(sig00000073),
    .I4(sig00000074),
    .I5(sig00000071),
    .O(sig00000124)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000195 (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig00000132),
    .I3(sig00000136),
    .O(sig00000109)
  );
  LUT5 #(
    .INIT ( 32'h76325410 ))
  blk00000196 (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig0000012c),
    .I3(sig00000130),
    .I4(sig00000134),
    .O(sig0000010f)
  );
  LUT5 #(
    .INIT ( 32'h76325410 ))
  blk00000197 (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig0000012d),
    .I3(sig00000131),
    .I4(sig00000135),
    .O(sig0000010e)
  );
  LUT5 #(
    .INIT ( 32'h76325410 ))
  blk00000198 (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig0000012b),
    .I3(sig0000012f),
    .I4(sig00000133),
    .O(sig00000110)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000199 (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig0000012f),
    .I3(sig00000133),
    .O(sig0000010c)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk0000019a (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig00000130),
    .I3(sig00000134),
    .O(sig0000010b)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk0000019b (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig00000131),
    .I3(sig00000135),
    .O(sig0000010a)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF8880 ))
  blk0000019c (
    .I0(sig00000104),
    .I1(sig00000103),
    .I2(sig00000128),
    .I3(sig00000129),
    .I4(sig0000012a),
    .I5(sig00000144),
    .O(sig00000120)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000019d (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig00000134),
    .O(sig00000107)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000019e (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig00000135),
    .O(sig00000106)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000019f (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig00000136),
    .O(sig00000105)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001a0 (
    .I0(sig00000103),
    .I1(sig00000104),
    .I2(sig00000133),
    .O(sig00000108)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  blk000001a1 (
    .I0(sig0000012b),
    .I1(sig0000012c),
    .I2(sig0000012d),
    .O(sig00000150)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000001a2 (
    .I0(sig0000012e),
    .I1(sig0000012f),
    .I2(sig00000130),
    .I3(sig00000131),
    .O(sig00000151)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000001a3 (
    .I0(sig00000132),
    .I1(sig00000133),
    .I2(sig00000134),
    .I3(sig00000135),
    .O(sig00000152)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  blk000001a4 (
    .I0(sig00000129),
    .I1(sig0000012b),
    .O(sig00000154)
  );
  LUT3 #(
    .INIT ( 8'h1F ))
  blk000001a5 (
    .I0(sig0000012f),
    .I1(sig0000012e),
    .I2(sig00000129),
    .O(sig00000155)
  );
  LUT3 #(
    .INIT ( 8'h1F ))
  blk000001a6 (
    .I0(sig00000133),
    .I1(sig00000132),
    .I2(sig00000129),
    .O(sig00000156)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  blk000001a7 (
    .I0(sig00000129),
    .I1(sig00000136),
    .O(sig00000157)
  );
  LUT5 #(
    .INIT ( 32'h0FF02DD2 ))
  blk000001a8 (
    .I0(sig00000113),
    .I1(sig00000126),
    .I2(sig0000017f),
    .I3(sig00000137),
    .I4(sig00000125),
    .O(sig0000016a)
  );
  LUT5 #(
    .INIT ( 32'h0FF02DD2 ))
  blk000001a9 (
    .I0(sig00000112),
    .I1(sig00000126),
    .I2(sig00000137),
    .I3(sig00000180),
    .I4(sig00000125),
    .O(sig0000016b)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk000001aa (
    .I0(sig00000182),
    .I1(sig0000011c),
    .I2(sig0000011a),
    .I3(sig00000126),
    .I4(sig00000125),
    .I5(sig00000137),
    .O(sig0000016e)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk000001ab (
    .I0(sig00000183),
    .I1(sig0000011b),
    .I2(sig00000119),
    .I3(sig00000126),
    .I4(sig00000125),
    .I5(sig00000137),
    .O(sig0000016f)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk000001ac (
    .I0(sig00000185),
    .I1(sig00000119),
    .I2(sig00000117),
    .I3(sig00000126),
    .I4(sig00000125),
    .I5(sig00000137),
    .O(sig00000171)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk000001ad (
    .I0(sig0000017a),
    .I1(sig00000118),
    .I2(sig00000116),
    .I3(sig00000126),
    .I4(sig00000125),
    .I5(sig00000137),
    .O(sig00000165)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk000001ae (
    .I0(sig00000184),
    .I1(sig0000011a),
    .I2(sig00000118),
    .I3(sig00000126),
    .I4(sig00000125),
    .I5(sig00000137),
    .O(sig00000170)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk000001af (
    .I0(sig0000017c),
    .I1(sig00000116),
    .I2(sig00000114),
    .I3(sig00000126),
    .I4(sig00000125),
    .I5(sig00000137),
    .O(sig00000167)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000001b0 (
    .I0(sig00000125),
    .I1(sig0000017d),
    .I2(sig00000137),
    .I3(sig00000126),
    .I4(sig00000113),
    .I5(sig00000115),
    .O(sig00000168)
  );
  LUT6 #(
    .INIT ( 64'h5555A599AAAA5A66 ))
  blk000001b1 (
    .I0(sig0000017b),
    .I1(sig00000117),
    .I2(sig00000115),
    .I3(sig00000126),
    .I4(sig00000125),
    .I5(sig00000137),
    .O(sig00000166)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000001b2 (
    .I0(sig00000125),
    .I1(sig0000017e),
    .I2(sig00000137),
    .I3(sig00000126),
    .I4(sig00000112),
    .I5(sig00000114),
    .O(sig00000169)
  );
  LUT5 #(
    .INIT ( 32'hF3F50C0A ))
  blk000001b3 (
    .I0(sig0000011d),
    .I1(sig0000011b),
    .I2(sig00000125),
    .I3(sig00000126),
    .I4(sig00000137),
    .O(sig0000016d)
  );
  LUT5 #(
    .INIT ( 32'hF3F50C0A ))
  blk000001b4 (
    .I0(sig0000011e),
    .I1(sig0000011c),
    .I2(sig00000125),
    .I3(sig00000126),
    .I4(sig00000137),
    .O(sig0000016c)
  );
  LUT5 #(
    .INIT ( 32'h01010100 ))
  blk000001b5 (
    .I0(sig000001b7),
    .I1(sig0000001b),
    .I2(sig0000001a),
    .I3(sig0000001d),
    .I4(sig0000001c),
    .O(sig000001aa)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000001b6 (
    .I0(sig000001b7),
    .I1(sig000001b8),
    .I2(sig00000010),
    .O(sig00000011)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001b7 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .O(sig000001a5)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001b8 (
    .I0(sig000001b6),
    .I1(sig000001b7),
    .O(sig000001a6)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001b9 (
    .I0(sig00000010),
    .I1(sig000001b6),
    .O(sig000001b1)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000001ba (
    .I0(sig0000004a),
    .I1(sig00000049),
    .I2(sig00000048),
    .I3(sig00000047),
    .O(sig000001b2)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000001bb (
    .I0(sig00000046),
    .I1(sig00000045),
    .I2(sig00000044),
    .I3(sig00000043),
    .O(sig000001b3)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000001bc (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(sig00000042),
    .I3(sig00000041),
    .O(sig000001b4)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk000001bd (
    .I0(sig0000003e),
    .I1(sig0000003d),
    .O(sig000001b5)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000001be (
    .I0(sig00000022),
    .I1(sig00000023),
    .I2(sig00000024),
    .I3(sig00000025),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001bc)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000001bf (
    .I0(sig00000021),
    .I1(sig00000022),
    .I2(sig00000023),
    .I3(sig00000024),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001bd)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001c0 (
    .I0(sig00000023),
    .I1(sig00000025),
    .I2(sig00000026),
    .I3(sig00000024),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001bb)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001c1 (
    .I0(sig00000024),
    .I1(sig00000026),
    .I2(sig00000027),
    .I3(sig00000025),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001ba)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001c2 (
    .I0(sig00000025),
    .I1(sig00000027),
    .I2(sig00000028),
    .I3(sig00000026),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001b9)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001c3 (
    .I0(sig00000026),
    .I1(sig00000028),
    .I2(sig00000029),
    .I3(sig00000027),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001c2)
  );
  LUT6 #(
    .INIT ( 64'hFF00F0F0CCCCAAAA ))
  blk000001c4 (
    .I0(sig00000027),
    .I1(sig00000029),
    .I2(sig00000028),
    .I3(sig0000002a),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001c1)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000001c5 (
    .I0(sig00000028),
    .I1(sig00000029),
    .I2(sig0000002a),
    .I3(sig0000002b),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001c0)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk000001c6 (
    .I0(sig00000029),
    .I1(sig0000002b),
    .I2(sig0000002c),
    .I3(sig0000002a),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001bf)
  );
  LUT6 #(
    .INIT ( 64'hAAAAFF00F0F0CCCC ))
  blk000001c7 (
    .I0(sig0000002d),
    .I1(sig0000002a),
    .I2(sig0000002c),
    .I3(sig0000002b),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001be)
  );
  LUT6 #(
    .INIT ( 64'hAAAAFF00F0F0CCCC ))
  blk000001c8 (
    .I0(sig0000002d),
    .I1(sig0000002a),
    .I2(sig0000002c),
    .I3(sig0000002b),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig000001ce)
  );
  LUT5 #(
    .INIT ( 32'h00CCAAF0 ))
  blk000001c9 (
    .I0(sig0000002d),
    .I1(sig0000002c),
    .I2(sig0000002b),
    .I3(sig00000012),
    .I4(sig00000013),
    .O(sig000001cd)
  );
  LUT4 #(
    .INIT ( 16'hF5F1 ))
  blk000001ca (
    .I0(sig0000002d),
    .I1(sig0000002c),
    .I2(sig00000012),
    .I3(sig00000013),
    .O(sig000001cc)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001cb (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000030),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [0]),
    .O(sig000001ee)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001cc (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000031),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [1]),
    .O(sig000001ef)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001cd (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000032),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [2]),
    .O(sig000001f0)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001ce (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000033),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [3]),
    .O(sig000001f1)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001cf (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000034),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [4]),
    .O(sig000001f2)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001d0 (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000035),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [5]),
    .O(sig000001f3)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001d1 (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000036),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [6]),
    .O(sig000001f4)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001d2 (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000037),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [7]),
    .O(sig000001f5)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000001d3 (
    .I0(ce),
    .I1(sig00000070),
    .I2(sig00000038),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [8]),
    .O(sig000001f6)
  );
  LUT4 #(
    .INIT ( 16'h5445 ))
  blk000001d4 (
    .I0(sig0000006d),
    .I1(sig0000006c),
    .I2(sig00000067),
    .I3(sig000001c4),
    .O(sig000001e9)
  );
  LUT5 #(
    .INIT ( 32'h54544554 ))
  blk000001d5 (
    .I0(sig0000006d),
    .I1(sig0000006c),
    .I2(sig00000068),
    .I3(sig00000067),
    .I4(sig000001c4),
    .O(sig000001ea)
  );
  LUT6 #(
    .INIT ( 64'h5544554445545544 ))
  blk000001d6 (
    .I0(sig0000006d),
    .I1(sig0000006c),
    .I2(sig00000068),
    .I3(sig00000069),
    .I4(sig00000067),
    .I5(sig000001c4),
    .O(sig000001eb)
  );
  LUT5 #(
    .INIT ( 32'h77752220 ))
  blk000001d7 (
    .I0(ce),
    .I1(sig0000006f),
    .I2(sig0000006e),
    .I3(sig00000039),
    .I4(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/mant_op [9]),
    .O(sig000001f7)
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  blk000001d8 (
    .I0(sig00000064),
    .I1(sig00000066),
    .I2(sig000001c4),
    .O(sig000001f8)
  );
  LUT3 #(
    .INIT ( 8'hAE ))
  blk000001d9 (
    .I0(sig00000063),
    .I1(sig00000065),
    .I2(sig000001c4),
    .O(sig000001f9)
  );
  LUT3 #(
    .INIT ( 8'hA9 ))
  blk000001da (
    .I0(sig000001fb),
    .I1(sig000001fc),
    .I2(sig000001fa),
    .O(sig000001fe)
  );
  LUT4 #(
    .INIT ( 16'hCCC9 ))
  blk000001db (
    .I0(sig000001fb),
    .I1(sig00000204),
    .I2(sig000001fc),
    .I3(sig000001fa),
    .O(sig000001fd)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000001dc (
    .I0(sig000001fc),
    .I1(sig000001fa),
    .O(sig000001ff)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk000001dd (
    .I0(sig00000204),
    .I1(ce),
    .I2(sig00000205),
    .O(sig00000201)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001de (
    .I0(operation_nd),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ),
    .O(sig00000206)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk000001df (
    .I0(sig000000cd),
    .I1(sig000000cb),
    .I2(sig000000cc),
    .O(sig00000208)
  );
  LUT5 #(
    .INIT ( 32'hAA0BAA08 ))
  blk000001e0 (
    .I0(sig000000ce),
    .I1(sig000000cf),
    .I2(sig000000d0),
    .I3(sig000000d1),
    .I4(sig00000208),
    .O(sig000000a9)
  );
  LUT5 #(
    .INIT ( 32'h8888F000 ))
  blk000001e1 (
    .I0(sig0000015b),
    .I1(sig0000015e),
    .I2(sig0000015d),
    .I3(sig00000160),
    .I4(sig00000159),
    .O(sig00000209)
  );
  LUT6 #(
    .INIT ( 64'hFBBBEAAA51114000 ))
  blk000001e2 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig0000015f),
    .I3(sig0000015c),
    .I4(sig0000015a),
    .I5(sig00000209),
    .O(sig00000127)
  );
  LUT4 #(
    .INIT ( 16'hAAFB ))
  blk000001e3 (
    .I0(sig00000084),
    .I1(sig00000015),
    .I2(sig00000014),
    .I3(sig00000085),
    .O(sig0000020a)
  );
  LUT6 #(
    .INIT ( 64'h2222020077775755 ))
  blk000001e4 (
    .I0(sig000001b8),
    .I1(sig00000016),
    .I2(sig00000018),
    .I3(sig00000019),
    .I4(sig00000017),
    .I5(sig0000020a),
    .O(sig000001a7)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk000001e5 (
    .I0(sig00000084),
    .I1(sig00000015),
    .I2(sig00000014),
    .I3(sig00000085),
    .O(sig0000020b)
  );
  LUT6 #(
    .INIT ( 64'h0404040037373733 ))
  blk000001e6 (
    .I0(sig00000016),
    .I1(sig000001b8),
    .I2(sig00000017),
    .I3(sig00000019),
    .I4(sig00000018),
    .I5(sig0000020b),
    .O(sig000001a8)
  );
  LUT2 #(
    .INIT ( 4'hB ))
  blk000001e7 (
    .I0(sig0000001e),
    .I1(sig0000001f),
    .O(sig0000020c)
  );
  LUT6 #(
    .INIT ( 64'h10111010DCDDDCDC ))
  blk000001e8 (
    .I0(sig0000001a),
    .I1(sig000001b7),
    .I2(sig0000001b),
    .I3(sig0000001c),
    .I4(sig0000001d),
    .I5(sig0000020c),
    .O(sig000001a9)
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  blk000001e9 (
    .I0(sig0000006a),
    .I1(sig00000069),
    .I2(sig00000068),
    .O(sig0000020d)
  );
  LUT6 #(
    .INIT ( 64'h00FA00F600FA00FA ))
  blk000001ea (
    .I0(sig0000006b),
    .I1(sig00000067),
    .I2(sig0000006c),
    .I3(sig0000006d),
    .I4(sig000001c4),
    .I5(sig0000020d),
    .O(sig000001ed)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000001eb (
    .I0(sig00000069),
    .I1(sig00000068),
    .O(sig0000020e)
  );
  LUT6 #(
    .INIT ( 64'h00FA00F600FA00FA ))
  blk000001ec (
    .I0(sig0000006a),
    .I1(sig00000067),
    .I2(sig0000006c),
    .I3(sig0000006d),
    .I4(sig000001c4),
    .I5(sig0000020e),
    .O(sig000001ec)
  );
  FDE   blk000001ed (
    .C(clk),
    .CE(ce),
    .D(sig0000005f),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/sign_op )
  );
  FD #(
    .INIT ( 1'b1 ))
  blk000001ee (
    .C(clk),
    .D(sig0000020f),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000001ef (
    .I0(sig00000020),
    .O(sig00000210)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000001f0 (
    .I0(sig00000137),
    .O(sig00000211)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000001f1 (
    .C(clk),
    .D(sig00000212),
    .Q(sig00000205)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000001f2 (
    .C(clk),
    .D(sig00000213),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  LUT6 #(
    .INIT ( 64'hDDDD4D4D4DDD444D ))
  blk000001f3 (
    .I0(sig000000b9),
    .I1(sig0000003a),
    .I2(sig000000b8),
    .I3(sig000000b7),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig00000207)
  );
  LUT4 #(
    .INIT ( 16'hFFF8 ))
  blk000001f4 (
    .I0(sig000000b6),
    .I1(sig000000df),
    .I2(sig000000ca),
    .I3(sig000000c9),
    .O(sig00000214)
  );
  LUT5 #(
    .INIT ( 32'h0000FF8F ))
  blk000001f5 (
    .I0(sig000000df),
    .I1(sig000000b6),
    .I2(sig000000bb),
    .I3(sig0000002f),
    .I4(sig000000c9),
    .O(sig00000215)
  );
  LUT4 #(
    .INIT ( 16'h00F8 ))
  blk000001f6 (
    .I0(sig000000b6),
    .I1(sig000000df),
    .I2(sig0000002f),
    .I3(sig000000c9),
    .O(sig00000216)
  );
  LUT4 #(
    .INIT ( 16'hFFF7 ))
  blk000001f7 (
    .I0(sig000000b6),
    .I1(sig000000df),
    .I2(sig000000ca),
    .I3(sig0000002f),
    .O(sig00000217)
  );
  LUT6 #(
    .INIT ( 64'h2BBB222B2B2B2222 ))
  blk000001f8 (
    .I0(sig0000003a),
    .I1(sig000000b9),
    .I2(sig000000b8),
    .I3(sig000000b7),
    .I4(sig00000012),
    .I5(sig00000013),
    .O(sig00000079)
  );
  LUT5 #(
    .INIT ( 32'h45000400 ))
  blk000001f9 (
    .I0(sig000000bb),
    .I1(sig0000003b),
    .I2(sig000000ba),
    .I3(sig00000077),
    .I4(sig00000079),
    .O(sig0000009c)
  );
  LUT4 #(
    .INIT ( 16'h599A ))
  blk000001fa (
    .I0(sig000000bb),
    .I1(sig000000ba),
    .I2(sig0000003b),
    .I3(sig00000079),
    .O(sig000000b3)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  blk000001fb (
    .I0(sig000000ba),
    .I1(sig0000003b),
    .I2(sig00000079),
    .O(sig000000b2)
  );
  LUT4 #(
    .INIT ( 16'hFF2A ))
  blk000001fc (
    .I0(sig00000205),
    .I1(sig00000204),
    .I2(ce),
    .I3(sclr),
    .O(sig00000212)
  );
  LUT5 #(
    .INIT ( 32'h10105410 ))
  blk000001fd (
    .I0(sclr),
    .I1(ce),
    .I2(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY ),
    .I3(sig00000203),
    .I4(sig00000205),
    .O(sig00000213)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk000001fe (
    .I0(sclr),
    .I1(ce),
    .I2(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ),
    .O(sig0000020f)
  );
  LUT6 #(
    .INIT ( 64'h6999696966696666 ))
  blk000001ff (
    .I0(sig0000003a),
    .I1(sig000000b9),
    .I2(sig000000b8),
    .I3(sig000000b7),
    .I4(sig00000013),
    .I5(sig00000012),
    .O(sig000000b1)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000200 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig0000001b),
    .I3(sig0000001f),
    .O(sig00000007)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000201 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig0000001a),
    .I3(sig0000001e),
    .O(sig00000008)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000202 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig00000018),
    .I3(sig0000001c),
    .O(sig0000000a)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000203 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig00000019),
    .I3(sig0000001d),
    .O(sig00000009)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000204 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig0000001c),
    .O(sig00000006)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000205 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig0000001d),
    .O(sig00000005)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000206 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig0000001e),
    .O(sig00000004)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000207 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig0000001f),
    .O(sig00000003)
  );
  LUT6 #(
    .INIT ( 64'h5140FBEA51405140 ))
  blk00000208 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig00000018),
    .I3(sig00000014),
    .I4(sig000001b7),
    .I5(sig0000001c),
    .O(sig0000000e)
  );
  LUT6 #(
    .INIT ( 64'h5140FBEA51405140 ))
  blk00000209 (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig00000019),
    .I3(sig00000015),
    .I4(sig000001b7),
    .I5(sig0000001d),
    .O(sig0000000d)
  );
  LUT6 #(
    .INIT ( 64'h5140FBEA51405140 ))
  blk0000020a (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig0000001a),
    .I3(sig00000016),
    .I4(sig000001b7),
    .I5(sig0000001e),
    .O(sig0000000c)
  );
  LUT6 #(
    .INIT ( 64'h5140FBEA51405140 ))
  blk0000020b (
    .I0(sig00000010),
    .I1(sig000001b8),
    .I2(sig0000001b),
    .I3(sig00000017),
    .I4(sig000001b7),
    .I5(sig0000001f),
    .O(sig0000000b)
  );
  LUT5 #(
    .INIT ( 32'h00000008 ))
  blk0000020c (
    .I0(sig000000df),
    .I1(sig000000b6),
    .I2(sig000000ca),
    .I3(sig000000c9),
    .I4(sig0000002f),
    .O(sig0000009b)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000020 ))
  blk0000020d (
    .I0(sig000000de),
    .I1(sig000000df),
    .I2(sig000000b6),
    .I3(sig000000ca),
    .I4(sig000000c9),
    .I5(sig0000002f),
    .O(sig0000009d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000020e (
    .I0(sig000000b7),
    .I1(sig00000013),
    .O(sig000000af)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk0000020f (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig00000055),
    .I4(sig0000004b),
    .O(sig00000145)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000210 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig00000056),
    .I4(sig0000004c),
    .O(sig00000146)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000211 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig00000057),
    .I4(sig0000004d),
    .O(sig00000147)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000212 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig00000058),
    .I4(sig0000004e),
    .O(sig00000148)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000213 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig00000059),
    .I4(sig0000004f),
    .O(sig00000149)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000214 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig0000005a),
    .I4(sig00000050),
    .O(sig0000014a)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000215 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig0000005b),
    .I4(sig00000051),
    .O(sig0000014b)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000216 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig0000005c),
    .I4(sig00000052),
    .O(sig0000014c)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000217 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig0000005d),
    .I4(sig00000053),
    .O(sig0000014d)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk00000218 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .I2(sig00000062),
    .I3(sig0000005e),
    .I4(sig00000054),
    .O(sig0000014e)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  blk00000219 (
    .I0(sig000000e0),
    .I1(sig000000e2),
    .O(sig0000014f)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFF45FFFFFF04 ))
  blk0000021a (
    .I0(sig000000bb),
    .I1(sig0000003b),
    .I2(sig000000ba),
    .I3(sig0000002f),
    .I4(sig00000214),
    .I5(sig00000207),
    .O(sig0000007e)
  );
  LUT6 #(
    .INIT ( 64'hFFFBF4F0FFF2FDF0 ))
  blk0000021b (
    .I0(sig0000003b),
    .I1(sig000000ba),
    .I2(sig000000ca),
    .I3(sig00000216),
    .I4(sig00000215),
    .I5(sig00000207),
    .O(sig000000b5)
  );
  LUT6 #(
    .INIT ( 64'hFF00FFBAFF00FFFB ))
  blk0000021c (
    .I0(sig000000bb),
    .I1(sig0000003b),
    .I2(sig000000ba),
    .I3(sig000000c9),
    .I4(sig00000217),
    .I5(sig00000207),
    .O(sig000000b4)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  blk0000021d (
    .I0(b[13]),
    .I1(a[13]),
    .I2(sig00000078),
    .O(sig000000a4)
  );
  LUT5 #(
    .INIT ( 32'hF7755110 ))
  blk0000021e (
    .I0(b[14]),
    .I1(b[13]),
    .I2(a[13]),
    .I3(sig00000078),
    .I4(a[14]),
    .O(sig000000a6)
  );
  LUT5 #(
    .INIT ( 32'h99696966 ))
  blk0000021f (
    .I0(b[14]),
    .I1(a[14]),
    .I2(b[13]),
    .I3(a[13]),
    .I4(sig00000078),
    .O(sig000000a5)
  );
  LUT4 #(
    .INIT ( 16'h6696 ))
  blk00000220 (
    .I0(sig000000b8),
    .I1(sig00000012),
    .I2(sig00000013),
    .I3(sig000000b7),
    .O(sig000000b0)
  );
  LUT4 #(
    .INIT ( 16'h6696 ))
  blk00000221 (
    .I0(b[11]),
    .I1(a[11]),
    .I2(a[10]),
    .I3(b[10]),
    .O(sig000000a2)
  );
  LUT6 #(
    .INIT ( 64'h6999696966696666 ))
  blk00000222 (
    .I0(b[12]),
    .I1(a[12]),
    .I2(b[11]),
    .I3(b[10]),
    .I4(a[10]),
    .I5(a[11]),
    .O(sig000000a3)
  );
  LUT6 #(
    .INIT ( 64'h08FF0008AEFF00AE ))
  blk00000223 (
    .I0(a[11]),
    .I1(a[10]),
    .I2(b[10]),
    .I3(b[12]),
    .I4(a[12]),
    .I5(b[11]),
    .O(sig00000078)
  );
  MUXF7   blk00000224 (
    .I0(sig00000218),
    .I1(sig00000219),
    .S(sig00000207),
    .O(sig00000080)
  );
  LUT6 #(
    .INIT ( 64'h5454545554545454 ))
  blk00000225 (
    .I0(sig000000c9),
    .I1(sig000000ca),
    .I2(sig0000002f),
    .I3(sig000000bb),
    .I4(sig000000ba),
    .I5(sig0000003b),
    .O(sig00000218)
  );
  LUT6 #(
    .INIT ( 64'h5555555555551101 ))
  blk00000226 (
    .I0(sig000000c9),
    .I1(sig000000bb),
    .I2(sig000000ba),
    .I3(sig0000003b),
    .I4(sig0000002f),
    .I5(sig000000ca),
    .O(sig00000219)
  );
  INV   blk00000227 (
    .I(sig00000071),
    .O(sig00000143)
  );
  INV   blk00000228 (
    .I(sig00000136),
    .O(sig00000153)
  );
  INV   blk00000229 (
    .I(sig000001fa),
    .O(sig00000200)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000022a (
    .A0(sig00000001),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig00000082),
    .Q(sig0000021a),
    .Q15(NLW_blk0000022a_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000022b (
    .C(clk),
    .CE(ce),
    .D(sig0000021a),
    .Q(sig000000c8)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000022c (
    .A0(sig00000002),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig0000003c),
    .Q(sig0000021b),
    .Q15(NLW_blk0000022c_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000022d (
    .C(clk),
    .CE(ce),
    .D(sig0000021b),
    .Q(sig00000020)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000022e (
    .A0(sig00000001),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig00000081),
    .Q(sig0000021c),
    .Q15(NLW_blk0000022e_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000022f (
    .C(clk),
    .CE(ce),
    .D(sig0000021c),
    .Q(sig000000b6)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000230 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000c0),
    .Q(sig0000021d),
    .Q15(NLW_blk00000230_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000231 (
    .C(clk),
    .CE(ce),
    .D(sig0000021d),
    .Q(sig000000bb)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000232 (
    .A0(sig00000001),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000fd),
    .Q(sig0000021e),
    .Q15(NLW_blk00000232_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000233 (
    .C(clk),
    .CE(ce),
    .D(sig0000021e),
    .Q(sig000000ca)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000234 (
    .A0(sig00000001),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000fc),
    .Q(sig0000021f),
    .Q15(NLW_blk00000234_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000235 (
    .C(clk),
    .CE(ce),
    .D(sig0000021f),
    .Q(sig000000c9)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000236 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000bd),
    .Q(sig00000220),
    .Q15(NLW_blk00000236_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000237 (
    .C(clk),
    .CE(ce),
    .D(sig00000220),
    .Q(sig000000b8)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000238 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000bf),
    .Q(sig00000221),
    .Q15(NLW_blk00000238_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000239 (
    .C(clk),
    .CE(ce),
    .D(sig00000221),
    .Q(sig000000ba)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000023a (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000be),
    .Q(sig00000222),
    .Q15(NLW_blk0000023a_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000023b (
    .C(clk),
    .CE(ce),
    .D(sig00000222),
    .Q(sig000000b9)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000023c (
    .A0(sig00000002),
    .A1(sig00000002),
    .A2(sig00000001),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig00000202),
    .Q(sig00000223),
    .Q15(NLW_blk0000023c_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000023d (
    .C(clk),
    .CE(ce),
    .D(sig00000223),
    .Q(sig00000203)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000023e (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000bc),
    .Q(sig00000224),
    .Q15(NLW_blk0000023e_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000023f (
    .C(clk),
    .CE(ce),
    .D(sig00000224),
    .Q(sig000000b7)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk00000240 (
    .A0(sig00000001),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig00000083),
    .Q(sig00000225),
    .Q15(NLW_blk00000240_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000241 (
    .C(clk),
    .CE(ce),
    .D(sig00000225),
    .Q(\U0/op_inst/FLT_PT_OP/ADDSUB_OP.SPEED_OP.LOGIC.OP/OP/FLAGS_REG.IV_OP_REG/RTL.delay_0 )
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
