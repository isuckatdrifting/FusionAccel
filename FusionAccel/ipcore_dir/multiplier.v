////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: multiplier.v
// /___/   /\     Timestamp: Tue Mar 12 20:17:49 2019
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
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_0 ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_1 ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_2 ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_3 ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_4 ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_5 ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_6 ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_7 ;
  wire \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_8 ;
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
  wire sig0000004f;
  wire sig0000005d;
  wire sig0000005e;
  wire sig0000005f;
  wire sig00000060;
  wire sig00000061;
  wire sig00000062;
  wire sig00000063;
  wire sig00000064;
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
  wire NLW_blk00000029_O_UNCONNECTED;
  wire [4 : 0] \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op ;
  wire [9 : 9] \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op ;
  assign
    result[15] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/sign_op ,
    result[14] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [4],
    result[13] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [3],
    result[12] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [2],
    result[11] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [1],
    result[10] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [0],
    result[9] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [9],
    result[8] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_0 ,
    result[7] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_1 ,
    result[6] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_2 ,
    result[5] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_3 ,
    result[4] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_4 ,
    result[3] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_5 ,
    result[2] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_6 ,
    result[1] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_7 ,
    result[0] = \U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_8 ,
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
    .A1REG ( 0 ),
    .B0REG ( 0 ),
    .B1REG ( 0 ),
    .CARRYINREG ( 0 ),
    .CARRYINSEL ( "OPMODE5" ),
    .CREG ( 0 ),
    .DREG ( 0 ),
    .MREG ( 0 ),
    .OPMODEREG ( 0 ),
    .PREG ( 0 ),
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
    .CEM(sig00000001),
    .CEB(sig00000001),
    .CARRYIN(sig00000001),
    .CEP(sig00000001),
    .CEA(sig00000001),
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
    .O(sig0000004f)
  );
  FDR #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .D(NlwRenamedSig_OI_operation_rfd),
    .R(sig00000002),
    .Q(\U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  MUXCY   blk0000000a (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig0000007d),
    .O(sig00000078)
  );
  MUXCY   blk0000000b (
    .CI(sig00000078),
    .DI(sig00000001),
    .S(sig0000007c),
    .O(sig00000088)
  );
  MUXCY   blk0000000c (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig0000007b),
    .O(sig00000079)
  );
  MUXCY   blk0000000d (
    .CI(sig00000079),
    .DI(sig00000001),
    .S(sig0000007a),
    .O(sig00000087)
  );
  XORCY   blk0000000e (
    .CI(sig0000008a),
    .LI(sig00000085),
    .O(sig0000005d)
  );
  MUXCY   blk0000000f (
    .CI(sig0000008a),
    .DI(b[14]),
    .S(sig00000085),
    .O(sig00000089)
  );
  XORCY   blk00000010 (
    .CI(sig0000008b),
    .LI(sig00000084),
    .O(sig0000005e)
  );
  MUXCY   blk00000011 (
    .CI(sig0000008b),
    .DI(b[13]),
    .S(sig00000084),
    .O(sig0000008a)
  );
  XORCY   blk00000012 (
    .CI(sig0000008c),
    .LI(sig00000083),
    .O(sig0000005f)
  );
  MUXCY   blk00000013 (
    .CI(sig0000008c),
    .DI(b[12]),
    .S(sig00000083),
    .O(sig0000008b)
  );
  XORCY   blk00000014 (
    .CI(sig0000008d),
    .LI(sig00000082),
    .O(sig00000060)
  );
  MUXCY   blk00000015 (
    .CI(sig0000008d),
    .DI(b[11]),
    .S(sig00000082),
    .O(sig0000008c)
  );
  XORCY   blk00000016 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .LI(sig00000081),
    .O(sig00000061)
  );
  MUXCY   blk00000017 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(b[10]),
    .S(sig00000081),
    .O(sig0000008d)
  );
  MUXCY   blk0000001c (
    .CI(sig000000a0),
    .DI(sig00000001),
    .S(sig00000098),
    .O(sig0000008e)
  );
  XORCY   blk0000001d (
    .CI(sig000000a0),
    .LI(sig00000098),
    .O(sig0000006f)
  );
  MUXCY   blk0000001e (
    .CI(sig0000008e),
    .DI(sig00000001),
    .S(sig00000099),
    .O(sig0000008f)
  );
  XORCY   blk0000001f (
    .CI(sig0000008e),
    .LI(sig00000099),
    .O(sig0000006e)
  );
  MUXCY   blk00000020 (
    .CI(sig0000008f),
    .DI(sig00000001),
    .S(sig0000009a),
    .O(sig00000090)
  );
  XORCY   blk00000021 (
    .CI(sig0000008f),
    .LI(sig0000009a),
    .O(sig0000006d)
  );
  MUXCY   blk00000022 (
    .CI(sig00000090),
    .DI(sig00000001),
    .S(sig0000009b),
    .O(sig00000091)
  );
  XORCY   blk00000023 (
    .CI(sig00000090),
    .LI(sig0000009b),
    .O(sig0000006c)
  );
  MUXCY   blk00000024 (
    .CI(sig00000091),
    .DI(sig00000001),
    .S(sig0000009c),
    .O(sig0000009f)
  );
  XORCY   blk00000025 (
    .CI(sig00000091),
    .LI(sig0000009c),
    .O(sig0000006b)
  );
  MUXCY   blk00000026 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000a4),
    .O(sig000000a1)
  );
  MUXCY   blk00000027 (
    .CI(sig000000a1),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000000a2)
  );
  MUXCY   blk00000028 (
    .CI(sig000000a2),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig000000a3),
    .O(sig000000a0)
  );
  XORCY   blk00000029 (
    .CI(sig000000a5),
    .LI(sig00000092),
    .O(NLW_blk00000029_O_UNCONNECTED)
  );
  MUXCY   blk0000002a (
    .CI(sig000000a5),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000092),
    .O(sig0000009e)
  );
  XORCY   blk0000002b (
    .CI(sig000000a6),
    .LI(sig00000097),
    .O(sig00000066)
  );
  MUXCY   blk0000002c (
    .CI(sig000000a6),
    .DI(sig00000001),
    .S(sig00000097),
    .O(sig000000a5)
  );
  XORCY   blk0000002d (
    .CI(sig000000a7),
    .LI(sig00000096),
    .O(sig00000067)
  );
  MUXCY   blk0000002e (
    .CI(sig000000a7),
    .DI(sig00000001),
    .S(sig00000096),
    .O(sig000000a6)
  );
  XORCY   blk0000002f (
    .CI(sig000000a8),
    .LI(sig00000095),
    .O(sig00000068)
  );
  MUXCY   blk00000030 (
    .CI(sig000000a8),
    .DI(sig00000001),
    .S(sig00000095),
    .O(sig000000a7)
  );
  XORCY   blk00000031 (
    .CI(sig000000a9),
    .LI(sig00000094),
    .O(sig00000069)
  );
  MUXCY   blk00000032 (
    .CI(sig000000a9),
    .DI(sig00000001),
    .S(sig00000094),
    .O(sig000000a8)
  );
  XORCY   blk00000033 (
    .CI(sig0000009f),
    .LI(sig00000093),
    .O(sig0000006a)
  );
  MUXCY   blk00000034 (
    .CI(sig0000009f),
    .DI(sig00000001),
    .S(sig00000093),
    .O(sig000000a9)
  );
  XORCY   blk00000035 (
    .CI(sig000000aa),
    .LI(sig0000009d),
    .O(sig00000070)
  );
  XORCY   blk00000036 (
    .CI(sig000000ab),
    .LI(sig000000bf),
    .O(sig00000071)
  );
  MUXCY   blk00000037 (
    .CI(sig000000ab),
    .DI(sig00000001),
    .S(sig000000bf),
    .O(sig000000aa)
  );
  XORCY   blk00000038 (
    .CI(sig000000ac),
    .LI(sig000000c0),
    .O(sig00000072)
  );
  MUXCY   blk00000039 (
    .CI(sig000000ac),
    .DI(sig00000001),
    .S(sig000000c0),
    .O(sig000000ab)
  );
  XORCY   blk0000003a (
    .CI(sig000000ad),
    .LI(sig000000c1),
    .O(sig00000073)
  );
  MUXCY   blk0000003b (
    .CI(sig000000ad),
    .DI(sig00000001),
    .S(sig000000c1),
    .O(sig000000ac)
  );
  XORCY   blk0000003c (
    .CI(sig0000009e),
    .LI(sig000000c2),
    .O(sig00000074)
  );
  MUXCY   blk0000003d (
    .CI(sig0000009e),
    .DI(sig00000001),
    .S(sig000000c2),
    .O(sig000000ad)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003e (
    .C(clk),
    .D(sig000000b6),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_0 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003f (
    .C(clk),
    .D(sig000000b5),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_1 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000040 (
    .C(clk),
    .D(sig000000b4),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_2 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000041 (
    .C(clk),
    .D(sig000000b3),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_3 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000042 (
    .C(clk),
    .D(sig000000b2),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_4 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000043 (
    .C(clk),
    .D(sig000000b1),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_5 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000044 (
    .C(clk),
    .D(sig000000b0),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_6 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000045 (
    .C(clk),
    .D(sig000000af),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_7 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000046 (
    .C(clk),
    .D(sig000000ae),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op_sliced_8 )
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000047 (
    .C(clk),
    .D(sig000000b7),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/mant_op [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000048 (
    .C(clk),
    .D(sig000000bc),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000049 (
    .C(clk),
    .D(sig000000bb),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004a (
    .C(clk),
    .D(sig000000ba),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004b (
    .C(clk),
    .D(sig000000b9),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004c (
    .C(clk),
    .D(sig000000b8),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/exp_op [0])
  );
  LUT6 #(
    .INIT ( 64'h1111111101010111 ))
  blk0000004d (
    .I0(sig0000007e),
    .I1(sig0000007f),
    .I2(sig00000077),
    .I3(sig0000005d),
    .I4(sig00000089),
    .I5(sig00000080),
    .O(sig00000062)
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  blk0000004e (
    .I0(sig0000005e),
    .I1(sig0000005f),
    .I2(sig00000060),
    .O(sig00000076)
  );
  LUT6 #(
    .INIT ( 64'h5E13121354111011 ))
  blk0000004f (
    .I0(sig0000007e),
    .I1(sig0000007f),
    .I2(sig00000080),
    .I3(sig00000077),
    .I4(sig00000087),
    .I5(sig00000088),
    .O(sig00000086)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk00000050 (
    .I0(b[10]),
    .I1(b[14]),
    .I2(b[13]),
    .I3(b[12]),
    .I4(b[11]),
    .O(sig00000080)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000051 (
    .I0(a[10]),
    .I1(a[14]),
    .I2(a[13]),
    .I3(a[12]),
    .I4(a[11]),
    .O(sig0000007e)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000052 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig0000007f)
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFFE ))
  blk00000053 (
    .I0(a[12]),
    .I1(a[13]),
    .I2(a[14]),
    .I3(a[10]),
    .I4(a[11]),
    .O(sig00000077)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000054 (
    .I0(a[10]),
    .I1(b[10]),
    .O(sig00000081)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000055 (
    .I0(a[11]),
    .I1(b[11]),
    .O(sig00000082)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000056 (
    .I0(a[12]),
    .I1(b[12]),
    .O(sig00000083)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000057 (
    .I0(a[13]),
    .I1(b[13]),
    .O(sig00000084)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000058 (
    .I0(a[14]),
    .I1(b[14]),
    .O(sig00000085)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000059 (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig0000007a)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000005a (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig0000007b)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000005b (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig0000007c)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000005c (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig0000007d)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000005d (
    .I0(sig00000039),
    .I1(sig0000003f),
    .I2(sig0000003e),
    .O(sig00000093)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000005e (
    .I0(sig00000039),
    .I1(sig0000003e),
    .I2(sig0000003d),
    .O(sig00000094)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000005f (
    .I0(sig00000039),
    .I1(sig0000003d),
    .I2(sig0000003c),
    .O(sig00000095)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000060 (
    .I0(sig00000039),
    .I1(sig0000003c),
    .I2(sig0000003b),
    .O(sig00000096)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000061 (
    .I0(sig00000039),
    .I1(sig0000003b),
    .I2(sig0000003a),
    .O(sig00000097)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000062 (
    .I0(sig00000039),
    .I1(sig00000044),
    .I2(sig00000043),
    .O(sig00000098)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000063 (
    .I0(sig00000039),
    .I1(sig00000043),
    .I2(sig00000042),
    .O(sig00000099)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000064 (
    .I0(sig00000039),
    .I1(sig00000042),
    .I2(sig00000041),
    .O(sig0000009a)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000065 (
    .I0(sig00000039),
    .I1(sig00000041),
    .I2(sig00000040),
    .O(sig0000009b)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000066 (
    .I0(sig00000039),
    .I1(sig00000040),
    .I2(sig0000003f),
    .O(sig0000009c)
  );
  LUT5 #(
    .INIT ( 32'h0455FFDD ))
  blk00000067 (
    .I0(sig00000045),
    .I1(sig0000004f),
    .I2(sig00000043),
    .I3(sig00000039),
    .I4(sig00000044),
    .O(sig000000a3)
  );
  LUT3 #(
    .INIT ( 8'hEF ))
  blk00000068 (
    .I0(sig00000044),
    .I1(sig00000045),
    .I2(sig0000004f),
    .O(sig000000a4)
  );
  LUT5 #(
    .INIT ( 32'h55554544 ))
  blk00000069 (
    .I0(sig00000086),
    .I1(sig0000007e),
    .I2(sig00000075),
    .I3(sig00000066),
    .I4(sig0000007f),
    .O(sig000000b7)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000006a (
    .I0(sig00000062),
    .I1(sig00000063),
    .I2(sig00000074),
    .O(sig000000b8)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000006b (
    .I0(sig00000062),
    .I1(sig00000063),
    .I2(sig00000073),
    .O(sig000000b9)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000006c (
    .I0(sig00000062),
    .I1(sig00000063),
    .I2(sig00000072),
    .O(sig000000ba)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000006d (
    .I0(sig00000062),
    .I1(sig00000063),
    .I2(sig00000071),
    .O(sig000000bb)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000006e (
    .I0(sig00000062),
    .I1(sig00000063),
    .I2(sig00000070),
    .O(sig000000bc)
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  blk0000006f (
    .I0(sig0000005e),
    .I1(sig0000005f),
    .I2(sig00000060),
    .O(sig000000bd)
  );
  LUT6 #(
    .INIT ( 64'hAAAADDD5AAAFDDD5 ))
  blk00000070 (
    .I0(sig00000089),
    .I1(sig00000076),
    .I2(sig00000061),
    .I3(sig00000039),
    .I4(sig0000005d),
    .I5(sig000000bd),
    .O(sig00000075)
  );
  LUT3 #(
    .INIT ( 8'hA2 ))
  blk00000071 (
    .I0(sig0000007e),
    .I1(sig00000088),
    .I2(sig00000080),
    .O(sig000000be)
  );
  LUT6 #(
    .INIT ( 64'h0040400000555500 ))
  blk00000072 (
    .I0(sig000000be),
    .I1(sig00000087),
    .I2(sig00000077),
    .I3(b[15]),
    .I4(a[15]),
    .I5(sig0000007f),
    .O(sig00000064)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000073 (
    .C(clk),
    .D(sig00000064),
    .Q(\U0/op_inst/FLT_PT_OP/MULT.OP/OP/sign_op )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000074 (
    .I0(sig0000005e),
    .O(sig000000bf)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000075 (
    .I0(sig0000005f),
    .O(sig000000c0)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000076 (
    .I0(sig00000060),
    .O(sig000000c1)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000077 (
    .I0(sig00000061),
    .O(sig000000c2)
  );
  LUT5 #(
    .INIT ( 32'h80808000 ))
  blk00000078 (
    .I0(sig0000005e),
    .I1(sig00000060),
    .I2(sig0000005f),
    .I3(sig00000039),
    .I4(sig00000061),
    .O(sig000000c3)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF2220 ))
  blk00000079 (
    .I0(sig00000089),
    .I1(sig00000086),
    .I2(sig0000005d),
    .I3(sig000000c3),
    .I4(sig0000007e),
    .I5(sig0000007f),
    .O(sig00000063)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000007a (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig0000006e),
    .O(sig000000af)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000007b (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig0000006d),
    .O(sig000000b0)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000007c (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig0000006f),
    .O(sig000000ae)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000007d (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig0000006c),
    .O(sig000000b1)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000007e (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig0000006b),
    .O(sig000000b2)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000007f (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig0000006a),
    .O(sig000000b3)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk00000080 (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig00000069),
    .O(sig000000b4)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk00000081 (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig00000068),
    .O(sig000000b5)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk00000082 (
    .I0(sig00000080),
    .I1(sig0000007e),
    .I2(sig0000007f),
    .I3(sig00000077),
    .I4(sig00000075),
    .I5(sig00000067),
    .O(sig000000b6)
  );
  INV   blk00000083 (
    .I(operation_nd),
    .O(sig00000002)
  );
  INV   blk00000084 (
    .I(sig0000005d),
    .O(sig0000009d)
  );
  INV   blk00000085 (
    .I(sig00000039),
    .O(sig00000092)
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
