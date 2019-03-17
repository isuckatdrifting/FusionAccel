`include "macros.vh"
module engine  // Instantiate 8CMACs for conv, 8SCMP for maxpool and 8SACC for avepool in engine.
(
	input 			clk,
//Control signals csb->engine
	input 			rst,
	input 			engine_valid,
	input [2:0] 	op_type,
	input [3:0]		stride,	
	input [7:0]		kernel,
	input [7:0]	    i_side,
	input [7:0]		o_side,
	input [15:0]    i_channel,
	input [15:0]	o_channel,
	input [7:0]		kernel_size,
	input [15:0]	stride2,	//kernel * stride
	input [15:0]	bias,
//Response signals engine->csb
	output			gemm_finish,
	output			layer_finish,
	output [15:0]   i_channel_count,
	output 			engine_ready,
//Command path engine->dma
	output          dma_p0_writes_en,
	output [12:0]	d_fifo_read_addr,
	output [12:0]	w_fifo_read_addr,
//Data path dma->engine
	input [16*`BURST_LEN-1:0] 	dma_p2_ob_data,
	input [16*`BURST_LEN-1:0] 	dma_p3_ob_data,
//Data path engine->dma
	output [15:0]	dma_p0_ib_data,
	output [3:0]	curr_state,
	output [31:0]   timer
);

localparam CONV = 1, MPOOL = 2, APOOL = 3;
//==================== CMAC Wires and Registers ====================//
reg  					 cmac_data_ready, cmac_enable;
wire [`BURST_LEN-1:0] 	 cmac_data_valid;
wire [`BURST_LEN-1:0] 	 rdy_cmac;

//Data BUF and Weight BUF of serializer
reg  [16*`BURST_LEN-1:0] dbuf; 						// serial buffer

reg  [16*`BURST_LEN-1:0] data; 						// parallel
reg  [16*`BURST_LEN-1:0] weight; 					// parallel
wire [16*`BURST_LEN-1:0] conv_result; 				// parallel

//Full sum registers
reg						 f_fifo_wr_en, c_fifo_wr_en;
wire					 f_fifo_rd_en, c_fifo_rd_en;
wire [`BURST_LEN-1:0]	 c_fifo_rd_en_mux;
wire [15:0]				 fsum_result;
wire					 fsum_ready;
reg  [7:0]				 fsum_index;
reg  [15:0] 			 i_channel_count;
wire [16*`BURST_LEN-1:0] psum_;
wire 					 c_fifo_empty, f_fifo_empty;

genvar i;
generate 
	for (i = 0; i < `BURST_LEN; i = i + 1) begin: gencmac
		cmac cmac_(.clk(clk), .rst(rst), .data(data[i*16 +: 16]), .weight(weight[i*16 +: 16]), .result(conv_result[i*16 +: 16]), .data_ready(cmac_data_ready), .data_valid(cmac_data_valid[i]), .conv_ready(rdy_cmac[i]));
	end 
endgenerate
//NOTES: weight and tmp_sum is directly wired out from the corresponding registers
assign c_fifo_rd_en = &c_fifo_rd_en_mux;

wire [127:0] 		  csum_;
wire [127:0]		  csum_result;
wire [7:0] 			  csum_ready;
wire 	 			  c_fifo_valid;
wire [`BURST_LEN-1:0] csum_data_valid;
fifo_fsum cc_(
	.rst			(rst),			// input
	.wr_clk			(clk),			// input
	.rd_clk			(clk),			// input
	.din			(conv_result), 		// input, Bus [31 : 0] 
	.wr_en			(c_fifo_wr_en),	// input
	.rd_en			(c_fifo_rd_en),		// input
	.dout			(csum_), 		// output, Bus [31 : 0] 
	.full			(),				// output
	.empty			(c_fifo_empty),	// output
	.valid			(c_fifo_valid));
genvar j;
generate
	for (j = 0; j < `BURST_LEN; j = j + 1) begin: gencsum
		csum c_(.clk(clk), .rst(rst), .fifo_empty(c_fifo_empty), .reads_en(c_fifo_rd_en_mux[j]), .kernel_size(kernel_size), .data(csum_[j*16 +: 16]), .data_ready(c_fifo_valid), .data_valid(csum_data_valid[j]), .csum_result(csum_result[j*16 +: 16]), .csum_ready(csum_ready[j]));
	end
