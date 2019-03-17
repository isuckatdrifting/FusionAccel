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

wire [31:0] cmd_size;
wire [31:0] bias;
// Command wires
wire [2:0] 	op_type;
wire [3:0]  stride;
wire [15:0] stride2;
wire [7:0]  kernel, kernel_size;
wire [15:0] i_channel, o_channel;
wire [7:0]  i_side, o_side;
wire [2:0]  csb_state;
wire [3:0]	engine_state;
wire [31:0] ep00wire;
wire 		sys_clk;

IBUFGDS osc_clk(.O(sys_clk), .I(sys_clkp), .IB(sys_clkn));

localparam BLOCK_SIZE      = 128;   // 512 bytes / 4 byte per word;
localparam FIFO_SIZE       = 1023;  // note that Xilinx does not allow use of the full 1024 words
localparam BUFFER_HEADROOM = 20; 	// headroom for the FIFO count to account for latency

// Front Panel Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

wire        pipe_in_read;
wire [31:0] pipe_in_data;
wire [9:0]  pipe_in_rd_count;
wire [9:0]  pipe_in_wr_count;
wire        pipe_in_valid;
wire        pipe_in_full;
wire        pipe_in_empty;
reg         pipe_in_ready;

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
reg  [9:0]  d_ram_write_addr, w_ram_write_addr;
wire [9:0]  d_ram_read_addr, w_ram_read_addr;
//-------------------------LED Stage Monitor-------------------------------//
wire 		gemm_finish, layer_finish;
assign led = ~{csb_state[0], w_ram_wr_en, d_ram_wr_en, engine_state[0], engine_state[1], engine_state[2], gemm_finish, layer_finish};

wire [15:0] 			 i_channel_count;
wire [31:0] 			 timer;
wire [16*`BURST_LEN-1:0] data_in_data, weig_in_data;
reg  [2:0] 				 d_ram_write_count, w_ram_write_count;
reg  [16*`BURST_LEN-1:0] d_ram_data, w_ram_data;
wire 					 d_ram_wr_en, w_ram_wr_en;
csb csb_(
    .clk					(sys_clk),
    .rst					(ep00wire[3]),
	.op_en					(ep00wire[4]),		// A wire from ep
	.engine_ready			(engine_ready),
	.rd_en					(pipe_in_read),
	.valid					(pipe_in_valid),
	.cmd					(pipe_in_data),
	.cmd_size				(cmd_size[6:0]),
	.op_type				(op_type),
	.stride					(stride),
	.kernel					(kernel),
	.i_side					(i_side),
	.o_side					(o_side),
	.i_channel				(i_channel),
	.o_channel				(o_channel),
	.kernel_size			(kernel_size),
	.stride2				(stride2),
	.curr_state				(csb_state),
    .irq					(irq));

engine engine_(
	.clk					(sys_clk),
//Control signals csb->engine
	.rst					(ep00wire[6]),
	.engine_valid			(ep00wire[7]),
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
	.gemm_finish			(gemm_finish),
    .layer_finish           (layer_finish),
	.i_channel_count		(i_channel_count),
	.engine_ready			(engine_ready),
//Command path engine->dma
	.dma_p0_writes_en		(pipe_out_write),
    .d_ram_read_addr       (d_ram_read_addr),
    .w_ram_read_addr       (w_ram_read_addr),
//Data path dma->engine
	.dma_p2_ob_data			(data_in_data),
	.dma_p3_ob_data			(weig_in_data),
	.dma_p0_ib_data			(pipe_out_data[15:0]),
	.curr_state				(engine_state),
    .timer                  (timer)
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
	
	if(pipe_out_rd_count >= 0) begin
	  pipe_out_ready <= 1'b1;
	end
	else begin
		pipe_out_ready <= 1'b0;
	end
end

// PC Communication using Front Panel(TM)
// Instantiate the okHost and connect endpoints.
wire [65*13-1:0]  okEHx;

okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE), 
	.okEH(okEH)
);

