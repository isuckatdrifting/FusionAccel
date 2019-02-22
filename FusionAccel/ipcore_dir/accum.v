////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: accum.v
// /___/   /\     Timestamp: Fri Feb 22 17:25:02 2019
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
  operation_nd, operation_rfd, rdy, a, b, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  output operation_rfd;
  output rdy;
  input [15 : 0] a;
  input [15 : 0] b;
  output [15 : 0] result;
  
  // synthesis translate_off
  
  wire NlwRenamedSignal_rdy;
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
  wire NLW_blk0000003a_O_UNCONNECTED;
  wire NLW_blk0000003b_O_UNCONNECTED;
  wire NLW_blk0000005e_O_UNCONNECTED;
  wire NLW_blk0000005f_O_UNCONNECTED;
  wire NLW_blk00000061_O_UNCONNECTED;
  wire NLW_blk00000063_O_UNCONNECTED;
  wire NLW_blk00000065_O_UNCONNECTED;
  assign
    NlwRenamedSignal_rdy = operation_nd,
    operation_rfd = NlwRenamedSig_OI_operation_rfd,
    rdy = NlwRenamedSignal_rdy;
  VCC   blk00000001 (
    .P(NlwRenamedSig_OI_operation_rfd)
  );
  GND   blk00000002 (
    .G(sig00000001)
  );
  MUXCY   blk00000003 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000044),
    .O(sig0000003f)
  );
  MUXCY   blk00000004 (
    .CI(sig0000003f),
    .DI(sig00000001),
    .S(sig00000043),
    .O(sig00000064)
  );
  MUXCY   blk00000005 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000042),
    .O(sig00000040)
  );
  MUXCY   blk00000006 (
    .CI(sig00000040),
    .DI(sig00000001),
    .S(sig00000041),
    .O(sig00000065)
  );
  MUXCY   blk00000007 (
    .CI(sig00000099),
    .DI(sig00000089),
    .S(sig0000008a),
    .O(sig00000088)
  );
  MUXCY   blk00000008 (
    .CI(sig0000009a),
    .DI(sig0000008b),
    .S(sig0000008c),
    .O(sig00000099)
  );
  MUXCY   blk00000009 (
    .CI(sig0000009b),
    .DI(sig0000008d),
    .S(sig0000008e),
    .O(sig0000009a)
  );
  MUXCY   blk0000000a (
    .CI(sig0000009c),
    .DI(sig0000008f),
    .S(sig00000090),
    .O(sig0000009b)
  );
  MUXCY   blk0000000b (
    .CI(sig0000009d),
    .DI(sig00000091),
    .S(sig00000092),
    .O(sig0000009c)
  );
  MUXCY   blk0000000c (
    .CI(sig0000009e),
    .DI(sig00000093),
    .S(sig00000094),
    .O(sig0000009d)
  );
  MUXCY   blk0000000d (
    .CI(sig0000009f),
    .DI(sig00000095),
    .S(sig00000096),
    .O(sig0000009e)
  );
  MUXCY   blk0000000e (
    .CI(sig00000001),
    .DI(sig00000097),
    .S(sig00000098),
    .O(sig0000009f)
  );
  XORCY   blk0000000f (
    .CI(sig000000a0),
    .LI(sig00000001),
    .O(sig00000077)
  );
  XORCY   blk00000010 (
    .CI(sig000000a1),
    .LI(sig00000072),
    .O(sig00000078)
  );
  MUXCY   blk00000011 (
    .CI(sig000000a1),
    .DI(sig00000001),
    .S(sig00000072),
    .O(sig000000a0)
  );
  XORCY   blk00000012 (
    .CI(sig000000a2),
    .LI(sig00000073),
    .O(sig00000079)
  );
  MUXCY   blk00000013 (
    .CI(sig000000a2),
    .DI(sig00000001),
    .S(sig00000073),
    .O(sig000000a1)
  );
  XORCY   blk00000014 (
    .CI(sig000000a3),
    .LI(sig00000074),
    .O(sig0000007a)
  );
  MUXCY   blk00000015 (
    .CI(sig000000a3),
    .DI(sig00000001),
    .S(sig00000074),
    .O(sig000000a2)
  );
  XORCY   blk00000016 (
    .CI(sig000000a4),
    .LI(sig00000075),
    .O(sig0000007b)
  );
  MUXCY   blk00000017 (
    .CI(sig000000a4),
    .DI(sig00000001),
    .S(sig00000075),
    .O(sig000000a3)
  );
  XORCY   blk00000018 (
    .CI(sig00000001),
    .LI(sig00000076),
    .O(sig0000007c)
  );
  MUXCY   blk00000019 (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000076),
    .O(sig000000a4)
  );
  MUXCY   blk0000001a (
    .CI(sig000000b4),
    .DI(sig00000001),
    .S(sig00000060),
    .O(sig000000b3)
  );
  MUXCY   blk0000001b (
    .CI(sig0000007d),
    .DI(sig00000001),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000b4)
  );
  XORCY   blk0000001c (
    .CI(sig000000b5),
    .LI(sig000000b1),
    .O(sig00000020)
  );
  MUXCY   blk0000001d (
    .CI(sig000000b5),
    .DI(sig00000050),
    .S(sig000000b1),
    .O(sig000000b2)
  );
  XORCY   blk0000001e (
    .CI(sig000000b6),
    .LI(sig000000b0),
    .O(sig00000021)
  );
  MUXCY   blk0000001f (
    .CI(sig000000b6),
    .DI(sig00000051),
    .S(sig000000b0),
    .O(sig000000b5)
  );
  XORCY   blk00000020 (
    .CI(sig000000b7),
    .LI(sig000000af),
    .O(sig00000022)
  );
  MUXCY   blk00000021 (
    .CI(sig000000b7),
    .DI(sig00000052),
    .S(sig000000af),
    .O(sig000000b6)
  );
  XORCY   blk00000022 (
    .CI(sig000000b8),
    .LI(sig000000ae),
    .O(sig00000023)
  );
  MUXCY   blk00000023 (
    .CI(sig000000b8),
    .DI(sig00000053),
    .S(sig000000ae),
    .O(sig000000b7)
  );
  XORCY   blk00000024 (
    .CI(sig000000b9),
    .LI(sig000000ad),
    .O(sig00000024)
  );
  MUXCY   blk00000025 (
    .CI(sig000000b9),
    .DI(sig00000001),
    .S(sig000000ad),
    .O(sig000000b8)
  );
  XORCY   blk00000026 (
    .CI(sig000000b3),
    .LI(sig000000ac),
    .O(sig00000025)
  );
  MUXCY   blk00000027 (
    .CI(sig000000b3),
    .DI(sig00000001),
    .S(sig000000ac),
    .O(sig000000b9)
  );
  XORCY   blk00000028 (
    .CI(sig000000ba),
    .LI(sig00000106),
    .O(sig00000018)
  );
  XORCY   blk00000029 (
    .CI(sig000000bb),
    .LI(sig000000ab),
    .O(sig00000019)
  );
  MUXCY   blk0000002a (
    .CI(sig000000bb),
    .DI(sig00000049),
    .S(sig000000ab),
    .O(sig000000ba)
  );
  XORCY   blk0000002b (
    .CI(sig000000bc),
    .LI(sig000000aa),
    .O(sig0000001a)
  );
  MUXCY   blk0000002c (
    .CI(sig000000bc),
    .DI(sig0000004a),
    .S(sig000000aa),
    .O(sig000000bb)
  );
  XORCY   blk0000002d (
    .CI(sig000000bd),
    .LI(sig000000a9),
    .O(sig0000001b)
  );
  MUXCY   blk0000002e (
    .CI(sig000000bd),
    .DI(sig0000004b),
    .S(sig000000a9),
    .O(sig000000bc)
  );
  XORCY   blk0000002f (
    .CI(sig000000be),
    .LI(sig000000a8),
    .O(sig0000001c)
  );
  MUXCY   blk00000030 (
    .CI(sig000000be),
    .DI(sig0000004c),
    .S(sig000000a8),
    .O(sig000000bd)
  );
  XORCY   blk00000031 (
    .CI(sig000000bf),
    .LI(sig000000a7),
    .O(sig0000001d)
  );
  MUXCY   blk00000032 (
    .CI(sig000000bf),
    .DI(sig0000004d),
    .S(sig000000a7),
    .O(sig000000be)
  );
  XORCY   blk00000033 (
    .CI(sig000000c0),
    .LI(sig000000a6),
    .O(sig0000001e)
  );
  MUXCY   blk00000034 (
    .CI(sig000000c0),
    .DI(sig0000004e),
    .S(sig000000a6),
    .O(sig000000bf)
  );
  XORCY   blk00000035 (
    .CI(sig000000b2),
    .LI(sig000000a5),
    .O(sig0000001f)
  );
  MUXCY   blk00000036 (
    .CI(sig000000b2),
    .DI(sig0000004f),
    .S(sig000000a5),
    .O(sig000000c0)
  );
  MUXCY   blk00000037 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000c7),
    .O(sig000000c3)
  );
  MUXCY   blk00000038 (
    .CI(sig000000c3),
    .DI(sig00000001),
    .S(sig000000c6),
    .O(sig000000c2)
  );
  MUXCY   blk00000039 (
    .CI(sig000000c2),
    .DI(sig00000001),
    .S(sig000000c5),
    .O(sig000000c1)
  );
  MUXCY   blk0000003a (
    .CI(sig000000c1),
    .DI(sig00000001),
    .S(sig000000c4),
    .O(NLW_blk0000003a_O_UNCONNECTED)
  );
  MUXF7   blk0000003b (
    .I0(sig000000c8),
    .I1(sig000000c9),
    .S(sig00000014),
    .O(NLW_blk0000003b_O_UNCONNECTED)
  );
  MUXCY   blk0000003c (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000d3),
    .O(sig000000d0)
  );
  MUXCY   blk0000003d (
    .CI(sig000000d0),
    .DI(sig00000001),
    .S(sig000000d4),
    .O(sig000000cf)
  );
  MUXCY   blk0000003e (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000d1),
    .O(sig000000ce)
  );
  MUXCY   blk0000003f (
    .CI(sig000000ce),
    .DI(sig00000001),
    .S(sig000000d2),
    .O(sig00000014)
  );
  MUXF7   blk00000040 (
    .I0(sig000000ca),
    .I1(sig000000cc),
    .S(sig00000014),
    .O(sig00000017)
  );
  MUXF7   blk00000041 (
    .I0(sig000000cb),
    .I1(sig000000cd),
    .S(sig00000014),
    .O(sig00000016)
  );
  MUXCY   blk00000042 (
    .CI(sig000000e6),
    .DI(sig00000001),
    .S(sig000000dc),
    .O(sig000000d5)
  );
  XORCY   blk00000043 (
    .CI(sig000000e6),
    .LI(sig000000dc),
    .O(sig00000083)
  );
  MUXCY   blk00000044 (
    .CI(sig000000d5),
    .DI(sig00000001),
    .S(sig000000dd),
    .O(sig000000d6)
  );
  XORCY   blk00000045 (
    .CI(sig000000d5),
    .LI(sig000000dd),
    .O(sig00000084)
  );
  MUXCY   blk00000046 (
    .CI(sig000000d6),
    .DI(sig00000001),
    .S(sig000000de),
    .O(sig000000d7)
  );
  XORCY   blk00000047 (
    .CI(sig000000d6),
    .LI(sig000000de),
    .O(sig00000085)
  );
  MUXCY   blk00000048 (
    .CI(sig000000d7),
    .DI(sig00000001),
    .S(sig000000df),
    .O(sig000000d8)
  );
  XORCY   blk00000049 (
    .CI(sig000000d7),
    .LI(sig000000df),
    .O(sig00000086)
  );
  MUXCY   blk0000004a (
    .CI(sig000000d8),
    .DI(sig00000001),
    .S(sig000000e0),
    .O(sig000000d9)
  );
  XORCY   blk0000004b (
    .CI(sig000000d8),
    .LI(sig000000e0),
    .O(sig00000087)
  );
  MUXCY   blk0000004c (
    .CI(sig000000d9),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000da)
  );
  XORCY   blk0000004d (
    .CI(sig000000d9),
    .LI(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000db)
  );
  MUXCY   blk0000004e (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000ef),
    .O(sig000000e8)
  );
  MUXCY   blk0000004f (
    .CI(sig000000e8),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig000000ed),
    .O(sig000000e9)
  );
  MUXCY   blk00000050 (
    .CI(sig000000e9),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000105),
    .O(sig000000ea)
  );
  MUXCY   blk00000051 (
    .CI(sig000000ea),
    .DI(sig00000001),
    .S(sig000000ee),
    .O(sig000000eb)
  );
  MUXCY   blk00000052 (
    .CI(sig000000eb),
    .DI(sig00000001),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000ec)
  );
  MUXCY   blk00000053 (
    .CI(sig000000ec),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig000000e7)
  );
  XORCY   blk00000054 (
    .CI(sig000000f0),
    .LI(sig000000e5),
    .O(sig00000082)
  );
  MUXCY   blk00000055 (
    .CI(sig000000f0),
    .DI(sig00000001),
    .S(sig000000e5),
    .O(sig000000e6)
  );
  XORCY   blk00000056 (
    .CI(sig000000f1),
    .LI(sig000000e4),
    .O(sig00000081)
  );
  MUXCY   blk00000057 (
    .CI(sig000000f1),
    .DI(sig00000001),
    .S(sig000000e4),
    .O(sig000000f0)
  );
  XORCY   blk00000058 (
    .CI(sig000000f2),
    .LI(sig000000e3),
    .O(sig00000080)
  );
  MUXCY   blk00000059 (
    .CI(sig000000f2),
    .DI(sig00000001),
    .S(sig000000e3),
    .O(sig000000f1)
  );
  XORCY   blk0000005a (
    .CI(sig000000f3),
    .LI(sig000000e2),
    .O(sig0000007f)
  );
  MUXCY   blk0000005b (
    .CI(sig000000f3),
    .DI(sig00000001),
    .S(sig000000e2),
    .O(sig000000f2)
  );
  XORCY   blk0000005c (
    .CI(sig000000e7),
    .LI(sig000000e1),
    .O(sig0000007e)
  );
  MUXCY   blk0000005d (
    .CI(sig000000e7),
    .DI(sig00000001),
    .S(sig000000e1),
    .O(sig000000f3)
  );
  XORCY   blk0000005e (
    .CI(sig000000f4),
    .LI(sig00000001),
    .O(NLW_blk0000005e_O_UNCONNECTED)
  );
  XORCY   blk0000005f (
    .CI(sig000000f5),
    .LI(sig00000001),
    .O(NLW_blk0000005f_O_UNCONNECTED)
  );
  MUXCY   blk00000060 (
    .CI(sig000000f5),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000000f4)
  );
  XORCY   blk00000061 (
    .CI(sig000000f6),
    .LI(sig00000001),
    .O(NLW_blk00000061_O_UNCONNECTED)
  );
  MUXCY   blk00000062 (
    .CI(sig000000f6),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000000f5)
  );
  XORCY   blk00000063 (
    .CI(sig000000f7),
    .LI(sig00000001),
    .O(NLW_blk00000063_O_UNCONNECTED)
  );
  MUXCY   blk00000064 (
    .CI(sig000000f7),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000000f6)
  );
  XORCY   blk00000065 (
    .CI(sig000000da),
    .LI(sig00000001),
    .O(NLW_blk00000065_O_UNCONNECTED)
  );
  MUXCY   blk00000066 (
    .CI(sig000000da),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000000f7)
  );
  LUT6 #(
    .INIT ( 64'h6669666966699969 ))
  blk00000067 (
    .I0(sig0000000c),
    .I1(sig0000000f),
    .I2(b[11]),
    .I3(sig00000010),
    .I4(b[10]),
    .I5(sig00000011),
    .O(sig0000000b)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000068 (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[1]),
    .I3(a[1]),
    .I4(a[0]),
    .I5(b[0]),
    .O(sig0000005d)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000069 (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[2]),
    .I3(a[2]),
    .I4(a[1]),
    .I5(b[1]),
    .O(sig0000005c)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000006a (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[9]),
    .I3(a[9]),
    .I4(a[8]),
    .I5(b[8]),
    .O(sig00000055)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000006b (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[8]),
    .I3(a[8]),
    .I4(a[7]),
    .I5(b[7]),
    .O(sig00000056)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000006c (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[5]),
    .I3(a[5]),
    .I4(a[4]),
    .I5(b[4]),
    .O(sig00000059)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000006d (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[6]),
    .I3(a[6]),
    .I4(a[5]),
    .I5(b[5]),
    .O(sig00000058)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000006e (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[4]),
    .I3(a[4]),
    .I4(a[3]),
    .I5(b[3]),
    .O(sig0000005a)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000006f (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[3]),
    .I3(a[3]),
    .I4(a[2]),
    .I5(b[2]),
    .O(sig0000005b)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000070 (
    .I0(sig000000c4),
    .I1(sig00000088),
    .I2(b[7]),
    .I3(a[7]),
    .I4(a[6]),
    .I5(b[6]),
    .O(sig00000057)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFEF ))
  blk00000071 (
    .I0(sig00000066),
    .I1(sig0000006d),
    .I2(sig00000003),
    .I3(sig00000067),
    .I4(sig00000070),
    .I5(sig0000006f),
    .O(sig00000012)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF14445444 ))
  blk00000072 (
    .I0(sig0000006e),
    .I1(sig00000068),
    .I2(sig00000065),
    .I3(sig00000047),
    .I4(sig0000007d),
    .I5(sig0000006c),
    .O(sig0000006f)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF00000400 ))
  blk00000073 (
    .I0(sig00000067),
    .I1(sig0000006d),
    .I2(sig0000006f),
    .I3(sig00000003),
    .I4(sig00000066),
    .I5(sig00000070),
    .O(sig00000071)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000074 (
    .I0(sig0000000c),
    .I1(a[11]),
    .I2(b[11]),
    .O(sig00000075)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000075 (
    .I0(sig0000000c),
    .I1(a[12]),
    .I2(b[12]),
    .O(sig00000074)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000076 (
    .I0(sig0000000c),
    .I1(a[13]),
    .I2(b[13]),
    .O(sig00000073)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000077 (
    .I0(sig0000000c),
    .I1(a[14]),
    .I2(b[14]),
    .O(sig00000072)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000078 (
    .I0(a[10]),
    .I1(b[10]),
    .O(sig000000c4)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000079 (
    .I0(a[15]),
    .I1(b[15]),
    .O(sig0000007d)
  );
  LUT3 #(
    .INIT ( 8'h27 ))
  blk0000007a (
    .I0(sig0000000c),
    .I1(b[10]),
    .I2(a[10]),
    .O(sig00000076)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000007b (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig00000041)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000007c (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig00000042)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000007d (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig00000043)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000007e (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig00000044)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk0000007f (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000045)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk00000080 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000046)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000081 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000047)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk00000082 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000048)
  );
  LUT4 #(
    .INIT ( 16'h22F2 ))
  blk00000083 (
    .I0(sig00000045),
    .I1(sig00000064),
    .I2(sig00000047),
    .I3(sig00000065),
    .O(sig0000006e)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000084 (
    .I0(sig00000079),
    .I1(sig00000014),
    .O(sig00000004)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000085 (
    .I0(sig0000007b),
    .I1(sig00000016),
    .O(sig00000007)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000086 (
    .I0(sig0000007c),
    .I1(sig00000017),
    .O(sig00000008)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000087 (
    .I0(b[14]),
    .I1(a[14]),
    .O(sig0000000d)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000088 (
    .I0(b[12]),
    .I1(a[12]),
    .O(sig0000000f)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000089 (
    .I0(b[11]),
    .I1(a[11]),
    .O(sig00000010)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk0000008a (
    .I0(b[10]),
    .I1(a[10]),
    .O(sig00000011)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000008b (
    .I0(b[13]),
    .I1(a[13]),
    .I2(b[12]),
    .I3(a[12]),
    .O(sig0000008c)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000008c (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig0000008e)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000008d (
    .I0(b[9]),
    .I1(a[9]),
    .I2(b[8]),
    .I3(a[8]),
    .O(sig00000090)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000008e (
    .I0(b[7]),
    .I1(a[7]),
    .I2(b[6]),
    .I3(a[6]),
    .O(sig00000092)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk0000008f (
    .I0(b[5]),
    .I1(a[5]),
    .I2(b[4]),
    .I3(a[4]),
    .O(sig00000094)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000090 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(b[2]),
    .I3(a[2]),
    .O(sig00000096)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  blk00000091 (
    .I0(b[1]),
    .I1(a[1]),
    .I2(b[0]),
    .I3(a[0]),
    .O(sig00000098)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000092 (
    .I0(b[13]),
    .I1(a[13]),
    .I2(b[12]),
    .I3(a[12]),
    .O(sig0000008b)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000093 (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig0000008d)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000094 (
    .I0(b[9]),
    .I1(a[9]),
    .I2(b[8]),
    .I3(a[8]),
    .O(sig0000008f)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000095 (
    .I0(b[7]),
    .I1(a[7]),
    .I2(b[6]),
    .I3(a[6]),
    .O(sig00000091)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000096 (
    .I0(b[5]),
    .I1(a[5]),
    .I2(b[4]),
    .I3(a[4]),
    .O(sig00000093)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000097 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(b[2]),
    .I3(a[2]),
    .O(sig00000095)
  );
  LUT4 #(
    .INIT ( 16'h22B2 ))
  blk00000098 (
    .I0(b[1]),
    .I1(a[1]),
    .I2(b[0]),
    .I3(a[0]),
    .O(sig00000097)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk00000099 (
    .I0(b[14]),
    .I1(a[14]),
    .O(sig00000089)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk0000009a (
    .I0(a[14]),
    .I1(b[14]),
    .O(sig0000008a)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk0000009b (
    .I0(sig0000005f),
    .I1(sig00000053),
    .I2(sig0000007d),
    .I3(sig00000063),
    .I4(sig0000003a),
    .I5(sig0000003c),
    .O(sig000000ae)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk0000009c (
    .I0(sig0000005f),
    .I1(sig00000052),
    .I2(sig0000007d),
    .I3(sig00000063),
    .I4(sig00000039),
    .I5(sig0000003b),
    .O(sig000000af)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk0000009d (
    .I0(sig0000005f),
    .I1(sig00000050),
    .I2(sig0000007d),
    .I3(sig00000063),
    .I4(sig00000037),
    .I5(sig00000039),
    .O(sig000000b1)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk0000009e (
    .I0(sig0000005f),
    .I1(sig0000004f),
    .I2(sig0000007d),
    .I3(sig00000063),
    .I4(sig00000036),
    .I5(sig00000038),
    .O(sig000000a5)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk0000009f (
    .I0(sig0000005f),
    .I1(sig00000051),
    .I2(sig0000007d),
    .I3(sig00000063),
    .I4(sig00000038),
    .I5(sig0000003a),
    .O(sig000000b0)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000a0 (
    .I0(sig0000005f),
    .I1(sig0000004d),
    .I2(sig0000007d),
    .I3(sig00000063),
    .I4(sig00000034),
    .I5(sig00000036),
    .O(sig000000a7)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000a1 (
    .I0(sig0000005f),
    .I1(sig0000007d),
    .I2(sig0000004c),
    .I3(sig00000063),
    .I4(sig00000033),
    .I5(sig00000035),
    .O(sig000000a8)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000a2 (
    .I0(sig0000005f),
    .I1(sig0000004e),
    .I2(sig0000007d),
    .I3(sig00000063),
    .I4(sig00000035),
    .I5(sig00000037),
    .O(sig000000a6)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk000000a3 (
    .I0(sig0000005f),
    .I1(sig0000007d),
    .I2(sig0000004b),
    .I3(sig00000063),
    .I4(sig00000032),
    .I5(sig00000034),
    .O(sig000000a9)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000a4 (
    .I0(sig00000057),
    .I1(sig00000056),
    .I2(sig00000055),
    .I3(sig00000054),
    .O(sig000000c5)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000a5 (
    .I0(sig0000005b),
    .I1(sig0000005a),
    .I2(sig00000059),
    .I3(sig00000058),
    .O(sig000000c6)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  blk000000a6 (
    .I0(sig0000005e),
    .I1(sig0000005d),
    .I2(sig0000005c),
    .O(sig000000c7)
  );
  LUT6 #(
    .INIT ( 64'h5544554455444554 ))
  blk000000a7 (
    .I0(sig00000013),
    .I1(sig00000071),
    .I2(sig0000006b),
    .I3(sig0000006a),
    .I4(sig00000008),
    .I5(sig000000db),
    .O(result[12])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000a8 (
    .I0(sig0000007e),
    .I1(sig00000012),
    .O(result[0])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000a9 (
    .I0(sig0000007f),
    .I1(sig00000012),
    .O(result[1])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000aa (
    .I0(sig00000080),
    .I1(sig00000012),
    .O(result[2])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000ab (
    .I0(sig00000082),
    .I1(sig00000012),
    .O(result[4])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000ac (
    .I0(sig00000083),
    .I1(sig00000012),
    .O(result[5])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000ad (
    .I0(sig00000081),
    .I1(sig00000012),
    .O(result[3])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000ae (
    .I0(sig00000084),
    .I1(sig00000012),
    .O(result[6])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000af (
    .I0(sig00000085),
    .I1(sig00000012),
    .O(result[7])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000b0 (
    .I0(sig00000086),
    .I1(sig00000012),
    .O(result[8])
  );
  LUT5 #(
    .INIT ( 32'h01010100 ))
  blk000000b1 (
    .I0(sig000000d0),
    .I1(sig00000021),
    .I2(sig00000020),
    .I3(sig00000023),
    .I4(sig00000022),
    .O(sig000000cd)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk000000b2 (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig000000d0),
    .O(sig00000015)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000b3 (
    .I0(sig00000014),
    .I1(sig000000ce),
    .O(sig000000c8)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000b4 (
    .I0(sig000000cf),
    .I1(sig000000d0),
    .O(sig000000c9)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000b5 (
    .I0(sig00000014),
    .I1(sig000000cf),
    .O(sig00000067)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000b6 (
    .I0(sig00000018),
    .I1(sig00000019),
    .I2(sig0000001a),
    .I3(sig0000001b),
    .O(sig000000d1)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000b7 (
    .I0(sig0000001c),
    .I1(sig0000001d),
    .I2(sig0000001e),
    .I3(sig0000001f),
    .O(sig000000d2)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000b8 (
    .I0(sig00000022),
    .I1(sig00000023),
    .I2(sig00000020),
    .I3(sig00000021),
    .O(sig000000d3)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk000000b9 (
    .I0(sig00000024),
    .I1(sig00000025),
    .O(sig000000d4)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000ba (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig00000027),
    .I3(sig00000029),
    .I4(sig00000028),
    .I5(sig00000026),
    .O(sig000000df)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000bb (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig00000028),
    .I3(sig0000002a),
    .I4(sig00000029),
    .I5(sig00000027),
    .O(sig000000de)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000bc (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig00000029),
    .I3(sig0000002b),
    .I4(sig0000002a),
    .I5(sig00000028),
    .O(sig000000dd)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000bd (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig0000002a),
    .I3(sig0000002c),
    .I4(sig0000002b),
    .I5(sig00000029),
    .O(sig000000dc)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000be (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig0000002b),
    .I3(sig0000002d),
    .I4(sig0000002c),
    .I5(sig0000002a),
    .O(sig000000e5)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000bf (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig0000002c),
    .I3(sig0000002e),
    .I4(sig0000002d),
    .I5(sig0000002b),
    .O(sig000000e4)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000c0 (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig0000002d),
    .I3(sig0000002f),
    .I4(sig0000002e),
    .I5(sig0000002c),
    .O(sig000000e3)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000c1 (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig0000002e),
    .I3(sig00000030),
    .I4(sig0000002f),
    .I5(sig0000002d),
    .O(sig000000e2)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000c2 (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig0000002f),
    .I3(sig00000031),
    .I4(sig00000030),
    .I5(sig0000002e),
    .O(sig000000e1)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000c3 (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig0000002f),
    .I3(sig00000031),
    .I4(sig00000030),
    .I5(sig0000002e),
    .O(sig000000ef)
  );
  LUT5 #(
    .INIT ( 32'h73625140 ))
  blk000000c4 (
    .I0(sig00000016),
    .I1(sig00000017),
    .I2(sig00000030),
    .I3(sig0000002f),
    .I4(sig00000031),
    .O(sig000000ee)
  );
  LUT6 #(
    .INIT ( 64'h55F4F4F400B0B0B0 ))
  blk000000c5 (
    .I0(sig00000068),
    .I1(sig00000088),
    .I2(a[15]),
    .I3(sig00000065),
    .I4(sig00000047),
    .I5(b[15]),
    .O(sig000000f8)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000c6 (
    .I0(sig0000007b),
    .I1(sig0000007c),
    .O(sig000000fa)
  );
  LUT6 #(
    .INIT ( 64'h2000000000000000 ))
  blk000000c7 (
    .I0(sig00000018),
    .I1(sig00000077),
    .I2(sig00000078),
    .I3(sig00000079),
    .I4(sig0000007a),
    .I5(sig000000fa),
    .O(sig0000006d)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF8788 ))
  blk000000c8 (
    .I0(sig0000000a),
    .I1(sig00000009),
    .I2(sig0000000d),
    .I3(sig00000002),
    .I4(sig00000046),
    .I5(sig00000048),
    .O(sig000000fb)
  );
  LUT6 #(
    .INIT ( 64'h0404040404440404 ))
  blk000000c9 (
    .I0(sig00000061),
    .I1(sig000000c3),
    .I2(sig00000063),
    .I3(sig0000005a),
    .I4(sig00000062),
    .I5(sig0000005b),
    .O(sig000000fc)
  );
  LUT6 #(
    .INIT ( 64'h232323A32F2F2FAF ))
  blk000000ca (
    .I0(sig000000c2),
    .I1(sig00000063),
    .I2(sig00000061),
    .I3(sig00000056),
    .I4(sig00000057),
    .I5(sig0000005e),
    .O(sig000000fe)
  );
  LUT6 #(
    .INIT ( 64'hFFFFD555FFFF8000 ))
  blk000000cb (
    .I0(sig00000062),
    .I1(sig00000061),
    .I2(sig000000c1),
    .I3(sig000000fd),
    .I4(sig000000fc),
    .I5(sig000000fe),
    .O(sig00000060)
  );
  LUT6 #(
    .INIT ( 64'h5544554455444554 ))
  blk000000cc (
    .I0(sig00000013),
    .I1(sig00000071),
    .I2(sig0000006a),
    .I3(sig00000069),
    .I4(sig000000db),
    .I5(sig000000ff),
    .O(result[13])
  );
  LUT6 #(
    .INIT ( 64'h5555555500400000 ))
  blk000000cd (
    .I0(sig0000006f),
    .I1(sig00000003),
    .I2(sig00000087),
    .I3(sig00000066),
    .I4(sig00000100),
    .I5(sig00000070),
    .O(result[9])
  );
  LUT4 #(
    .INIT ( 16'hFF45 ))
  blk000000ce (
    .I0(sig0000001d),
    .I1(sig0000001e),
    .I2(sig0000001f),
    .I3(sig0000001c),
    .O(sig00000101)
  );
  LUT6 #(
    .INIT ( 64'h11110100BBBBABAA ))
  blk000000cf (
    .I0(sig000000ce),
    .I1(sig00000018),
    .I2(sig0000001a),
    .I3(sig0000001b),
    .I4(sig00000019),
    .I5(sig00000101),
    .O(sig000000ca)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk000000d0 (
    .I0(sig0000001c),
    .I1(sig0000001e),
    .I2(sig0000001f),
    .I3(sig0000001d),
    .O(sig00000102)
  );
  LUT6 #(
    .INIT ( 64'h01010100ABABABAA ))
  blk000000d1 (
    .I0(sig000000ce),
    .I1(sig00000019),
    .I2(sig00000018),
    .I3(sig0000001b),
    .I4(sig0000001a),
    .I5(sig00000102),
    .O(sig000000cb)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk000000d2 (
    .I0(sig00000025),
    .I1(sig00000024),
    .O(sig00000103)
  );
  LUT6 #(
    .INIT ( 64'h11110100BBBBABAA ))
  blk000000d3 (
    .I0(sig000000d0),
    .I1(sig00000020),
    .I2(sig00000022),
    .I3(sig00000023),
    .I4(sig00000021),
    .I5(sig00000103),
    .O(sig000000cc)
  );
  LUT6 #(
    .INIT ( 64'h028A139B46CE57DF ))
  blk000000d4 (
    .I0(sig00000015),
    .I1(sig00000014),
    .I2(sig0000001d),
    .I3(sig00000025),
    .I4(sig00000019),
    .I5(sig00000021),
    .O(sig00000104)
  );
  LUT6 #(
    .INIT ( 64'hF858A808FD5DAD0D ))
  blk000000d5 (
    .I0(sig00000016),
    .I1(sig00000027),
    .I2(sig00000017),
    .I3(sig00000028),
    .I4(sig00000026),
    .I5(sig00000104),
    .O(sig000000e0)
  );
  LUT6 #(
    .INIT ( 64'hFFFFD555FFFF8000 ))
  blk000000d6 (
    .I0(sig00000062),
    .I1(sig00000061),
    .I2(sig000000c1),
    .I3(sig000000fd),
    .I4(sig000000fc),
    .I5(sig000000fe),
    .O(sig00000105)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000d7 (
    .I0(a[15]),
    .I1(b[15]),
    .O(sig00000106)
  );
  LUT6 #(
    .INIT ( 64'h5555555559555555 ))
  blk000000d8 (
    .I0(sig00000078),
    .I1(sig00000069),
    .I2(sig00000008),
    .I3(sig0000006b),
    .I4(sig0000006a),
    .I5(sig000000db),
    .O(sig00000107)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000000d9 (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig00000020),
    .I3(sig00000024),
    .O(sig0000002c)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000000da (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig00000021),
    .I3(sig00000025),
    .O(sig0000002d)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000000db (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig0000001f),
    .I3(sig00000023),
    .O(sig0000002b)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000000dc (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig0000001e),
    .I3(sig00000022),
    .O(sig0000002a)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000000dd (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig00000025),
    .O(sig00000031)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000000de (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig00000024),
    .O(sig00000030)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000000df (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig00000023),
    .O(sig0000002f)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000000e0 (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig00000022),
    .O(sig0000002e)
  );
  LUT4 #(
    .INIT ( 16'hFF8E ))
  blk000000e1 (
    .I0(sig00000005),
    .I1(sig00000079),
    .I2(sig00000014),
    .I3(sig00000078),
    .O(sig00000003)
  );
  LUT4 #(
    .INIT ( 16'h95A9 ))
  blk000000e2 (
    .I0(b[14]),
    .I1(sig0000000e),
    .I2(b[13]),
    .I3(a[13]),
    .O(sig00000002)
  );
  LUT6 #(
    .INIT ( 64'h5410FEBA54105410 ))
  blk000000e3 (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig0000001d),
    .I3(sig00000021),
    .I4(sig000000d0),
    .I5(sig00000025),
    .O(sig00000029)
  );
  LUT6 #(
    .INIT ( 64'h5410FEBA54105410 ))
  blk000000e4 (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig0000001c),
    .I3(sig00000020),
    .I4(sig000000d0),
    .I5(sig00000024),
    .O(sig00000028)
  );
  LUT6 #(
    .INIT ( 64'h5410FEBA54105410 ))
  blk000000e5 (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig0000001b),
    .I3(sig0000001f),
    .I4(sig000000d0),
    .I5(sig00000023),
    .O(sig00000027)
  );
  LUT6 #(
    .INIT ( 64'h5410FEBA54105410 ))
  blk000000e6 (
    .I0(sig00000014),
    .I1(sig000000ce),
    .I2(sig0000001a),
    .I3(sig0000001e),
    .I4(sig000000d0),
    .I5(sig00000022),
    .O(sig00000026)
  );
  LUT5 #(
    .INIT ( 32'hDFFD8FF8 ))
  blk000000e7 (
    .I0(sig00000088),
    .I1(a[9]),
    .I2(a[10]),
    .I3(b[10]),
    .I4(b[9]),
    .O(sig00000054)
  );
  LUT5 #(
    .INIT ( 32'h66600600 ))
  blk000000e8 (
    .I0(a[10]),
    .I1(b[10]),
    .I2(sig00000088),
    .I3(b[0]),
    .I4(a[0]),
    .O(sig0000005e)
  );
  LUT6 #(
    .INIT ( 64'h9614BE3C8200AA28 ))
  blk000000e9 (
    .I0(sig00000062),
    .I1(sig00000009),
    .I2(sig0000000a),
    .I3(sig0000005b),
    .I4(sig000000c4),
    .I5(sig00000057),
    .O(sig0000003e)
  );
  LUT6 #(
    .INIT ( 64'h5555555555454545 ))
  blk000000ea (
    .I0(sig00000070),
    .I1(sig0000006f),
    .I2(sig00000003),
    .I3(sig00000014),
    .I4(sig000000cf),
    .I5(sig00000066),
    .O(sig00000013)
  );
  LUT4 #(
    .INIT ( 16'h7770 ))
  blk000000eb (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000045),
    .I3(sig00000047),
    .O(sig00000070)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000ec (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[0]),
    .I4(b[0]),
    .O(sig00000053)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000ed (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[1]),
    .I4(b[1]),
    .O(sig00000052)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000ee (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[2]),
    .I4(b[2]),
    .O(sig00000051)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000ef (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[3]),
    .I4(b[3]),
    .O(sig00000050)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000f0 (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[4]),
    .I4(b[4]),
    .O(sig0000004f)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000f1 (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[5]),
    .I4(b[5]),
    .O(sig0000004e)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000f2 (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[6]),
    .I4(b[6]),
    .O(sig0000004d)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000f3 (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[7]),
    .I4(b[7]),
    .O(sig0000004c)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000f4 (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[8]),
    .I4(b[8]),
    .O(sig0000004b)
  );
  LUT5 #(
    .INIT ( 32'h77700700 ))
  blk000000f5 (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig00000088),
    .I3(a[9]),
    .I4(b[9]),
    .O(sig0000004a)
  );
  LUT6 #(
    .INIT ( 64'h9F0F960699099000 ))
  blk000000f6 (
    .I0(sig00000009),
    .I1(sig0000000a),
    .I2(sig00000062),
    .I3(sig0000005a),
    .I4(sig0000005e),
    .I5(sig00000056),
    .O(sig0000003d)
  );
  LUT6 #(
    .INIT ( 64'h9F0F960699099000 ))
  blk000000f7 (
    .I0(sig00000009),
    .I1(sig0000000a),
    .I2(sig00000062),
    .I3(sig00000059),
    .I4(sig0000005d),
    .I5(sig00000055),
    .O(sig0000003c)
  );
  LUT6 #(
    .INIT ( 64'h9F0F960699099000 ))
  blk000000f8 (
    .I0(sig00000009),
    .I1(sig0000000a),
    .I2(sig00000062),
    .I3(sig00000058),
    .I4(sig0000005c),
    .I5(sig00000054),
    .O(sig0000003b)
  );
  LUT6 #(
    .INIT ( 64'hC382D79641005514 ))
  blk000000f9 (
    .I0(sig00000062),
    .I1(sig00000009),
    .I2(sig0000000a),
    .I3(sig0000005b),
    .I4(sig000000c4),
    .I5(sig00000057),
    .O(sig0000003a)
  );
  LUT5 #(
    .INIT ( 32'h99900900 ))
  blk000000fa (
    .I0(sig00000009),
    .I1(sig0000000a),
    .I2(sig00000062),
    .I3(sig0000005a),
    .I4(sig00000056),
    .O(sig00000039)
  );
  LUT5 #(
    .INIT ( 32'h99900900 ))
  blk000000fb (
    .I0(sig00000009),
    .I1(sig0000000a),
    .I2(sig00000062),
    .I3(sig00000059),
    .I4(sig00000055),
    .O(sig00000038)
  );
  LUT5 #(
    .INIT ( 32'h99900900 ))
  blk000000fc (
    .I0(sig00000009),
    .I1(sig0000000a),
    .I2(sig00000062),
    .I3(sig00000058),
    .I4(sig00000054),
    .O(sig00000037)
  );
  LUT6 #(
    .INIT ( 64'h0000000082000000 ))
  blk000000fd (
    .I0(sig00000007),
    .I1(sig0000007c),
    .I2(sig00000017),
    .I3(sig00000006),
    .I4(sig00000004),
    .I5(sig00000078),
    .O(sig00000066)
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  blk000000fe (
    .I0(sig00000079),
    .I1(sig00000014),
    .I2(sig00000005),
    .O(sig00000069)
  );
  LUT4 #(
    .INIT ( 16'h4004 ))
  blk000000ff (
    .I0(sig00000062),
    .I1(sig00000055),
    .I2(sig0000000a),
    .I3(sig00000009),
    .O(sig00000034)
  );
  LUT4 #(
    .INIT ( 16'h4004 ))
  blk00000100 (
    .I0(sig00000062),
    .I1(sig00000054),
    .I2(sig0000000a),
    .I3(sig00000009),
    .O(sig00000033)
  );
  LUT4 #(
    .INIT ( 16'h4004 ))
  blk00000101 (
    .I0(sig00000062),
    .I1(sig00000056),
    .I2(sig0000000a),
    .I3(sig00000009),
    .O(sig00000035)
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  blk00000102 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .I5(sig00000064),
    .O(sig00000068)
  );
  LUT6 #(
    .INIT ( 64'hF00F0FF0D22D2DD2 ))
  blk00000103 (
    .I0(sig00000033),
    .I1(sig00000063),
    .I2(a[15]),
    .I3(b[15]),
    .I4(sig0000004a),
    .I5(sig0000005f),
    .O(sig000000aa)
  );
  LUT6 #(
    .INIT ( 64'hC03FC03F956AC03F ))
  blk00000104 (
    .I0(sig00000063),
    .I1(sig00000048),
    .I2(sig00000046),
    .I3(sig0000007d),
    .I4(sig00000032),
    .I5(sig0000005f),
    .O(sig000000ab)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk00000105 (
    .I0(sig0000005f),
    .I1(b[15]),
    .I2(a[15]),
    .I3(sig00000063),
    .I4(sig0000003b),
    .I5(sig0000003d),
    .O(sig000000ad)
  );
  LUT6 #(
    .INIT ( 64'h69693C69693C3C3C ))
  blk00000106 (
    .I0(sig0000005f),
    .I1(b[15]),
    .I2(a[15]),
    .I3(sig00000063),
    .I4(sig0000003c),
    .I5(sig0000003e),
    .O(sig000000ac)
  );
  LUT5 #(
    .INIT ( 32'h45545445 ))
  blk00000107 (
    .I0(sig00000013),
    .I1(sig00000071),
    .I2(sig0000007c),
    .I3(sig00000017),
    .I4(sig000000db),
    .O(result[10])
  );
  LUT6 #(
    .INIT ( 64'h8F0707078F000000 ))
  blk00000108 (
    .I0(sig00000048),
    .I1(sig00000046),
    .I2(sig0000006e),
    .I3(a[15]),
    .I4(b[15]),
    .I5(sig000000f8),
    .O(sig000000f9)
  );
  LUT5 #(
    .INIT ( 32'hAAAA8AAA ))
  blk00000109 (
    .I0(sig000000f9),
    .I1(sig0000006f),
    .I2(sig00000014),
    .I3(sig000000cf),
    .I4(sig00000070),
    .O(result[15])
  );
  LUT3 #(
    .INIT ( 8'h15 ))
  blk0000010a (
    .I0(sig0000006d),
    .I1(sig000000cf),
    .I2(sig00000014),
    .O(sig00000100)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA66AAAA69 ))
  blk0000010b (
    .I0(sig0000000b),
    .I1(sig00000010),
    .I2(sig00000011),
    .I3(a[10]),
    .I4(b[10]),
    .I5(sig0000000c),
    .O(sig00000062)
  );
  LUT6 #(
    .INIT ( 64'h4004000040000004 ))
  blk0000010c (
    .I0(sig0000000c),
    .I1(sig0000000b),
    .I2(a[10]),
    .I3(b[10]),
    .I4(sig00000010),
    .I5(sig00000011),
    .O(sig0000000a)
  );
  LUT6 #(
    .INIT ( 64'h4554454545455445 ))
  blk0000010d (
    .I0(sig00000013),
    .I1(sig00000071),
    .I2(sig00000007),
    .I3(sig0000007c),
    .I4(sig00000017),
    .I5(sig000000db),
    .O(result[11])
  );
  LUT6 #(
    .INIT ( 64'h5555555514114414 ))
  blk0000010e (
    .I0(sig00000013),
    .I1(sig00000107),
    .I2(sig00000005),
    .I3(sig00000014),
    .I4(sig00000079),
    .I5(sig00000071),
    .O(result[14])
  );
  LUT5 #(
    .INIT ( 32'h6A665655 ))
  blk0000010f (
    .I0(sig00000006),
    .I1(sig0000007b),
    .I2(sig0000007c),
    .I3(sig00000017),
    .I4(sig00000016),
    .O(sig0000006a)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000002 ))
  blk00000110 (
    .I0(sig00000046),
    .I1(b[14]),
    .I2(b[13]),
    .I3(b[12]),
    .I4(b[11]),
    .I5(b[10]),
    .O(sig0000006c)
  );
  LUT4 #(
    .INIT ( 16'h9A95 ))
  blk00000111 (
    .I0(sig0000007a),
    .I1(sig000000d0),
    .I2(sig00000014),
    .I3(sig000000ce),
    .O(sig00000006)
  );
  LUT6 #(
    .INIT ( 64'h9990090009009990 ))
  blk00000112 (
    .I0(sig00000009),
    .I1(sig0000000a),
    .I2(sig00000062),
    .I3(sig00000057),
    .I4(a[10]),
    .I5(b[10]),
    .O(sig00000036)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFEF ))
  blk00000113 (
    .I0(b[12]),
    .I1(b[13]),
    .I2(sig00000046),
    .I3(b[11]),
    .I4(b[10]),
    .I5(b[14]),
    .O(sig00000049)
  );
  LUT5 #(
    .INIT ( 32'h09000009 ))
  blk00000114 (
    .I0(b[10]),
    .I1(a[10]),
    .I2(sig00000062),
    .I3(sig00000009),
    .I4(sig0000000a),
    .O(sig00000032)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFF45 ))
  blk00000115 (
    .I0(sig00000025),
    .I1(sig00000017),
    .I2(sig00000024),
    .I3(sig000000ce),
    .I4(sig00000014),
    .I5(sig00000016),
    .O(sig000000ed)
  );
  LUT5 #(
    .INIT ( 32'hB2BB22B2 ))
  blk00000116 (
    .I0(b[14]),
    .I1(a[14]),
    .I2(b[13]),
    .I3(a[13]),
    .I4(sig0000000e),
    .O(sig0000000c)
  );
  LUT5 #(
    .INIT ( 32'h422DB442 ))
  blk00000117 (
    .I0(b[14]),
    .I1(a[14]),
    .I2(sig0000000e),
    .I3(b[13]),
    .I4(a[13]),
    .O(sig00000009)
  );
  LUT6 #(
    .INIT ( 64'hB2BB22B2B2BBB2BB ))
  blk00000118 (
    .I0(sig0000007a),
    .I1(sig00000015),
    .I2(sig0000007b),
    .I3(sig00000016),
    .I4(sig0000007c),
    .I5(sig00000017),
    .O(sig00000005)
  );
  LUT6 #(
    .INIT ( 64'hB2BB22B2B2BBB2BB ))
  blk00000119 (
    .I0(b[12]),
    .I1(a[12]),
    .I2(b[11]),
    .I3(a[11]),
    .I4(b[10]),
    .I5(a[10]),
    .O(sig0000000e)
  );
  LUT4 #(
    .INIT ( 16'h6966 ))
  blk0000011a (
    .I0(sig0000007b),
    .I1(sig00000016),
    .I2(sig0000007c),
    .I3(sig00000017),
    .O(sig0000006b)
  );
  LUT4 #(
    .INIT ( 16'hEB7D ))
  blk0000011b (
    .I0(sig00000017),
    .I1(sig0000007b),
    .I2(sig00000016),
    .I3(sig0000007c),
    .O(sig000000ff)
  );
  LUT6 #(
    .INIT ( 64'hBDD24BBD422DB442 ))
  blk0000011c (
    .I0(b[14]),
    .I1(a[14]),
    .I2(sig0000000e),
    .I3(b[13]),
    .I4(a[13]),
    .I5(sig0000000a),
    .O(sig00000061)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF08808888 ))
  blk0000011d (
    .I0(sig00000061),
    .I1(sig00000062),
    .I2(b[10]),
    .I3(a[10]),
    .I4(sig00000010),
    .I5(sig000000fb),
    .O(sig0000005f)
  );
  LUT4 #(
    .INIT ( 16'h9FF9 ))
  blk0000011e (
    .I0(b[11]),
    .I1(a[11]),
    .I2(b[10]),
    .I3(a[10]),
    .O(sig000000fd)
  );
  LUT5 #(
    .INIT ( 32'h66699666 ))
  blk0000011f (
    .I0(b[11]),
    .I1(a[11]),
    .I2(sig0000000c),
    .I3(a[10]),
    .I4(b[10]),
    .O(sig00000063)
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
