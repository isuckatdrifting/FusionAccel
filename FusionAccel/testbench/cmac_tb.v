`timescale 1ns/1ps 
module cmac_tb;

reg clk;
reg rst;
reg [15:0] data;
reg [15:0] weight;
wire [15:0] result;
reg conv_ready;
reg [31:0] op_num;
wire rdy_acc;
wire conv_valid;

reg [15:0] data_fifo [0:8];
reg [15:0] weight_fifo [0:8];

initial begin
    data_fifo[0] = 16'h3c00; weight_fifo[0] = 16'h3c00;
    data_fifo[1] = 16'h4000; weight_fifo[1] = 16'h4000;
    data_fifo[2] = 16'h4200; weight_fifo[2] = 16'h4200;
    data_fifo[3] = 16'h4400; weight_fifo[3] = 16'h4400;
    data_fifo[4] = 16'h4500; weight_fifo[4] = 16'h4500;
    data_fifo[5] = 16'h4600; weight_fifo[5] = 16'h4600;
    data_fifo[6] = 16'h4700; weight_fifo[6] = 16'h4700;
    data_fifo[7] = 16'h4800; weight_fifo[7] = 16'h4800;
    data_fifo[8] = 16'h4880; weight_fifo[8] = 16'h4880;
end

cmac cmac_(
    .clk        (clk),
    .rst        (rst),
    .data       (data),
    .weight     (weight),
    .result     (result),
    .conv_ready (conv_ready),
    .op_num     (op_num),
    .rdy_acc    (rdy_acc),
    .conv_valid (conv_valid)
);

always #5 clk = ~clk;
integer i;
initial begin
    rst = 1;
    clk = 0;
    i = 0;
    conv_ready = 0;
    #20 rst = 1;
    #10 rst = 0;
    #100 conv_ready = 1; op_num = 9;

end

always @(posedge conv_valid) conv_ready <= 0;

always @(posedge rdy_acc or posedge conv_ready) begin
    data <= data_fifo[i];
    weight <= weight_fifo[i];
    i <= i + 1;
end

endmodule
