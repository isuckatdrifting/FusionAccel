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
    
    im = {16'h307e, 16'h3ba7, 16'h3a2a, 16'h3131, 16'h38e8, 16'h36fd, 16'h3478, 16'h2f78, 16'h310c, 16'h33b9, 16'h36cb, 16'h31ea, 16'h303b,
16'h363e, 16'h3553, 16'h3444, 16'h2dd2, 16'h3a2f, 16'h3060, 16'h3074, 16'h396a, 16'h3944, 16'h39c1, 16'h3bfb, 16'h2de5, 16'h305a,
16'h3849, 16'h392c, 16'h3979, 16'h2eb1, 16'h34f5, 16'h380d, 16'h3983, 16'h3833, 16'h3b55, 16'h398e, 16'h3683, 16'h3009, 16'h39ac,
16'h3011, 16'h2930, 16'h3b77, 16'h398b, 16'h3b5e, 16'h3910, 16'h2dae, 16'h3adb, 16'h1b47, 16'h3b64, 16'h3137, 16'h37f7, 16'h3567,
16'h3932, 16'h396a, 16'h3adf, 16'h3899, 16'h29cc, 16'h3711, 16'h383e, 16'h3264, 16'h3b89, 16'h3398, 16'h3ad9, 16'h399f, 16'h31fd,
16'h3729, 16'h3aa6, 16'h32df, 16'h37d3, 16'h31e5, 16'h2d5d, 16'h2d27, 16'h3acf, 16'h3736, 16'h334b, 16'h3770, 16'h36c3, 16'h3053,
16'h2762, 16'h386f, 16'h3b83, 16'h3b2c, 16'h3864, 16'h358b, 16'h39ae, 16'h2f47, 16'h381a, 16'h3905, 16'h3aec, 16'h381a, 16'h3b0f,
16'h3aa6, 16'h3b41, 16'h311a, 16'h3819, 16'h38c7, 16'h37d6, 16'h36c8, 16'h3bc4, 16'h36ca, 16'h29a1, 16'h34b5, 16'h3531, 16'h3886,
16'h36db, 16'h3b35, 16'h335f, 16'h35b1, 16'h3a60, 16'h3b95, 16'h3b3c, 16'h31d4, 16'h3353, 16'h3b17, 16'h3ae2, 16'h3a7b, 16'h3624,
16'h379d, 16'h3774, 16'h3ae3, 16'h37e7, 16'h34a2, 16'h3b09, 16'h39ab, 16'h3753, 16'h38c9, 16'h34b4, 16'h3acc, 16'h3474, 16'h382c,
16'h3709, 16'h3bcf, 16'h2dcb, 16'h3222, 16'h3935, 16'h354a, 16'h33e1, 16'h38ad, 16'h3a1d, 16'h30d7, 16'h34fb, 16'h36b0, 16'h38bd,
16'h3b66, 16'h33e3, 16'h3a08, 16'h393c, 16'h34ad, 16'h240b, 16'h3510, 16'h39ad, 16'h3a14, 16'h322a, 16'h3b19, 16'h3034, 16'h3b53,
16'h39be, 16'h39b4, 16'h3314, 16'h31c1, 16'h2e60, 16'h3a6b, 16'h3876, 16'h3a14, 16'h36db, 16'h2a5c, 16'h3865, 16'h20f4, 16'h2fd4};
    #10 rst_n = 1;
    #100 pool_ready = 1;
    #1195 pool_ready = 0;
end

endmodule