endgenerate

fifo_fsum ff_ (
	.rst			(rst),			// input
	.wr_clk			(clk),			// input
	.rd_clk			(clk),			// input
	.din			(csum_result), 		// input, Bus [31 : 0] 
	.wr_en			(f_fifo_wr_en),	// input
	.rd_en			(f_fifo_rd_en),		// input
	.dout			(psum_), 		// output, Bus [31 : 0] 
	.full			(),				// output
	.empty			(fifo_empty),	// output
	.valid			(valid));		// output

fsum f_ (.clk(clk), .rst(rst), .fifo_empty(fifo_empty), .reads_en(f_fifo_rd_en), .bias(bias), .data(psum_), .valid(valid), .fsum_result(fsum_result), .i_channel_count(i_channel_count), .fsum_index(fsum_index), .ready(fsum_ready));
//==================== SCMP Wires and Registers ====================//
reg 					 maxpool_data_ready, maxpool_enable;
wire [`BURST_LEN-1:0] 	 maxpool_data_valid;
wire [`BURST_LEN-1:0] 	 rdy_scmp;
reg  [`BURST_LEN-1:0] 	 scmp_ready;
wire [16*`BURST_LEN-1:0] scmp_data; 				// parallel

wire [16*`BURST_LEN-1:0] scmp_tmp_cmp;				// parallel, wired out from scmp_cmp 
wire [`BURST_LEN-1:0]    maxpool_result; 			// parallel
reg  [`BURST_LEN-1:0]    scmp_result;
reg  [7:0] 				 scmp_input_pipe_count;		//NOTES: counter for data reuse in scmp
reg  [7:0] 				 scmp_output_pipe_count;	//NOTES: counter for data reuse in scmp
reg  [16*`BURST_LEN-1:0] scmp_data_cache [`MAX_KERNEL-1:0];		//NOTES: memory for storing scmp reuse input data
reg  [16*`BURST_LEN-1:0] scmp_cmp [`MAX_KERNEL-1:0];			//NOTES: memory for storing scmp reuse output cmp
reg  [7:0]  			 scmp_count [`MAX_KERNEL-1:0];			//NOTES: counter for results in a kernel_size
reg  [16*`BURST_LEN-1:0] cmp;						//NOTES: registers for 16-channel cmp output, it is selected from the memory scmp_cmp

genvar l;
generate
	for (l = 0; l < `BURST_LEN; l = l + 1) begin: genscmp
		scmp scmp_(.clk(clk), .rst(rst), .new_data(scmp_data[l*16 +: 16]), .ori_data(scmp_tmp_cmp[l*16 +: 16]), .result(maxpool_result[l]), .data_ready(maxpool_data_ready), .data_valid(maxpool_data_valid[l]), .pool_ready(rdy_scmp[l]));
	end
endgenerate
always @(posedge clk) scmp_result <= maxpool_result;
always @(posedge clk) scmp_ready <= rdy_scmp;
assign scmp_data = scmp_data_cache[scmp_input_pipe_count];
assign scmp_tmp_cmp = scmp_cmp[scmp_input_pipe_count];

