`timescale 1ns/1ps

module pool_13x13_tb();

reg [169*16 - 1:0] im;
reg clk;
reg rst_n;
wire [15:0] om;
reg pool_ready;
wire pool_valid;

pool_13x13 pool_13x13_i(
    .im(im),
    .clk(clk),
    .rst_n(rst_n),
    .om(om),
    .pool_ready(pool_ready),
    .pool_valid(pool_valid)
);
always #5 clk = ~clk;

initial begin
    rst_n = 0;
    clk = 0;
    pool_ready = 0;
    
    im = {16'h361d, 16'h2f51, 16'h3028, 16'h39a2, 16'h3500, 16'h3922, 16'h3576, 16'h3864, 16'h3651, 16'h397d, 16'h2df3, 16'h36db, 16'h39ca,
16'h3a27, 16'h3bcf, 16'h36cd, 16'h3a5c, 16'h3a5c, 16'h3866, 16'h38ce, 16'h36fc, 16'h388d, 16'h39d0, 16'h3be6, 16'h3966, 16'h3b49,
16'h35d9, 16'h3a97, 16'h3867, 16'h3a2a, 16'h3418, 16'h39c0, 16'h30d7, 16'h32f5, 16'h324a, 16'h38b0, 16'h3994, 16'h3355, 16'h3a73,
16'h39bf, 16'h3b33, 16'h3b00, 16'h37ad, 16'h374e, 16'h3aa8, 16'h3516, 16'h3476, 16'h3bb1, 16'h3589, 16'h3358, 16'h3638, 16'h3b7f,
16'h3a06, 16'h38a7, 16'h3509, 16'h37e7, 16'h39c1, 16'h38d3, 16'h3a13, 16'h3966, 16'h25c4, 16'h365b, 16'h3b07, 16'h3b40, 16'h36dd,
16'h34af, 16'h36da, 16'h3106, 16'h2df4, 16'h2e1e, 16'h3823, 16'h3a88, 16'h3424, 16'h3431, 16'h347c, 16'h37fc, 16'h37cc, 16'h3891,
16'h3bd5, 16'h24c9, 16'h3abf, 16'h3899, 16'h322a, 16'h3602, 16'h395f, 16'h305e, 16'h36bf, 16'h38e3, 16'h2355, 16'h36eb, 16'h34e3,
16'h3b35, 16'h3a4f, 16'h3b59, 16'h2cbd, 16'h3b3b, 16'h3478, 16'h2fad, 16'h3124, 16'h349e, 16'h3a14, 16'h3940, 16'h397d, 16'h340d,
16'h3b5e, 16'h37cc, 16'h397a, 16'h357e, 16'h39dc, 16'h386b, 16'h3885, 16'h3455, 16'h293a, 16'h3446, 16'h3877, 16'h3b5f, 16'h33b8,
16'h34ff, 16'h30d4, 16'h3af3, 16'h3985, 16'h314e, 16'h34b6, 16'h3919, 16'h3aab, 16'h324a, 16'h38e4, 16'h3b0a, 16'h2643, 16'h3a12,
16'h257d, 16'h35e4, 16'h2e25, 16'h3809, 16'h3b94, 16'h39e2, 16'h204f, 16'h3918, 16'h3ad6, 16'h3bc3, 16'h3208, 16'h36d6, 16'h3af9,
16'h36ca, 16'h3b2b, 16'h3861, 16'h381b, 16'h34ed, 16'h363e, 16'h397b, 16'h3ad9, 16'h31ff, 16'h2a27, 16'h3b1d, 16'h38de, 16'h347b,
16'h3960, 16'h37cf, 16'h3a8e, 16'h331d, 16'h2b60, 16'h3a1d, 16'h342d, 16'h387b, 16'h375f, 16'h35ab, 16'h3836, 16'h2f55, 16'h350a};
    #10 rst_n = 1;
    #100 pool_ready = 1;
    #1195 pool_ready = 0;
end

endmodule

