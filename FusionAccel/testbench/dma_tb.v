`timescale 1ns/1ps

module dma_tb;

reg clk;
reg reset;
reg writes_en;
reg reads_en;
reg calib_done;

reg [31:0] ib_data;
reg [9:0] ib_count;
reg ib_valid;
reg ib_empty;

reg [9:0] ob_count;

reg rd_empty;
reg [31:0] rd_data;

reg cmd_full;
reg wr_full;


dma dma_
	(
	.clk(clk),
	.reset(reset),
	.writes_en(writes_en),
	.reads_en(reads_en),
	.calib_done(calib_done), 
	//DDR Input Buffer (ib_)
	.ib_re(ib_re),
	.ib_data(ib_data),
	.ib_count(ib_count),
	.ib_valid(ib_valid),
	.ib_empty(ib_empty),
	//DDR Output Buffer (ob_)
	.ob_we(ob_we),
	.ob_data(ob_data),
	.ob_count(ob_count),
	
	.rd_en(rd_en), 
	.rd_empty(rd_empty),
	.rd_data(rd_data),
	
	.cmd_full(cmd_full),
	.cmd_en(cmd_en),
	.cmd_instr(cmd_instr),
	.cmd_byte_addr(cmd_byte_addr),
	.cmd_bl(cmd_bl), 

	.wr_full(wr_full),
	.wr_en(wr_en),
	.wr_data(wr_data),
	.wr_mask(wr_mask)
	);

always #5 clk = ~clk;

initial begin
    reset = 1;
    clk = 0;
    writes_en = 0;
    calib_done = 0;
    ib_count = 0;
    ib_valid = 0;
    #10 reset = 0;
    #100 writes_en = 1;
    calib_done = 1;
    ib_count = 64;
    #40 ib_valid = 1;
end
endmodule