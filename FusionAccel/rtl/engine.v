`include "macros.vh"
module engine  //Instantiate 16CMACs for conv3x3, 16CMACs for conv1x1, maxpool and avepool in engine.
(
	input 			clk,
//Control signals csb->engine
	input 			rst,
	input 			engine_valid,
	input [2:0] 	op_type,
	input			padding,
	input [3:0]		stride,		//TODO: valid check: stride < padding
	input [7:0]		kernel,
	input [15:0]	stride2,	//kernel * stride
	input [7:0]		kernel_size,
	input [15:0]    i_channel,
	input [15:0]	o_channel,
	input [7:0]	    i_side,
	input [7:0]		o_side,
	input [31:0]	data_start_addr,
	input [31:0]	weight_start_addr,
	input [31:0]    result_start_addr,
//Response signals engine->csb
	output 			engine_ready,
//Command path engine->dma
	output          dma_p0_writes_en,
	output          dma_p1_writes_en,
    output          dma_p2_reads_en,
    output          dma_p3_reads_en,
    output          dma_p4_reads_en,
    output          dma_p5_reads_en,
	output [29:0]   p0_addr,
	output [29:0]   p1_addr,
	output [29:0]   p2_addr,
    output [29:0]   p3_addr,
    output [29:0]   p4_addr,
    output [29:0]   p5_addr,
//Data path dma->engine
	input [15:0] 	dma_p2_ob_data,
	input [15:0] 	dma_p3_ob_data,
	input [15:0] 	dma_p4_ob_data,
	input [15:0] 	dma_p5_ob_data,
	input			dma_p0_ib_re,
	input			dma_p1_ib_re,
	input 			dma_p2_ob_we,
	input 			dma_p3_ob_we,
	input 			dma_p4_ob_we,
	input 			dma_p5_ob_we,
//Data path engine->dma
	output [15:0]	dma_p0_ib_data,
	output [15:0]	dma_p1_ib_data,
	output			dma_p0_ib_valid,
	output			dma_p1_ib_valid
);

localparam CONV = 1;
localparam MPOOL = 4;
localparam APOOL = 5;

reg  conv_valid, maxpool_valid, avepool_valid;
wire [`BURST_LEN-1:0] cmac_data_valid, avepool_data_valid, maxpool_data_valid, mult_ready_buf;
reg  cmac_data_ready, cmac_enable, avepool_data_ready, avepool_enable, maxpool_data_ready, maxpool_enable;
wire [`BURST_LEN-1:0] rdy_cmac, rdy_sacc, rdy_scmp;
reg  [`BURST_LEN-1:0] cmac_ready, sacc_ready, scmp_ready;

//Data BUF and Weight BUF of serializer
reg  [16*`BURST_LEN-1:0] dbuf; 	// serial buffer
reg  [16*`BURST_LEN-1:0] wbuf [8:0]; // serial buffer

reg  [16*`BURST_LEN-1:0] data; 	// parallel
wire [16*`BURST_LEN-1:0] weight; // parallel 3x3xBURST_LEN, wired out from weight_cache
wire [16*`BURST_LEN-1:0] tmp_sum;// paralle, wired out from cmac_sum
reg  [7:0]  dma_p2_burst_cnt, dma_p3_burst_cnt, dma_p3_offset; // de-serializer counter, burst get 16 data, then send to operation unit.
//Result registers of cmac/sacc/scmp
wire [16*`BURST_LEN-1:0] conv_result; // parallel
reg  [16*`BURST_LEN-1:0] cmac_result;
wire [16*`BURST_LEN-1:0] maxpool_result; // parallel
wire [16*`BURST_LEN-1:0] avepool_result; // parallel
reg  [16*`BURST_LEN-1:0] sacc_result;
reg  [16*`BURST_LEN-1:0] scmp_result;

reg div_en;
//pipeline registers
reg  [7:0]  atom_count;						//NOTES: atom count is used only in address parsing, it is not used in operation logic
reg  [7:0]  pipe_count;						//NOTES: counter for data reuse on one data
reg  [7:0]  pipe2_count;
reg  [15:0] line_count;						//NOTES: counter for one gemm line, range:(0, kernel * o_side)
reg  [7:0]  cache_count [2:0]; 				//FIXME: use max conv side support defined in include files.
reg  [7:0]  result_count;					//NOTES: counter for results in single cmac reuse
reg  [7:0]  sum_count [2:0];				//NOTES: counter for results in a kernel_size
reg  [16*`BURST_LEN-1:0] weight_cache [2:0];		//NOTES: memory for storing cmac reuse input weight // FIXME: use bram
reg  [16*`BURST_LEN-1:0] cmac_sum [2:0];	//NOTES: memory for storing cmac reuse output sum // FIXME: use bram

reg  [16*`BURST_LEN-1:0] psum;			//NOTES: registers for 16-channel sum output, it is selected from the memory cmac_sum

