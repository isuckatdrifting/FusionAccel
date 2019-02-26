module engine #(  //Instantiate 16CMACs for conv3x3, 16CMACs for conv1x1, maxpool and avepool in engine.
	parameter BURST_LEN = 16
)
(
	input 			clk,
//Control signals csb->engine
	input 			rst,
	input 			engine_valid,
	input [2:0] 	op_type,
	input			padding,
	input [7:0]		kernel,
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

reg  conv_rst, psum_rst, maxpool_rst, avepool_rst;
reg  conv_valid, maxpool_valid, avepool_valid;
wire [BURST_LEN-1:0] cmac_data_valid, avepool_data_valid, maxpool_data_valid, psum_data_valid;
reg  cmac_data_ready, avepool_data_ready, maxpool_data_ready, psum_data_ready;
wire [BURST_LEN-1:0] cmac_ready, psum_ready;
wire maxpool_ready, avepool_ready;

//Data BUF and Weight BUF of serializer
reg  [15:0] dbuf [0:BURST_LEN-1]; // serial
reg  [15:0] wbuf [0:BURST_LEN-1]; // serial

reg  [15:0] data [0:BURST_LEN-1]; // parallel
reg  [15:0] weight [0:BURST_LEN-1]; // parallel
reg  [7:0]  dma_p2_burst_cnt, dma_p3_burst_cnt; // de-serializer counter, burst cache 16 data, then send to operation unit.

//Ping-pong registers
reg  [15:0] cache [0:2][0:BURST_LEN-1];
reg  [7:0]  atom_count;
reg  [7:0]  cache_sel;
reg         cache_update;

//Line partial sum registers
wire [15:0] psum_result [0:BURST_LEN-1]; // parallel
reg  [15:0] psum_a [0:BURST_LEN-1]; // parallel
reg  [15:0] psum_b [0:BURST_LEN-1]; // parallel
reg  [7:0]  psum_index;
reg  [7:0]  psum_count;
reg			fsum_enable;

//Full sum registers
reg			psum_update;
reg			fsum_rst;
reg  [15:0] sum [0:127]; //max support 128 x 128 output side
reg  [15:0] fsum_a;
reg  [15:0] fsum_b;
wire [15:0] fsum_result;
reg  [7:0]  fsum_count;
wire        fsum_data_valid;
reg			fsum_data_ready;
wire		fsum_ready;

//GEMM registers
reg  [15:0] i_channel_count;
reg  [7:0]  gemm_count;
reg  [15:0] o_channel_count;
reg			layer_finish;

//Writeback BUF
reg			writeback_en;
wire [15:0] conv_result [0:BURST_LEN-1]; // parallel
wire [15:0] maxpool_result [0:BURST_LEN-1]; // parallel
wire [15:0] avepool_result [0:BURST_LEN-1]; // parallel

reg 		engine_ready;

//DMA enable signal
reg			dma_p0_writes_en, dma_p1_writes_en, dma_p2_reads_en, dma_p3_reads_en, dma_p4_reads_en, dma_p5_reads_en;
reg [29:0]  p0_addr, p1_addr, p2_addr, p3_addr, p4_addr, p5_addr;              //Output to DMA, burst start address. 
reg [29:0]  gemm_addr, data_addr_block, weight_addr_block, data_addr_offset, weight_addr_offset;
reg [15:0]  dma_p0_ib_data, dma_p1_ib_data;
reg			dma_p0_ib_valid, dma_p1_ib_valid;

wire [15:0]  para;
assign para = i_channel > 16? 16: i_channel;
// NOTES: Generate accumulator for atom(1 * 1 * channel) and cube(k * k * channel), this data path is dedicated to convolution only.
// NOTES: deserializer for write back is only enabled in pooling

genvar i;
generate 
	for (i = 0; i < BURST_LEN; i = i + 1) begin: gencmac
		cmac cmac_(.clk(clk), .rst(rst), .rst_acc(conv_rst), .data(data[i]), .weight(weight[i]), .result(conv_result[i]), .conv_valid(conv_valid), .data_ready(cmac_data_ready), .data_valid(cmac_data_valid[i]), .conv_ready(cmac_ready[i]));
	end 
endgenerate

genvar j;
generate 
	for (j = 0; j < BURST_LEN; j = j + 1) begin: genpsum
		accum psum_ (.a(psum_a[j]), .b(psum_b[j]), .operation_nd(psum_data_ready), .operation_rfd(psum_data_valid[j]), .result(psum_result[j]), .rdy(psum_ready[j]));
	end 
endgenerate

accum fsum_ (.a(fsum_a), .b(fsum_b), .operation_nd(fsum_data_ready), .operation_rfd(fsum_data_valid), .result(fsum_result), .rdy(fsum_ready));

genvar k;
generate
	for (k = 0; k < BURST_LEN; k = k + 1) begin: gensacc
		sacc sacc_(.clk(clk), .rst(avepool_rst), .data(data[k]), .result(avepool_result[k]), .pool_valid(avepool_valid),  .data_ready(avepool_data_ready), .data_valid(avepool_data_valid[k]), .pool_ready(avepool_ready));
	end
endgenerate

genvar l;
generate
	for (l = 0; l < BURST_LEN; l = l + 1) begin: gensacmp
		scmp scmp_(.clk(clk), .rst(maxpool_rst), .data(data[l]), .result(maxpool_result[l]), .pool_valid(maxpool_valid), .data_ready(maxpool_data_ready), .data_valid(maxpool_data_valid[l]), .pool_ready(maxpool_ready));
	end
endgenerate

//State Machine
localparam idle = 4'b0000;
localparam gemm_busy = 4'b0001;
localparam gemm_clear = 4'b0010;
localparam finish = 4'b0011;

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
            if(engine_valid) next_state = gemm_busy;
            else next_state = idle;
        end
		gemm_busy: begin
			if(engine_ready) next_state = finish;
			else next_state = gemm_busy;
		end
		gemm_clear: begin
			next_state = gemm_busy;
		end
		finish: begin
		end
        default:
            next_state = idle;
    endcase
end
//    Output, non-blocking
//NOTES: Use MEC convolution: 3x3 kernel in PARA -> channel += PARA -> next_line, cache -> next_gemm
//NOTES: ping-pong line cache, pipeline weight-mac
//NOTES: Sum point is ready only after the all channel 3x3 kernel mac is complete
//TODO: Padding Layer: dual channel write back address parsing
integer a;
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		dma_p2_burst_cnt <= 0; dma_p3_burst_cnt <= 0;
		conv_valid <= 0; avepool_valid <= 0; maxpool_valid <= 0; engine_ready <= 0;
		dma_p0_writes_en <= 0; dma_p1_writes_en <= 0;
		dma_p2_reads_en <= 0; dma_p3_reads_en <= 0;
        dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
		p0_addr <= 30'h0000_0000; p1_addr <= 30'h0000_0000; p2_addr <= 30'h0000_0000; 
		p3_addr <= 30'h0000_0000; p4_addr <= 30'h0000_0000; p5_addr <= 30'h0000_0000;
		gemm_addr <= 30'h0000_0000;
		data_addr_block <= 30'h0000_0000; weight_addr_block <= 30'h0000_0000;
		data_addr_offset <= 30'h0000_0000; weight_addr_offset <= 30'h0000_0000;
		for(a=0;a<BURST_LEN;a=a+1) begin
			data[a] <= 16'h0000; weight[a] <= 16'h0000;
			dbuf[a] <= 16'h0000; wbuf[a] <= 16'h0000;
			cache[0][a] <= 0; cache[1][a] <= 0; cache[2][a] <= 0;
			psum_a[a] <= 16'h0000; psum_b[a] <= 16'h0000;
		end
		dma_p0_ib_data <= 16'h0000; dma_p1_ib_data <= 16'h0000;
		dma_p0_ib_valid <= 0; dma_p1_ib_valid <= 0;
		conv_rst <= 1; psum_rst <= 1; maxpool_rst <= 1; avepool_rst <= 1;
		cmac_data_ready <= 0; psum_data_ready <= 0;
		i_channel_count <= 0; o_channel_count <= 0; psum_count <= 0; cache_sel <= 0; atom_count <= 0;
		for(a=0;a<128;a=a+1)begin
			sum[a] <= 16'h0000;
		end
		fsum_rst <= 0;
		fsum_enable <= 0; psum_index <= 8'hff;
		cache_update <= 0; psum_update <= 0;
		fsum_data_ready <= 0; fsum_count <= 0;
		fsum_a <= 16'h0000; fsum_b <= 16'h0000;
		gemm_count <= 0; layer_finish <= 0;
		writeback_en <= 0;
	end else begin
		case (curr_state)
			idle: begin
				conv_rst <= 1; psum_rst <= 1; maxpool_rst <= 1; avepool_rst <= 1;
				data_addr_block <= data_start_addr; weight_addr_block <= weight_start_addr;
			end
			gemm_busy: begin // de-serialize cache dma output to buffer
				case (op_type) 
					CONV: begin
						p2_addr <= data_addr_block + data_addr_offset; p3_addr <= weight_addr_block + weight_addr_offset;//TODO: Update start addr @ the same edge of reads_en
						// PIPELINE STEP1: enable data read and weight read, (this part is the slowest and defines the pipeline available timing space)
						if(dma_p2_burst_cnt == 0) dma_p2_reads_en <= 1;
						if(dma_p3_burst_cnt == 0) dma_p3_reads_en <= 1;
						if(dma_p2_burst_cnt == para) dma_p2_reads_en <= 0;	
						if(dma_p3_burst_cnt == para) dma_p3_reads_en <= 0;		
						if(dma_p2_ob_we) begin
							dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
							dbuf[dma_p2_burst_cnt] <= dma_p2_ob_data; // deserialize data to dbuf
							data_addr_offset <= data_addr_offset + 1;
							if(data_addr_offset + 1 == para) begin
								data_addr_offset <= 0;
								data_addr_block <= data_addr_block + para;
								if(atom_count + 1 == kernel) begin
									//jump to the next row
									data_addr_block <= data_addr_block + (i_side - kernel) * para;

								end
							end
						end
						if(dma_p3_ob_we) begin // @ this edge dma_p3_ob_data is also updated.
							dma_p3_burst_cnt <= dma_p3_burst_cnt + 1;
							wbuf[dma_p3_burst_cnt] <= dma_p3_ob_data; // deserialize weight to wbuf
							weight_addr_offset <= weight_addr_offset + 1;
						end
						if(dma_p2_burst_cnt == 0) begin
							cmac_data_ready <= 0;
						end
						//PIPELINE STEP2: one point channel operation, channel stride = para
						if(dma_p2_burst_cnt == para) begin
							conv_valid <= 1;
							if(&cmac_data_valid) begin
								for(a=0;a<BURST_LEN;a=a+1) begin
									data[a] <= dbuf[a]; weight[a] <= wbuf[a]; //Load data/weight to cmac/sacc/scmp
								end
								cmac_data_ready <= 1;
							end
							dma_p2_burst_cnt <= 0; dma_p3_burst_cnt <= 0;
							dma_p2_reads_en <= 0; dma_p3_reads_en <= 0; dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
							atom_count <= atom_count + 1;
							if(atom_count == kernel) begin
								atom_count <= 1;
								conv_rst <= 1;
								case(cache_sel)
									0: cache_sel <= 1;
									1: cache_sel <= 2;
									2: cache_sel <= 0;
									default:;
								endcase
							end
						end
						if(&cmac_ready) begin
							conv_rst <= 0;
						end
						//PIPELINE STEP3: cache sum of atoms, partial sum of caches --> surface conv temp sum
						psum_data_ready <= cache_update;
						if(atom_count == kernel) begin
							//update ping-pong cache and selector
							if(&cmac_ready) begin
								for(a=0;a<BURST_LEN;a=a+1) begin
									cache[cache_sel][a] <= conv_result[a];
								end
								cache_update <= 1;
								psum_rst <= 1;
							end
							//cache sum, TODO: sum is enabled less frequently for stride > 1; TODO: clear cache after finishing each channel group in a gemm					
							if(cache_update) begin
								if(psum_count + 1 == para) begin
									psum_count <= 0;
									cache_update <= 0;
									if(fsum_enable) begin
										psum_index <= psum_index + 1;
										if(psum_index + 1 == o_side) begin 
											psum_index <= 0; // this means starting a new channel group/gemm
											i_channel_count <= i_channel_count + para; // FIXME: next-channel increment after done sum
											if(i_channel_count + para >= i_channel) begin
												i_channel_count <= 0;
												gemm_count <= gemm_count + 1;
											end
											if(gemm_count == o_side && i_channel_count + para >= i_channel) begin
												o_channel_count <= o_channel_count + 1;
											end
										end
									end
								end
								else psum_count <= psum_count + 1;
								for(a=0;a<BURST_LEN;a=a+1) begin
									psum_a[a] <= psum_result[a];
									psum_b[a] <= cache[psum_count][a];
								end
								if(psum_count==0) psum_rst <= 0;
							end
							if(psum_rst) begin
								for(a=0;a<BURST_LEN;a=a+1) begin //NOTES: clear partial sum
									psum_a[a] <= 16'h0000;
								end
							end
							if(cache_sel + 1 == para) begin
								fsum_enable <= 1;
							end
						end
						//PIPELINE STEP4: full channel sum stored in -> sum, sum all channels and write back, TODO: bias operation
						fsum_data_ready <= psum_update;
						if(fsum_enable) begin
							if(psum_count + 1 == para) begin
								psum_update <= 1;
							end
							if(psum_update) begin
								if(fsum_count == 0) begin
									fsum_a <= sum[psum_index];
								end else begin
									fsum_a <= fsum_result;
								end
								fsum_count <= fsum_count + 1;
								fsum_b <= psum_result[fsum_count];
							end
							if(fsum_count + 1 == para) begin
								psum_update <= 0;
								fsum_count <= 0;
							end
							if(fsum_data_ready && fsum_count == 0) begin
								sum[psum_index] <= fsum_result;
								if(gemm_count == o_side && i_channel_count + para >= i_channel) begin
									gemm_count <= 0;
								end
								if(i_channel_count + para >= i_channel) begin //FIXME: writeback o_side outputs
									writeback_en <= 1;
								end
							end
							if(writeback_en) begin
								dma_p0_writes_en <= 1; // TODO: Update start addr @ the same edge of writes_en
								if(dma_p0_ib_re) begin
									dma_p0_ib_data <= sum[psum_index];
									dma_p0_ib_valid <= 1;
									if(psum_index + para == o_side && o_channel_count + 1 == o_channel) begin
										layer_finish <= 1;
									end
								end else begin
									dma_p0_ib_valid <= 0;
								end
							end
						end
						//PIPELINE STEP5: Go to the next gemm, gemm clear
						//PIPELINE STEP6: TODO: jump to next weight group
					end
				endcase
			end
			gemm_clear: begin
				//updating gemm addr and data addr_block, TODO: stride = 2
				gemm_addr <= gemm_addr + para;
				data_addr_block <= gemm_addr + para;
			end
			finish: begin
				layer_finish <= 0;
				engine_ready <= 1;
				dma_p0_writes_en <= 0; dma_p1_writes_en <= 0;
			end
			default:;
		endcase
	end
end
endmodule
