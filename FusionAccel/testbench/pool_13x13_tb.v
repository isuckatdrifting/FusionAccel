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
    
    im = {16'h3be9, 16'h3960, 16'h38f9, 16'h3a7e, 16'h3039, 16'h3a9f, 16'h33ee, 16'h361b, 16'h340a, 16'h3bdf, 16'h397f, 16'h3687, 16'h38e7,
16'h3902, 16'h3ba0, 16'h36a4, 16'h3ae6, 16'h3ba0, 16'h3af2, 16'h36a5, 16'h387d, 16'h3a2b, 16'h39a6, 16'h34a5, 16'h2d36, 16'h398a,
16'h36b4, 16'h2cc2, 16'h1aa1, 16'h3581, 16'h3b5f, 16'h3b90, 16'h386b, 16'h3407, 16'h388b, 16'h3aab, 16'h3426, 16'h381f, 16'h320c,
16'h350e, 16'h3404, 16'h2ab9, 16'h39a5, 16'h3bb6, 16'h32d0, 16'h3bd4, 16'h3af0, 16'h3876, 16'h327e, 16'h3ba8, 16'h367d, 16'h3a88,
16'h38e7, 16'h3ac5, 16'h389c, 16'h3708, 16'h331d, 16'h3b9c, 16'h2e03, 16'h384b, 16'h34df, 16'h34c2, 16'h3b9f, 16'h39dd, 16'h3bec,
16'h32eb, 16'h3a43, 16'h2b4b, 16'h3878, 16'h34cd, 16'h384f, 16'h377d, 16'h3058, 16'h391d, 16'h3673, 16'h32d2, 16'h343f, 16'h3a84,
16'h350e, 16'h38e2, 16'h3ad8, 16'h3857, 16'h39c3, 16'h37ff, 16'h3a10, 16'h3b93, 16'h3805, 16'h380e, 16'h39db, 16'h3b50, 16'h31d3,
16'h26b2, 16'h3b6a, 16'h3a95, 16'h31fb, 16'h3b80, 16'h39db, 16'h36b4, 16'h3be0, 16'h366b, 16'h3011, 16'h3a6c, 16'h38c9, 16'h3b29,
16'h3839, 16'h3a82, 16'h33b0, 16'h3ab2, 16'h3159, 16'h3b8f, 16'h3a65, 16'h371d, 16'h2c81, 16'h3222, 16'h3af5, 16'h39c9, 16'h39d1,
16'h3a52, 16'h3735, 16'h3adb, 16'h2d62, 16'h37bb, 16'h3600, 16'h31e5, 16'h2a02, 16'h391f, 16'h2a93, 16'h388f, 16'h3b8f, 16'h3bc5,
16'h36fd, 16'h338d, 16'h3b7a, 16'h3447, 16'h36ca, 16'h3a98, 16'h3a61, 16'h3711, 16'h3b08, 16'h2dfd, 16'h25c2, 16'h3868, 16'h3bbd,
16'h31fb, 16'h39e7, 16'h3a24, 16'h2b7a, 16'h3a1b, 16'h343d, 16'h3966, 16'h385a, 16'h38ca, 16'h2b78, 16'h3311, 16'h3b2b, 16'h2ea2,
16'h3693, 16'h392a, 16'h375a, 16'h3a21, 16'h3494, 16'h398d, 16'h3884, 16'h3bc6, 16'h3532, 16'h3b72, 16'h3080, 16'h31a2, 16'h34e6};
    #10 rst_n = 1;
    #100 pool_ready = 1;
    #1195 pool_ready = 0;
end

endmodule

