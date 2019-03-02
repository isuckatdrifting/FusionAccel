////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: multiplier.v
// /___/   /\     Timestamp: Sat Mar 02 23:52:03 2019
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/multiplier.ngc C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/multiplier.v 
// Device	: 6slx45fgg484-2
// Input file	: C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/multiplier.ngc
// Output file	: C:/Users/shish/source/repos/FusionAccel/FusionAccel/ipcore_dir/tmp/_cg/multiplier.v
// # of Modules	: 1
// Design Name	: multiplier
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

module multiplier (
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
  
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/sign_op ;
  wire \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  wire NlwRenamedSig_OI_operation_rfd;
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
  wire NLW_blk0000003d_CARRYOUTF_UNCONNECTED;
  wire NLW_blk0000003d_CARRYOUT_UNCONNECTED;
  wire \NLW_blk0000003d_BCOUT<17>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<16>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<15>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<14>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<13>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<12>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<11>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<10>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<9>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<8>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<7>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<6>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<5>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<4>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<3>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<2>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<1>_UNCONNECTED ;
  wire \NLW_blk0000003d_BCOUT<0>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<47>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<46>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<45>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<44>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<43>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<42>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<41>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<40>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<39>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<38>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<37>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<36>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<35>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<34>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<33>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<32>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<31>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<30>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<29>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<28>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<27>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<26>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<25>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<24>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<23>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<22>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<10>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<9>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<8>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<7>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<6>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<5>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<4>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<3>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<2>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<1>_UNCONNECTED ;
  wire \NLW_blk0000003d_P<0>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<47>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<46>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<45>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<44>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<43>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<42>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<41>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<40>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<39>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<38>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<37>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<36>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<35>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<34>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<33>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<32>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<31>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<30>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<29>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<28>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<27>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<26>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<25>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<24>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<23>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<22>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<21>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<20>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<19>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<18>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<17>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<16>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<15>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<14>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<13>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<12>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<11>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<10>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<9>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<8>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<7>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<6>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<5>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<4>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<3>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<2>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<1>_UNCONNECTED ;
  wire \NLW_blk0000003d_PCOUT<0>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<35>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<34>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<33>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<32>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<31>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<30>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<29>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<28>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<27>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<26>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<25>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<24>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<23>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<22>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<21>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<20>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<19>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<18>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<17>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<16>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<15>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<14>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<13>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<12>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<11>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<10>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<9>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<8>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<7>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<6>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<5>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<4>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<3>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<2>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<1>_UNCONNECTED ;
  wire \NLW_blk0000003d_M<0>_UNCONNECTED ;
  wire NLW_blk0000009a_Q15_UNCONNECTED;
  wire NLW_blk0000009c_Q15_UNCONNECTED;
  wire NLW_blk0000009e_Q15_UNCONNECTED;
  wire NLW_blk000000a0_Q15_UNCONNECTED;
  wire NLW_blk000000a2_Q15_UNCONNECTED;
  wire NLW_blk000000a4_Q15_UNCONNECTED;
  wire [4 : 0] \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op ;
  wire [9 : 0] \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op ;
  assign
    result[15] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/sign_op ,
    result[14] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [4],
    result[13] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [3],
    result[12] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [2],
    result[11] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [1],
    result[10] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [0],
    result[9] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [9],
    result[8] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [8],
    result[7] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [7],
    result[6] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [6],
    result[5] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [5],
    result[4] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [4],
    result[3] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [3],
    result[2] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [2],
    result[1] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [1],
    result[0] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [0],
    operation_rfd = NlwRenamedSig_OI_operation_rfd,
    rdy = \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(NlwRenamedSig_OI_operation_rfd)
  );
  GND   blk00000002 (
    .G(sig00000001)
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
    .CECARRYIN(sig00000001),
    .RSTC(sig00000001),
    .RSTCARRYIN(sig00000001),
    .CED(sig00000001),
    .RSTD(sig00000001),
    .CEOPMODE(sig00000001),
    .CEC(sig00000001),
    .CARRYOUTF(NLW_blk00000003_CARRYOUTF_UNCONNECTED),
    .RSTOPMODE(sig00000001),
    .RSTM(sig00000001),
    .CLK(clk),
    .RSTB(sig00000001),
    .CEM(NlwRenamedSig_OI_operation_rfd),
    .CEB(NlwRenamedSig_OI_operation_rfd),
    .CARRYIN(sig00000001),
    .CEP(NlwRenamedSig_OI_operation_rfd),
    .CEA(NlwRenamedSig_OI_operation_rfd),
    .CARRYOUT(NLW_blk00000003_CARRYOUT_UNCONNECTED),
    .RSTA(sig00000001),
    .RSTP(sig00000001),
    .B({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, NlwRenamedSig_OI_operation_rfd, b[9], b[8], b[7], 
b[6], b[5], b[4], b[3], b[2], b[1], b[0]}),
    .BCOUT({\NLW_blk00000003_BCOUT<17>_UNCONNECTED , \NLW_blk00000003_BCOUT<16>_UNCONNECTED , \NLW_blk00000003_BCOUT<15>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<14>_UNCONNECTED , \NLW_blk00000003_BCOUT<13>_UNCONNECTED , \NLW_blk00000003_BCOUT<12>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<11>_UNCONNECTED , \NLW_blk00000003_BCOUT<10>_UNCONNECTED , \NLW_blk00000003_BCOUT<9>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<8>_UNCONNECTED , \NLW_blk00000003_BCOUT<7>_UNCONNECTED , \NLW_blk00000003_BCOUT<6>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<5>_UNCONNECTED , \NLW_blk00000003_BCOUT<4>_UNCONNECTED , \NLW_blk00000003_BCOUT<3>_UNCONNECTED , 
\NLW_blk00000003_BCOUT<2>_UNCONNECTED , \NLW_blk00000003_BCOUT<1>_UNCONNECTED , \NLW_blk00000003_BCOUT<0>_UNCONNECTED }),
    .PCIN({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, 
sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, 
sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, 
sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, 
sig00000001, sig00000001, sig00000001, sig00000001, sig00000001}),
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
    .OPMODE({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, NlwRenamedSig_OI_operation_rfd}),
    .D({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001
, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001}),
    .PCOUT({sig00000068, sig00000069, sig0000006a, sig0000006b, sig0000006c, sig0000006d, sig0000006e, sig0000006f, sig00000070, sig00000071, 
sig00000072, sig00000073, sig00000074, sig00000075, sig00000076, sig00000077, sig00000078, sig00000079, sig0000007a, sig0000007b, sig0000007c, 
sig0000007d, sig0000007e, sig0000007f, sig00000080, sig00000081, sig00000082, sig00000083, sig00000084, sig00000085, sig00000086, sig00000087, 
sig00000088, sig00000089, sig0000008a, sig0000008b, sig0000008c, sig0000008d, sig0000008e, sig0000008f, sig00000090, sig00000091, sig00000092, 
sig00000093, sig00000094, sig00000095, sig00000096, sig00000097}),
    .A({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, NlwRenamedSig_OI_operation_rfd, a[9], a[8], a[7], 
a[6], a[5], a[4], a[3], a[2], a[1], a[0]}),
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
    .I3(sig00000001),
    .I4(sig00000001),
    .I5(sig00000001),
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
    .DI(sig00000001),
    .S(sig00000003),
    .O(sig00000005)
  );
  MUXCY   blk00000007 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000004),
    .O(sig00000006)
  );
  XORCY   blk00000008 (
    .CI(sig00000005),
    .LI(sig00000001),
    .O(sig00000002)
  );
  MUXCY   blk00000009 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000a8),
    .O(sig000000a1)
  );
  MUXCY   blk0000000a (
    .CI(sig000000a1),
    .DI(sig00000001),
    .S(sig000000a7),
    .O(sig000000a2)
  );
  MUXCY   blk0000000b (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000a6),
    .O(sig000000a3)
  );
  MUXCY   blk0000000c (
    .CI(sig000000a3),
    .DI(sig00000001),
    .S(sig000000a5),
    .O(sig000000a4)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000d (
    .C(clk),
    .D(sig000000b9),
    .Q(sig0000009e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000e (
    .C(clk),
    .D(sig0000009e),
    .Q(sig000000bf)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000f (
    .C(clk),
    .D(sig000000b7),
    .Q(sig000000a0)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000010 (
    .C(clk),
    .D(sig000000b8),
    .Q(sig0000009f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000011 (
    .C(clk),
    .D(sig000000a0),
    .Q(sig000000c0)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000012 (
    .C(clk),
    .D(sig0000009f),
    .Q(sig000000c1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000013 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000b2),
    .Q(sig000000c2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000014 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000bf),
    .Q(sig0000005a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000015 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000ac),
    .Q(sig000000c3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000016 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000ab),
    .Q(sig000000c4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000017 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000aa),
    .Q(sig000000c6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000018 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a9),
    .Q(sig000000c7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000019 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a2),
    .Q(sig000000c8)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001a (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000a4),
    .Q(sig000000c5)
  );
  XORCY   blk0000001b (
    .CI(sig000000d1),
    .LI(sig00000001),
    .O(sig000000cf)
  );
  XORCY   blk0000001c (
    .CI(sig000000d3),
    .LI(sig000000b1),
    .O(sig000000d0)
  );
  MUXCY   blk0000001d (
    .CI(sig000000d3),
    .DI(b[14]),
    .S(sig000000b1),
    .O(sig000000d1)
  );
  XORCY   blk0000001e (
    .CI(sig000000d5),
    .LI(sig000000b0),
    .O(sig000000d2)
  );
  MUXCY   blk0000001f (
    .CI(sig000000d5),
    .DI(b[13]),
    .S(sig000000b0),
    .O(sig000000d3)
  );
  XORCY   blk00000020 (
    .CI(sig000000d7),
    .LI(sig000000af),
    .O(sig000000d4)
  );
  MUXCY   blk00000021 (
    .CI(sig000000d7),
    .DI(b[12]),
    .S(sig000000af),
    .O(sig000000d5)
  );
  XORCY   blk00000022 (
    .CI(sig000000d9),
    .LI(sig000000ae),
    .O(sig000000d6)
  );
  MUXCY   blk00000023 (
    .CI(sig000000d9),
    .DI(b[11]),
    .S(sig000000ae),
    .O(sig000000d7)
  );
  XORCY   blk00000024 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .LI(sig000000ad),
    .O(sig000000d8)
  );
  MUXCY   blk00000025 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(b[10]),
    .S(sig000000ad),
    .O(sig000000d9)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000026 (
    .C(clk),
    .D(sig000000d8),
    .Q(sig000000ca)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000027 (
    .C(clk),
    .D(sig000000d6),
    .Q(sig000000cb)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000028 (
    .C(clk),
    .D(sig000000d4),
    .Q(sig000000cc)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000029 (
    .C(clk),
    .D(sig000000d2),
    .Q(sig000000cd)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002a (
    .C(clk),
    .D(sig000000d0),
    .Q(sig000000ce)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000cf),
    .Q(sig000000c9)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002c (
    .C(clk),
    .D(sig000000dd),
    .Q(sig000000bd)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002d (
    .C(clk),
    .D(sig000000dc),
    .Q(sig000000be)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002e (
    .C(clk),
    .D(sig000000db),
    .Q(sig000000bb)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002f (
    .C(clk),
    .D(sig000000da),
    .Q(sig000000bc)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000030 (
    .C(clk),
    .D(sig000000b6),
    .Q(sig000000dd)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000031 (
    .C(clk),
    .D(sig000000ba),
    .Q(sig000000dc)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000032 (
    .C(clk),
    .D(sig000000b4),
    .Q(sig000000db)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000033 (
    .C(clk),
    .D(sig000000b5),
    .Q(sig000000da)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000034 (
    .C(clk),
    .D(sig0000009c),
    .Q(sig00000059)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000035 (
    .C(clk),
    .D(sig0000009d),
    .Q(sig00000057)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000036 (
    .C(clk),
    .D(sig000000b3),
    .Q(sig00000055)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000037 (
    .C(clk),
    .D(sig0000009a),
    .Q(sig00000056)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .D(sig0000009b),
    .Q(sig00000058)
  );
  DSP48A1 #(
    .A0REG ( 0 ),
    .A1REG ( 0 ),
    .B0REG ( 0 ),
    .B1REG ( 0 ),
    .CARRYINREG ( 0 ),
    .CARRYINSEL ( "OPMODE5" ),
    .CREG ( 0 ),
    .DREG ( 0 ),
    .MREG ( 0 ),
    .OPMODEREG ( 0 ),
    .PREG ( 1 ),
    .RSTTYPE ( "SYNC" ),
    .CARRYOUTREG ( 0 ))
  blk0000003d (
    .CECARRYIN(sig00000001),
    .RSTC(sig00000001),
    .RSTCARRYIN(sig00000001),
    .CED(sig00000001),
    .RSTD(sig00000001),
    .CEOPMODE(sig00000001),
    .CEC(sig00000001),
    .CARRYOUTF(NLW_blk0000003d_CARRYOUTF_UNCONNECTED),
    .RSTOPMODE(sig00000001),
    .RSTM(sig00000001),
    .CLK(clk),
    .RSTB(sig00000001),
    .CEM(sig00000001),
    .CEB(sig00000001),
    .CARRYIN(sig00000001),
    .CEP(NlwRenamedSig_OI_operation_rfd),
    .CEA(sig00000001),
    .CARRYOUT(NLW_blk0000003d_CARRYOUT_UNCONNECTED),
    .RSTA(sig00000001),
    .RSTP(sig00000001),
    .B({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, NlwRenamedSig_OI_operation_rfd, sig00000001, sig00000001, 
sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001}),
    .BCOUT({\NLW_blk0000003d_BCOUT<17>_UNCONNECTED , \NLW_blk0000003d_BCOUT<16>_UNCONNECTED , \NLW_blk0000003d_BCOUT<15>_UNCONNECTED , 
\NLW_blk0000003d_BCOUT<14>_UNCONNECTED , \NLW_blk0000003d_BCOUT<13>_UNCONNECTED , \NLW_blk0000003d_BCOUT<12>_UNCONNECTED , 
\NLW_blk0000003d_BCOUT<11>_UNCONNECTED , \NLW_blk0000003d_BCOUT<10>_UNCONNECTED , \NLW_blk0000003d_BCOUT<9>_UNCONNECTED , 
\NLW_blk0000003d_BCOUT<8>_UNCONNECTED , \NLW_blk0000003d_BCOUT<7>_UNCONNECTED , \NLW_blk0000003d_BCOUT<6>_UNCONNECTED , 
\NLW_blk0000003d_BCOUT<5>_UNCONNECTED , \NLW_blk0000003d_BCOUT<4>_UNCONNECTED , \NLW_blk0000003d_BCOUT<3>_UNCONNECTED , 
\NLW_blk0000003d_BCOUT<2>_UNCONNECTED , \NLW_blk0000003d_BCOUT<1>_UNCONNECTED , \NLW_blk0000003d_BCOUT<0>_UNCONNECTED }),
    .PCIN({sig00000068, sig00000069, sig0000006a, sig0000006b, sig0000006c, sig0000006d, sig0000006e, sig0000006f, sig00000070, sig00000071, 
sig00000072, sig00000073, sig00000074, sig00000075, sig00000076, sig00000077, sig00000078, sig00000079, sig0000007a, sig0000007b, sig0000007c, 
sig0000007d, sig0000007e, sig0000007f, sig00000080, sig00000081, sig00000082, sig00000083, sig00000084, sig00000085, sig00000086, sig00000087, 
sig00000088, sig00000089, sig0000008a, sig0000008b, sig0000008c, sig0000008d, sig0000008e, sig0000008f, sig00000090, sig00000091, sig00000092, 
sig00000093, sig00000094, sig00000095, sig00000096, sig00000097}),
    .C({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001
, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, 
sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, 
sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, 
sig00000001, sig00000001, sig00000001, sig00000001}),
    .P({\NLW_blk0000003d_P<47>_UNCONNECTED , \NLW_blk0000003d_P<46>_UNCONNECTED , \NLW_blk0000003d_P<45>_UNCONNECTED , 
\NLW_blk0000003d_P<44>_UNCONNECTED , \NLW_blk0000003d_P<43>_UNCONNECTED , \NLW_blk0000003d_P<42>_UNCONNECTED , \NLW_blk0000003d_P<41>_UNCONNECTED , 
\NLW_blk0000003d_P<40>_UNCONNECTED , \NLW_blk0000003d_P<39>_UNCONNECTED , \NLW_blk0000003d_P<38>_UNCONNECTED , \NLW_blk0000003d_P<37>_UNCONNECTED , 
\NLW_blk0000003d_P<36>_UNCONNECTED , \NLW_blk0000003d_P<35>_UNCONNECTED , \NLW_blk0000003d_P<34>_UNCONNECTED , \NLW_blk0000003d_P<33>_UNCONNECTED , 
\NLW_blk0000003d_P<32>_UNCONNECTED , \NLW_blk0000003d_P<31>_UNCONNECTED , \NLW_blk0000003d_P<30>_UNCONNECTED , \NLW_blk0000003d_P<29>_UNCONNECTED , 
\NLW_blk0000003d_P<28>_UNCONNECTED , \NLW_blk0000003d_P<27>_UNCONNECTED , \NLW_blk0000003d_P<26>_UNCONNECTED , \NLW_blk0000003d_P<25>_UNCONNECTED , 
\NLW_blk0000003d_P<24>_UNCONNECTED , \NLW_blk0000003d_P<23>_UNCONNECTED , \NLW_blk0000003d_P<22>_UNCONNECTED , sig000000fa, sig000000f0, sig000000f9, 
sig000000f8, sig000000f7, sig000000f6, sig000000f5, sig000000f4, sig000000f3, sig000000f2, sig000000f1, \NLW_blk0000003d_P<10>_UNCONNECTED , 
\NLW_blk0000003d_P<9>_UNCONNECTED , \NLW_blk0000003d_P<8>_UNCONNECTED , \NLW_blk0000003d_P<7>_UNCONNECTED , \NLW_blk0000003d_P<6>_UNCONNECTED , 
\NLW_blk0000003d_P<5>_UNCONNECTED , \NLW_blk0000003d_P<4>_UNCONNECTED , \NLW_blk0000003d_P<3>_UNCONNECTED , \NLW_blk0000003d_P<2>_UNCONNECTED , 
\NLW_blk0000003d_P<1>_UNCONNECTED , \NLW_blk0000003d_P<0>_UNCONNECTED }),
    .OPMODE({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, NlwRenamedSig_OI_operation_rfd, NlwRenamedSig_OI_operation_rfd, 
NlwRenamedSig_OI_operation_rfd}),
    .D({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001
, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001}),
    .PCOUT({\NLW_blk0000003d_PCOUT<47>_UNCONNECTED , \NLW_blk0000003d_PCOUT<46>_UNCONNECTED , \NLW_blk0000003d_PCOUT<45>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<44>_UNCONNECTED , \NLW_blk0000003d_PCOUT<43>_UNCONNECTED , \NLW_blk0000003d_PCOUT<42>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<41>_UNCONNECTED , \NLW_blk0000003d_PCOUT<40>_UNCONNECTED , \NLW_blk0000003d_PCOUT<39>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<38>_UNCONNECTED , \NLW_blk0000003d_PCOUT<37>_UNCONNECTED , \NLW_blk0000003d_PCOUT<36>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<35>_UNCONNECTED , \NLW_blk0000003d_PCOUT<34>_UNCONNECTED , \NLW_blk0000003d_PCOUT<33>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<32>_UNCONNECTED , \NLW_blk0000003d_PCOUT<31>_UNCONNECTED , \NLW_blk0000003d_PCOUT<30>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<29>_UNCONNECTED , \NLW_blk0000003d_PCOUT<28>_UNCONNECTED , \NLW_blk0000003d_PCOUT<27>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<26>_UNCONNECTED , \NLW_blk0000003d_PCOUT<25>_UNCONNECTED , \NLW_blk0000003d_PCOUT<24>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<23>_UNCONNECTED , \NLW_blk0000003d_PCOUT<22>_UNCONNECTED , \NLW_blk0000003d_PCOUT<21>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<20>_UNCONNECTED , \NLW_blk0000003d_PCOUT<19>_UNCONNECTED , \NLW_blk0000003d_PCOUT<18>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<17>_UNCONNECTED , \NLW_blk0000003d_PCOUT<16>_UNCONNECTED , \NLW_blk0000003d_PCOUT<15>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<14>_UNCONNECTED , \NLW_blk0000003d_PCOUT<13>_UNCONNECTED , \NLW_blk0000003d_PCOUT<12>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<11>_UNCONNECTED , \NLW_blk0000003d_PCOUT<10>_UNCONNECTED , \NLW_blk0000003d_PCOUT<9>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<8>_UNCONNECTED , \NLW_blk0000003d_PCOUT<7>_UNCONNECTED , \NLW_blk0000003d_PCOUT<6>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<5>_UNCONNECTED , \NLW_blk0000003d_PCOUT<4>_UNCONNECTED , \NLW_blk0000003d_PCOUT<3>_UNCONNECTED , 
\NLW_blk0000003d_PCOUT<2>_UNCONNECTED , \NLW_blk0000003d_PCOUT<1>_UNCONNECTED , \NLW_blk0000003d_PCOUT<0>_UNCONNECTED }),
    .A({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001
, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001}),
    .M({\NLW_blk0000003d_M<35>_UNCONNECTED , \NLW_blk0000003d_M<34>_UNCONNECTED , \NLW_blk0000003d_M<33>_UNCONNECTED , 
\NLW_blk0000003d_M<32>_UNCONNECTED , \NLW_blk0000003d_M<31>_UNCONNECTED , \NLW_blk0000003d_M<30>_UNCONNECTED , \NLW_blk0000003d_M<29>_UNCONNECTED , 
\NLW_blk0000003d_M<28>_UNCONNECTED , \NLW_blk0000003d_M<27>_UNCONNECTED , \NLW_blk0000003d_M<26>_UNCONNECTED , \NLW_blk0000003d_M<25>_UNCONNECTED , 
\NLW_blk0000003d_M<24>_UNCONNECTED , \NLW_blk0000003d_M<23>_UNCONNECTED , \NLW_blk0000003d_M<22>_UNCONNECTED , \NLW_blk0000003d_M<21>_UNCONNECTED , 
\NLW_blk0000003d_M<20>_UNCONNECTED , \NLW_blk0000003d_M<19>_UNCONNECTED , \NLW_blk0000003d_M<18>_UNCONNECTED , \NLW_blk0000003d_M<17>_UNCONNECTED , 
\NLW_blk0000003d_M<16>_UNCONNECTED , \NLW_blk0000003d_M<15>_UNCONNECTED , \NLW_blk0000003d_M<14>_UNCONNECTED , \NLW_blk0000003d_M<13>_UNCONNECTED , 
\NLW_blk0000003d_M<12>_UNCONNECTED , \NLW_blk0000003d_M<11>_UNCONNECTED , \NLW_blk0000003d_M<10>_UNCONNECTED , \NLW_blk0000003d_M<9>_UNCONNECTED , 
\NLW_blk0000003d_M<8>_UNCONNECTED , \NLW_blk0000003d_M<7>_UNCONNECTED , \NLW_blk0000003d_M<6>_UNCONNECTED , \NLW_blk0000003d_M<5>_UNCONNECTED , 
\NLW_blk0000003d_M<4>_UNCONNECTED , \NLW_blk0000003d_M<3>_UNCONNECTED , \NLW_blk0000003d_M<2>_UNCONNECTED , \NLW_blk0000003d_M<1>_UNCONNECTED , 
\NLW_blk0000003d_M<0>_UNCONNECTED })
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003e (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000df),
    .Q(sig000000e4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig000000e0),
    .Q(sig000000e3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000040 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000039),
    .Q(sig000000e2)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000041 (
    .C(clk),
    .D(sig0000003a),
    .Q(sig000000e5)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000042 (
    .C(clk),
    .D(sig0000003b),
    .Q(sig000000ef)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000043 (
    .C(clk),
    .D(sig0000003c),
    .Q(sig000000ee)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000044 (
    .C(clk),
    .D(sig0000003d),
    .Q(sig000000ed)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000045 (
    .C(clk),
    .D(sig0000003e),
    .Q(sig000000ec)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000046 (
    .C(clk),
    .D(sig0000003f),
    .Q(sig000000eb)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000047 (
    .C(clk),
    .D(sig00000040),
    .Q(sig000000ea)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000048 (
    .C(clk),
    .D(sig00000041),
    .Q(sig000000e9)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000049 (
    .C(clk),
    .D(sig00000042),
    .Q(sig000000e8)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004a (
    .C(clk),
    .D(sig00000043),
    .Q(sig000000e7)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004b (
    .C(clk),
    .D(sig000000e1),
    .Q(sig000000e6)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004c (
    .C(clk),
    .D(sig00000104),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004d (
    .C(clk),
    .D(sig00000103),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004e (
    .C(clk),
    .D(sig00000102),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004f (
    .C(clk),
    .D(sig00000101),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000050 (
    .C(clk),
    .D(sig00000100),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000051 (
    .C(clk),
    .D(sig000000ff),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000052 (
    .C(clk),
    .D(sig000000fe),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000053 (
    .C(clk),
    .D(sig000000fd),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000054 (
    .C(clk),
    .D(sig000000fc),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000055 (
    .C(clk),
    .D(sig000000fb),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [0])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000056 (
    .C(clk),
    .D(sig00000109),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000057 (
    .C(clk),
    .D(sig00000108),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000058 (
    .C(clk),
    .D(sig00000107),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000059 (
    .C(clk),
    .D(sig00000106),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000005a (
    .C(clk),
    .D(sig00000105),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [0])
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA80000000 ))
  blk0000005b (
    .I0(sig000000c9),
    .I1(sig000000ca),
    .I2(sig000000cb),
    .I3(sig000000cc),
    .I4(sig000000cd),
    .I5(sig000000ce),
    .O(sig000000b5)
  );
  LUT6 #(
    .INIT ( 64'h1000000000000000 ))
  blk0000005c (
    .I0(sig000000ca),
    .I1(sig000000ce),
    .I2(sig000000c9),
    .I3(sig000000cd),
    .I4(sig000000cb),
    .I5(sig000000cc),
    .O(sig000000ba)
  );
  LUT6 #(
    .INIT ( 64'h153E113215141110 ))
  blk0000005d (
    .I0(sig000000c4),
    .I1(sig000000c7),
    .I2(sig000000c3),
    .I3(sig000000c6),
    .I4(sig000000c8),
    .I5(sig000000c5),
    .O(sig000000b8)
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  blk0000005e (
    .I0(sig000000bc),
    .I1(sig000000be),
    .I2(sig00000039),
    .O(sig00000099)
  );
  LUT6 #(
    .INIT ( 64'hF0FFF0FFF0FCF0FE ))
  blk0000005f (
    .I0(sig000000bd),
    .I1(sig000000bb),
    .I2(sig000000c1),
    .I3(sig000000c0),
    .I4(sig00000039),
    .I5(sig00000099),
    .O(sig0000009d)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  blk00000060 (
    .I0(sig000000c4),
    .I1(sig000000c7),
    .O(sig000000b7)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000061 (
    .I0(a[15]),
    .I1(b[15]),
    .O(sig000000b2)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000062 (
    .I0(a[10]),
    .I1(b[10]),
    .O(sig000000ad)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000063 (
    .I0(a[11]),
    .I1(b[11]),
    .O(sig000000ae)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000064 (
    .I0(a[12]),
    .I1(b[12]),
    .O(sig000000af)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000065 (
    .I0(a[13]),
    .I1(b[13]),
    .O(sig000000b0)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000066 (
    .I0(a[14]),
    .I1(b[14]),
    .O(sig000000b1)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000067 (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig000000a5)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000068 (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig000000a6)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000069 (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig000000a7)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000006a (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig000000a8)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk0000006b (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig000000a9)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk0000006c (
    .I0(a[14]),
    .I1(a[13]),
    .I2(a[12]),
    .I3(a[11]),
    .I4(a[10]),
    .O(sig000000aa)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk0000006d (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig000000ab)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk0000006e (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig000000ac)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk0000006f (
    .I0(sig000000c9),
    .I1(sig000000ce),
    .O(sig000000b4)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000004 ))
  blk00000070 (
    .I0(sig000000c9),
    .I1(sig000000ce),
    .I2(sig000000cd),
    .I3(sig000000cc),
    .I4(sig000000cb),
    .I5(sig000000ca),
    .O(sig000000b6)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk00000071 (
    .I0(sig00000039),
    .I1(sig00000044),
    .I2(sig00000045),
    .O(sig000000e0)
  );
  LUT4 #(
    .INIT ( 16'hAAAE ))
  blk00000072 (
    .I0(sig00000044),
    .I1(sig00000045),
    .I2(sig00000039),
    .I3(sig00000002),
    .O(sig000000e1)
  );
  LUT5 #(
    .INIT ( 32'hE0C0F0C0 ))
  blk00000073 (
    .I0(sig00000043),
    .I1(sig00000045),
    .I2(sig00000044),
    .I3(sig00000039),
    .I4(sig00000002),
    .O(sig000000df)
  );
  LUT5 #(
    .INIT ( 32'h5F7F5FFF ))
  blk00000074 (
    .I0(sig00000053),
    .I1(sig000000e3),
    .I2(sig00000054),
    .I3(sig000000e2),
    .I4(sig000000fa),
    .O(sig000000de)
  );
  LUT3 #(
    .INIT ( 8'hEC ))
  blk00000075 (
    .I0(sig000000e3),
    .I1(sig000000e2),
    .I2(sig000000fa),
    .O(sig00000098)
  );
  LUT6 #(
    .INIT ( 64'h4505410144044000 ))
  blk00000076 (
    .I0(sig00000056),
    .I1(sig000000e2),
    .I2(sig000000e4),
    .I3(sig000000f1),
    .I4(sig000000e7),
    .I5(sig000000e6),
    .O(sig000000fb)
  );
  LUT6 #(
    .INIT ( 64'h5555555511141414 ))
  blk00000077 (
    .I0(sig00000055),
    .I1(sig00000054),
    .I2(sig000000e2),
    .I3(sig000000fa),
    .I4(sig000000e3),
    .I5(sig00000059),
    .O(sig00000105)
  );
  LUT2 #(
    .INIT ( 4'hB ))
  blk00000078 (
    .I0(sig000000c6),
    .I1(sig000000c5),
    .O(sig0000010a)
  );
  LUT6 #(
    .INIT ( 64'h0020202000AAAAAA ))
  blk00000079 (
    .I0(sig000000c2),
    .I1(sig000000c3),
    .I2(sig000000c8),
    .I3(sig0000010a),
    .I4(sig000000c4),
    .I5(sig000000c7),
    .O(sig000000b9)
  );
  LUT3 #(
    .INIT ( 8'h35 ))
  blk0000007a (
    .I0(sig000000e7),
    .I1(sig000000e8),
    .I2(sig000000e2),
    .O(sig0000010b)
  );
  LUT6 #(
    .INIT ( 64'h4440004055511151 ))
  blk0000007b (
    .I0(sig00000056),
    .I1(sig000000e4),
    .I2(sig000000f1),
    .I3(sig000000e2),
    .I4(sig000000f2),
    .I5(sig0000010b),
    .O(sig000000fc)
  );
  LUT3 #(
    .INIT ( 8'h35 ))
  blk0000007c (
    .I0(sig000000e8),
    .I1(sig000000e9),
    .I2(sig000000e2),
    .O(sig0000010c)
  );
  LUT6 #(
    .INIT ( 64'h4440004055511151 ))
  blk0000007d (
    .I0(sig00000056),
    .I1(sig000000e4),
    .I2(sig000000f2),
    .I3(sig000000e2),
    .I4(sig000000f3),
    .I5(sig0000010c),
    .O(sig000000fd)
  );
  LUT3 #(
    .INIT ( 8'h35 ))
  blk0000007e (
    .I0(sig000000e9),
    .I1(sig000000ea),
    .I2(sig000000e2),
    .O(sig0000010d)
  );
  LUT6 #(
    .INIT ( 64'h4440004055511151 ))
  blk0000007f (
    .I0(sig00000056),
    .I1(sig000000e4),
    .I2(sig000000f3),
    .I3(sig000000e2),
    .I4(sig000000f4),
    .I5(sig0000010d),
    .O(sig000000fe)
  );
  LUT3 #(
    .INIT ( 8'h35 ))
  blk00000080 (
    .I0(sig000000ea),
    .I1(sig000000eb),
    .I2(sig000000e2),
    .O(sig0000010e)
  );
  LUT6 #(
    .INIT ( 64'h4440004055511151 ))
  blk00000081 (
    .I0(sig00000056),
    .I1(sig000000e4),
    .I2(sig000000f4),
    .I3(sig000000e2),
    .I4(sig000000f5),
    .I5(sig0000010e),
    .O(sig000000ff)
  );
  LUT3 #(
    .INIT ( 8'h35 ))
  blk00000082 (
    .I0(sig000000eb),
    .I1(sig000000ec),
    .I2(sig000000e2),
    .O(sig0000010f)
  );
  LUT6 #(
    .INIT ( 64'h4440004055511151 ))
  blk00000083 (
    .I0(sig00000056),
    .I1(sig000000e4),
    .I2(sig000000f5),
    .I3(sig000000e2),
    .I4(sig000000f6),
    .I5(sig0000010f),
    .O(sig00000100)
  );
  LUT3 #(
    .INIT ( 8'h35 ))
  blk00000084 (
    .I0(sig000000ec),
    .I1(sig000000ed),
    .I2(sig000000e2),
    .O(sig00000110)
  );
  LUT6 #(
    .INIT ( 64'h4440004055511151 ))
  blk00000085 (
    .I0(sig00000056),
    .I1(sig000000e4),
    .I2(sig000000f6),
    .I3(sig000000e2),
    .I4(sig000000f7),
    .I5(sig00000110),
    .O(sig00000101)
  );
  LUT3 #(
    .INIT ( 8'h35 ))
  blk00000086 (
    .I0(sig000000ed),
    .I1(sig000000ee),
    .I2(sig000000e2),
    .O(sig00000111)
  );
  LUT6 #(
    .INIT ( 64'h4440004055511151 ))
  blk00000087 (
    .I0(sig00000056),
    .I1(sig000000e4),
    .I2(sig000000f7),
    .I3(sig000000e2),
    .I4(sig000000f8),
    .I5(sig00000111),
    .O(sig00000102)
  );
  LUT3 #(
    .INIT ( 8'h35 ))
  blk00000088 (
    .I0(sig000000ee),
    .I1(sig000000ef),
    .I2(sig000000e2),
    .O(sig00000112)
  );
  LUT6 #(
    .INIT ( 64'h4440004055511151 ))
  blk00000089 (
    .I0(sig00000056),
    .I1(sig000000e4),
    .I2(sig000000f8),
    .I3(sig000000e2),
    .I4(sig000000f9),
    .I5(sig00000112),
    .O(sig00000103)
  );
  LUT5 #(
    .INIT ( 32'hAAFEAAAE ))
  blk0000008a (
    .I0(sig00000058),
    .I1(sig000000ef),
    .I2(sig000000e4),
    .I3(sig000000e2),
    .I4(sig000000f9),
    .O(sig00000113)
  );
  LUT6 #(
    .INIT ( 64'h5555555540444000 ))
  blk0000008b (
    .I0(sig00000057),
    .I1(sig000000e2),
    .I2(sig000000f0),
    .I3(sig000000e4),
    .I4(sig000000e5),
    .I5(sig00000113),
    .O(sig00000104)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  blk0000008c (
    .I0(sig00000053),
    .I1(sig00000054),
    .O(sig00000114)
  );
  LUT6 #(
    .INIT ( 64'h0E0F0E0E0C0D0C0C ))
  blk0000008d (
    .I0(sig00000052),
    .I1(sig00000059),
    .I2(sig00000055),
    .I3(sig00000114),
    .I4(sig00000098),
    .I5(sig000000de),
    .O(sig00000107)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk0000008e (
    .I0(sig00000050),
    .I1(sig00000051),
    .I2(sig00000052),
    .I3(sig00000053),
    .I4(sig00000054),
    .O(sig00000115)
  );
  LUT6 #(
    .INIT ( 64'h5555555510111111 ))
  blk0000008f (
    .I0(sig00000055),
    .I1(sig00000050),
    .I2(sig000000de),
    .I3(sig00000052),
    .I4(sig00000051),
    .I5(sig00000116),
    .O(sig00000109)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000090 (
    .C(clk),
    .D(sig0000005a),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/sign_op )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk00000091 (
    .I0(sig000000c0),
    .I1(sig000000c1),
    .O(sig0000009b)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFCFFFE ))
  blk00000092 (
    .I0(sig000000bd),
    .I1(sig000000bb),
    .I2(sig000000c1),
    .I3(sig000000c0),
    .I4(sig00000039),
    .I5(sig00000099),
    .O(sig0000009a)
  );
  LUT5 #(
    .INIT ( 32'hFEFCCCCC ))
  blk00000093 (
    .I0(sig000000e3),
    .I1(sig00000059),
    .I2(sig000000e2),
    .I3(sig000000fa),
    .I4(sig00000115),
    .O(sig00000116)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF11101010 ))
  blk00000094 (
    .I0(sig000000bb),
    .I1(sig000000c1),
    .I2(sig000000bc),
    .I3(sig000000be),
    .I4(sig00000039),
    .I5(sig000000c0),
    .O(sig0000009c)
  );
  MUXF7   blk00000095 (
    .I0(sig00000117),
    .I1(sig00000118),
    .S(sig000000fa),
    .O(sig00000106)
  );
  LUT5 #(
    .INIT ( 32'h55551444 ))
  blk00000096 (
    .I0(sig00000055),
    .I1(sig00000053),
    .I2(sig00000054),
    .I3(sig000000e2),
    .I4(sig00000059),
    .O(sig00000117)
  );
  LUT6 #(
    .INIT ( 64'h5555555514141444 ))
  blk00000097 (
    .I0(sig00000055),
    .I1(sig00000053),
    .I2(sig00000054),
    .I3(sig000000e3),
    .I4(sig000000e2),
    .I5(sig00000059),
    .O(sig00000118)
  );
  LUT4 #(
    .INIT ( 16'h5504 ))
  blk00000098 (
    .I0(sig000000c0),
    .I1(sig000000bb),
    .I2(sig000000bd),
    .I3(sig000000c1),
    .O(sig000000b3)
  );
  LUT5 #(
    .INIT ( 32'h00FA00F6 ))
  blk00000099 (
    .I0(sig00000051),
    .I1(sig00000052),
    .I2(sig00000059),
    .I3(sig00000055),
    .I4(sig000000de),
    .O(sig00000108)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000009a (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000cc),
    .Q(sig00000119),
    .Q15(NLW_blk0000009a_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009b (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig00000119),
    .Q(sig00000052)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000009c (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000ce),
    .Q(sig0000011a),
    .Q15(NLW_blk0000009c_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009d (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000011a),
    .Q(sig00000050)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk0000009e (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000cd),
    .Q(sig0000011b),
    .Q15(NLW_blk0000009e_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009f (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000011b),
    .Q(sig00000051)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000a0 (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(NlwRenamedSig_OI_operation_rfd),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(operation_nd),
    .Q(sig0000011c),
    .Q15(NLW_blk000000a0_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a1 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000011c),
    .Q(\U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000a2 (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000cb),
    .Q(sig0000011d),
    .Q15(NLW_blk000000a2_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a3 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000011d),
    .Q(sig00000053)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000a4 (
    .A0(NlwRenamedSig_OI_operation_rfd),
    .A1(sig00000001),
    .A2(sig00000001),
    .A3(sig00000001),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .CLK(clk),
    .D(sig000000ca),
    .Q(sig0000011e),
    .Q15(NLW_blk000000a4_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a5 (
    .C(clk),
    .CE(NlwRenamedSig_OI_operation_rfd),
    .D(sig0000011e),
    .Q(sig00000054)
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