okWireOR # (.N(13)) wireOR (okEH, okEHx);
okWireIn      wi00  (.okHE(okHE),                             .ep_addr(8'h00), .ep_dataout(ep00wire));
okWireIn	  cmdi  (.okHE(okHE),							  .ep_addr(8'h01), .ep_dataout(cmd_size));
okWireIn   bias_in	(.okHE(okHE),							  .ep_addr(8'h02), .ep_dataout(bias));

okWireOut	  irq0	(.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h20), .ep_datain({31'h0000_0000, irq}));
okWireOut	  cmd0 	(.okHE(okHE), .okEH(okEHx[ 1*65 +: 65 ]), .ep_addr(8'h21), .ep_datain({o_side, i_side, kernel, stride, 1'b0, op_type}));
okWireOut	  cmd1 	(.okHE(okHE), .okEH(okEHx[ 2*65 +: 65 ]), .ep_addr(8'h22), .ep_datain({o_channel, i_channel}));
okWireOut	  cmd2 	(.okHE(okHE), .okEH(okEHx[ 3*65 +: 65 ]), .ep_addr(8'h23), .ep_datain({stride2, kernel_size, 8'h00}));
okWireOut	  ich 	(.okHE(okHE), .okEH(okEHx[ 4*65 +: 65 ]), .ep_addr(8'h24), .ep_datain({16'h0000, i_channel_count}));
okWireOut	  irq1 	(.okHE(okHE), .okEH(okEHx[ 5*65 +: 65 ]), .ep_addr(8'h25), .ep_datain({31'h0000_0000, gemm_finish}));
okWireOut	timer0 	(.okHE(okHE), .okEH(okEHx[ 6*65 +: 65 ]), .ep_addr(8'h26), .ep_datain(timer));
okWireOut	count0 	(.okHE(okHE), .okEH(okEHx[ 7*65 +: 65 ]), .ep_addr(8'h27), .ep_datain({22'h00_0000, pipe_out_rd_count}));
okWireOut	count1 	(.okHE(okHE), .okEH(okEHx[ 8*65 +: 65 ]), .ep_addr(8'h28), .ep_datain({22'h00_0000, pipe_out_wr_count}));

okBTPipeIn     pi0  (.okHE(okHE), .okEH(okEHx[ 9*65 +: 65 ]), .ep_addr(8'h80), .ep_write(pi0_ep_write), .ep_blockstrobe(), .ep_dataout(pi0_ep_dataout), .ep_ready(pipe_in_ready));
okBTPipeIn     pi1  (.okHE(okHE), .okEH(okEHx[ 10*65 +: 65 ]), .ep_addr(8'h81), .ep_write(pi1_ep_write), .ep_blockstrobe(), .ep_dataout(pi1_ep_dataout), .ep_ready(1));
okBTPipeIn     pi2  (.okHE(okHE), .okEH(okEHx[ 11*65 +: 65 ]), .ep_addr(8'h82), .ep_write(pi2_ep_write), .ep_blockstrobe(), .ep_dataout(pi2_ep_dataout), .ep_ready(1));
okBTPipeOut    po0  (.okHE(okHE), .okEH(okEHx[ 12*65 +: 65 ]), .ep_addr(8'ha0), .ep_read(po0_ep_read),   .ep_blockstrobe(), .ep_datain(po0_ep_datain),   .ep_ready(pipe_out_ready));

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

bram_w32_d8192 d_bram (
    .clka           (okClk),
    .wea            (d_ram_wr_en), 
    .addra          (d_ram_write_addr),
    .dina           (d_ram_data),
    .clkb           (sys_clk),
    .addrb          (d_ram_read_addr),
    .doutb          (data_in_data));

bram_w32_d8192 w_bram (
    .clka           (okClk),
    .wea            (w_ram_wr_en), 
    .addra          (w_ram_write_addr),
    .dina           (w_ram_data),
    .clkb           (sys_clk),
    .addrb          (w_ram_read_addr),
    .doutb          (weig_in_data));

assign d_ram_wr_en = (d_ram_write_count == `BURST_LEN-1)? 1: 0;
assign w_ram_wr_en = (w_ram_write_count == `BURST_LEN-1)? 1: 0;
always @ (posedge okClk) begin
    if(ep00wire[0]) begin
        d_ram_write_addr <= 'd0;
        w_ram_write_addr <= 'd0;
		d_ram_write_count <= 'd0;
		w_ram_write_count <= 'd0;
		d_ram_data <= 'd0;
		w_ram_data <= 'd0;
    end else begin
        if(pi1_ep_write) begin
			if(d_ram_write_count == `BURST_LEN-1) begin
				d_ram_write_count <= 'd0;
				d_ram_write_addr <= d_ram_write_addr + 1;
			end else begin
				d_ram_write_count <= d_ram_write_count + 1;
			end 
			d_ram_data <= {pi1_ep_dataout[15:0], d_ram_data[16*`BURST_LEN-1: 16]};
		end
        if(pi2_ep_write) begin
			if(w_ram_write_count == `BURST_LEN-1) begin
				w_ram_write_count <= 'd0;
				w_ram_write_addr <= w_ram_write_addr + 1;
			end else begin
				w_ram_write_count <= w_ram_write_count + 1;
			end
			w_ram_data <= {pi2_ep_dataout[15:0], w_ram_data[16*`BURST_LEN-1: 16]};
		end
    end
end

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