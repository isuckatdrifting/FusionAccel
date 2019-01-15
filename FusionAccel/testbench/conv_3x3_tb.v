`timescale 1ns/1ps

module conv_3x3_tb();

reg [144 - 1:0] im;
reg [144 - 1:0] iw;
reg clk;
reg rst_n;
wire [15:0] om;
reg conv_ready;
wire conv_valid;

conv_3x3 conv_3x3_i(
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
    
    im = {16'h3c00, 16'h4000, 16'h4200, 16'h4400, 16'h4500, 16'h4600, 16'h4700, 16'h4800, 16'h4880};
    iw = {16'h3c00, 16'h4000, 16'h4200, 16'h4400, 16'h4500, 16'h4600, 16'h4700, 16'h4800, 16'h4880};
    #10 rst_n = 1;
    #100 conv_ready = 1;
    #510 conv_ready = 0;
end

endmodule