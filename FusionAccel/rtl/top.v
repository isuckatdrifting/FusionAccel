`include "macros.vh"
module top 
(
	// Front Panel Interface
	input  wire [4:0]   okUH,
	output wire [2:0]   okHU,
	inout  wire [31:0]  okUHU,
	inout  wire         okAA,
	input  wire         sys_clkp,
	input  wire         sys_clkn,
	output      [7:0]   led
);

wire [6:0]  cmd_size;
wire [31:0] bias;
// Command wires
wire [2:0] 	op_type;
wire [3:0]  stride;
wire [15:0] stride2;
wire [7:0]  kernel, kernel_size;
wire [15:0] i_channel, o_channel;
wire [7:0]  i_side, o_side;
wire		engine_reset;
wire [2:0]  csb_state;
wire [3:0]	engine_state;
wire [31:0] ep00wire;
wire 		sys_clk;

IBUFGDS osc_clk(.O(sys_clk), .I(sys_clkp), .IB(sys_clkn));
//------------------------------------------------
// Control Signal Block for all cores
//------------------------------------------------

localparam BLOCK_SIZE      = 128;   // 512 bytes / 4 byte per word;
localparam FIFO_SIZE       = 1023;  // note that Xilinx does not allow use of the full 1024 words
localparam GEMM_FIFO_SIZE  = 8191;
localparam BUFFER_HEADROOM = 20; 	// headroom for the FIFO count to account for latency

// Front Panel Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

wire        pipe_in_read, data_in_read, weig_in_read;
wire [31:0] pipe_in_data, data_in_data, weig_in_data;
wire [9:0]  pipe_in_rd_count;
wire [9:0]  pipe_in_wr_count;
wire [12:0] data_in_rd_count, weig_in_rd_count;
wire [12:0] data_in_wr_count, weig_in_wr_count;
wire        pipe_in_valid, data_in_valid, weig_in_valid;
wire        pipe_in_full, data_in_full, weig_in_full;
wire        pipe_in_empty, data_in_empty, weig_in_empty;
reg         pipe_in_ready, data_in_ready, weig_in_ready;

wire        pipe_out_write;
wire [31:0] pipe_out_data;
wire [9:0]  pipe_out_rd_count;
wire [9:0]  pipe_out_wr_count;
wire        pipe_out_full;
wire        pipe_out_empty;
reg         pipe_out_ready;

// Pipe Fifos
wire        pi0_ep_write, po0_ep_read, pi1_ep_write, pi2_ep_write;
wire [31:0] pi0_ep_dataout, po0_ep_datain, pi1_ep_dataout, pi2_ep_dataout;

//-------------------------LED Stage Monitor-------------------------------//
assign led = ~{csb_state[0], csb_state[1], csb_state[2], engine_valid, engine_state[0], engine_state[1], engine_ready, irq};

csb csb_(
    .clk					(sys_clk),
    .rst					(ep00wire[3]),
	.op_en					(ep00wire[4]),		// A wire from ep
    .engine_valid			(engine_valid),
	.engine_ready			(engine_ready),
	.rd_en					(pipe_in_read),
	.valid					(pipe_in_valid),
	.cmd					(pipe_in_data),
	.cmd_size				(cmd_size),
	.op_type				(op_type),
	.stride					(stride),
	.kernel					(kernel),
	.i_side					(i_side),
	.o_side					(o_side),
	.i_channel				(i_channel),
	.o_channel				(o_channel),
	.kernel_size			(kernel_size),
	.stride2				(stride2),
	.engine_reset			(engine_reset),
	.curr_state				(csb_state),
    .irq					(irq));

engine engine_(
	.clk					(sys_clk),
//Control signals csb->engine
	.rst					(engine_reset),
	.engine_valid			(engine_valid),
	.op_type				(op_type),
	.stride					(stride),
	.kernel					(kernel),
	.i_side					(i_side),
	.o_side					(o_side),
	.i_channel				(i_channel),
	.o_channel				(o_channel),
	.kernel_size			(kernel_size),
	.stride2				(stride2),
	.bias					(bias[15:0]),
//Response signals engine->csb
	.engine_ready			(engine_ready),
//Command path engine->dma
	.dma_p0_writes_en		(pipe_out_write),
	.dma_p2_reads_en		(data_in_read),
    .dma_p3_reads_en		(weig_in_read),
//Data path dma->engine
	.dma_p2_ob_data			(data_in_data),
	.dma_p3_ob_data			(weig_in_data),
	.dma_p2_ob_we			(data_in_valid),
	.dma_p3_ob_we			(weig_in_valid),
	.dma_p0_ib_data			(pipe_out_data),
	.curr_state				(engine_state)
);

//Block Throttle
always @(posedge okClk) begin
	// Check for enough space in input FIFO to pipe in another block
	// The count is compared against a reduced size to account for delays in
	// FIFO count updates.
	if(pipe_in_wr_count <= (FIFO_SIZE-BUFFER_HEADROOM-BLOCK_SIZE) ) begin
	  pipe_in_ready <= 1'b1;
	end
	else begin
		pipe_in_ready <= 1'b0;
	end

	if(data_in_wr_count <= (GEMM_FIFO_SIZE-BUFFER_HEADROOM-BLOCK_SIZE) ) begin
	  data_in_ready <= 1'b1;
	end
	else begin
		data_in_ready <= 1'b0;
	end

	if(weig_in_wr_count <= (GEMM_FIFO_SIZE-BUFFER_HEADROOM-BLOCK_SIZE) ) begin
	  weig_in_ready <= 1'b1;
	end
	else begin
		weig_in_ready <= 1'b0;
	end
	
	if(pipe_out_rd_count >= BLOCK_SIZE) begin
	  pipe_out_ready <= 1'b1;
	end
	else begin
		pipe_out_ready <= 1'b0;
	end
end

// PC Communication using Front Panel(TM)
// Instantiate the okHost and connect endpoints.
wire [65*8-1:0]  okEHx;

okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE), 
	.okEH(okEH)
);

okWireOR # (.N(8)) wireOR (okEH, okEHx);
okWireIn      wi00  (.okHE(okHE),                             .ep_addr(8'h00), .ep_dataout(ep00wire));
okWireIn	  cmdi  (.okHE(okHE),							  .ep_addr(8'h01), .ep_dataout(cmd_size));
okWireIn	  bias	(.okHE(okHE),							  .ep_addr(8'h02), .ep_dataout(bias));
okWireOut	  irq0	(.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h20), .ep_datain({31'h0000_0000, irq}));
okWireOut	  cmd0 	(.okHE(okHE), .okEH(okEHx[ 1*65 +: 65 ]), .ep_addr(8'h21), .ep_datain({o_side, i_side, kernel, stride, 1'b0, op_type}));
okWireOut	  cmd1 	(.okHE(okHE), .okEH(okEHx[ 2*65 +: 65 ]), .ep_addr(8'h22), .ep_datain({o_channel, i_channel}));
okWireOut	  cmd2 	(.okHE(okHE), .okEH(okEHx[ 3*65 +: 65 ]), .ep_addr(8'h23), .ep_datain({stride2, kernel_size, 8'h00}));
okBTPipeIn     pi0  (.okHE(okHE), .okEH(okEHx[ 4*65 +: 65 ]), .ep_addr(8'h80), .ep_write(pi0_ep_write), .ep_blockstrobe(), .ep_dataout(pi0_ep_dataout), .ep_ready(pipe_in_ready));
okBTPipeIn     pi1  (.okHE(okHE), .okEH(okEHx[ 5*65 +: 65 ]), .ep_addr(8'h81), .ep_write(pi1_ep_write), .ep_blockstrobe(), .ep_dataout(pi1_ep_dataout), .ep_ready(data_in_ready));
okBTPipeIn     pi2  (.okHE(okHE), .okEH(okEHx[ 6*65 +: 65 ]), .ep_addr(8'h82), .ep_write(pi2_ep_write), .ep_blockstrobe(), .ep_dataout(pi2_ep_dataout), .ep_ready(weig_in_ready));
okBTPipeOut    po0  (.okHE(okHE), .okEH(okEHx[ 7*65 +: 65 ]), .ep_addr(8'ha0), .ep_read(po0_ep_read),   .ep_blockstrobe(), .ep_datain(po0_ep_datain),   .ep_ready(pipe_out_ready));

fifo_w32_1024_r32_1024 cmd_fifo (
	.rst			(ep00wire[2]),			// input
	.wr_clk			(okClk),				// input
	.rd_clk			(sys_clk),				// input
	.din			(pi0_ep_dataout), 		// input, Bus [31 : 0] 
	.wr_en			(pi0_ep_write),			// input
	.rd_en			(pipe_in_read),			// input
	.dout			(pipe_in_data), 		// output, Bus [31 : 0] 
	.full			(pipe_in_full),			// output
	.empty			(pipe_in_empty),		// output
	.valid			(pipe_in_valid),		// output
	.rd_data_count	(pipe_in_rd_count), 	// output, Bus [9 : 0] 
	.wr_data_count	(pipe_in_wr_count));	// output, Bus [9 : 0] 

fifo_gemm data_fifo (
	.rst			(ep00wire[0]),			// input
	.wr_clk			(okClk),				// input
	.rd_clk			(sys_clk),				// input
	.din			(pi1_ep_dataout), 		// input, Bus [31 : 0] 
	.wr_en			(pi1_ep_write),			// input
	.rd_en			(data_in_read),			// input
	.dout			(data_in_data), 		// output, Bus [31 : 0] 
	.full			(data_in_full),			// output
	.empty			(data_in_empty),		// output
	.valid			(data_in_valid),		// output
	.rd_data_count	(data_in_rd_count), 	// output, Bus [12 : 0] 
	.wr_data_count	(data_in_wr_count));	// output, Bus [12 : 0] 

fifo_gemm weig_fifo (
	.rst			(ep00wire[0]),			// input
	.wr_clk			(okClk),				// input
	.rd_clk			(sys_clk),				// input
	.din			(pi2_ep_dataout), 		// input, Bus [31 : 0] 
	.wr_en			(pi2_ep_write),			// input
	.rd_en			(weig_in_read),			// input
	.dout			(weig_in_data), 		// output, Bus [31 : 0] 
	.full			(weig_in_full),			// output
	.empty			(weig_in_empty),		// output
	.valid			(weig_in_valid),		// output
	.rd_data_count	(weig_in_rd_count), 	// output, Bus [12 : 0] 
	.wr_data_count	(weig_in_wr_count));	// output, Bus [12 : 0] 

fifo_w32_1024_r32_1024 result_fifo (
	.rst			(ep00wire[1]),			// input
	.wr_clk			(sys_clk),				// input
	.rd_clk			(okClk),				// input
	.din			(pipe_out_data), 		// input, Bus [31 : 0] 
	.wr_en			(pipe_out_write),		// input
	.rd_en			(po0_ep_read),			// input
	.dout			(po0_ep_datain), 		// output, Bus [31 : 0] 
	.full			(pipe_out_full),		// output
	.empty			(pipe_out_empty),		// output
	.valid			(), 					// NC		
	.rd_data_count	(pipe_out_rd_count), 	// output, Bus [9 : 0] 
	.wr_data_count	(pipe_out_wr_count));	// output, Bus [9 : 0] 

endmodule