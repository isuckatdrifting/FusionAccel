`timescale 1ns/1ns
module scmp_tb;

reg clk;
reg rst;
reg [15:0] data;
wire [15:0] result;
reg pool_valid;
wire pool_ready;
wire data_valid;
reg data_ready;

reg [15:0] data_fifo [0:8];

initial begin
    data_fifo[0] = 16'h4600;//5
    data_fifo[1] = 16'h4200;//2
    data_fifo[2] = 16'h4000;//1
    data_fifo[3] = 16'h4800;//7
    data_fifo[4] = 16'h4400;//3
    data_fifo[5] = 16'h4880;//8
    data_fifo[6] = 16'h4700;//6
    data_fifo[7] = 16'h4500;//4
    data_fifo[8] = 16'h3c00;//0
end

scmp scmp_( //max pooling
    .clk (clk),
    .rst (rst),
    .data (data),
    .result (result),
    .pool_valid (pool_valid),
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
        data <= data_fifo[i];
        if(i < 9) i <= i + 1;
        else data_ready <= 0;
    end
end

endmodule