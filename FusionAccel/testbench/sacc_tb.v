`timescale 1ns/1ns
module sacc_tb;

reg clk;
reg rst;
reg [15:0] data;
wire [15:0] result;
reg pool_valid;
wire acc_ready;
wire pool_ready;
reg data_ready;
wire data_valid;

reg [169*16-1:0] data_fifo;

initial begin
    data_fifo = {16'h3757, 16'h39da, 16'h3b67, 16'h3376, 16'h3bb5, 16'h30da, 16'h3b8a, 16'h2675, 16'h3454, 16'h2d3e, 16'h39d1, 16'h3614, 16'h36dd,
16'h304e, 16'h3023, 16'h3b02, 16'h3367, 16'h3b9d, 16'h32ff, 16'h387e, 16'h384d, 16'h3812, 16'h3bad, 16'h3587, 16'h33f5, 16'h3ab1,
16'h3945, 16'h3625, 16'h2f8f, 16'h39de, 16'h367c, 16'h287c, 16'h354f, 16'h2d21, 16'h39a8, 16'h382e, 16'h3b5c, 16'h3ba0, 16'h39cd,
16'h3a0c, 16'h2e91, 16'h38cb, 16'h2bc9, 16'h3872, 16'h3173, 16'h37b0, 16'h32da, 16'h3b5a, 16'h380e, 16'h3892, 16'h3988, 16'h390d,
16'h38e9, 16'h3a7c, 16'h3a78, 16'h3a50, 16'h3894, 16'h397d, 16'h314d, 16'h2c73, 16'h304c, 16'h3774, 16'h36ca, 16'h3512, 16'h3b17,
16'h363f, 16'h3721, 16'h3489, 16'h2fe5, 16'h34c6, 16'h3aaf, 16'h37b1, 16'h38e3, 16'h36e3, 16'h3942, 16'h3bbe, 16'h39ac, 16'h3873,
16'h37c1, 16'h340b, 16'h3b26, 16'h3b70, 16'h372c, 16'h36f3, 16'h3bd5, 16'h3a3a, 16'h339e, 16'h3821, 16'h33f5, 16'h3858, 16'h3bf0,
16'h3beb, 16'h3b73, 16'h3a1c, 16'h3a83, 16'h3bb2, 16'h3808, 16'h39c7, 16'h3b72, 16'h39cf, 16'h2a93, 16'h3402, 16'h39d8, 16'h3974,
16'h3483, 16'h3b46, 16'h3af9, 16'h38ad, 16'h3933, 16'h30de, 16'h305e, 16'h2fdb, 16'h3ad9, 16'h3ad2, 16'h39fa, 16'h2ae8, 16'h32b6,
16'h3596, 16'h3b5e, 16'h329c, 16'h2da6, 16'h3a5a, 16'h3562, 16'h3a02, 16'h3a38, 16'h354e, 16'h3b19, 16'h3976, 16'h383c, 16'h29d8,
16'h3a29, 16'h3a08, 16'h3301, 16'h386f, 16'h2a75, 16'h37cf, 16'h3267, 16'h30e1, 16'h3967, 16'h388a, 16'h397b, 16'h3ab4, 16'h3999,
16'h3899, 16'h378f, 16'h394b, 16'h3554, 16'h3723, 16'h3880, 16'h327a, 16'h3a9b, 16'h383c, 16'h3936, 16'h387d, 16'h34c5, 16'h3782,
16'h3a3f, 16'h3b8c, 16'h3156, 16'h3ba7, 16'h3b97, 16'h2e65, 16'h3194, 16'h32d6, 16'h3572, 16'h3889, 16'h3aa1, 16'h36d4, 16'h2cc5}; //16'h558f, 16'h3836
end

sacc sacc_( //max pooling
    .clk (clk),
    .rst (rst),
    .data (data),
    .result (result),
    .pool_valid (pool_valid),
    .acc_ready (acc_ready),
    .pool_ready (pool_ready),
    .data_ready (data_ready),
    .data_valid (data_valid)
);

always #5 clk = ~clk;
integer i;
initial begin
    rst = 1;
    clk = 0;
    i = 0;
    pool_valid = 0;
    data = 16'h0000;
    data_ready = 0;
    #20 rst = 1;
    #10 rst = 0;
    #100 pool_valid = 1;
end

always @(posedge pool_ready) pool_valid <= 0;

always @(posedge clk) begin
    if(data_valid && pool_valid) begin
        data_ready <= 1;
        data <= data_fifo[15:0];
        data_fifo <= data_fifo >> 16;
        if(i < 170) i <= i + 1;
        else data_ready <= 0;
    end
end

endmodule