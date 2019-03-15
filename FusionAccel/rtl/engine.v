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
	output [15:0]   i_channel_count,
	output 			engine_ready,
//Command path engine->dma
	output          dma_p0_writes_en,
    output          dma_p2_reads_en,
    output          dma_p3_reads_en,
//Data path dma->engine
	input [15:0] 	dma_p2_ob_data,
	input [15:0] 	dma_p3_ob_data,
	input 			dma_p2_ob_we,
	input 			dma_p3_ob_we,
//Data path engine->dma
	output [15:0]	dma_p0_ib_data,
	output [3:0]	curr_state,
	output [31:0]   timer
);

localparam CONV = 1, MPOOL = 2, APOOL = 3;
//==================== CMAC Wires and Registers ====================//
reg  					 cmac_data_ready, cmac_enable;
wire [`BURST_LEN-1:0] 	 cmac_data_valid, mult_ready_buf;
wire [`BURST_LEN-1:0] 	 rdy_cmac;
reg  [`BURST_LEN-1:0] 	 cmac_ready;

//Data BUF and Weight BUF of serializer
reg  [16*`BURST_LEN-1:0] dbuf; 						// serial buffer
reg  [16*`BURST_LEN-1:0] wbuf [`MAX_KERNEL_SIZE-1:0]; 				// serial buffer

reg  [16*`BURST_LEN-1:0] data; 						// parallel
wire [16*`BURST_LEN-1:0] weight; 					// parallel 3x3xBURST_LEN, wired out from cmac_weight_cache
wire [16*`BURST_LEN-1:0] cmac_tmp_sum;				// parallel, wired out from cmac_sum
wire [16*`BURST_LEN-1:0] conv_result; 				// parallel
reg  [16*`BURST_LEN-1:0] cmac_result;

//pipeline registers
reg  [7:0]  			 cmac_input_pipe_count;		//NOTES: counter for data reuse on one data in cmac
reg  [7:0]  			 cmac_middle_pipe_count;	//NOTES: counter for cmac_tmp_sum in cmac
reg  [7:0]  			 cmac_output_pipe_count;	//NOTES: counter for results in single cmac reuse
reg  [16*`BURST_LEN-1:0] cmac_weight_cache [`MAX_KERNEL-1:0];	//NOTES: memory for storing cmac reuse input weight
reg  [16*`BURST_LEN-1:0] cmac_sum [`MAX_KERNEL-1:0];			//NOTES: memory for storing cmac reuse output sum
reg  [7:0]  			 psum_count [`MAX_KERNEL-1:0];			//NOTES: counter for results in a kernel_size
reg  [16*`BURST_LEN-1:0] psum;						//NOTES: registers for 16-channel sum output, it is selected from the memory cmac_sum

//Full sum registers
reg						 writes_en;
wire					 reads_en;
wire [15:0]				 fsum_result;
wire					 fsum_ready;
reg  [7:0]				 fsum_index;
reg  [15:0] 			 i_channel_count;
wire [127:0] 			 psum_;
wire 					 fifo_empty;

genvar i;
generate 
	for (i = 0; i < `BURST_LEN; i = i + 1) begin: gencmac
		cmac cmac_(.clk(clk), .rst(rst), .data(data[i*16 +: 16]), .weight(weight[i*16 +: 16]), .result(conv_result[i*16 +: 16]), .tmp_sum(cmac_tmp_sum[i*16 +: 16]), .mult_ready_buf(mult_ready_buf[i]), .data_ready(cmac_data_ready), .data_valid(cmac_data_valid[i]), .conv_ready(rdy_cmac[i]));
	end 
endgenerate
//NOTES: weight and tmp_sum is directly wired out from the corresponding registers
always @(posedge clk) cmac_result <= conv_result;
always @(posedge clk) cmac_ready <= rdy_cmac;
assign weight = cmac_weight_cache[cmac_input_pipe_count];
assign cmac_tmp_sum = cmac_sum[cmac_middle_pipe_count];

