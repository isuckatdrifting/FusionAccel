////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: multiplier.v
// /___/   /\     Timestamp: Mon Feb 25 11:07:32 2019
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
  wire NLW_blk0000002d_O_UNCONNECTED;
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
    .CLK(sig00000001),
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
\NLW_blk00000003_P<36>_UNCONNECTED , sig0000002a, sig0000002b, sig0000002c, sig0000002d, sig0000002e, sig0000002f, sig00000030, sig00000031, 
sig00000032, sig00000033, sig00000034, sig00000035, sig00000036, sig00000037, sig00000038, sig00000039, sig0000003a, sig0000003b, sig0000003c, 
sig0000003d, sig0000003e, sig0000003f, sig00000040, sig00000041, sig00000042, sig00000043, sig00000044, sig00000045, sig00000046, sig00000047, 
sig00000048, sig00000049, sig0000004a, sig0000004b, sig0000004c, sig0000004d}),
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
    .I0(sig00000047),
    .I1(sig00000046),
    .I2(sig00000045),
    .I3(sig00000001),
    .I4(sig00000001),
    .I5(sig00000001),
    .O(sig00000002)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000005 (
    .I0(sig0000004d),
    .I1(sig0000004c),
    .I2(sig0000004b),
    .I3(sig0000004a),
    .I4(sig00000049),
    .I5(sig00000048),
    .O(sig00000003)
  );
  MUXCY   blk00000006 (
    .CI(sig00000005),
    .DI(sig00000001),
    .S(sig00000002),
    .O(sig00000004)
  );
  MUXCY   blk00000007 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000003),
    .O(sig00000005)
  );
  XORCY   blk00000008 (
    .CI(sig00000004),
    .LI(sig00000001),
    .O(sig0000004e)
  );
  MUXCY   blk00000009 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig0000007b),
    .O(sig00000076)
  );
  MUXCY   blk0000000a (
    .CI(sig00000076),
    .DI(sig00000001),
    .S(sig0000007a),
    .O(sig00000087)
  );
  MUXCY   blk0000000b (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig00000079),
    .O(sig00000077)
  );
  MUXCY   blk0000000c (
    .CI(sig00000077),
    .DI(sig00000001),
    .S(sig00000078),
    .O(sig00000086)
  );
  XORCY   blk0000000d (
    .CI(sig00000088),
    .LI(sig00000084),
    .O(sig0000005c)
  );
  MUXCY   blk0000000e (
    .CI(sig00000088),
    .DI(b[14]),
    .S(sig00000084),
    .O(sig00000085)
  );
  XORCY   blk0000000f (
    .CI(sig00000089),
    .LI(sig00000083),
    .O(sig0000005d)
  );
  MUXCY   blk00000010 (
    .CI(sig00000089),
    .DI(b[13]),
    .S(sig00000083),
    .O(sig00000088)
  );
  XORCY   blk00000011 (
    .CI(sig0000008a),
    .LI(sig00000082),
    .O(sig0000005e)
  );
  MUXCY   blk00000012 (
    .CI(sig0000008a),
    .DI(b[12]),
    .S(sig00000082),
    .O(sig00000089)
  );
  XORCY   blk00000013 (
    .CI(sig0000008b),
    .LI(sig00000081),
    .O(sig0000005f)
  );
  MUXCY   blk00000014 (
    .CI(sig0000008b),
    .DI(b[11]),
    .S(sig00000081),
    .O(sig0000008a)
  );
  XORCY   blk00000015 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .LI(sig00000080),
    .O(sig00000060)
  );
  MUXCY   blk00000016 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(b[10]),
    .S(sig00000080),
    .O(sig0000008b)
  );
  MUXCY   blk00000017 (
    .CI(sig0000009e),
    .DI(sig00000001),
    .S(sig00000097),
    .O(sig0000008c)
  );
  XORCY   blk00000018 (
    .CI(sig0000009e),
    .LI(sig00000097),
    .O(sig0000006c)
  );
  MUXCY   blk00000019 (
    .CI(sig0000008c),
    .DI(sig00000001),
    .S(sig00000098),
    .O(sig0000008d)
  );
  XORCY   blk0000001a (
    .CI(sig0000008c),
    .LI(sig00000098),
    .O(sig0000006b)
  );
  MUXCY   blk0000001b (
    .CI(sig0000008d),
    .DI(sig00000001),
    .S(sig00000099),
    .O(sig0000008e)
  );
  XORCY   blk0000001c (
    .CI(sig0000008d),
    .LI(sig00000099),
    .O(sig0000006a)
  );
  MUXCY   blk0000001d (
    .CI(sig0000008e),
    .DI(sig00000001),
    .S(sig0000009a),
    .O(sig0000008f)
  );
  XORCY   blk0000001e (
    .CI(sig0000008e),
    .LI(sig0000009a),
    .O(sig00000069)
  );
  MUXCY   blk0000001f (
    .CI(sig0000008f),
    .DI(sig00000001),
    .S(sig0000009b),
    .O(sig0000009c)
  );
  XORCY   blk00000020 (
    .CI(sig0000008f),
    .LI(sig0000009b),
    .O(sig00000068)
  );
  MUXCY   blk00000021 (
    .CI(NlwRenamedSig_OI_operation_rfd),
    .DI(sig00000001),
    .S(sig000000a2),
    .O(sig0000009f)
  );
  MUXCY   blk00000022 (
    .CI(sig0000009f),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig000000a0)
  );
  MUXCY   blk00000023 (
    .CI(sig000000a0),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig000000a1),
    .O(sig0000009e)
  );
  XORCY   blk00000024 (
    .CI(sig000000a3),
    .LI(sig0000009d),
    .O(sig0000006d)
  );
  XORCY   blk00000025 (
    .CI(sig000000a4),
    .LI(sig000000ae),
    .O(sig0000006e)
  );
  MUXCY   blk00000026 (
    .CI(sig000000a4),
    .DI(sig00000001),
    .S(sig000000ae),
    .O(sig000000a3)
  );
  XORCY   blk00000027 (
    .CI(sig000000a5),
    .LI(sig000000af),
    .O(sig0000006f)
  );
  MUXCY   blk00000028 (
    .CI(sig000000a5),
    .DI(sig00000001),
    .S(sig000000af),
    .O(sig000000a4)
  );
  XORCY   blk00000029 (
    .CI(sig000000a6),
    .LI(sig000000b0),
    .O(sig00000070)
  );
  MUXCY   blk0000002a (
    .CI(sig000000a6),
    .DI(sig00000001),
    .S(sig000000b0),
    .O(sig000000a5)
  );
  XORCY   blk0000002b (
    .CI(sig00000096),
    .LI(sig000000b1),
    .O(sig00000071)
  );
  MUXCY   blk0000002c (
    .CI(sig00000096),
    .DI(sig00000001),
    .S(sig000000b1),
    .O(sig000000a6)
  );
  XORCY   blk0000002d (
    .CI(sig000000a7),
    .LI(sig00000090),
    .O(NLW_blk0000002d_O_UNCONNECTED)
  );
  MUXCY   blk0000002e (
    .CI(sig000000a7),
    .DI(NlwRenamedSig_OI_operation_rfd),
    .S(sig00000090),
    .O(sig00000096)
  );
  XORCY   blk0000002f (
    .CI(sig000000a8),
    .LI(sig00000095),
    .O(sig00000063)
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
    .O(sig00000064)
  );
  MUXCY   blk00000032 (
    .CI(sig000000a9),
    .DI(sig00000001),
    .S(sig00000094),
    .O(sig000000a8)
  );
  XORCY   blk00000033 (
    .CI(sig000000aa),
    .LI(sig00000093),
    .O(sig00000065)
  );
  MUXCY   blk00000034 (
    .CI(sig000000aa),
    .DI(sig00000001),
    .S(sig00000093),
    .O(sig000000a9)
  );
  XORCY   blk00000035 (
    .CI(sig000000ab),
    .LI(sig00000092),
    .O(sig00000066)
  );
  MUXCY   blk00000036 (
    .CI(sig000000ab),
    .DI(sig00000001),
    .S(sig00000092),
    .O(sig000000aa)
  );
  XORCY   blk00000037 (
    .CI(sig0000009c),
    .LI(sig00000091),
    .O(sig00000067)
  );
  MUXCY   blk00000038 (
    .CI(sig0000009c),
    .DI(sig00000001),
    .S(sig00000091),
    .O(sig000000ab)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000003d (
    .I0(sig00000061),
    .I1(sig0000006d),
    .I2(sig00000062),
    .O(result[14])
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000003e (
    .I0(sig00000061),
    .I1(sig0000006e),
    .I2(sig00000062),
    .O(result[13])
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000003f (
    .I0(sig00000061),
    .I1(sig0000006f),
    .I2(sig00000062),
    .O(result[12])
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk00000040 (
    .I0(sig00000061),
    .I1(sig00000070),
    .I2(sig00000062),
    .O(result[11])
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk00000041 (
    .I0(sig00000061),
    .I1(sig00000071),
    .I2(sig00000062),
    .O(result[10])
  );
  LUT5 #(
    .INIT ( 32'h55554544 ))
  blk00000042 (
    .I0(sig0000007f),
    .I1(sig0000007c),
    .I2(sig00000073),
    .I3(sig00000063),
    .I4(sig0000007d),
    .O(result[9])
  );
  LUT6 #(
    .INIT ( 64'h1111111101010111 ))
  blk00000043 (
    .I0(sig0000007c),
    .I1(sig0000007d),
    .I2(sig00000075),
    .I3(sig0000005c),
    .I4(sig00000085),
    .I5(sig0000007e),
    .O(sig00000061)
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  blk00000044 (
    .I0(sig0000005d),
    .I1(sig0000005e),
    .I2(sig0000005f),
    .O(sig00000074)
  );
  LUT6 #(
    .INIT ( 64'h5E13121354111011 ))
  blk00000045 (
    .I0(sig0000007c),
    .I1(sig0000007d),
    .I2(sig0000007e),
    .I3(sig00000075),
    .I4(sig00000086),
    .I5(sig00000087),
    .O(sig0000007f)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk00000046 (
    .I0(b[10]),
    .I1(b[14]),
    .I2(b[13]),
    .I3(b[12]),
    .I4(b[11]),
    .O(sig0000007e)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000047 (
    .I0(a[10]),
    .I1(a[14]),
    .I2(a[13]),
    .I3(a[12]),
    .I4(a[11]),
    .O(sig0000007c)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk00000048 (
    .I0(b[14]),
    .I1(b[13]),
    .I2(b[12]),
    .I3(b[11]),
    .I4(b[10]),
    .O(sig0000007d)
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFFE ))
  blk00000049 (
    .I0(a[12]),
    .I1(a[13]),
    .I2(a[14]),
    .I3(a[10]),
    .I4(a[11]),
    .O(sig00000075)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000004a (
    .I0(a[10]),
    .I1(b[10]),
    .O(sig00000080)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000004b (
    .I0(a[11]),
    .I1(b[11]),
    .O(sig00000081)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000004c (
    .I0(a[12]),
    .I1(b[12]),
    .O(sig00000082)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000004d (
    .I0(a[13]),
    .I1(b[13]),
    .O(sig00000083)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000004e (
    .I0(a[14]),
    .I1(b[14]),
    .O(sig00000084)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000004f (
    .I0(b[6]),
    .I1(b[7]),
    .I2(b[8]),
    .I3(b[9]),
    .O(sig00000078)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000050 (
    .I0(b[0]),
    .I1(b[1]),
    .I2(b[2]),
    .I3(b[3]),
    .I4(b[4]),
    .I5(b[5]),
    .O(sig00000079)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000051 (
    .I0(a[6]),
    .I1(a[7]),
    .I2(a[8]),
    .I3(a[9]),
    .O(sig0000007a)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk00000052 (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig0000007b)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000053 (
    .I0(sig00000038),
    .I1(sig0000003e),
    .I2(sig0000003d),
    .O(sig00000091)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000054 (
    .I0(sig00000038),
    .I1(sig0000003d),
    .I2(sig0000003c),
    .O(sig00000092)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000055 (
    .I0(sig00000038),
    .I1(sig0000003c),
    .I2(sig0000003b),
    .O(sig00000093)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000056 (
    .I0(sig00000038),
    .I1(sig0000003b),
    .I2(sig0000003a),
    .O(sig00000094)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000057 (
    .I0(sig00000038),
    .I1(sig0000003a),
    .I2(sig00000039),
    .O(sig00000095)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000058 (
    .I0(sig00000038),
    .I1(sig00000043),
    .I2(sig00000042),
    .O(sig00000097)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000059 (
    .I0(sig00000038),
    .I1(sig00000042),
    .I2(sig00000041),
    .O(sig00000098)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000005a (
    .I0(sig00000038),
    .I1(sig00000041),
    .I2(sig00000040),
    .O(sig00000099)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000005b (
    .I0(sig00000038),
    .I1(sig00000040),
    .I2(sig0000003f),
    .O(sig0000009a)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000005c (
    .I0(sig00000038),
    .I1(sig0000003f),
    .I2(sig0000003e),
    .O(sig0000009b)
  );
  LUT5 #(
    .INIT ( 32'h0455FFDD ))
  blk0000005d (
    .I0(sig00000044),
    .I1(sig0000004e),
    .I2(sig00000042),
    .I3(sig00000038),
    .I4(sig00000043),
    .O(sig000000a1)
  );
  LUT3 #(
    .INIT ( 8'hEF ))
  blk0000005e (
    .I0(sig00000043),
    .I1(sig00000044),
    .I2(sig0000004e),
    .O(sig000000a2)
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  blk0000005f (
    .I0(sig0000005d),
    .I1(sig0000005e),
    .I2(sig0000005f),
    .O(sig000000ac)
  );
  LUT6 #(
    .INIT ( 64'hAAAADDD5AAAFDDD5 ))
  blk00000060 (
    .I0(sig00000085),
    .I1(sig00000074),
    .I2(sig00000060),
    .I3(sig00000038),
    .I4(sig0000005c),
    .I5(sig000000ac),
    .O(sig00000073)
  );
  LUT3 #(
    .INIT ( 8'hA2 ))
  blk00000061 (
    .I0(sig0000007c),
    .I1(sig00000087),
    .I2(sig0000007e),
    .O(sig000000ad)
  );
  LUT6 #(
    .INIT ( 64'h0040400000555500 ))
  blk00000062 (
    .I0(sig000000ad),
    .I1(sig00000086),
    .I2(sig00000075),
    .I3(b[15]),
    .I4(a[15]),
    .I5(sig0000007d),
    .O(result[15])
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000063 (
    .I0(sig0000005d),
    .O(sig000000ae)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000064 (
    .I0(sig0000005e),
    .O(sig000000af)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000065 (
    .I0(sig0000005f),
    .O(sig000000b0)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000066 (
    .I0(sig00000060),
    .O(sig000000b1)
  );
  LUT5 #(
    .INIT ( 32'h80808000 ))
  blk00000067 (
    .I0(sig0000005d),
    .I1(sig0000005f),
    .I2(sig0000005e),
    .I3(sig00000038),
    .I4(sig00000060),
    .O(sig000000b2)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF2220 ))
  blk00000068 (
    .I0(sig00000085),
    .I1(sig0000007f),
    .I2(sig0000005c),
    .I3(sig000000b2),
    .I4(sig0000007c),
    .I5(sig0000007d),
    .O(sig00000062)
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk00000069 (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig00000064),
    .O(result[8])
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000006a (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig00000065),
    .O(result[7])
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000006b (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig00000066),
    .O(result[6])
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000006c (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig00000067),
    .O(result[5])
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000006d (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig00000068),
    .O(result[4])
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000006e (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig00000069),
    .O(result[3])
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk0000006f (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig0000006a),
    .O(result[2])
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk00000070 (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig0000006b),
    .O(result[1])
  );
  LUT6 #(
    .INIT ( 64'h0000010000000000 ))
  blk00000071 (
    .I0(sig0000007e),
    .I1(sig0000007c),
    .I2(sig0000007d),
    .I3(sig00000075),
    .I4(sig00000073),
    .I5(sig0000006c),
    .O(result[0])
  );
  INV   blk00000072 (
    .I(sig0000005c),
    .O(sig0000009d)
  );
  INV   blk00000073 (
    .I(sig00000038),
    .O(sig00000090)
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