//==================== SACC Wires and Registers ====================//
reg 					 avepool_enable;
reg						 s_fifo_wr_en;
wire					 s_fifo_rd_en;
wire [`BURST_LEN-1:0]	 s_fifo_rd_en_mux;
wire 					 s_fifo_empty;
assign s_fifo_rd_en = &s_fifo_rd_en_mux;

wire [127:0] 		  ssum_;
wire [127:0]		  ssum_result;
wire [7:0] 			  ssum_ready;
wire 	 			  s_fifo_valid;
wire [`BURST_LEN-1:0] ssum_data_valid;
reg  [`BURST_LEN-1:0] sacc_ready;
fifo_fsum ss_(
	.rst			(rst),			// input
	.wr_clk			(clk),			// input
	.rd_clk			(clk),			// input
	.din			(data), 		// input, Bus [31 : 0] 
	.wr_en			(s_fifo_wr_en),	// input
	.rd_en			(s_fifo_rd_en),		// input
	.dout			(ssum_), 		// output, Bus [31 : 0] 
	.full			(),				// output
	.empty			(s_fifo_empty),	// output
	.valid			(s_fifo_valid));

reg [16*`BURST_LEN-1:0] a_div, b_div;
reg div_data_ready;
wire [16*`BURST_LEN-1:0] result_div;
wire [`BURST_LEN-1:0] div_data_valid, div_ready;
genvar k;
generate
	for (k = 0; k < `BURST_LEN; k = k + 1) begin: gensacc
		csum s_(.clk(clk), .rst(rst), .fifo_empty(s_fifo_empty), .reads_en(s_fifo_rd_en_mux[k]), .kernel_size(kernel_size), .data(ssum_[k*16 +: 16]), .data_ready(s_fifo_valid), .data_valid(ssum_data_valid[k]), .csum_result(ssum_result[k*16 +: 16]), .csum_ready(ssum_ready[k]));
		divider div_(.a(a_div[k*16+:16]), .b(b_div[k*16+:16]), .clk(clk), .operation_nd(div_data_ready), .operation_rfd(div_data_valid[k]), .result(result_div[k*16 +:16]), .rdy(div_ready[k]));
	end
endgenerate
always @(posedge clk) sacc_ready <= div_ready;

//==================== Address registers ===========================//
reg  [7:0]  gemm_count;
reg  [15:0] o_channel_count;
reg			gemm_finish, layer_finish;
reg 		to_clear;
reg 		engine_ready;

//==================== DMA related registers========================//
reg  [15:0] input_count;						//NOTES: counter for one gemm line, range:(0, kernel * o_side)
reg  [15:0] output_count;
reg  [7:0]  cache_count [`MAX_KERNEL-1:0]; 	//NOTES: use max conv side support defined in include files.
reg  [7:0]  dma_p2_burst_cnt, dma_p3_burst_cnt, dma_p3_offset; // de-serializer counter, burst get 16 data, then send to operation unit.
reg			dma_p0_writes_en;
reg  [9:0] d_fifo_read_addr, w_fifo_read_addr;
reg  [15:0] dma_p0_ib_data;
reg			p0_writeback_en;
reg	 [7:0]	p0_writeback_count;
reg	 [7:0]	writeback_num;
reg  [31:0] timer;

// NOTES: Generate accumulator for atom(1 * 1 * channel) and cube(k * k * channel), this data path is dedicated to convolution only.
// NOTES: deserializer for write back is only enabled in pooling
//State Machine
localparam idle 		= 0;
localparam gemm_busy 	= 1;
localparam sacc_busy 	= 2;
localparam scmp_busy 	= 3;
localparam clear 		= 4;
localparam wait_		= 5;
localparam finish 		= 6;

reg [3:0] curr_state;
reg [3:0] next_state;

//    Current State, non-blocking
always @ (posedge clk or posedge rst)    begin
    if (rst)
        curr_state    <= idle;
    else
        curr_state    <= next_state;
end