//Full sum registers
reg  [15:0] sum [127:0]; //max support 128 x 128 output side // FIXME: use bram
reg  [15:0] fsum_a;
reg  [15:0] fsum_b;
reg  [15:0] fsum_result;
reg  [7:0]  fsum_count;
reg  [7:0]  fsum_index;
reg         fsum_data_valid;
reg			fsum_enable;
reg			fsum_data_ready;
reg		    fsum_ready;

//GEMM registers
reg 		clear;
reg  [15:0] i_channel_count;
reg  [7:0]  gemm_count;
reg  [15:0] o_channel_count;
reg			layer_finish;

reg 		engine_ready;

//DMA enable signal
reg			dma_p0_writes_en, dma_p1_writes_en, dma_p2_reads_en, dma_p3_reads_en, dma_p4_reads_en, dma_p5_reads_en;
reg [29:0]  p0_addr, p1_addr, p2_addr, p3_addr, p4_addr, p5_addr;              //Output to DMA, burst start address. 
reg [29:0]  gemm_addr, data_addr_block, weight_addr_block, result_addr_block, data_addr_offset, weight_addr_offset, result_addr_offset;
reg [15:0]  dma_p0_ib_data, dma_p1_ib_data;
reg			dma_p0_ib_valid, dma_p1_ib_valid;

// NOTES: Generate accumulator for atom(1 * 1 * channel) and cube(k * k * channel), this data path is dedicated to convolution only.
// NOTES: deserializer for write back is only enabled in pooling

genvar i;
generate 
	for (i = 0; i < `BURST_LEN; i = i + 1) begin: gencmac
		cmac cmac_(.clk(clk), .rst(rst), .data(data[i*16 +: 16]), .weight(weight[i*16 +: 16]), .result(conv_result[i*16 +: 16]), .tmp_sum(tmp_sum[i*16 +: 16]), .mult_ready_buf(mult_ready_buf[i]), .conv_valid(conv_valid), .data_ready(cmac_data_ready), .data_valid(cmac_data_valid[i]), .conv_ready(rdy_cmac[i]));
	end 
endgenerate
always @(posedge clk) cmac_result <= conv_result;
always @(posedge clk) cmac_ready <= rdy_cmac;

wire operation_rfd_fsum, rdy_fsum;
wire [15:0] result_fsum;
accum fsum_ (.a(fsum_a), .b(fsum_b), .clk(clk), .operation_nd(fsum_data_ready), .operation_rfd(operation_rfd_fsum), .result(result_fsum), .rdy(rdy_fsum));

always @(posedge clk) fsum_data_valid <= operation_rfd_fsum;
always @(posedge clk) fsum_result <= result_fsum;
always @(posedge clk) fsum_ready <= rdy_fsum;

genvar k;
generate
	for (k = 0; k < `BURST_LEN; k = k + 1) begin: gensacc
		sacc sacc_(.clk(clk), .rst(rst), .data(data[k*16 +: 16]), .result(avepool_result[k*16 +: 16]), .tmp_sum(tmp_sum[k*16 +: 16]), .pool_valid(avepool_valid), .data_ready(avepool_data_ready), .data_valid(avepool_data_valid[k]), .div_en(div_en), .pool_ready(rdy_sacc[k]));
	end
endgenerate
always @(posedge clk) sacc_result <= avepool_result;
always @(posedge clk) sacc_ready <= rdy_sacc;

