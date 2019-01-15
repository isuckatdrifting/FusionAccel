////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: multiplier.v
// /___/   /\     Timestamp: Tue Jan 15 10:06:20 2019
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/multiplier.ngc /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/multiplier.v 
// Device	: 6slx45fgg484-2
// Input file	: /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/multiplier.ngc
// Output file	: /mnt/c/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/multiplier.v
// # of Modules	: 1
// Design Name	: multiplier
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

module multiplier (
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
  
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/sign_op ;
  wire \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/UNDERFLOW ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/OVERFLOW ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/INVALID_OP ;
  wire \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  wire sig00000001;
  wire sig00000002;
  wire sig00000003;
  wire sig00000004;
  wire sig00000005;
  wire sig00000006;
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
  wire NLW_blk00000003_CARRYOUTF_UNCONNECTED;
  wire NLW_blk00000003_CARRYOUT_UNCONNECTED;
  wire \NLW_blk00000003_BCOUT<17>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<16>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<15>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<14>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<13>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<12>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<11>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<10>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<9>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<8>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<7>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<6>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<5>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<4>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<3>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<2>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<1>_UNCONNECTED ;
  wire \NLW_blk00000003_BCOUT<0>_UNCONNECTED ;
  wire \NLW_blk00000003_C<47>_UNCONNECTED ;
  wire \NLW_blk00000003_C<46>_UNCONNECTED ;
  wire \NLW_blk00000003_C<45>_UNCONNECTED ;
  wire \NLW_blk00000003_C<44>_UNCONNECTED ;
  wire \NLW_blk00000003_C<43>_UNCONNECTED ;
  wire \NLW_blk00000003_C<42>_UNCONNECTED ;
  wire \NLW_blk00000003_C<41>_UNCONNECTED ;
  wire \NLW_blk00000003_C<40>_UNCONNECTED ;
  wire \NLW_blk00000003_C<39>_UNCONNECTED ;
  wire \NLW_blk00000003_C<38>_UNCONNECTED ;
  wire \NLW_blk00000003_C<37>_UNCONNECTED ;
  wire \NLW_blk00000003_C<36>_UNCONNECTED ;
  wire \NLW_blk00000003_C<35>_UNCONNECTED ;
  wire \NLW_blk00000003_C<34>_UNCONNECTED ;
  wire \NLW_blk00000003_C<33>_UNCONNECTED ;
  wire \NLW_blk00000003_C<32>_UNCONNECTED ;
  wire \NLW_blk00000003_C<31>_UNCONNECTED ;
  wire \NLW_blk00000003_C<30>_UNCONNECTED ;
  wire \NLW_blk00000003_C<29>_UNCONNECTED ;
  wire \NLW_blk00000003_C<28>_UNCONNECTED ;
  wire \NLW_blk00000003_C<27>_UNCONNECTED ;
  wire \NLW_blk00000003_C<26>_UNCONNECTED ;
  wire \NLW_blk00000003_C<25>_UNCONNECTED ;
  wire \NLW_blk00000003_C<24>_UNCONNECTED ;
  wire \NLW_blk00000003_C<23>_UNCONNECTED ;
  wire \NLW_blk00000003_C<22>_UNCONNECTED ;
  wire \NLW_blk00000003_C<21>_UNCONNECTED ;
  wire \NLW_blk00000003_C<20>_UNCONNECTED ;
  wire \NLW_blk00000003_C<19>_UNCONNECTED ;
  wire \NLW_blk00000003_C<18>_UNCONNECTED ;
  wire \NLW_blk00000003_C<17>_UNCONNECTED ;
  wire \NLW_blk00000003_C<16>_UNCONNECTED ;
  wire \NLW_blk00000003_C<15>_UNCONNECTED ;
  wire \NLW_blk00000003_C<14>_UNCONNECTED ;
  wire \NLW_blk00000003_C<13>_UNCONNECTED ;
  wire \NLW_blk00000003_C<12>_UNCONNECTED ;
  wire \NLW_blk00000003_C<11>_UNCONNECTED ;
  wire \NLW_blk00000003_C<10>_UNCONNECTED ;
  wire \NLW_blk00000003_C<9>_UNCONNECTED ;
  wire \NLW_blk00000003_C<8>_UNCONNECTED ;
  wire \NLW_blk00000003_C<7>_UNCONNECTED ;
  wire \NLW_blk00000003_C<6>_UNCONNECTED ;
  wire \NLW_blk00000003_C<5>_UNCONNECTED ;
  wire \NLW_blk00000003_C<4>_UNCONNECTED ;
  wire \NLW_blk00000003_C<3>_UNCONNECTED ;
  wire \NLW_blk00000003_C<2>_UNCONNECTED ;
  wire \NLW_blk00000003_C<1>_UNCONNECTED ;
  wire \NLW_blk00000003_C<0>_UNCONNECTED ;
  wire \NLW_blk00000003_P<47>_UNCONNECTED ;
  wire \NLW_blk00000003_P<46>_UNCONNECTED ;
  wire \NLW_blk00000003_P<45>_UNCONNECTED ;
  wire \NLW_blk00000003_P<44>_UNCONNECTED ;
  wire \NLW_blk00000003_P<43>_UNCONNECTED ;
  wire \NLW_blk00000003_P<42>_UNCONNECTED ;
  wire \NLW_blk00000003_P<41>_UNCONNECTED ;
  wire \NLW_blk00000003_P<40>_UNCONNECTED ;
  wire \NLW_blk00000003_P<39>_UNCONNECTED ;
  wire \NLW_blk00000003_P<38>_UNCONNECTED ;
  wire \NLW_blk00000003_P<37>_UNCONNECTED ;
  wire \NLW_blk00000003_P<36>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<47>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<46>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<45>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<44>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<43>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<42>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<41>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<40>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<39>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<38>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<37>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<36>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<35>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<34>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<33>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<32>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<31>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<30>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<29>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<28>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<27>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<26>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<25>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<24>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<23>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<22>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<21>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<20>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<19>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<18>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<17>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<16>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<15>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<14>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<13>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<12>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<11>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<10>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<9>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<8>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<7>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<6>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<5>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<4>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<3>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<2>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<1>_UNCONNECTED ;
  wire \NLW_blk00000003_PCOUT<0>_UNCONNECTED ;
  wire \NLW_blk00000003_M<35>_UNCONNECTED ;
  wire \NLW_blk00000003_M<34>_UNCONNECTED ;
  wire \NLW_blk00000003_M<33>_UNCONNECTED ;
  wire \NLW_blk00000003_M<32>_UNCONNECTED ;
  wire \NLW_blk00000003_M<31>_UNCONNECTED ;
  wire \NLW_blk00000003_M<30>_UNCONNECTED ;
  wire \NLW_blk00000003_M<29>_UNCONNECTED ;
  wire \NLW_blk00000003_M<28>_UNCONNECTED ;
  wire \NLW_blk00000003_M<27>_UNCONNECTED ;
  wire \NLW_blk00000003_M<26>_UNCONNECTED ;
  wire \NLW_blk00000003_M<25>_UNCONNECTED ;
  wire \NLW_blk00000003_M<24>_UNCONNECTED ;
  wire \NLW_blk00000003_M<23>_UNCONNECTED ;
  wire \NLW_blk00000003_M<22>_UNCONNECTED ;
  wire \NLW_blk00000003_M<21>_UNCONNECTED ;
  wire \NLW_blk00000003_M<20>_UNCONNECTED ;
  wire \NLW_blk00000003_M<19>_UNCONNECTED ;
  wire \NLW_blk00000003_M<18>_UNCONNECTED ;
  wire \NLW_blk00000003_M<17>_UNCONNECTED ;
  wire \NLW_blk00000003_M<16>_UNCONNECTED ;
  wire \NLW_blk00000003_M<15>_UNCONNECTED ;
  wire \NLW_blk00000003_M<14>_UNCONNECTED ;
  wire \NLW_blk00000003_M<13>_UNCONNECTED ;
  wire \NLW_blk00000003_M<12>_UNCONNECTED ;
  wire \NLW_blk00000003_M<11>_UNCONNECTED ;
  wire \NLW_blk00000003_M<10>_UNCONNECTED ;
  wire \NLW_blk00000003_M<9>_UNCONNECTED ;
  wire \NLW_blk00000003_M<8>_UNCONNECTED ;
  wire \NLW_blk00000003_M<7>_UNCONNECTED ;
  wire \NLW_blk00000003_M<6>_UNCONNECTED ;
  wire \NLW_blk00000003_M<5>_UNCONNECTED ;
  wire \NLW_blk00000003_M<4>_UNCONNECTED ;
  wire \NLW_blk00000003_M<3>_UNCONNECTED ;
  wire \NLW_blk00000003_M<2>_UNCONNECTED ;
  wire \NLW_blk00000003_M<1>_UNCONNECTED ;
  wire \NLW_blk00000003_M<0>_UNCONNECTED ;
  wire NLW_blk000000e0_Q15_UNCONNECTED;
  wire NLW_blk000000e2_Q15_UNCONNECTED;
  wire NLW_blk000000e4_Q15_UNCONNECTED;
  wire NLW_blk000000e6_Q15_UNCONNECTED;
  wire NLW_blk000000e8_Q15_UNCONNECTED;
  wire NLW_blk000000ea_Q15_UNCONNECTED;
  wire NLW_blk000000ec_Q15_UNCONNECTED;
  wire NLW_blk000000ee_Q15_UNCONNECTED;
  wire NLW_blk000000f0_Q15_UNCONNECTED;
  wire NLW_blk000000f2_Q15_UNCONNECTED;
  wire NLW_blk000000f4_Q15_UNCONNECTED;
  wire NLW_blk000000f6_Q15_UNCONNECTED;
  wire NLW_blk000000f8_Q15_UNCONNECTED;
  wire [4 : 0] \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op ;
  wire [9 : 0] \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op ;
  assign
    result[15] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/sign_op ,
    result[14] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [4],
    result[13] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [3],
    result[12] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [2],
    result[11] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [1],
    result[10] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [0],
    result[9] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [9],
    result[8] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [8],
    result[7] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [7],
    result[6] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [6],
    result[5] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [5],
    result[4] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [4],
    result[3] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [3],
    result[2] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [2],
    result[1] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [1],
    result[0] = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [0],
    operation_rfd = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ,
    underflow = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/UNDERFLOW ,
    overflow = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/OVERFLOW ,
    invalid_op = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/INVALID_OP ,
    rdy = \NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(sig00000001)
  );
  GND   blk00000002 (
    .G(sig00000002)
  );
  DSP48A1 #(
    .A0REG ( 0 ),
    .A1REG ( 1 ),
    .B0REG ( 0 ),
    .B1REG ( 1 ),
    .CARRYINREG ( 0 ),
    .CARRYINSEL ( "OPMODE5" ),
    .CREG ( 0 ),
    .DREG ( 0 ),
    .MREG ( 1 ),
    .OPMODEREG ( 0 ),
    .PREG ( 1 ),
    .RSTTYPE ( "SYNC" ),
    .CARRYOUTREG ( 0 ))
  blk00000003 (
    .CECARRYIN(sig00000002),
    .RSTC(sig00000002),
    .RSTCARRYIN(sig00000002),
    .CED(sig00000002),
    .RSTD(sig00000002),
    .CEOPMODE(sig00000002),
    .CEC(sig00000002),
    .CARRYOUTF(NLW_blk00000003_CARRYOUTF_UNCONNECTED),
    .RSTOPMODE(sig00000002),
    .RSTM(sig00000002),
    .CLK(clk),
    .RSTB(sig00000002),
    .CEM(ce),
    .CEB(ce),
    .CARRYIN(sig00000002),
    .CEP(ce),
    .CEA(ce),
    .CARRYOUT(NLW_blk00000003_CARRYOUT_UNCONNECTED),
    .RSTA(sig00000002),
    .RSTP(sig00000002),
    .B({sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000001, b[9], b[8], b[7], b[6], b[5], b[4], 
b[3], b[2], b[1], b[0]}),
    .BCOUT({\NLW_blk00000003_BCOUT<17>_UNCONNECTED , \NLW_blk00000003_BCOUT<16>_UNCONNECTED , \NLW_blk00000003_BCOUT<15>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<14>_UNCONNECTED , \NLW_blk00000003_BCOUT<13>_UNCONNECTED , \NLW_blk00000003_BCOUT<12>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<11>_UNCONNECTED , \NLW_blk00000003_BCOUT<10>_UNCONNECTED , \NLW_blk00000003_BCOUT<9>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<8>_UNCONNECTED , \NLW_blk00000003_BCOUT<7>_UNCONNECTED , \NLW_blk00000003_BCOUT<6>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<5>_UNCONNECTED , \NLW_blk00000003_BCOUT<4>_UNCONNECTED , \NLW_blk00000003_BCOUT<3>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<2>_UNCONNECTED , \NLW_blk00000003_BCOUT<1>_UNCONNECTED , \NLW_blk00000003_BCOUT<0>_UNCONNECTED }),
    .PCIN({sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, 
sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, 
sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, 
sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, 
sig00000002, sig00000002, sig00000002, sig00000002, sig00000002}),
    .C({\NLW_blk00000003_C<47>_UNCONNECTED , \NLW_blk00000003_C<46>_UNCONNECTED , \NLW_blk00000003_C<45>_UNCONNECTED , 
\NLW_blk00000003_C<44>_UNCONNECTED , \NLW_blk00000003_C<43>_UNCONNECTED , \NLW_blk00000003_C<42>_UNCONNECTED , \NLW_blk00000003_C<41>_UNCONNECTED , 
\NLW_blk00000003_C<40>_UNCONNECTED , \NLW_blk00000003_C<39>_UNCONNECTED , \NLW_blk00000003_C<38>_UNCONNECTED , \NLW_blk00000003_C<37>_UNCONNECTED , 
\NLW_blk00000003_C<36>_UNCONNECTED , \NLW_blk00000003_C<35>_UNCONNECTED , \NLW_blk00000003_C<34>_UNCONNECTED , \NLW_blk00000003_C<33>_UNCONNECTED , 
\NLW_blk00000003_C<32>_UNCONNECTED , \NLW_blk00000003_C<31>_UNCONNECTED , \NLW_blk00000003_C<30>_UNCONNECTED , \NLW_blk00000003_C<29>_UNCONNECTED , 
\NLW_blk00000003_C<28>_UNCONNECTED , \NLW_blk00000003_C<27>_UNCONNECTED , \NLW_blk00000003_C<26>_UNCONNECTED , \NLW_blk00000003_C<25>_UNCONNECTED , 
\NLW_blk00000003_C<24>_UNCONNECTED , \NLW_blk00000003_C<23>_UNCONNECTED , \NLW_blk00000003_C<22>_UNCONNECTED , \NLW_blk00000003_C<21>_UNCONNECTED , 
\NLW_blk00000003_C<20>_UNCONNECTED , \NLW_blk00000003_C<19>_UNCONNECTED , \NLW_blk00000003_C<18>_UNCONNECTED , \NLW_blk00000003_C<17>_UNCONNECTED , 
\NLW_blk00000003_C<16>_UNCONNECTED , \NLW_blk00000003_C<15>_UNCONNECTED , \NLW_blk00000003_C<14>_UNCONNECTED , \NLW_blk00000003_C<13>_UNCONNECTED , 
\NLW_blk00000003_C<12>_UNCONNECTED , \NLW_blk00000003_C<11>_UNCONNECTED , \NLW_blk00000003_C<10>_UNCONNECTED , \NLW_blk00000003_C<9>_UNCONNECTED , 
\NLW_blk00000003_C<8>_UNCONNECTED , \NLW_blk00000003_C<7>_UNCONNECTED , \NLW_blk00000003_C<6>_UNCONNECTED , \NLW_blk00000003_C<5>_UNCONNECTED , 
\NLW_blk00000003_C<4>_UNCONNECTED , \NLW_blk00000003_C<3>_UNCONNECTED , \NLW_blk00000003_C<2>_UNCONNECTED , \NLW_blk00000003_C<1>_UNCONNECTED , 
\NLW_blk00000003_C<0>_UNCONNECTED }),
    .P({\NLW_blk00000003_P<47>_UNCONNECTED , \NLW_blk00000003_P<46>_UNCONNECTED , \NLW_blk00000003_P<45>_UNCONNECTED , 
\NLW_blk00000003_P<44>_UNCONNECTED , \NLW_blk00000003_P<43>_UNCONNECTED , \NLW_blk00000003_P<42>_UNCONNECTED , \NLW_blk00000003_P<41>_UNCONNECTED , 
\NLW_blk00000003_P<40>_UNCONNECTED , \NLW_blk00000003_P<39>_UNCONNECTED , \NLW_blk00000003_P<38>_UNCONNECTED , \NLW_blk00000003_P<37>_UNCONNECTED , 
\NLW_blk00000003_P<36>_UNCONNECTED , sig0000002b, sig0000002c, sig0000002d, sig0000002e, sig0000002f, sig00000030, sig00000031, sig00000032, 
sig00000033, sig00000034, sig00000035, sig00000036, sig00000037, sig00000038, sig00000039, sig0000003a, sig0000003b, sig0000003c, sig0000003d, 
sig0000003e, sig0000003f, sig00000040, sig00000041, sig00000042, sig00000043, sig00000044, sig00000045, sig00000046, sig00000047, sig00000048, 
sig00000049, sig0000004a, sig0000004b, sig0000004c, sig0000004d, sig0000004e}),
    .OPMODE({sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000001}),
    .D({sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002
, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002}),
    .PCOUT({\NLW_blk00000003_PCOUT<47>_UNCONNECTED , \NLW_blk00000003_PCOUT<46>_UNCONNECTED , \NLW_blk00000003_PCOUT<45>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<44>_UNCONNECTED , \NLW_blk00000003_PCOUT<43>_UNCONNECTED , \NLW_blk00000003_PCOUT<42>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<41>_UNCONNECTED , \NLW_blk00000003_PCOUT<40>_UNCONNECTED , \NLW_blk00000003_PCOUT<39>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<38>_UNCONNECTED , \NLW_blk00000003_PCOUT<37>_UNCONNECTED , \NLW_blk00000003_PCOUT<36>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<35>_UNCONNECTED , \NLW_blk00000003_PCOUT<34>_UNCONNECTED , \NLW_blk00000003_PCOUT<33>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<32>_UNCONNECTED , \NLW_blk00000003_PCOUT<31>_UNCONNECTED , \NLW_blk00000003_PCOUT<30>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<29>_UNCONNECTED , \NLW_blk00000003_PCOUT<28>_UNCONNECTED , \NLW_blk00000003_PCOUT<27>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<26>_UNCONNECTED , \NLW_blk00000003_PCOUT<25>_UNCONNECTED , \NLW_blk00000003_PCOUT<24>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<23>_UNCONNECTED , \NLW_blk00000003_PCOUT<22>_UNCONNECTED , \NLW_blk00000003_PCOUT<21>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<20>_UNCONNECTED , \NLW_blk00000003_PCOUT<19>_UNCONNECTED , \NLW_blk00000003_PCOUT<18>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<17>_UNCONNECTED , \NLW_blk00000003_PCOUT<16>_UNCONNECTED , \NLW_blk00000003_PCOUT<15>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<14>_UNCONNECTED , \NLW_blk00000003_PCOUT<13>_UNCONNECTED , \NLW_blk00000003_PCOUT<12>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<11>_UNCONNECTED , \NLW_blk00000003_PCOUT<10>_UNCONNECTED , \NLW_blk00000003_PCOUT<9>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<8>_UNCONNECTED , \NLW_blk00000003_PCOUT<7>_UNCONNECTED , \NLW_blk00000003_PCOUT<6>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<5>_UNCONNECTED , \NLW_blk00000003_PCOUT<4>_UNCONNECTED , \NLW_blk00000003_PCOUT<3>_UNCONNECTED , 
\NLW_blk00000003_PCOUT<2>_UNCONNECTED , \NLW_blk00000003_PCOUT<1>_UNCONNECTED , \NLW_blk00000003_PCOUT<0>_UNCONNECTED }),
    .A({sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000002, sig00000001, a[9], a[8], a[7], a[6], a[5], a[4], 
a[3], a[2], a[1], a[0]}),
    .M({\NLW_blk00000003_M<35>_UNCONNECTED , \NLW_blk00000003_M<34>_UNCONNECTED , \NLW_blk00000003_M<33>_UNCONNECTED , 
\NLW_blk00000003_M<32>_UNCONNECTED , \NLW_blk00000003_M<31>_UNCONNECTED , \NLW_blk00000003_M<30>_UNCONNECTED , \NLW_blk00000003_M<29>_UNCONNECTED , 
\NLW_blk00000003_M<28>_UNCONNECTED , \NLW_blk00000003_M<27>_UNCONNECTED , \NLW_blk00000003_M<26>_UNCONNECTED , \NLW_blk00000003_M<25>_UNCONNECTED , 
\NLW_blk00000003_M<24>_UNCONNECTED , \NLW_blk00000003_M<23>_UNCONNECTED , \NLW_blk00000003_M<22>_UNCONNECTED , \NLW_blk00000003_M<21>_UNCONNECTED , 
\NLW_blk00000003_M<20>_UNCONNECTED , \NLW_blk00000003_M<19>_UNCONNECTED , \NLW_blk00000003_M<18>_UNCONNECTED , \NLW_blk00000003_M<17>_UNCONNECTED , 
\NLW_blk00000003_M<16>_UNCONNECTED , \NLW_blk00000003_M<15>_UNCONNECTED , \NLW_blk00000003_M<14>_UNCONNECTED , \NLW_blk00000003_M<13>_UNCONNECTED , 
\NLW_blk00000003_M<12>_UNCONNECTED , \NLW_blk00000003_M<11>_UNCONNECTED , \NLW_blk00000003_M<10>_UNCONNECTED , \NLW_blk00000003_M<9>_UNCONNECTED , 
\NLW_blk00000003_M<8>_UNCONNECTED , \NLW_blk00000003_M<7>_UNCONNECTED , \NLW_blk00000003_M<6>_UNCONNECTED , \NLW_blk00000003_M<5>_UNCONNECTED , 
\NLW_blk00000003_M<4>_UNCONNECTED , \NLW_blk00000003_M<3>_UNCONNECTED , \NLW_blk00000003_M<2>_UNCONNECTED , \NLW_blk00000003_M<1>_UNCONNECTED , 
\NLW_blk00000003_M<0>_UNCONNECTED })
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000004 (
    .I0(sig00000048),
    .I1(sig00000047),
    .I2(sig00000046),
    .I3(sig00000002),
    .I4(sig00000002),
    .I5(sig00000002),
    .O(sig00000003)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000005 (
    .I0(sig0000004e),
    .I1(sig0000004d),
    .I2(sig0000004c),
    .I3(sig0000004b),
    .I4(sig0000004a),
    .I5(sig00000049),
    .O(sig00000004)
  );
  MUXCY   blk00000006 (
    .CI(sig00000006),
    .DI(sig00000002),
    .S(sig00000003),
    .O(sig00000005)
  );
  MUXCY   blk00000007 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000004),
    .O(sig00000006)
  );
  XORCY   blk00000008 (
    .CI(sig00000005),
    .LI(sig00000002),
    .O(sig0000004f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .CE(ce),
    .D(sig0000004f),
    .Q(sig00000075)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000a (
    .C(clk),
    .CE(ce),
    .D(sig00000001),
    .Q(sig000000e5)
  );
  MUXCY   blk0000000b (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000096),
    .O(sig0000008f)
  );
  MUXCY   blk0000000c (
    .CI(sig0000008f),
    .DI(sig00000002),
    .S(sig00000095),
    .O(sig00000090)
  );
  MUXCY   blk0000000d (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000094),
    .O(sig00000091)
  );
  MUXCY   blk0000000e (
    .CI(sig00000091),
    .DI(sig00000002),
    .S(sig00000093),
    .O(sig00000092)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000f (
    .C(clk),
    .CE(ce),
    .D(sig000000a2),
    .Q(sig00000066)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000010 (
    .C(clk),
    .CE(ce),
    .D(sig000000a3),
    .Q(sig00000065)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000011 (
    .C(clk),
    .CE(ce),
    .D(sig000000a4),
    .Q(sig00000064)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000012 (
    .C(clk),
    .CE(ce),
    .D(sig000000a5),
    .Q(sig00000063)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000013 (
    .C(clk),
    .CE(ce),
    .D(sig000000a9),
    .Q(sig0000008a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000014 (
    .C(clk),
    .CE(ce),
    .D(sig000000ac),
    .Q(sig0000008b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000015 (
    .C(clk),
    .CE(ce),
    .D(sig0000008b),
    .Q(sig0000008c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000016 (
    .C(clk),
    .CE(ce),
    .D(sig0000008c),
    .Q(sig000000b2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000017 (
    .C(clk),
    .CE(ce),
    .D(sig000000aa),
    .Q(sig0000008e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000018 (
    .C(clk),
    .CE(ce),
    .D(sig000000ab),
    .Q(sig0000008d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000019 (
    .C(clk),
    .CE(ce),
    .D(sig000000a0),
    .Q(sig000000b5)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001a (
    .C(clk),
    .CE(ce),
    .D(sig000000b2),
    .Q(sig00000067)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001b (
    .C(clk),
    .CE(ce),
    .D(sig0000009a),
    .Q(sig000000b6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001c (
    .C(clk),
    .CE(ce),
    .D(sig00000099),
    .Q(sig000000b7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001d (
    .C(clk),
    .CE(ce),
    .D(sig00000098),
    .Q(sig000000b9)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001e (
    .C(clk),
    .CE(ce),
    .D(sig00000097),
    .Q(sig000000ba)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001f (
    .C(clk),
    .CE(ce),
    .D(sig00000090),
    .Q(sig000000bb)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000020 (
    .C(clk),
    .CE(ce),
    .D(sig00000092),
    .Q(sig000000b8)
  );
  XORCY   blk00000021 (
    .CI(sig000000c4),
    .LI(sig00000002),
    .O(sig000000c2)
  );
  XORCY   blk00000022 (
    .CI(sig000000c6),
    .LI(sig0000009f),
    .O(sig000000c3)
  );
  MUXCY   blk00000023 (
    .CI(sig000000c6),
    .DI(b[14]),
    .S(sig0000009f),
    .O(sig000000c4)
  );
  XORCY   blk00000024 (
    .CI(sig000000c8),
    .LI(sig0000009e),
    .O(sig000000c5)
  );
  MUXCY   blk00000025 (
    .CI(sig000000c8),
    .DI(b[13]),
    .S(sig0000009e),
    .O(sig000000c6)
  );
  XORCY   blk00000026 (
    .CI(sig000000ca),
    .LI(sig0000009d),
    .O(sig000000c7)
  );
  MUXCY   blk00000027 (
    .CI(sig000000ca),
    .DI(b[12]),
    .S(sig0000009d),
    .O(sig000000c8)
  );
  XORCY   blk00000028 (
    .CI(sig000000cc),
    .LI(sig0000009c),
    .O(sig000000c9)
  );
  MUXCY   blk00000029 (
    .CI(sig000000cc),
    .DI(b[11]),
    .S(sig0000009c),
    .O(sig000000ca)
  );
  XORCY   blk0000002a (
    .CI(sig00000001),
    .LI(sig0000009b),
    .O(sig000000cb)
  );
  MUXCY   blk0000002b (
    .CI(sig00000001),
    .DI(b[10]),
    .S(sig0000009b),
    .O(sig000000cc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002c (
    .C(clk),
    .CE(ce),
    .D(sig000000cb),
    .Q(sig000000bd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002d (
    .C(clk),
    .CE(ce),
    .D(sig000000c9),
    .Q(sig000000be)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002e (
    .C(clk),
    .CE(ce),
    .D(sig000000c7),
    .Q(sig000000bf)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002f (
    .C(clk),
    .CE(ce),
    .D(sig000000c5),
    .Q(sig000000c0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000030 (
    .C(clk),
    .CE(ce),
    .D(sig000000c3),
    .Q(sig000000c1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000031 (
    .C(clk),
    .CE(ce),
    .D(sig000000c2),
    .Q(sig000000bc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000032 (
    .C(clk),
    .CE(ce),
    .D(sig000000a8),
    .Q(sig000000d0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000033 (
    .C(clk),
    .CE(ce),
    .D(sig000000ad),
    .Q(sig000000cf)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000034 (
    .C(clk),
    .CE(ce),
    .D(sig000000a6),
    .Q(sig000000ce)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000035 (
    .C(clk),
    .CE(ce),
    .D(sig000000a7),
    .Q(sig000000cd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000036 (
    .C(clk),
    .CE(ce),
    .D(sig00000088),
    .Q(sig00000062)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000037 (
    .C(clk),
    .CE(ce),
    .D(sig00000089),
    .Q(sig00000060)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .CE(ce),
    .D(sig000000a1),
    .Q(sig0000005e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000039 (
    .C(clk),
    .CE(ce),
    .D(sig00000086),
    .Q(sig0000005f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003a (
    .C(clk),
    .CE(ce),
    .D(sig00000087),
    .Q(sig00000061)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003f (
    .C(clk),
    .CE(ce),
    .D(sig00000039),
    .Q(sig00000068)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000040 (
    .C(clk),
    .CE(ce),
    .D(sig0000003a),
    .Q(sig00000069)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000041 (
    .C(clk),
    .CE(ce),
    .D(sig0000003b),
    .Q(sig0000006a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000042 (
    .C(clk),
    .CE(ce),
    .D(sig0000003c),
    .Q(sig0000006b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000043 (
    .C(clk),
    .CE(ce),
    .D(sig0000003d),
    .Q(sig0000006c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000044 (
    .C(clk),
    .CE(ce),
    .D(sig0000003e),
    .Q(sig0000006d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000045 (
    .C(clk),
    .CE(ce),
    .D(sig0000003f),
    .Q(sig0000006e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000046 (
    .C(clk),
    .CE(ce),
    .D(sig00000040),
    .Q(sig0000006f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000047 (
    .C(clk),
    .CE(ce),
    .D(sig00000041),
    .Q(sig00000070)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000048 (
    .C(clk),
    .CE(ce),
    .D(sig00000042),
    .Q(sig00000071)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000049 (
    .C(clk),
    .CE(ce),
    .D(sig00000043),
    .Q(sig00000072)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004a (
    .C(clk),
    .CE(ce),
    .D(sig00000044),
    .Q(sig00000073)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004b (
    .C(clk),
    .CE(ce),
    .D(sig00000045),
    .Q(sig00000074)
  );
  MUXCY   blk0000004c (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig000000ea),
    .O(sig000000e7)
  );
  MUXCY   blk0000004d (
    .CI(sig000000e7),
    .DI(sig00000002),
    .S(sig00000002),
    .O(sig000000e8)
  );
  MUXCY   blk0000004e (
    .CI(sig000000e8),
    .DI(sig00000001),
    .S(sig000000e9),
    .O(sig000000e4)
  );
  XORCY   blk0000004f (
    .CI(sig000000ed),
    .LI(sig000000db),
    .O(sig000000eb)
  );
  MUXCY   blk00000050 (
    .CI(sig000000ed),
    .DI(sig00000002),
    .S(sig000000db),
    .O(sig000000e3)
  );
  XORCY   blk00000051 (
    .CI(sig000000ef),
    .LI(sig000000da),
    .O(sig000000ec)
  );
  MUXCY   blk00000052 (
    .CI(sig000000ef),
    .DI(sig00000002),
    .S(sig000000da),
    .O(sig000000ed)
  );
  XORCY   blk00000053 (
    .CI(sig000000f1),
    .LI(sig000000d9),
    .O(sig000000ee)
  );
  MUXCY   blk00000054 (
    .CI(sig000000f1),
    .DI(sig00000002),
    .S(sig000000d9),
    .O(sig000000ef)
  );
  XORCY   blk00000055 (
    .CI(sig000000f3),
    .LI(sig000000d8),
    .O(sig000000f0)
  );
  MUXCY   blk00000056 (
    .CI(sig000000f3),
    .DI(sig00000002),
    .S(sig000000d8),
    .O(sig000000f1)
  );
  XORCY   blk00000057 (
    .CI(sig000000e4),
    .LI(sig000000d7),
    .O(sig000000f2)
  );
  MUXCY   blk00000058 (
    .CI(sig000000e4),
    .DI(sig00000002),
    .S(sig000000d7),
    .O(sig000000f3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000059 (
    .C(clk),
    .CE(ce),
    .D(sig000000f2),
    .Q(sig0000007f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005a (
    .C(clk),
    .CE(ce),
    .D(sig000000f0),
    .Q(sig0000007e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005b (
    .C(clk),
    .CE(ce),
    .D(sig000000ee),
    .Q(sig0000007d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005c (
    .C(clk),
    .CE(ce),
    .D(sig000000ec),
    .Q(sig0000007c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005d (
    .C(clk),
    .CE(ce),
    .D(sig000000eb),
    .Q(sig0000007b)
  );
  XORCY   blk0000005e (
    .CI(sig000000f6),
    .LI(sig00000002),
    .O(sig000000f4)
  );
  XORCY   blk0000005f (
    .CI(sig000000f8),
    .LI(sig000000d1),
    .O(sig000000f5)
  );
  MUXCY   blk00000060 (
    .CI(sig000000f8),
    .DI(sig00000001),
    .S(sig000000d1),
    .O(sig000000f6)
  );
  XORCY   blk00000061 (
    .CI(sig000000fa),
    .LI(sig000000d6),
    .O(sig000000f7)
  );
  MUXCY   blk00000062 (
    .CI(sig000000fa),
    .DI(sig00000002),
    .S(sig000000d6),
    .O(sig000000f8)
  );
  XORCY   blk00000063 (
    .CI(sig000000fc),
    .LI(sig000000d5),
    .O(sig000000f9)
  );
  MUXCY   blk00000064 (
    .CI(sig000000fc),
    .DI(sig00000002),
    .S(sig000000d5),
    .O(sig000000fa)
  );
  XORCY   blk00000065 (
    .CI(sig000000fe),
    .LI(sig000000d4),
    .O(sig000000fb)
  );
  MUXCY   blk00000066 (
    .CI(sig000000fe),
    .DI(sig00000002),
    .S(sig000000d4),
    .O(sig000000fc)
  );
  XORCY   blk00000067 (
    .CI(sig00000100),
    .LI(sig000000d3),
    .O(sig000000fd)
  );
  MUXCY   blk00000068 (
    .CI(sig00000100),
    .DI(sig00000002),
    .S(sig000000d3),
    .O(sig000000fe)
  );
  XORCY   blk00000069 (
    .CI(sig000000e3),
    .LI(sig000000d2),
    .O(sig000000ff)
  );
  MUXCY   blk0000006a (
    .CI(sig000000e3),
    .DI(sig00000002),
    .S(sig000000d2),
    .O(sig00000100)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006b (
    .C(clk),
    .CE(ce),
    .D(sig000000ff),
    .Q(sig0000007a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006c (
    .C(clk),
    .CE(ce),
    .D(sig000000fd),
    .Q(sig00000079)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006d (
    .C(clk),
    .CE(ce),
    .D(sig000000fb),
    .Q(sig00000078)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006e (
    .C(clk),
    .CE(ce),
    .D(sig000000f9),
    .Q(sig00000077)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006f (
    .C(clk),
    .CE(ce),
    .D(sig000000f7),
    .Q(sig00000076)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000070 (
    .C(clk),
    .CE(ce),
    .D(sig000000f5),
    .Q(sig000000e2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000071 (
    .C(clk),
    .CE(ce),
    .D(sig000000f4),
    .Q(sig000000e1)
  );
  XORCY   blk00000072 (
    .CI(sig00000101),
    .LI(sig000000e0),
    .O(sig00000080)
  );
  XORCY   blk00000073 (
    .CI(sig00000102),
    .LI(sig00000123),
    .O(sig00000081)
  );
  MUXCY   blk00000074 (
    .CI(sig00000102),
    .DI(sig00000002),
    .S(sig00000123),
    .O(sig00000101)
  );
  XORCY   blk00000075 (
    .CI(sig00000103),
    .LI(sig00000124),
    .O(sig00000082)
  );
  MUXCY   blk00000076 (
    .CI(sig00000103),
    .DI(sig00000002),
    .S(sig00000124),
    .O(sig00000102)
  );
  XORCY   blk00000077 (
    .CI(sig00000104),
    .LI(sig00000125),
    .O(sig00000083)
  );
  MUXCY   blk00000078 (
    .CI(sig00000104),
    .DI(sig00000002),
    .S(sig00000125),
    .O(sig00000103)
  );
  XORCY   blk00000079 (
    .CI(sig000000e1),
    .LI(sig00000126),
    .O(sig00000084)
  );
  MUXCY   blk0000007a (
    .CI(sig000000e1),
    .DI(sig00000002),
    .S(sig00000126),
    .O(sig00000104)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007b (
    .C(clk),
    .D(sig0000010e),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007c (
    .C(clk),
    .D(sig0000010d),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007d (
    .C(clk),
    .D(sig0000010c),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007e (
    .C(clk),
    .D(sig0000010b),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007f (
    .C(clk),
    .D(sig0000010a),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000080 (
    .C(clk),
    .D(sig00000109),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000081 (
    .C(clk),
    .D(sig00000108),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000082 (
    .C(clk),
    .D(sig00000107),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000083 (
    .C(clk),
    .D(sig00000106),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000084 (
    .C(clk),
    .D(sig00000105),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [0])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000085 (
    .C(clk),
    .D(sig00000113),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000086 (
    .C(clk),
    .D(sig00000112),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000087 (
    .C(clk),
    .D(sig00000111),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000088 (
    .C(clk),
    .D(sig00000110),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000089 (
    .C(clk),
    .D(sig0000010f),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008a (
    .C(clk),
    .CE(ce),
    .D(sig00000114),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/UNDERFLOW )
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008b (
    .C(clk),
    .CE(ce),
    .D(sig00000115),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/OVERFLOW )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  blk0000008c (
    .C(clk),
    .CE(sig0000011b),
    .D(sig00000118),
    .R(sclr),
    .Q(sig0000011e)
  );
  FDSE #(
    .INIT ( 1'b1 ))
  blk0000008d (
    .C(clk),
    .CE(sig0000011b),
    .D(sig0000011a),
    .S(sclr),
    .Q(sig00000116)
  );
  FDSE #(
    .INIT ( 1'b1 ))
  blk0000008e (
    .C(clk),
    .CE(sig0000011b),
    .D(sig00000119),
    .S(sclr),
    .Q(sig00000117)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008f (
    .C(clk),
    .CE(ce),
    .D(sig00000120),
    .Q(sig0000011c)
  );
  LUT6 #(
    .INIT ( 64'h000000A8000000AA ))
  blk00000090 (
    .I0(sig000000b0),
    .I1(sig000000af),
    .I2(sig000000ae),
    .I3(sig000000b4),
    .I4(sig000000b3),
    .I5(sig00000068),
    .O(sig000000a5)
  );
  LUT6 #(
    .INIT ( 64'h0202020202000202 ))
  blk00000091 (
    .I0(sig000000b1),
    .I1(sig000000b3),
    .I2(sig000000b4),
    .I3(sig000000ae),
    .I4(sig00000068),
    .I5(sig000000af),
    .O(sig000000a4)
  );
  LUT6 #(
    .INIT ( 64'h1111111101000000 ))
  blk00000092 (
    .I0(sig000000b3),
    .I1(sig000000b4),
    .I2(sig000000ae),
    .I3(sig000000b1),
    .I4(sig00000068),
    .I5(sig000000af),
    .O(sig000000a2)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  blk00000093 (
    .I0(sig000000ae),
    .I1(sig000000b4),
    .I2(sig000000b3),
    .O(sig000000a3)
  );
  LUT6 #(
    .INIT ( 64'hDD00808080008080 ))
  blk00000094 (
    .I0(sig000000ba),
    .I1(sig000000bb),
    .I2(sig000000b6),
    .I3(sig000000b8),
    .I4(sig000000b7),
    .I5(sig000000b9),
    .O(sig000000a9)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA80000000 ))
  blk00000095 (
    .I0(sig000000bc),
    .I1(sig000000bd),
    .I2(sig000000be),
    .I3(sig000000bf),
    .I4(sig000000c0),
    .I5(sig000000c1),
    .O(sig000000a7)
  );
  LUT6 #(
    .INIT ( 64'h1000000000000000 ))
  blk00000096 (
    .I0(sig000000bd),
    .I1(sig000000c1),
    .I2(sig000000bc),
    .I3(sig000000c0),
    .I4(sig000000be),
    .I5(sig000000bf),
    .O(sig000000ad)
  );
  LUT6 #(
    .INIT ( 64'h153E113215141110 ))
  blk00000097 (
    .I0(sig000000b7),
    .I1(sig000000ba),
    .I2(sig000000b6),
    .I3(sig000000b9),
    .I4(sig000000bb),
    .I5(sig000000b8),
    .O(sig000000ab)
  );
  LUT3 #(
    .INIT ( 8'hEC ))
  blk00000098 (
    .I0(sig000000b1),
    .I1(sig000000af),
    .I2(sig00000068),
    .O(sig00000085)
  );
  LUT6 #(
    .INIT ( 64'hF0FFF0FFF0FCF0FE ))
  blk00000099 (
    .I0(sig000000b0),
    .I1(sig000000ae),
    .I2(sig000000b4),
    .I3(sig000000b3),
    .I4(sig00000068),
    .I5(sig00000085),
    .O(sig00000089)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  blk0000009a (
    .I0(sig000000b7),
    .I1(sig000000ba),
    .O(sig000000aa)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000009b (
    .I0(a[15]),
    .I1(b[15]),
    .O(sig000000a0)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000009c (
    .I0(a[10]),
    .I1(b[10]),
    .O(sig0000009b)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000009d (
    .I0(a[11]),
    .I1(b[11]),
    .O(sig0000009c)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000009e (
    .I0(a[12]),
    .I1(b[12]),
    .O(sig0000009d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000009f (
    .I0(a[13]),
    .I1(b[13]),
    .O(sig0000009e)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000a0 (
    .I0(a[14]),
    .I1(b[14]),
    .O(sig0000009f)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000a1 (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig00000093)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk000000a2 (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig00000094)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000a3 (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig00000095)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk000000a4 (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig00000096)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk000000a5 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000097)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk000000a6 (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig00000098)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk000000a7 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig00000099)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk000000a8 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig0000009a)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk000000a9 (
    .I0(sig000000bc),
    .I1(sig000000c1),
    .O(sig000000a6)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000004 ))
  blk000000aa (
    .I0(sig000000bc),
    .I1(sig000000c1),
    .I2(sig000000c0),
    .I3(sig000000bf),
    .I4(sig000000be),
    .I5(sig000000bd),
    .O(sig000000a8)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000ab (
    .I0(sig0000006d),
    .I1(sig0000006e),
    .I2(sig00000068),
    .O(sig000000d2)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000ac (
    .I0(sig0000006c),
    .I1(sig0000006d),
    .I2(sig00000068),
    .O(sig000000d3)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000ad (
    .I0(sig0000006b),
    .I1(sig0000006c),
    .I2(sig00000068),
    .O(sig000000d4)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000ae (
    .I0(sig0000006a),
    .I1(sig0000006b),
    .I2(sig00000068),
    .O(sig000000d5)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000af (
    .I0(sig00000069),
    .I1(sig0000006a),
    .I2(sig00000068),
    .O(sig000000d6)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000b0 (
    .I0(sig00000072),
    .I1(sig00000073),
    .I2(sig00000068),
    .O(sig000000d7)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000b1 (
    .I0(sig00000071),
    .I1(sig00000072),
    .I2(sig00000068),
    .O(sig000000d8)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000b2 (
    .I0(sig00000070),
    .I1(sig00000071),
    .I2(sig00000068),
    .O(sig000000d9)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000b3 (
    .I0(sig0000006f),
    .I1(sig00000070),
    .I2(sig00000068),
    .O(sig000000da)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000000b4 (
    .I0(sig0000006e),
    .I1(sig0000006f),
    .I2(sig00000068),
    .O(sig000000db)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000b5 (
    .I0(sig000000e6),
    .I1(sig000000e5),
    .O(sig000000e0)
  );
  LUT6 #(
    .INIT ( 64'h0F2F0F0F3B3B3333 ))
  blk000000b6 (
    .I0(sig00000075),
    .I1(sig00000074),
    .I2(sig00000073),
    .I3(sig00000072),
    .I4(sig000000e5),
    .I5(sig00000068),
    .O(sig000000e9)
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  blk000000b7 (
    .I0(sig00000075),
    .I1(sig00000074),
    .I2(sig00000073),
    .I3(sig000000e5),
    .O(sig000000ea)
  );
  LUT5 #(
    .INIT ( 32'h44EE44E4 ))
  blk000000b8 (
    .I0(ce),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [3]),
    .I2(sig00000062),
    .I3(sig0000005e),
    .I4(sig00000081),
    .O(sig00000112)
  );
  LUT5 #(
    .INIT ( 32'h44EE44E4 ))
  blk000000b9 (
    .I0(ce),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [4]),
    .I2(sig00000062),
    .I3(sig0000005e),
    .I4(sig00000080),
    .O(sig00000113)
  );
  LUT5 #(
    .INIT ( 32'h44EE44E4 ))
  blk000000ba (
    .I0(ce),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [1]),
    .I2(sig00000062),
    .I3(sig0000005e),
    .I4(sig00000083),
    .O(sig00000110)
  );
  LUT5 #(
    .INIT ( 32'h44EE44E4 ))
  blk000000bb (
    .I0(ce),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [2]),
    .I2(sig00000062),
    .I3(sig0000005e),
    .I4(sig00000082),
    .O(sig00000111)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000bc (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig0000007d),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [2]),
    .O(sig00000107)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000bd (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig0000007f),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [0]),
    .O(sig00000105)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000be (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig0000007e),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [1]),
    .O(sig00000106)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000bf (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig0000007a),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [5]),
    .O(sig0000010a)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000c0 (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig0000007c),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [3]),
    .O(sig00000108)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000c1 (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig0000007b),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [4]),
    .O(sig00000109)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000c2 (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig00000077),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [8]),
    .O(sig0000010d)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000c3 (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig00000079),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [6]),
    .O(sig0000010b)
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  blk000000c4 (
    .I0(ce),
    .I1(sig0000005f),
    .I2(sig00000078),
    .I3(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [7]),
    .O(sig0000010c)
  );
  LUT5 #(
    .INIT ( 32'h44EE44E4 ))
  blk000000c5 (
    .I0(ce),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [0]),
    .I2(sig00000062),
    .I3(sig0000005e),
    .I4(sig00000084),
    .O(sig0000010f)
  );
  LUT5 #(
    .INIT ( 32'h77752220 ))
  blk000000c6 (
    .I0(ce),
    .I1(sig00000060),
    .I2(sig00000061),
    .I3(sig00000076),
    .I4(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [9]),
    .O(sig0000010e)
  );
  LUT3 #(
    .INIT ( 8'hF8 ))
  blk000000c7 (
    .I0(sig00000063),
    .I1(sig000000e2),
    .I2(sig00000065),
    .O(sig00000114)
  );
  LUT3 #(
    .INIT ( 8'hAE ))
  blk000000c8 (
    .I0(sig00000066),
    .I1(sig00000064),
    .I2(sig000000e2),
    .O(sig00000115)
  );
  LUT3 #(
    .INIT ( 8'hF1 ))
  blk000000c9 (
    .I0(sig00000117),
    .I1(sig00000116),
    .I2(sig0000011e),
    .O(sig00000118)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000ca (
    .I0(sig00000117),
    .I1(sig00000116),
    .O(sig00000119)
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  blk000000cb (
    .I0(ce),
    .I1(sig0000011f),
    .I2(sig0000011e),
    .O(sig0000011b)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk000000cc (
    .I0(operation_nd),
    .I1(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ),
    .O(sig00000120)
  );
  LUT2 #(
    .INIT ( 4'hB ))
  blk000000cd (
    .I0(sig000000b9),
    .I1(sig000000b8),
    .O(sig00000121)
  );
  LUT6 #(
    .INIT ( 64'h000008AA08AA08AA ))
  blk000000ce (
    .I0(sig000000b5),
    .I1(sig000000bb),
    .I2(sig000000b6),
    .I3(sig000000ba),
    .I4(sig000000b7),
    .I5(sig00000121),
    .O(sig000000ac)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000cf (
    .C(clk),
    .CE(ce),
    .D(sig00000067),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/sign_op )
  );
  FD #(
    .INIT ( 1'b1 ))
  blk000000d0 (
    .C(clk),
    .D(sig00000122),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000d1 (
    .I0(sig000000df),
    .O(sig00000123)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000d2 (
    .I0(sig000000de),
    .O(sig00000124)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000d3 (
    .I0(sig000000dd),
    .O(sig00000125)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000d4 (
    .I0(sig000000dc),
    .O(sig00000126)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d5 (
    .C(clk),
    .D(sig00000127),
    .Q(sig0000011f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000d6 (
    .C(clk),
    .D(sig00000128),
    .Q(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk000000d7 (
    .I0(sig000000b3),
    .I1(sig000000b4),
    .O(sig00000087)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFCFFFE ))
  blk000000d8 (
    .I0(sig000000b0),
    .I1(sig000000ae),
    .I2(sig000000b4),
    .I3(sig000000b3),
    .I4(sig00000068),
    .I5(sig00000085),
    .O(sig00000086)
  );
  LUT4 #(
    .INIT ( 16'hFF2A ))
  blk000000d9 (
    .I0(sig0000011f),
    .I1(sig0000011e),
    .I2(ce),
    .I3(sclr),
    .O(sig00000127)
  );
  LUT5 #(
    .INIT ( 32'h10105410 ))
  blk000000da (
    .I0(sclr),
    .I1(ce),
    .I2(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/RDY ),
    .I3(sig0000011d),
    .I4(sig0000011f),
    .O(sig00000128)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk000000db (
    .I0(sclr),
    .I1(ce),
    .I2(\NlwRenamedSig_OI_U0/op_inst/FLT_PT_OP/HND_SHK/rfd_int ),
    .O(sig00000122)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF11101010 ))
  blk000000dc (
    .I0(sig000000ae),
    .I1(sig000000b4),
    .I2(sig000000af),
    .I3(sig000000b1),
    .I4(sig00000068),
    .I5(sig000000b3),
    .O(sig00000088)
  );
  LUT4 #(
    .INIT ( 16'h5510 ))
  blk000000dd (
    .I0(sig000000b3),
    .I1(sig000000b0),
    .I2(sig000000ae),
    .I3(sig000000b4),
    .O(sig000000a1)
  );
  INV   blk000000de (
    .I(sig00000068),
    .O(sig000000d1)
  );
  INV   blk000000df (
    .I(sig00000116),
    .O(sig0000011a)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000e0 (
    .A0(sig00000002),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig0000008e),
    .Q(sig00000129),
    .Q15(NLW_blk000000e0_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e1 (
    .C(clk),
    .CE(ce),
    .D(sig00000129),
    .Q(sig000000b3)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000e2 (
    .A0(sig00000002),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig0000008d),
    .Q(sig0000012a),
    .Q15(NLW_blk000000e2_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e3 (
    .C(clk),
    .CE(ce),
    .D(sig0000012a),
    .Q(sig000000b4)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000e4 (
    .A0(sig00000002),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000d0),
    .Q(sig0000012b),
    .Q15(NLW_blk000000e4_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e5 (
    .C(clk),
    .CE(ce),
    .D(sig0000012b),
    .Q(sig000000b0)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000e6 (
    .A0(sig00000002),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000cf),
    .Q(sig0000012c),
    .Q15(NLW_blk000000e6_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e7 (
    .C(clk),
    .CE(ce),
    .D(sig0000012c),
    .Q(sig000000b1)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000e8 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000bd),
    .Q(sig0000012d),
    .Q15(NLW_blk000000e8_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000e9 (
    .C(clk),
    .CE(ce),
    .D(sig0000012d),
    .Q(sig000000dc)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000ea (
    .A0(sig00000002),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000ce),
    .Q(sig0000012e),
    .Q15(NLW_blk000000ea_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000eb (
    .C(clk),
    .CE(ce),
    .D(sig0000012e),
    .Q(sig000000ae)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000ec (
    .A0(sig00000002),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000cd),
    .Q(sig0000012f),
    .Q15(NLW_blk000000ec_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ed (
    .C(clk),
    .CE(ce),
    .D(sig0000012f),
    .Q(sig000000af)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000ee (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000c0),
    .Q(sig00000130),
    .Q15(NLW_blk000000ee_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000ef (
    .C(clk),
    .CE(ce),
    .D(sig00000130),
    .Q(sig000000df)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000f0 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000be),
    .Q(sig00000131),
    .Q15(NLW_blk000000f0_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f1 (
    .C(clk),
    .CE(ce),
    .D(sig00000131),
    .Q(sig000000dd)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000f2 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000bf),
    .Q(sig00000132),
    .Q15(NLW_blk000000f2_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f3 (
    .C(clk),
    .CE(ce),
    .D(sig00000132),
    .Q(sig000000de)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000f4 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig0000011c),
    .Q(sig00000133),
    .Q15(NLW_blk000000f4_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f5 (
    .C(clk),
    .CE(ce),
    .D(sig00000133),
    .Q(sig0000011d)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000f6 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig000000c1),
    .Q(sig00000134),
    .Q15(NLW_blk000000f6_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f7 (
    .C(clk),
    .CE(ce),
    .D(sig00000134),
    .Q(sig000000e6)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000f8 (
    .A0(sig00000002),
    .A1(sig00000001),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(sig0000008a),
    .Q(sig00000135),
    .Q15(NLW_blk000000f8_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f9 (
    .C(clk),
    .CE(ce),
    .D(sig00000135),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/INVALID_OP )
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