fifo_fsum ff_ (
	.rst			(rst),			// input
	.wr_clk			(clk),			// input
	.rd_clk			(clk),			// input
	.din			(psum), 		// input, Bus [31 : 0] 
	.wr_en			(writes_en),	// input
	.rd_en			(reads_en),		// input
	.dout			(psum_), 		// output, Bus [31 : 0] 
	.full			(),				// output
	.empty			(fifo_empty),	// output
	.valid			(valid));		// output

fsum f_ (.clk(clk), .rst(rst), .fifo_empty(fifo_empty), .reads_en(reads_en), .bias(bias), .data(psum_), .valid(valid), .fsum_result(fsum_result), .i_channel_count(i_channel_count), .fsum_index(fsum_index), .ready(fsum_ready));
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
reg 					 avepool_data_ready, avepool_enable;
wire [`BURST_LEN-1:0] 	 avepool_data_valid;
wire [`BURST_LEN-1:0] 	 rdy_sacc;
reg  [`BURST_LEN-1:0] 	 sacc_ready;

reg  [16*`BURST_LEN-1:0] sacc_tmp_sum;
wire [16*`BURST_LEN-1:0] avepool_result; // parallel
reg  [16*`BURST_LEN-1:0] sacc_result;

reg div_en;

genvar k;
generate
	for (k = 0; k < `BURST_LEN; k = k + 1) begin: gensacc
		sacc sacc_(.clk(clk), .rst(rst), .data(data[k*16 +: 16]), .result(avepool_result[k*16 +: 16]), .tmp_sum(sacc_tmp_sum[k*16 +: 16]), .data_ready(avepool_data_ready), .data_valid(avepool_data_valid[k]), .div_en(div_en), .pool_ready(rdy_sacc[k]));
	end
endgenerate
always @(posedge clk) sacc_result <= avepool_result;
always @(posedge clk) sacc_ready <= rdy_sacc;

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
reg			dma_p0_writes_en, dma_p2_reads_en, dma_p3_reads_en;
reg  [15:0] dma_p0_ib_data;
reg			p0_writeback_en;
reg	 [7:0]	p0_writeback_count;
reg	 [7:0]	writeback_num;
reg  [31:0] timer;

// NOTES: Generate accumulator for atom(1 * 1 * channel) and cube(k * k * channel), this data path is dedicated to convolution only.
// NOTES: deserializer for write back is only enabled in pooling
//State Machine
localparam idle 		= 1;
localparam gemm_busy 	= 2;
localparam sacc_busy 	= 3;
localparam scmp_busy 	= 4;
localparam clear 		= 5;
localparam wait_		= 6;
localparam finish 		= 7;

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
			next_state = clear;
		end
		finish: begin
			next_state = finish;
		end
        default:
            next_state = idle;
    endcase
end
//NOTES: MEC convolution: k * k kernel in BURST_LEN -> finish the line -> next channel group(channel += BURST_LEN) -> next_gemm
//		 Register level:       cmac_sum -> psum -> sum
//		 Counter level:		   input_count, cache_count -> XXX_pipe_count -> output_count, psum_count -> fsum_index
//NOTES: Sum point is ready only after the all channel is complete

//    Output, non-blocking
integer b;
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		engine_ready <= 0;
		dma_p2_burst_cnt <= 16'h0000; dma_p3_burst_cnt <= 16'h0000; dma_p3_offset <= 8'h00;
		dma_p0_writes_en <= 0; dma_p2_reads_en <= 0; dma_p3_reads_en <= 0;
		dma_p0_ib_data <= 16'h0000;
		//==================== Channel operation registers ====================
		dbuf <= 'd0; data <= 'd0; psum <= 'd0; cmp <= 'd0; sacc_tmp_sum <= 'd0;
		for(b=0;b<`MAX_KERNEL_SIZE;b=b+1) wbuf[b] <= 'd0;
		//==================== Slot registers ====================
		for(b=0;b<`MAX_KERNEL;b=b+1) begin
			cache_count[b] <= 8'h00;
			psum_count[b] <= 8'h00;
			scmp_count[b] <= 8'h00;
			cmac_sum[b] <= 'd0;
			scmp_cmp[b] <= 'd0;
			scmp_data_cache[b] <= 'd0;
			cmac_weight_cache[b] <= 'd0;
		end
		cmac_enable <= 0; cmac_data_ready <= 0; avepool_enable <= 0; avepool_data_ready <= 0; maxpool_enable <= 0; maxpool_data_ready <= 0; div_en <= 0;
		input_count <= 16'h0000; output_count <= 16'h0000; cmac_output_pipe_count <= 8'h00;
		cmac_input_pipe_count <= 8'h00; cmac_middle_pipe_count <= 8'h00; scmp_input_pipe_count <= 8'h00; scmp_output_pipe_count <= 8'h00; 
		writes_en <= 0; fsum_index <= 8'h00;
		to_clear <= 0; 
		//==================== Cross-channel registers ====================
		i_channel_count <= 16'h0000; gemm_count <= 8'h00; o_channel_count <= 16'h0000; gemm_finish <= 0; layer_finish <= 0;
		p0_writeback_en <= 0; p0_writeback_count <= 8'h00; writeback_num <= 8'h00; timer <= 0;
	end else begin
		case (curr_state)
			//==================== Clear all registers except cross-channel registers ====================
			idle: begin 
				engine_ready <= 0;
				dma_p2_burst_cnt <= 16'h0000; dma_p3_burst_cnt <= 16'h0000; dma_p3_offset <= 8'h00;
				dma_p0_writes_en <= 0; dma_p2_reads_en <= 0; dma_p3_reads_en <= 0;
				dma_p0_ib_data <= 16'h0000;
				//==================== Channel operation registers ====================
				dbuf <= 'd0; data <= 'd0; psum <= 'd0; cmp <= 'd0; sacc_tmp_sum <= 'd0;
				for(b=0;b<`MAX_KERNEL_SIZE;b=b+1) wbuf[b] <= 'd0;
				//==================== Slot registers ====================
				for(b=0;b<`MAX_KERNEL;b=b+1) begin
					cache_count[b] <= 8'h00;
					psum_count[b] <= 8'h00;
					scmp_count[b] <= 8'h00;
					cmac_sum[b] <= 'd0;
					scmp_cmp[b] <= 'd0;
					scmp_data_cache[b] <= 'd0;
					cmac_weight_cache[b] <= 'd0;
				end
				cmac_enable <= 0; cmac_data_ready <= 0; avepool_enable <= 0; avepool_data_ready <= 0; maxpool_enable <= 0; maxpool_data_ready <= 0; div_en <= 0;
				input_count <= 16'h0000; output_count <= 16'h0000; cmac_output_pipe_count <= 8'h00;
				cmac_input_pipe_count <= 8'h00; cmac_middle_pipe_count <= 8'h00; scmp_input_pipe_count <= 8'h00; scmp_output_pipe_count <= 8'h00; 
				writes_en <= 0; fsum_index <= 8'h00;
				to_clear <= 0; gemm_finish <= 0;
			end
// CMD = 1 ==================== CONVOLUTION: Process a line ====================//
			gemm_busy: begin
				timer <= timer + 1;
				if(engine_valid) begin
					dma_p2_reads_en <= 1; 
					dma_p3_reads_en <= 1;
				end

				//========== CONVOLUTION PIPELINE STEP1: enable data read and weight read (this part is the slowest and defines the available timing space of the pipeline)
				if(dma_p2_ob_we) begin
					dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
					if(dma_p2_burst_cnt == `BURST_LEN-1) begin	//NOTES: start cmac when finishing reading the first atom (1x1xpara)
						dma_p2_reads_en <= 0; 
						dma_p2_burst_cnt <= 0;
						cmac_enable <= 1;	//NOTES: use this signal to latch buffer
					end
					dbuf <= {dma_p2_ob_data, dbuf[16*`BURST_LEN-1 : 16]}; // deserialize data to dbuf
				end
				if(dma_p3_ob_we) begin // @ this edge dma_p3_ob_data is also updated.
					if(dma_p3_burst_cnt == `BURST_LEN-1) begin
						dma_p3_reads_en <= 0; 
						dma_p3_burst_cnt <= 0;
						dma_p3_offset <= dma_p3_offset + 1;
					end else dma_p3_burst_cnt <= dma_p3_burst_cnt + 1;
					wbuf[dma_p3_offset] <= {dma_p3_ob_data, wbuf[dma_p3_offset][16*`BURST_LEN-1 : 16]};
				end
				if(dma_p3_offset == kernel_size) begin
					dma_p3_reads_en <= 0; // pull down weight read
				end

				//========== CONVOLUTION PIPELINE STEP2: start passing deserialized data and weight to cmac (including weight reuse)
				if(cmac_data_ready) begin
					cmac_input_pipe_count <= cmac_input_pipe_count + 1;
				end
				if(cmac_input_pipe_count == kernel - stride) begin //cmac_data_ready width is max of cmac_input_pipe_count
					cmac_input_pipe_count <= 0;
					cmac_data_ready <= 0;
				end
				if(mult_ready_buf == {`BURST_LEN{1'b1}}) begin
					cmac_middle_pipe_count <= cmac_middle_pipe_count + 1;
				end
				if(cmac_middle_pipe_count == kernel - stride) begin
					cmac_middle_pipe_count <= 0;
				end
				if(cmac_enable) begin
					cmac_data_ready <= 1;
					cmac_enable <= 0;
					if(cmac_data_valid == {`BURST_LEN{1'b1}}) data <= dbuf;

					input_count <= input_count + 1;
					// Logic for setting cache_count according to input_count
					if(input_count >= 0 && (kernel - stride) >= 7'd0) begin // stride2 * a
						cache_count[0] <= cache_count[0] + 1;
						if(cache_count[0] < kernel_size) cmac_weight_cache[0] <= wbuf[cache_count[0]];
						else cmac_weight_cache[0] <= 0;
					end 
					if(cache_count[0] + 1 == kernel_size + stride2 - kernel) begin
						cache_count[0] <= 0;
					end
					if(input_count >= stride2 && (kernel - stride) >= 7'd1) begin
						cache_count[1] <= cache_count[1] + 1;
						if(cache_count[1] < kernel_size) cmac_weight_cache[1] <= wbuf[cache_count[1]];
						else cmac_weight_cache[1] <= 0;
					end 
					if(cache_count[1] + 1 == kernel_size + stride2 - kernel) begin
						cache_count[1] <= 0;
					end
					if(input_count >= stride2 + stride2 && (kernel - stride) >= 7'd2) begin
						cache_count[2] <= cache_count[2] + 1;
						if(cache_count[2] < kernel_size) cmac_weight_cache[2] <= wbuf[cache_count[2]];
						else cmac_weight_cache[2] <= 0;
					end
					if(cache_count[2] + 1 == kernel_size + stride2 - kernel) begin
						cache_count[2] <= 0;
					end
				end

				//========== CONVOLUTION PIPELINE STEP3: Partial SUM of channel outputs, independent of the pipeline
				if(cmac_ready == {`BURST_LEN{1'b1}}) begin
					cmac_output_pipe_count <= cmac_output_pipe_count + 1;
					cmac_sum[cmac_output_pipe_count] <= (psum_count[cmac_output_pipe_count] + 1 < kernel_size)? cmac_result: 0;
					if(cmac_output_pipe_count == kernel - stride) begin // to ensure the following actions do only once in cmac_ready = 1
						cmac_output_pipe_count <= 0;

						output_count <= output_count + 1;
						if(output_count >= 0 && (kernel - stride) >= 7'd0) begin // stride2 * a
							psum_count[0] <= psum_count[0] + 1;
						end 
						if(psum_count[0] + 1 == kernel_size + stride2 - kernel) begin
							psum_count[0] <= 0;
						end
						if(output_count >= stride2 && (kernel - stride) >= 7'd1) begin
							psum_count[1] <= psum_count[1] + 1;
						end 
						if(psum_count[1] + 1 == kernel_size + stride2 - kernel) begin
							psum_count[1] <= 0;
						end
						if(output_count >= stride2 + stride2 && (kernel - stride) >= 7'd2) begin
							psum_count[2] <= psum_count[2] + 1;
						end
						if(psum_count[2] + 1 == kernel_size + stride2 - kernel) begin
							psum_count[2] <= 0;
						end
					end
					//Logic for setting psum_count according to cache_count
					if(psum_count[cmac_output_pipe_count] + 1 == kernel_size) begin
						psum <= cmac_result;
						writes_en <= 1; //Trigger for channel partial sum
					end
				end 
				// ========== CONVOLUTION PIPELINE STEP4: full channel sum stored in -> sum, sum all channels
				if(writes_en) writes_en <= 0;
				if(fsum_ready) begin 
					p0_writeback_en <= 1; 
					writeback_num <= 1; 
					fsum_index <= fsum_index + 1;
					if(fsum_index + 1 == o_side) to_clear <= 1; 
				end
			end

// CMD = 4 ==================== MAXPOOLING: Process a line ====================//
			scmp_busy: begin
				if(engine_valid) dma_p2_reads_en <= 1;

				//========== MAXPOOLING PIPELINE STEP1: enable data read (this part is the slowest and defines the available timing space of the pipeline)
				if(dma_p2_ob_we) begin
					dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
					if(dma_p2_burst_cnt == `BURST_LEN-1) begin	//NOTES: start scmp when finishing reading the first atom (1x1xpara)
						dma_p2_reads_en <= 0;
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
				if(engine_valid) dma_p2_reads_en <= 1;

				//========== AVEPOOLING PIPELINE STEP1: enable data read (this part is the slowest and defines the available timing space of the pipeline)
				if(dma_p2_ob_we) begin
					dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
					if(dma_p2_burst_cnt == `BURST_LEN-1) begin	//NOTES: start cmac when finishing reading the first atom (1x1xpara)
						dma_p2_burst_cnt <= 0;
						avepool_enable <= 1;
					end
					dbuf <= {dma_p2_ob_data, dbuf[16*`BURST_LEN-1 : 16]}; // deserialize data to dbuf
				end
				//========== AVEPOOLING PIPELINE STEP2: accumulate and divide
				if(avepool_enable) begin
					avepool_enable <= 0;
					avepool_data_ready <= 1;
					if(avepool_data_valid == {`BURST_LEN{1'b1}}) data <= dbuf;
					input_count <= input_count + 1;
					if(fsum_index + 1 == kernel_size) begin
						div_en <= 1; //NOTES: divide trigger
					end
				end
				if(avepool_data_ready) begin
					avepool_data_ready <= 0;
				end
				if(sacc_ready) begin
					sacc_tmp_sum <= sacc_result;
					fsum_index <= fsum_index + 1;
				end
				if(div_en && sacc_ready) begin
					div_en <= 0;
					to_clear <= 1;
					p0_writeback_en <= 1; //NOTES: Writeback all channels
					writeback_num <= `BURST_LEN;
				end
			end

			//==================== Update cross-channel counters and read address ====================
			clear: begin
				dma_p2_reads_en <= 0; dma_p3_reads_en <= 0;
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
				APOOL: dma_p0_ib_data <= sacc_tmp_sum[p0_writeback_count * 16 +: 16];
			endcase
		end 

	end
end
endmodule