genvar l;
generate
	for (l = 0; l < `BURST_LEN; l = l + 1) begin: genscmp
		scmp scmp_(.clk(clk), .rst(rst), .data(data[l*16 +: 16]), .result(maxpool_result[l*16 +: 16]), .pool_valid(maxpool_valid), .data_ready(maxpool_data_ready), .data_valid(maxpool_data_valid[l]), .pool_ready(rdy_scmp[l]));
	end
endgenerate
always @(posedge clk) scmp_result <= maxpool_result;
always @(posedge clk) scmp_ready <= rdy_scmp;

//State Machine
localparam init 		= 4'b0000;
localparam gemm_idle 	= 4'b0001;
localparam gemm_busy 	= 4'b0010;
localparam gemm_clear 	= 4'b0011;
localparam sacc_idle 	= 4'b0100;
localparam sacc_busy 	= 4'b0101;
localparam sacc_clear 	= 4'b0110;
localparam scmp_idle 	= 4'b0111;
localparam scmp_busy 	= 4'b1000;
localparam scmp_clear 	= 4'b1001;
localparam finish 		= 4'b1010;

reg [3:0] curr_state;
reg [3:0] next_state;

//    Current State, non-blocking
always @ (posedge clk or posedge rst)    begin
    if (rst)
        curr_state    <= init;
    else
        curr_state    <= next_state;
end

//    Status Jump, blocking
always @ (*) begin
    next_state = init;    //    Initialize
    case (curr_state)
		init: begin
			if(engine_valid) begin
				case(op_type)
					1: next_state = gemm_idle;
					4: next_state = scmp_idle;
					5: next_state = sacc_idle;
				endcase
			end
			else next_state = init;
		end
        gemm_idle: begin
            next_state = gemm_busy;
        end
		gemm_busy: begin
			if(fsum_index == o_side) next_state = gemm_clear;
			else next_state = gemm_busy;
		end
		gemm_clear: begin
			next_state = gemm_idle;
		end
		
		scmp_idle: begin
			next_state = scmp_busy;
		end
		scmp_busy: begin
			next_state = scmp_busy;
		end
		scmp_clear: begin
			next_state = scmp_clear;
		end

		sacc_idle: begin
			next_state = sacc_busy;
		end
		sacc_busy: begin
			next_state = sacc_busy;
		end
		sacc_clear: begin
			next_state = sacc_idle;
		end

		finish: begin
		end
        default:
            next_state = init;
    endcase
end
//NOTES: MEC convolution: k * k kernel in BURST_LEN -> finish the line -> next channel group(channel += BURST_LEN) -> next_gemm
//		 Register level:       cmac_sum -> psum -> sum
//		 Counter level:		   atom_count -> line_count, cache_count -> result_count, sum_count -> fsum_index
//NOTES: Sum point is ready only after the all channel 3x3 kernel mac is complete
//TODO:  Padding Layer: dual channel write back address parsing
//NOTES: weight and tmp_sum is directly from the corresponding registers

assign weight = weight_cache[pipe_count];
assign tmp_sum = cmac_sum[pipe2_count];

integer a;
initial begin
	for (a=0; a<128; a=a+1) begin //FIXME: hardcode
		sum[a] <= 16'h0000;
	end
end

//    Output, non-blocking
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		conv_valid <= 0; avepool_valid <= 0; maxpool_valid <= 0; engine_ready <= 0;
		dma_p2_burst_cnt <= 16'h0000; dma_p3_burst_cnt <= 16'h0000; dma_p3_offset <= 8'h00;
		dma_p0_writes_en <= 0; dma_p1_writes_en <= 0;
		dma_p2_reads_en <= 0; dma_p3_reads_en <= 0; dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
		dma_p0_ib_data <= 16'h0000; dma_p1_ib_data <= 16'h0000;
		dma_p0_ib_valid <= 0; dma_p1_ib_valid <= 0;
		//==================== Channel operation registers ====================
		dbuf <= 'd0; data <= 'd0; psum <= 'd0;
		wbuf[0] <= 'd0; wbuf[1] <= 'd0; wbuf[2] <= 'd0; 
		wbuf[3] <= 'd0; wbuf[4] <= 'd0; wbuf[5] <= 'd0; 
		wbuf[6] <= 'd0; wbuf[7] <= 'd0; wbuf[8] <= 'd0; 
		//==================== Slot registers ====================
		cache_count[0] <= 8'h00; cache_count[1] <= 8'h00; cache_count[2] <= 8'h00;
		sum_count[0] <= 8'h00; sum_count[1] <= 8'h00; sum_count[2] <= 8'h00;
		cmac_sum[0] <= 'd0; cmac_sum[1] <= 'd0; cmac_sum[2] <= 'd0;
		weight_cache[0] <= 'd0; weight_cache[1] <= 'd0; weight_cache[2] <= 'd0;
		cmac_enable <= 0; cmac_data_ready <= 0; avepool_enable <= 0; avepool_data_ready <= 0; maxpool_enable <= 0; maxpool_data_ready <= 0; div_en <= 0; //FIXME: unite names
		atom_count <= 8'h00; pipe_count <= 8'h00; pipe2_count <= 8'h00; line_count <= 16'h0000; result_count <= 8'h00;
		fsum_enable <= 0; fsum_data_ready <= 0;
		fsum_a <= 16'h0000; fsum_b <= 16'h0000; fsum_count <= 8'h00; fsum_index <= 8'h00;
		clear <= 0; 
		//==================== Cross-channel registers ====================
		p0_addr <= 30'h0000_0000; p1_addr <= 30'h0000_0000; p2_addr <= 30'h0000_0000; 
		p3_addr <= 30'h0000_0000; p4_addr <= 30'h0000_0000; p5_addr <= 30'h0000_0000;
		gemm_addr <= 30'h0000_0000;
		data_addr_block <= 30'h0000_0000; weight_addr_block <= 30'h0000_0000; result_addr_block <= 30'h0000_0000;
		data_addr_offset <= 30'h0000_0000; weight_addr_offset <= 30'h0000_0000; result_addr_offset <= 30'h0000_0000;
		
		i_channel_count <= 16'h0000; gemm_count <= 8'h00; o_channel_count <= 16'h0000; layer_finish <= 0;
	end else begin
		case (curr_state)
			init: begin
				data_addr_block <= data_start_addr; weight_addr_block <= weight_start_addr; result_addr_block <= result_start_addr;
				gemm_addr <= data_start_addr;
			end
			//==================== Clear all registers except cross-channel registers ====================
			gemm_idle: begin 
				conv_valid <= 0; avepool_valid <= 0; maxpool_valid <= 0; engine_ready <= 0;
				dma_p2_burst_cnt <= 16'h0000; dma_p3_burst_cnt <= 16'h0000; dma_p3_offset <= 8'h00;
				dma_p0_writes_en <= 0; dma_p1_writes_en <= 0;
				dma_p2_reads_en <= 0; dma_p3_reads_en <= 0; dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
				dma_p0_ib_data <= 16'h0000; dma_p1_ib_data <= 16'h0000;
				dma_p0_ib_valid <= 0; dma_p1_ib_valid <= 0;
				//==================== Channel operation registers ====================
				dbuf <= 'd0; data <= 'd0; psum <= 'd0;
				wbuf[0] <= 'd0; wbuf[1] <= 'd0; wbuf[2] <= 'd0; 
				wbuf[3] <= 'd0; wbuf[4] <= 'd0; wbuf[5] <= 'd0; 
				wbuf[6] <= 'd0; wbuf[7] <= 'd0; wbuf[8] <= 'd0; 
				//==================== Slot registers ====================
				cache_count[0] <= 8'h00; cache_count[1] <= 8'h00; cache_count[2] <= 8'h00;
				sum_count[0] <= 8'h00; sum_count[1] <= 8'h00; sum_count[2] <= 8'h00;
				//cache_sel <= 3'b000;
				cmac_sum[0] <= 'd0; cmac_sum[1] <= 'd0; cmac_sum[2] <= 'd0;
				weight_cache[0] <= 'd0; weight_cache[1] <= 'd0; weight_cache[2] <= 'd0;
				cmac_enable <= 0; cmac_data_ready <= 0; avepool_enable <= 0; avepool_data_ready <= 0; maxpool_enable <= 0; maxpool_data_ready <= 0; div_en <= 0; //FIXME: unite names
				atom_count <= 8'h00; pipe_count <= 8'h00; pipe2_count <= 8'h00; line_count <= 16'h0000; result_count <= 8'h00;
				fsum_enable <= 0; fsum_data_ready <= 0;
				fsum_a <= 16'h0000; fsum_b <= 16'h0000; fsum_count <= 8'h00; fsum_index <= 8'h00;
				clear <= 0; 
			end
			//==================== CONVOLUTION: Process a line ====================
			gemm_busy: begin
				p2_addr <= data_addr_block + data_addr_offset; p3_addr <= weight_addr_block + weight_addr_offset;//NOTES: Update start addr @ the same edge of reads_en
				p0_addr <= result_addr_block + result_addr_offset;
				dma_p2_reads_en <= 1; dma_p3_reads_en <= 1;

				//==================== PIPELINE STEP1: enable data read and weight read (this part is the slowest and defines the available timing space of the pipeline)
				if(dma_p2_ob_we) begin
					dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
					if(dma_p2_burst_cnt + 1 == `BURST_LEN) begin	//NOTES: start cmac when finishing reading the first atom (1x1xpara)
						dma_p2_burst_cnt <= 0;
						conv_valid <= 1;
						cmac_enable <= 1;	//NOTES: use this signal to latch buffer
					end
					dbuf <= {dma_p2_ob_data, dbuf[16*`BURST_LEN-1 : 16]}; // deserialize data to dbuf
					data_addr_offset <= data_addr_offset + 1;
					if(data_addr_offset + 1 == `BURST_LEN) begin
						data_addr_offset <= 0;
						data_addr_block <= data_addr_block + `BURST_LEN;
						if(atom_count + 1 == kernel) begin //jump to the next row
							data_addr_block <= data_addr_block + {(i_side - kernel), 4'b0000}; //(i_side - kernel) * BURST_LEN;
						end
					end
				end
				if(dma_p3_ob_we) begin // @ this edge dma_p3_ob_data is also updated.
					if(dma_p3_burst_cnt + 1 == `BURST_LEN) begin
						dma_p3_burst_cnt <= 0;
						dma_p3_offset <= dma_p3_offset + 1;
					end else dma_p3_burst_cnt <= dma_p3_burst_cnt + 1;
					wbuf[dma_p3_offset] <= {dma_p3_ob_data, wbuf[dma_p3_offset][16*`BURST_LEN-1 : 16]};
					weight_addr_offset <= weight_addr_offset + 1;
					if(weight_addr_offset + 1 == `BURST_LEN) begin //do not need to jump, weights are continuous
						weight_addr_offset <= 0;
						weight_addr_block <= weight_addr_block + `BURST_LEN;
					end
				end
				if(dma_p3_offset == kernel_size) begin
					dma_p3_reads_en <= 0; // force sync reset to generate a 1-cycle pulse
				end

				//==================== PIPELINE STEP1.5: Generate data ready signal for cmac
				if(cmac_data_ready) begin
					pipe_count <= pipe_count + 1;
				end
				if(pipe_count == kernel - stride) begin //cmac_data_ready width is max of pipe_count
					pipe_count <= 0;
					cmac_data_ready <= 0;
				end

				if(mult_ready_buf == {`BURST_LEN{1'b1}}) begin
					pipe2_count <= pipe2_count + 1;
				end
				if(pipe2_count == kernel - stride) begin
					pipe2_count <= 0;
				end
				
				//==================== PIPELINE STEP2: start passing deserialized data and weight to cmac/sacc/scmp (including weight reuse)
				if(cmac_enable) begin
					cmac_data_ready <= 1;
					cmac_enable <= 0;
					data <= dbuf;
					
					atom_count <= atom_count + 1;
					line_count <= line_count + 1;
					if(atom_count + 1 == kernel) begin
						atom_count <= 0;
					end
					//==================== Logic for setting cache_count according to line_count
					if(line_count >= 0 && (kernel - stride) >= 7'd0) begin // stride2 * a
						cache_count[0] <= cache_count[0] + 1;
						if(cache_count[0] < kernel_size) weight_cache[0] <= wbuf[cache_count[0]];
					end 
					if(cache_count[0] + 1 == kernel_size + stride2 - kernel) begin
						cache_count[0] <= 0;
					end
					if(line_count >= stride2 && (kernel - stride) >= 7'd1) begin
						cache_count[1] <= cache_count[1] + 1;
						if(cache_count[1] < kernel_size) weight_cache[1] <= wbuf[cache_count[1]];
					end 
					if(cache_count[1] + 1 == kernel_size + stride2 - kernel) begin
						cache_count[1] <= 0;
					end
					if(line_count >= stride2 + stride2 && (kernel - stride) >= 7'd2) begin
						cache_count[2] <= cache_count[2] + 1;
						if(cache_count[2] < kernel_size) weight_cache[2] <= wbuf[cache_count[2]];
					end
					if(cache_count[2] + 1 == kernel_size + stride2 - kernel) begin
						cache_count[2] <= 0;
					end
				end
			end
			//==================== Update cross-channel counters and address
			gemm_clear: begin
				i_channel_count <= i_channel_count + `BURST_LEN; // within channel operation the address is not updated
				if(i_channel_count + `BURST_LEN >= i_channel) begin
					i_channel_count <= 0;
					gemm_count <= gemm_count + 1; //NOTES: a gemm is finished
					//updating gemm addr only after finishing the whole line + channel and data addr_block
					gemm_addr <= gemm_addr + {stride[3:0], 4'b0000}; //NOTES: gemm addr parsing. kernel > stride >= 1
					data_addr_block <= gemm_addr + {stride[3:0], 4'b0000};
					if(gemm_count + 1 == o_side) begin
						gemm_count <= 0;
						o_channel_count <= o_channel_count + 1; //NOTES: start the next weight group
						if(o_channel_count + 1 == o_channel) begin
							layer_finish <= 1;
						end
					end
				end
			end

			scmp_idle: begin
			end
			//==================== MAXPOOLING: Process a line ====================
			scmp_busy: begin
				p2_addr <= data_addr_block + data_addr_offset; //NOTES: Update start addr @ the same edge of reads_en
				p0_addr <= result_addr_block + result_addr_offset;
				dma_p2_reads_en <= 1;

				//==================== PIPELINE STEP1: enable data read (this part is the slowest and defines the available timing space of the pipeline)
				if(dma_p2_ob_we) begin
					dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
					if(dma_p2_burst_cnt + 1 == `BURST_LEN) begin	//NOTES: start cmac when finishing reading the first atom (1x1xpara)
						dma_p2_burst_cnt <= 0;
						maxpool_valid <= 1;
					end
					dbuf <= {dma_p2_ob_data, dbuf[16*`BURST_LEN-1 : 16]}; // deserialize data to dbuf
					data_addr_offset <= data_addr_offset + 1;
					if(data_addr_offset + 1 == `BURST_LEN) begin
						data_addr_offset <= 0;
						data_addr_block <= data_addr_block + `BURST_LEN;
						if(atom_count + 1 == kernel) begin //jump to the next row
							data_addr_block <= data_addr_block + {(i_side - kernel), 4'b0000}; //(i_side - kernel) * BURST_LEN;
						end
					end
				end

			end
			scmp_clear: begin
			end

			sacc_idle: begin
			end
			//==================== AVEPOOLING: Process a line * surface ====================
			sacc_busy: begin
				p2_addr <= data_addr_block + data_addr_offset; //NOTES: Update start addr @ the same edge of reads_en
				p0_addr <= result_addr_block + result_addr_offset;
				dma_p2_reads_en <= 1;

				//==================== PIPELINE STEP1: enable data read (this part is the slowest and defines the available timing space of the pipeline)
				if(dma_p2_ob_we) begin
					dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
					if(dma_p2_burst_cnt + 1 == `BURST_LEN) begin	//NOTES: start cmac when finishing reading the first atom (1x1xpara)
						dma_p2_burst_cnt <= 0;
						avepool_valid <= 1;
						avepool_enable <= 1;
					end
					dbuf <= {dma_p2_ob_data, dbuf[16*`BURST_LEN-1 : 16]}; // deserialize data to dbuf
					data_addr_offset <= data_addr_offset + 1;
					if(data_addr_offset + 1 == `BURST_LEN) begin
						data_addr_offset <= 0;
						data_addr_block <= data_addr_block + `BURST_LEN;
						if(atom_count + 1 == kernel) begin //jump to the next row
							data_addr_block <= data_addr_block + {(i_side - kernel), 4'b0000}; //(i_side - kernel) * BURST_LEN;
						end
					end
				end

				if(avepool_enable) begin
					avepool_enable <= 0;
					avepool_data_ready <= 1;
					data <= dbuf;
					atom_count <= atom_count + 1;
					line_count <= line_count + 1;
				end
				if(avepool_data_ready) begin
					avepool_data_ready <= 0;
				end

			end
			sacc_clear: begin
			end

			finish: begin
				layer_finish <= 0;
				engine_ready <= 1;
			end
			default:;
		endcase

		//==================== PIPELINE STEP3: Partial SUM of channel outputs, independent of the pipeline
		if(cmac_ready == {`BURST_LEN{1'b1}}) begin
			result_count <= result_count + 1;
			cmac_sum[result_count] <= cmac_result;
		end
		if(result_count == kernel - stride) begin
			result_count <= 0;
			sum_count[0] <= cache_count[0];
			sum_count[1] <= cache_count[1];
			sum_count[2] <= cache_count[2];
			//Logic for setting sum_count according to cache_count
			if(sum_count[0] + 1 == kernel_size) begin
				psum <= cmac_sum[0];
				fsum_enable <= 1; //Trigger for channel partial sum
				fsum_count <= 0;
			end
			if(sum_count[1] + 1 == kernel_size) begin
				psum <= cmac_sum[1];
				fsum_enable <= 1; //Trigger for channel partial sum
				fsum_count <= 0;
			end
			if(sum_count[2] + 1 == kernel_size) begin
				psum <= cmac_sum[2];
				fsum_enable <= 1; //Trigger for channel partial sum
				fsum_count <= 0;
			end
		end 
		// ==================== PIPELINE STEP4: full channel sum stored in -> sum, sum all channels, TODO: bias operation, independent of the pipeline
		if(fsum_data_valid) begin
			fsum_data_ready <= fsum_enable;
		end
		if(fsum_enable) begin
			fsum_enable <= 0;
			if(fsum_count == 0) fsum_a <= sum[fsum_index]; //NOTES: initially 0, accumulated sum is called after the first channel group
			else fsum_a <= fsum_result;
			fsum_b <= psum[15:0];
			psum <= {16'h0000, psum[16*`BURST_LEN-1:16]};
			if(fsum_count < `BURST_LEN) fsum_count <= fsum_count + 1;
		end
		if(fsum_ready) begin
			if(fsum_count < `BURST_LEN) fsum_enable <= 1;
			if(fsum_count == `BURST_LEN) begin
				fsum_index <= fsum_index + 1; //pipeline index sampling (delay align)
				sum[fsum_index] <= fsum_result; //NOTES: it will overwrite the fsum_result in the first c-1 channel groups
				dma_p0_ib_data <= fsum_result;
			end
			if(i_channel_count + `BURST_LEN >= i_channel && fsum_count == `BURST_LEN) begin
				dma_p0_writes_en <= 1;
			end
		end

		//==================== Write back logic independent of the pipeline
		if(fsum_index + 1 == o_side && fsum_ready && fsum_count == 0) begin
			clear <= 1;
		end
		if(dma_p0_ib_re) begin
			dma_p0_writes_en <= 0;
			dma_p0_ib_valid <= 1;
		end else begin
			dma_p0_ib_valid <= 0;
		end
		if(dma_p0_ib_valid) begin //Update start addr @ after updating data
			result_addr_offset <= result_addr_offset + {o_side, 3'b000}; //p0_addr will be updated after one cycle //FIXME: add result_addr_surface
			if(fsum_index == 0) begin // start a new gemm
				result_addr_block <= result_addr_block + `BURST_LEN;
				result_addr_offset <= 0;
			end
		end

	end
end
endmodule
