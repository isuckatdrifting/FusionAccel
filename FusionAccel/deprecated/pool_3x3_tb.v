`timescale 1ns/1ps

module pool_3x3_tb();

reg [144 - 1:0] im;
reg clk;
reg rst_n;
wire [15:0] om;
reg pool_ready;
wire pool_valid;

pool_3x3 pool_3x3_i(
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
    
    //im = {16'h3c00, 16'h4000, 16'h4200, 16'h4400, 16'h4500, 16'h4600, 16'h4700, 16'h4880, 16'h4800}; //1,2,3,4,5,6,7,9,8
    im = {16'h4880, 16'h4400, 16'h4600, 16'h4880, 16'h4200, 16'h4700, 16'h3c00, 16'h4000, 16'h4500}; //9,4,6,8,3,7,1,2,5
    #10 rst_n = 1;
    #100 pool_ready = 1;
    #310 pool_ready = 0;
end

endmodule