//    Status Jump, blocking
always @ (*) begin
    next_state = idle;    //    Initialize
    case (curr_state)
        idle: begin
			if(engine_valid) begin
				case(op_type)
					CONV: next_state = gemm_busy;
					MPOOL: next_state = scmp_busy;
					APOOL: next_state = sacc_busy;
				endcase
			end else next_state = idle;
        end
		gemm_busy: begin
			if(to_clear) next_state = clear;
			else next_state = gemm_busy;
		end
		scmp_busy: begin
			if(to_clear) next_state = clear;
			else next_state = scmp_busy;
		end
		sacc_busy: begin
			if(to_clear) next_state = clear;
			else next_state = sacc_busy;
		end
		clear: begin
			if(i_channel_count + `BURST_LEN >= i_channel) next_state = wait_;
			else next_state = idle;
		end
		wait_: begin
			next_state = wait_;
		end
		finish: begin
			next_state = finish;
		end
        default:
            next_state = idle;
    endcase
end
//NOTES: MEC convolution: k * k kernel in BURST_LEN -> finish the line -> next channel group(channel += BURST_LEN) -> next_gemm
//NOTES: Sum point is ready only after the all channel is complete

//    Output, non-blocking
integer b;
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		engine_ready <= 0;
		d_fifo_read_addr <= 'd0; w_fifo_read_addr <= 'd0;
		dma_p2_burst_cnt <= 16'h0000; dma_p3_burst_cnt <= 16'h0000; dma_p3_offset <= 8'h00;
		dma_p0_writes_en <= 0; dma_p0_ib_data <= 16'h0000;
		//==================== Channel operation registers ====================
		dbuf <= 'd0; data <= 'd0; cmp <= 'd0;
		weight <= 'd0;
		//==================== Slot registers ====================
		for(b=0;b<`MAX_KERNEL;b=b+1) begin
			cache_count[b] <= 8'h00;
			scmp_count[b] <= 8'h00;
			scmp_cmp[b] <= 'd0;
			scmp_data_cache[b] <= 'd0;
		end
		cmac_enable <= 0; cmac_data_ready <= 0; avepool_enable <= 0; maxpool_enable <= 0; maxpool_data_ready <= 0;
		input_count <= 16'h0000; output_count <= 16'h0000;
		scmp_input_pipe_count <= 8'h00; scmp_output_pipe_count <= 8'h00; 
		f_fifo_wr_en <= 0; c_fifo_wr_en <= 0; s_fifo_wr_en <= 0; fsum_index <= 8'h00;
		to_clear <= 0; a_div <= 0; b_div <= {16{16'h3c00}}; div_data_ready <= 0;
		//==================== Cross-channel registers ====================
		i_channel_count <= 16'h0000; gemm_count <= 8'h00; o_channel_count <= 16'h0000; gemm_finish <= 0; layer_finish <= 0;
		p0_writeback_en <= 0; p0_writeback_count <= 8'h00; writeback_num <= 8'h00; timer <= 0;
	end else begin
		case (curr_state)
			//==================== Clear all registers except cross-channel registers ====================
			idle: begin 
				engine_ready <= 0;
				dma_p2_burst_cnt <= 16'h0000; dma_p3_burst_cnt <= 16'h0000; dma_p3_offset <= 8'h00;
				dma_p0_writes_en <= 0; dma_p0_ib_data <= 16'h0000;
				//==================== Channel operation registers ====================
				dbuf <= 'd0; data <= 'd0; cmp <= 'd0;
				//==================== Slot registers ====================
				for(b=0;b<`MAX_KERNEL;b=b+1) begin
					cache_count[b] <= 8'h00;
					scmp_count[b] <= 8'h00;
					scmp_cmp[b] <= 'd0;
					scmp_data_cache[b] <= 'd0;
				end
				cmac_enable <= 0; cmac_data_ready <= 0; avepool_enable <= 0; maxpool_enable <= 0; maxpool_data_ready <= 0;
				input_count <= 16'h0000; output_count <= 16'h0000;
				scmp_input_pipe_count <= 8'h00; scmp_output_pipe_count <= 8'h00; 
				f_fifo_wr_en <= 0; c_fifo_wr_en <= 0; s_fifo_wr_en <= 0; fsum_index <= 8'h00;
				to_clear <= 0; a_div <= 0; b_div <= {16{16'h3c00}}; div_data_ready <= 0;
				gemm_finish <= 0;
			end
// CMD = 1 ==================== CONVOLUTION: Process a line ====================//
			gemm_busy: begin
				timer <= timer + 1;
				//========== CONVOLUTION PIPELINE STEP1: enable data read and weight read (this part is the slowest and defines the available timing space of the pipeline)
				if(engine_valid) begin
					if(w_fifo_read_addr + 1 < kernel_size) begin
						d_fifo_read_addr <= d_fifo_read_addr + 1;
						w_fifo_read_addr <= w_fifo_read_addr + 1;
					end	else begin
						d_fifo_read_addr <= (d_fifo_read_addr + stride2) - (kernel_size - 1);
						w_fifo_read_addr <= 0;
					end
					cmac_enable <= 1;
				end
				if(cmac_enable) begin
					if(cmac_data_valid == {`BURST_LEN{1'b1}}) begin
						data <= dma_p2_ob_data;
						weight <= dma_p3_ob_data;
					end
					cmac_data_ready <= 1;
				end
				if(rdy_cmac == {`BURST_LEN{1'b1}}) begin
					c_fifo_wr_en <= 1;
				end
				if(csum_ready == {`BURST_LEN{1'b1}}) begin
					f_fifo_wr_en <= 1;
				end
				// ========== CONVOLUTION PIPELINE STEP4: full channel sum stored in -> sum, sum all channels
				if(f_fifo_wr_en) f_fifo_wr_en <= 0;
				if(fsum_ready) begin 
					p0_writeback_en <= 1; 
					writeback_num <= 1; 
					fsum_index <= fsum_index + 1;
					if(fsum_index + 1 == o_side) to_clear <= 1; 
				end
			end

// CMD = 4 ==================== MAXPOOLING: Process a line ====================//
			scmp_busy: begin
				if(engine_valid) d_fifo_read_addr <= d_fifo_read_addr + 1;

				//========== MAXPOOLING PIPELINE STEP1: enable data read (this part is the slowest and defines the available timing space of the pipeline)
				if(d_fifo_read_addr > 0) begin
					dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
					if(dma_p2_burst_cnt == `BURST_LEN-1) begin	//NOTES: start scmp when finishing reading the first atom (1x1xpara)
						dma_p2_burst_cnt <= 0;
						maxpool_enable <= 1;
					end
					dbuf <= {dma_p2_ob_data, dbuf[16*`BURST_LEN-1 : 16]}; // deserialize data to dbuf
				end

				//========== MAXPOOLING PIPELINE STEP2: start passing deserialized data scmp (including data reuse)
				if(maxpool_data_ready) begin
					scmp_input_pipe_count <= scmp_input_pipe_count + 1;
				end
				if(scmp_input_pipe_count == kernel - stride) begin //cmac_data_ready width is max of cmac_input_pipe_count
					scmp_input_pipe_count <= 0;
					maxpool_data_ready <= 0;
				end
				if(maxpool_enable) begin
					maxpool_data_ready <= 1;
					maxpool_enable <= 0;
					scmp_input_pipe_count <= 0;
					
					input_count <= input_count + 1;
					// Logic for setting cache_count according to input_count
					if(maxpool_data_valid == {`BURST_LEN{1'b1}}) begin
						if(input_count >= 0 && (kernel - stride) >= 7'd0) begin // stride2 * a
							cache_count[0] <= cache_count[0] + 1;
							if(cache_count[0] < kernel_size) scmp_data_cache[0] <= dbuf;
							else begin scmp_data_cache[0] <= 0; scmp_cmp[0] <= 0; end // clear buffer
						end 
						if(cache_count[0] + 1 == kernel_size + stride2 - kernel) begin
							cache_count[0] <= 0;
						end
						if(input_count >= stride2 && (kernel - stride) >= 7'd1) begin
							cache_count[1] <= cache_count[1] + 1;
							if(cache_count[1] < kernel_size) scmp_data_cache[1] <= dbuf;
							else begin scmp_data_cache[1] <= 0; scmp_cmp[1] <= 0; end
						end 
						if(cache_count[1] + 1 == kernel_size + stride2 - kernel) begin
							cache_count[1] <= 0;
						end
						if(input_count >= stride2 + stride2 && (kernel - stride) >= 7'd2) begin
							cache_count[2] <= cache_count[2] + 1;
							if(cache_count[2] < kernel_size) scmp_data_cache[2] <= dbuf;
							else begin scmp_data_cache[2] <= 0; scmp_cmp[2] <= 0; end
						end
						if(cache_count[2] + 1 == kernel_size + stride2 - kernel) begin
							cache_count[2] <= 0;
						end
					end
				end

				//========== MAXPOOLING PIPELINE STEP3: Results of channel outputs, independent of the pipeline
				if(scmp_ready == {`BURST_LEN{1'b1}}) begin
					scmp_output_pipe_count <= scmp_output_pipe_count + 1;
					for(b=0;b<`BURST_LEN;b=b+1) begin
						scmp_cmp[scmp_output_pipe_count][16*b +: 16] <= scmp_result[b] ? scmp_data_cache[scmp_output_pipe_count][16*b +: 16]: scmp_cmp[scmp_output_pipe_count][16*b +: 16];
					end
					if(scmp_output_pipe_count == kernel - stride) begin
						scmp_output_pipe_count <= 0;

						output_count <= output_count + 1;
						if(output_count >= 0 && (kernel - stride) >= 7'd0) begin // stride2 * a
							scmp_count[0] <= scmp_count[0] + 1;
						end 
						if(scmp_count[0] + 1 == kernel_size + stride2 - kernel) begin
							scmp_count[0] <= 0;
						end
						if(output_count >= stride2 && (kernel - stride) >= 7'd1) begin
							scmp_count[1] <= scmp_count[1] + 1;
						end 
						if(scmp_count[1] + 1 == kernel_size + stride2 - kernel) begin
							scmp_count[1] <= 0;
						end
						if(output_count >= stride2 + stride2 && (kernel - stride) >= 7'd2) begin
							scmp_count[2] <= scmp_count[2] + 1;
						end
						if(scmp_count[2] + 1 == kernel_size + stride2 - kernel) begin
							scmp_count[2] <= 0;
						end
					end
					//Logic for setting scmp_count according to cache_count
					if(scmp_count[scmp_output_pipe_count] + 1 == kernel_size) begin
						cmp <= scmp_cmp[scmp_output_pipe_count];
						p0_writeback_en <= 1; //Trigger for channel memory writeback
						writeback_num <= `BURST_LEN;
					end
				end
			end

// CMD = 5 ==================== AVEPOOLING: Process a line * surface ====================//
			sacc_busy: begin
				if(engine_valid) begin
					if(d_fifo_read_addr + 1 < kernel_size) begin
						d_fifo_read_addr <= d_fifo_read_addr + 1;
					end	else begin
						d_fifo_read_addr <= 0;
					end
					avepool_enable <= 1;
				end
				if(avepool_enable) begin
					s_fifo_wr_en <= 1;
					data <= dma_p2_ob_data;
				end
				if(ssum_ready == {`BURST_LEN{1'b1}}) begin 
					a_div <= ssum_result;
					b_div <= {16{16'h5948}};
					div_data_ready <= 1;
				end
				if(div_data_ready) div_data_ready <= 0;
				if(sacc_ready == {`BURST_LEN{1'b1}}) begin
					to_clear <= 1;
					p0_writeback_en <= 1; //NOTES: Writeback all channels
					writeback_num <= `BURST_LEN;
				end
			end

			//==================== Update cross-channel counters and read address ====================
			clear: begin
				i_channel_count <= i_channel_count + `BURST_LEN; // within channel operation the address is not updated
				if(i_channel_count + `BURST_LEN >= i_channel) begin
					i_channel_count <= 0;
					gemm_count <= gemm_count + 1; //NOTES: a gemm is finished
					gemm_finish <= 1;
					if(gemm_count + 1 == o_side) begin
						gemm_count <= 0;
						case(op_type)
							CONV: begin o_channel_count <= o_channel_count + 1; end//NOTES: start the next weight group, o_channel should jump to load_bias
							MPOOL, APOOL: o_channel_count <= o_channel_count + `BURST_LEN;
							default:;
						endcase
						if(o_channel_count + 1 == o_channel) begin
							layer_finish <= 1;
						end
					end
				end
			end

			finish: begin
				layer_finish <= 0;
				engine_ready <= 1;
			end
			default:;
		endcase

		//==================== Write back logic and write address ====================
		if(p0_writeback_en) begin
			if(p0_writeback_count < writeback_num) begin
				dma_p0_writes_en <= 1; //NOTES: Dual channel write back with shared data and independent address
				p0_writeback_count <= p0_writeback_count + 1;
			end else begin
				p0_writeback_en <= 0;
				p0_writeback_count <= 0;
				dma_p0_writes_en <= 0;
			end
			case(op_type)
				CONV: dma_p0_ib_data <= fsum_result[15]? 16'h0000: fsum_result; //Notes: ReLu Activation
				MPOOL: dma_p0_ib_data <= cmp[p0_writeback_count * 16 +: 16];
				APOOL: dma_p0_ib_data <= result_div[p0_writeback_count * 16 +: 16];
			endcase
		end 

	end
end
endmodule
