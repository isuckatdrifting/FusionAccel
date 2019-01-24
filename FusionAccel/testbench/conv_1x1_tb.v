`timescale 1ns/1ps

module conv_1x1_tb();

reg [15:0] im;
reg [15:0] iw;
reg clk;
reg rst_n;
wire [15:0] om;
reg conv_ready;
wire conv_valid;

conv_1x1 conv_1x1_i(
    .im(im),
    .iw(iw),
    .clk(clk),
    .rst_n(rst_n),
    .om(om),
    .conv_ready(conv_ready),
    .conv_valid(conv_valid)
);
always #5 clk = ~clk;

initial begin
    rst_n = 0;
    clk = 0;
    conv_ready = 0;
    
    im = {16'h3c00};
    iw = {16'h4880};
    #10 rst_n = 1;
    #100 conv_ready = 1;
    #80 conv_ready = 0;
end

endmodule