////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: int2fp16.v
// /___/   /\     Timestamp: Sun Mar 24 18:44:56 2019
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/int2fp16.ngc C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/int2fp16.v 
// Device	: 6slx45fgg484-2
// Input file	: C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/int2fp16.ngc
// Output file	: C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/int2fp16.v
// # of Modules	: 1
// Design Name	: int2fp16
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

module int2fp16 (
  operation_nd, clk, operation_rfd, rdy, a, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  output operation_rfd;
  output rdy;
  input [8 : 0] a;
  output [15 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op ;
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
  wire NLW_blk0000003e_O_UNCONNECTED;
  wire NLW_blk00000054_O_UNCONNECTED;
  wire NLW_blk00000056_O_UNCONNECTED;
  wire NLW_blk000000b5_Q15_UNCONNECTED;
  wire NLW_blk000000b7_Q15_UNCONNECTED;
  wire NLW_blk000000b9_Q15_UNCONNECTED;
  wire NLW_blk000000bb_Q15_UNCONNECTED;
  wire [4 : 0] \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op ;
  wire [9 : 2] \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op ;
  wire [0 : 0] NlwRenamedSig_OI_result;
  assign
    result[15] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op ,
    result[14] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [4],
    result[13] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [3],
    result[12] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [2],
    result[11] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [1],
    result[10] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [0],
    result[9] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [9],
    result[8] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [8],
    result[7] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [7],
    result[6] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [6],
    result[5] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [5],
    result[4] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [4],
    result[3] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [3],
    result[2] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [2],
    result[1] = NlwRenamedSig_OI_result[0],
    result[0] = NlwRenamedSig_OI_result[0],
    operation_rfd = NlwRenamedSig_OI_operation_rfd,
    rdy = \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(NlwRenamedSig_OI_operation_rfd)
  );
  GND   blk00000002 (
    .G(NlwRenamedSig_OI_result[0])
  );
  MUXCY   blk00000003 (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(NlwRenamedSig_OI_operation_rfd),
    .O(sig00000003)
  );
  MUXCY   blk00000004 (
    .CI(sig00000002),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000001)
  );
  MUXCY   blk00000005 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000002)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000006 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000009),
    .Q(sig00000028)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000007 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000008),
    .Q(sig00000027)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000008 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000007),
    .Q(sig00000026)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000023),
    .Q(sig00000025)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000022),
    .Q(sig00000024)
  );
  XORCY   blk0000000b (
    .CI(sig00000062),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(sig00000060)
  );
  XORCY   blk0000000c (
    .CI(sig00000064),
    .LI(sig0000005a),
    .O(sig00000061)
  );
  MUXCY   blk0000000d (
    .CI(sig00000064),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000005a),
    .O(sig00000062)
  );
  XORCY   blk0000000e (
    .CI(sig00000066),
    .LI(sig00000059),
    .O(sig00000063)
  );
  MUXCY   blk0000000f (
    .CI(sig00000066),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000059),
    .O(sig00000064)
  );
  XORCY   blk00000010 (
    .CI(sig00000068),
    .LI(sig00000058),
    .O(sig00000065)
  );
  MUXCY   blk00000011 (
    .CI(sig00000068),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000058),
    .O(sig00000066)
  );
  XORCY   blk00000012 (
    .CI(sig0000006a),
    .LI(sig00000057),
    .O(sig00000067)
  );
  MUXCY   blk00000013 (
    .CI(sig0000006a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000057),
    .O(sig00000068)
  );
  XORCY   blk00000014 (
    .CI(sig0000006c),
    .LI(sig00000056),
    .O(sig00000069)
  );
  MUXCY   blk00000015 (
    .CI(sig0000006c),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000056),
    .O(sig0000006a)
  );
  XORCY   blk00000016 (
    .CI(sig0000006e),
    .LI(sig00000055),
    .O(sig0000006b)
  );
  MUXCY   blk00000017 (
    .CI(sig0000006e),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000055),
    .O(sig0000006c)
  );
  XORCY   blk00000018 (
    .CI(sig00000070),
    .LI(sig00000054),
    .O(sig0000006d)
  );
  MUXCY   blk00000019 (
    .CI(sig00000070),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000054),
    .O(sig0000006e)
  );
  XORCY   blk0000001a (
    .CI(a[8]),
    .LI(sig00000053),
    .O(sig0000006f)
  );
  MUXCY   blk0000001b (
    .CI(a[8]),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000053),
    .O(sig00000070)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001c (
    .C(clk),
    .D(sig00000060),
    .Q(sig00000052)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001d (
    .C(clk),
    .D(sig00000061),
    .Q(sig00000051)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001e (
    .C(clk),
    .D(sig00000063),
    .Q(sig00000050)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001f (
    .C(clk),
    .D(sig00000065),
    .Q(sig0000004f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000020 (
    .C(clk),
    .D(sig00000067),
    .Q(sig0000004e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000021 (
    .C(clk),
    .D(sig00000069),
    .Q(sig0000004d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000022 (
    .C(clk),
    .D(sig0000006b),
    .Q(sig0000004c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000023 (
    .C(clk),
    .D(sig0000006d),
    .Q(sig0000004b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000024 (
    .C(clk),
    .D(sig0000006f),
    .Q(sig0000004a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000025 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000012),
    .Q(sig0000000a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000026 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000013),
    .Q(sig0000000b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000027 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000014),
    .Q(sig0000000c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000028 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000015),
    .Q(sig0000000d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000029 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000016),
    .Q(sig0000000e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000017),
    .Q(sig0000000f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000018),
    .Q(sig00000010)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002c (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000019),
    .Q(sig00000011)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000001a),
    .Q(sig00000031)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002e (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000001b),
    .Q(sig00000032)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000001c),
    .Q(sig00000033)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000030 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000001d),
    .Q(sig00000034)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000031 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000001e),
    .Q(sig00000035)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000032 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000001f),
    .Q(sig00000036)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000033 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000020),
    .Q(sig00000037)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000034 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000021),
    .Q(sig00000038)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000035 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000052),
    .Q(sig00000049)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000036 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000051),
    .Q(sig00000048)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000037 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000050),
    .Q(sig00000047)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000004f),
    .Q(sig00000046)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000039 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000004e),
    .Q(sig00000045)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000004d),
    .Q(sig00000044)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000004c),
    .Q(sig00000043)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003c (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000004b),
    .Q(sig00000042)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000004a),
    .Q(sig00000041)
  );
  MUXF7   blk0000003e (
    .I0(sig00000072),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig00000040),
    .O(NLW_blk0000003e_O_UNCONNECTED)
  );
  MUXF7   blk0000003f (
    .I0(sig00000073),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig00000040),
    .O(sig00000075)
  );
  MUXF7   blk00000040 (
    .I0(sig00000074),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig00000040),
    .O(sig00000076)
  );
  MUXCY   blk00000041 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000007d),
    .O(sig00000077)
  );
  MUXCY   blk00000042 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000007a),
    .O(sig00000078)
  );
  MUXCY   blk00000043 (
    .CI(sig00000078),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000007b),
    .O(sig00000079)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000044 (
    .C(clk),
    .D(sig0000003f),
    .Q(sig00000071)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000045 (
    .C(clk),
    .D(sig00000071),
    .Q(sig0000003c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000046 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000003e),
    .Q(sig0000003b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000047 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000003d),
    .Q(sig0000003a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000048 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000075),
    .Q(sig0000003d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000049 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000076),
    .Q(sig0000003e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000007c),
    .Q(sig00000039)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000077),
    .Q(sig0000007e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004c (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000078),
    .Q(sig0000007f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000079),
    .Q(sig00000040)
  );
  XORCY   blk0000004e (
    .CI(sig00000082),
    .LI(sig0000009d),
    .O(sig00000080)
  );
  MUXCY   blk0000004f (
    .CI(sig00000082),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000009d),
    .O(sig00000004)
  );
  XORCY   blk00000050 (
    .CI(sig00000084),
    .LI(sig0000009e),
    .O(sig00000081)
  );
  MUXCY   blk00000051 (
    .CI(sig00000084),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000009e),
    .O(sig00000082)
  );
  XORCY   blk00000052 (
    .CI(sig00000085),
    .LI(sig0000009f),
    .O(sig00000083)
  );
  MUXCY   blk00000053 (
    .CI(sig00000085),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000009f),
    .O(sig00000084)
  );
  XORCY   blk00000054 (
    .CI(sig00000086),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000054_O_UNCONNECTED)
  );
  MUXCY   blk00000055 (
    .CI(sig00000086),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000085)
  );
  XORCY   blk00000056 (
    .CI(sig00000003),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000056_O_UNCONNECTED)
  );
  MUXCY   blk00000057 (
    .CI(sig00000003),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000086)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000058 (
    .C(clk),
    .D(sig00000083),
    .Q(sig00000029)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000059 (
    .C(clk),
    .D(sig00000081),
    .Q(sig0000002a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000005a (
    .C(clk),
    .D(sig00000080),
    .Q(sig0000002b)
  );
  XORCY   blk0000005b (
    .CI(sig00000089),
    .LI(NlwRenamedSig_OI_operation_rfd),
    .O(sig00000087)
  );
  XORCY   blk0000005c (
    .CI(sig0000008b),
    .LI(sig000000a0),
    .O(sig00000088)
  );
  MUXCY   blk0000005d (
    .CI(sig0000008b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000a0),
    .O(sig00000089)
  );
  XORCY   blk0000005e (
    .CI(sig0000008d),
    .LI(sig000000a1),
    .O(sig0000008a)
  );
  MUXCY   blk0000005f (
    .CI(sig0000008d),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000a1),
    .O(sig0000008b)
  );
  XORCY   blk00000060 (
    .CI(sig0000008f),
    .LI(sig000000a2),
    .O(sig0000008c)
  );
  MUXCY   blk00000061 (
    .CI(sig0000008f),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000a2),
    .O(sig0000008d)
  );
  XORCY   blk00000062 (
    .CI(sig00000091),
    .LI(sig000000a3),
    .O(sig0000008e)
  );
  MUXCY   blk00000063 (
    .CI(sig00000091),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000a3),
    .O(sig0000008f)
  );
  XORCY   blk00000064 (
    .CI(sig00000004),
    .LI(sig000000a4),
    .O(sig00000090)
  );
  MUXCY   blk00000065 (
    .CI(sig00000004),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000a4),
    .O(sig00000091)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000066 (
    .C(clk),
    .D(sig00000090),
    .Q(sig0000002c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000067 (
    .C(clk),
    .D(sig0000008e),
    .Q(sig0000002d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000068 (
    .C(clk),
    .D(sig0000008c),
    .Q(sig0000002e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000069 (
    .C(clk),
    .D(sig0000008a),
    .Q(sig0000002f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000006a (
    .C(clk),
    .D(sig00000088),
    .Q(sig00000030)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000006b (
    .C(clk),
    .D(sig00000087),
    .Q(sig00000005)
  );
  FD   blk0000006c (
    .C(clk),
    .D(sig00000099),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [9])
  );
  FD   blk0000006d (
    .C(clk),
    .D(sig00000098),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [8])
  );
  FD   blk0000006e (
    .C(clk),
    .D(sig00000097),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [7])
  );
  FD   blk0000006f (
    .C(clk),
    .D(sig00000096),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [6])
  );
  FD   blk00000070 (
    .C(clk),
    .D(sig00000095),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [5])
  );
  FD   blk00000071 (
    .C(clk),
    .D(sig00000094),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [4])
  );
  FD   blk00000072 (
    .C(clk),
    .D(sig00000093),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [3])
  );
  FD   blk00000073 (
    .C(clk),
    .D(sig00000092),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [2])
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000074 (
    .I0(sig0000003d),
    .I1(sig0000003e),
    .I2(sig00000010),
    .I3(sig0000000e),
    .I4(sig0000000f),
    .I5(sig00000011),
    .O(sig00000021)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000075 (
    .I0(sig0000003d),
    .I1(sig0000003e),
    .I2(sig0000000f),
    .I3(sig0000000d),
    .I4(sig0000000e),
    .I5(sig00000010),
    .O(sig00000020)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000076 (
    .I0(sig0000003d),
    .I1(sig0000003e),
    .I2(sig0000000d),
    .I3(sig0000000b),
    .I4(sig0000000c),
    .I5(sig0000000e),
    .O(sig0000001e)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000077 (
    .I0(sig0000003d),
    .I1(sig0000003e),
    .I2(sig0000000e),
    .I3(sig0000000c),
    .I4(sig0000000d),
    .I5(sig0000000f),
    .O(sig0000001f)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000078 (
    .I0(sig0000003e),
    .I1(sig0000003d),
    .I2(sig0000000b),
    .I3(sig0000000a),
    .I4(sig0000000c),
    .I5(sig0000000d),
    .O(sig0000001d)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000079 (
    .I0(sig0000003e),
    .I1(sig0000003d),
    .I2(sig0000000b),
    .I3(sig0000000a),
    .O(sig0000001b)
  );
  LUT3 #(
    .INIT ( 8'h41 ))
  blk0000007a (
    .I0(sig0000005f),
    .I1(sig00000028),
    .I2(sig00000005),
    .O(sig00000006)
  );
  LUT4 #(
    .INIT ( 16'h4414 ))
  blk0000007b (
    .I0(sig0000005f),
    .I1(sig00000027),
    .I2(sig00000028),
    .I3(sig00000005),
    .O(sig0000005b)
  );
  LUT5 #(
    .INIT ( 32'h44441444 ))
  blk0000007c (
    .I0(sig0000005f),
    .I1(sig00000026),
    .I2(sig00000027),
    .I3(sig00000028),
    .I4(sig00000005),
    .O(sig0000005c)
  );
  LUT6 #(
    .INIT ( 64'h00000000AA6AAAAA ))
  blk0000007d (
    .I0(sig00000025),
    .I1(sig00000026),
    .I2(sig00000027),
    .I3(sig00000005),
    .I4(sig00000028),
    .I5(sig0000005f),
    .O(sig0000005d)
  );
  LUT5 #(
    .INIT ( 32'h73625140 ))
  blk0000007e (
    .I0(sig0000003e),
    .I1(sig0000003d),
    .I2(sig0000000b),
    .I3(sig0000000c),
    .I4(sig0000000a),
    .O(sig0000001c)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000007f (
    .I0(sig0000003e),
    .I1(sig0000003d),
    .I2(sig0000000a),
    .O(sig0000001a)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000080 (
    .I0(a[0]),
    .I1(a[8]),
    .O(sig00000053)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000081 (
    .I0(a[1]),
    .I1(a[8]),
    .O(sig00000054)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000082 (
    .I0(a[2]),
    .I1(a[8]),
    .O(sig00000055)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000083 (
    .I0(a[3]),
    .I1(a[8]),
    .O(sig00000056)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000084 (
    .I0(a[4]),
    .I1(a[8]),
    .O(sig00000057)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000085 (
    .I0(a[5]),
    .I1(a[8]),
    .O(sig00000058)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000086 (
    .I0(a[6]),
    .I1(a[8]),
    .O(sig00000059)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000087 (
    .I0(a[7]),
    .I1(a[8]),
    .O(sig0000005a)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000088 (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig0000007e),
    .O(sig0000003f)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000089 (
    .I0(sig00000040),
    .I1(sig0000007f),
    .O(sig00000072)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000008a (
    .I0(sig00000052),
    .I1(sig00000051),
    .I2(sig00000050),
    .I3(sig0000004f),
    .O(sig0000007a)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000008b (
    .I0(sig0000004e),
    .I1(sig0000004d),
    .I2(sig0000004c),
    .I3(sig0000004b),
    .O(sig0000007b)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000008c (
    .I0(sig00000040),
    .I1(sig0000007e),
    .O(sig0000007c)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000008d (
    .I0(sig0000005f),
    .I1(sig0000002a),
    .O(sig00000093)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000008e (
    .I0(sig0000005f),
    .I1(sig0000002b),
    .O(sig00000094)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000008f (
    .I0(sig0000005f),
    .I1(sig00000029),
    .O(sig00000092)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000090 (
    .I0(sig0000005f),
    .I1(sig0000002c),
    .O(sig00000095)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000091 (
    .I0(sig0000005f),
    .I1(sig0000002d),
    .O(sig00000096)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000092 (
    .I0(sig0000005f),
    .I1(sig0000002f),
    .O(sig00000098)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000093 (
    .I0(sig0000005f),
    .I1(sig0000002e),
    .O(sig00000097)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000094 (
    .I0(sig0000005f),
    .I1(sig00000030),
    .O(sig00000099)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  blk00000095 (
    .I0(sig00000025),
    .I1(sig00000026),
    .O(sig0000009a)
  );
  LUT6 #(
    .INIT ( 64'h0000AAAA0000A6AA ))
  blk00000096 (
    .I0(sig00000024),
    .I1(sig00000027),
    .I2(sig00000005),
    .I3(sig00000028),
    .I4(sig0000005f),
    .I5(sig0000009a),
    .O(sig0000005e)
  );
  LUT4 #(
    .INIT ( 16'hAAEF ))
  blk00000097 (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000042),
    .I3(sig00000044),
    .O(sig0000009b)
  );
  LUT6 #(
    .INIT ( 64'h11110100DDDDCDCC ))
  blk00000098 (
    .I0(sig00000049),
    .I1(sig0000007f),
    .I2(sig00000047),
    .I3(sig00000046),
    .I4(sig00000048),
    .I5(sig0000009b),
    .O(sig00000073)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk00000099 (
    .I0(sig00000045),
    .I1(sig00000043),
    .I2(sig00000042),
    .I3(sig00000044),
    .O(sig0000009c)
  );
  LUT6 #(
    .INIT ( 64'h01010100CDCDCDCC ))
  blk0000009a (
    .I0(sig00000048),
    .I1(sig0000007f),
    .I2(sig00000049),
    .I3(sig00000046),
    .I4(sig00000047),
    .I5(sig0000009c),
    .O(sig00000074)
  );
  FD   blk0000009b (
    .C(clk),
    .D(sig0000005e),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [4])
  );
  FD   blk0000009c (
    .C(clk),
    .D(sig0000005d),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [3])
  );
  FD   blk0000009d (
    .C(clk),
    .D(sig0000005c),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [2])
  );
  FD   blk0000009e (
    .C(clk),
    .D(sig0000005b),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [1])
  );
  FD   blk0000009f (
    .C(clk),
    .D(sig00000006),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [0])
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000a0 (
    .I0(sig00000033),
    .O(sig0000009d)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000a1 (
    .I0(sig00000032),
    .O(sig0000009e)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000a2 (
    .I0(sig00000031),
    .O(sig0000009f)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000a3 (
    .I0(sig00000038),
    .O(sig000000a0)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000a4 (
    .I0(sig00000037),
    .O(sig000000a1)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000a5 (
    .I0(sig00000036),
    .O(sig000000a2)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000a6 (
    .I0(sig00000035),
    .O(sig000000a3)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000a7 (
    .I0(sig00000034),
    .O(sig000000a4)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000000a8 (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig00000048),
    .I3(sig00000044),
    .O(sig00000019)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000000a9 (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig00000047),
    .I3(sig00000043),
    .O(sig00000018)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000000aa (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig00000046),
    .I3(sig00000042),
    .O(sig00000017)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk000000ab (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig00000045),
    .I3(sig00000041),
    .O(sig00000016)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000000ac (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig00000041),
    .O(sig00000012)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000000ad (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig00000044),
    .O(sig00000015)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000000ae (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig00000043),
    .O(sig00000014)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000000af (
    .I0(sig00000040),
    .I1(sig0000007f),
    .I2(sig00000042),
    .O(sig00000013)
  );
  INV   blk000000b0 (
    .I(sig00000023),
    .O(sig00000022)
  );
  INV   blk000000b1 (
    .I(sig0000003c),
    .O(sig00000007)
  );
  INV   blk000000b2 (
    .I(sig0000003b),
    .O(sig00000008)
  );
  INV   blk000000b3 (
    .I(sig0000003a),
    .O(sig00000009)
  );
  INV   blk000000b4 (
    .I(sig0000004a),
    .O(sig0000007d)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000b5 (
    .A0(NlwRenamedSig_OI_result[0]),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(NlwRenamedSig_OI_result[0]),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig00000039),
    .Q(sig000000a5),
    .Q15(NLW_blk000000b5_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b6 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a5),
    .Q(sig0000005f)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000b7 (
    .A0(NlwRenamedSig_OI_result[0]),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(NlwRenamedSig_OI_result[0]),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig00000040),
    .Q(sig000000a6),
    .Q15(NLW_blk000000b7_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b8 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a6),
    .Q(sig00000023)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000b9 (
    .A0(NlwRenamedSig_OI_result[0]),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(NlwRenamedSig_OI_operation_rfd),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(a[8]),
    .Q(sig000000a7),
    .Q15(NLW_blk000000b9_Q15_UNCONNECTED)
  );
  FDE   blk000000ba (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a7),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op )
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000bb (
    .A0(NlwRenamedSig_OI_result[0]),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(NlwRenamedSig_OI_operation_rfd),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(operation_nd),
    .Q(sig000000a8),
    .Q15(NLW_blk000000bb_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000bc (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a8),
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
