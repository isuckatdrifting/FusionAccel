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
	input [3:0]		stride,		//TODO: valid check: stride < padding
	input [7:0]		kernel,
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

reg  conv_rst, maxpool_rst, avepool_rst;
reg  conv_valid, maxpool_valid, avepool_valid;
wire [BURST_LEN-1:0] cmac_data_valid, avepool_data_valid, maxpool_data_valid;
reg  cmac_data_ready, cmac_enable, avepool_data_ready, maxpool_data_ready;
wire [BURST_LEN-1:0] cmac_ready;
wire maxpool_ready, avepool_ready;

//Data BUF and Weight BUF of serializer
reg  [15:0] dbuf [0:BURST_LEN-1]; 	// serial buffer
reg  [15:0] wbuf [0:BURST_LEN*9-1]; // serial buffer

reg  [15:0] data [0:BURST_LEN-1]; 	// parallel
wire [15:0] weight [0:BURST_LEN-1]; // parallel 3x3xBURST_LEN, wired out from cache
wire [15:0] tmp_sum [0:BURST_LEN-1];// paralle, wired out from cache_sum
reg  [7:0]  dma_p2_burst_cnt, dma_p3_burst_cnt, dma_p3_offset; // de-serializer counter, burst cache 16 data, then send to operation unit.
//Result registers of cmac/sacc/scmp
wire [15:0] conv_result [0:BURST_LEN-1]; // parallel
wire [15:0] maxpool_result [0:BURST_LEN-1]; // parallel
wire [15:0] avepool_result [0:BURST_LEN-1]; // parallel

//pipeline registers
reg  [7:0]  atom_count;						//Notes: atom count is used only in address parsing, it is not used in operation logic
reg  [7:0]  elec_count;						//FIXME: change this name
reg  [15:0] line_count;						//NOTES: counter for one gemm line, range:(0, kernel * o_side)
reg  [7:0]  cache_count [0:2]; 				//FIXME: use max conv side support defined in include files.
reg  [7:0]  idle_count [0:2]; 				//NOTES: counter for stride 
reg  [7:0]  result_count;					//NOTES: counter for results in single cmac reuse
reg  [7:0]  sum_count [0:2];				//NOTES: counter for results in a kernel_size
reg  [7:0]  sum_index;						//NOTES: counter for the nth kernel sum to psum
reg  [15:0] cache [0:2][0:BURST_LEN-1];		//NOTES: memory for cache cmac reuse input weight
reg  [15:0] cache_sum [0:2][0:BURST_LEN-1];	//NOTES: memory for cache cmac reuse input tmp_sum
reg  [15:0] cmac_sum [0:2][0:BURST_LEN-1];	//NOTES: memory for cache cmac reuse output sum
reg  [2:0]  cache_sel;

reg  [15:0] psum [0:BURST_LEN-1];			//NOTES: registers for 16-channel sum output, it is selected from the memory cmac_sum

//Full sum registers
reg  [15:0] sum [0:127]; //max support 128 x 128 output side
reg  [2:0]  sum_id;
reg  [15:0] fsum_a;
reg  [15:0] fsum_b;
wire [15:0] fsum_result;
reg  [15:0] fsum_count;
reg  [7:0]  fsum_index;
wire        fsum_data_valid;
reg			fsum_enable;
reg			fsum_data_ready;
wire		fsum_ready;

//GEMM registers
reg  [15:0] i_channel_count;
reg  [7:0]  gemm_count;
reg  [15:0] o_channel_count;
reg			layer_finish;

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
		cmac cmac_(.clk(clk), .rst(rst), .data(data[i]), .weight(weight[i]), .result(conv_result[i]), .tmp_sum(tmp_sum[i]), .conv_valid(conv_valid), .data_ready(cmac_data_ready), .data_valid(cmac_data_valid[i]), .conv_ready(cmac_ready[i]));
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
		finish: begin
		end
        default:
            next_state = idle;
    endcase
end
//    Output, non-blocking
//NOTES: Use MEC convolution: 3x3 kernel in PARA -> channel += PARA -> next_line, cache -> next_gemm
//NOTES: pipeline weight-mac and sum
//NOTES: Sum point is ready only after the all channel 3x3 kernel mac is complete
//TODO: Padding Layer: dual channel write back address parsing

//NOTES: weight and tmp_sum is directly from the registers
genvar m;
generate
	for(m=0;m<BURST_LEN;m=m+1) begin: weight_to_cmac
		assign weight[m] = cache[elec_count][m];
		assign tmp_sum[m] = cache_sum[elec_count][m];
	end
endgenerate

integer a,b;
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		dma_p2_burst_cnt <= 0; dma_p3_burst_cnt <= 0; dma_p3_offset <= 0;
		conv_valid <= 0; avepool_valid <= 0; maxpool_valid <= 0; engine_ready <= 0;
		dma_p0_writes_en <= 0; dma_p1_writes_en <= 0;
		dma_p2_reads_en <= 0; dma_p3_reads_en <= 0;
        dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
		p0_addr <= 30'h0000_0000; p1_addr <= 30'h0000_0000; p2_addr <= 30'h0000_0000; 
		p3_addr <= 30'h0000_0000; p4_addr <= 30'h0000_0000; p5_addr <= 30'h0000_0000;
		gemm_addr <= 30'h0000_0000;
		data_addr_block <= 30'h0000_0000; weight_addr_block <= 30'h0000_0000;
		data_addr_offset <= 30'h0000_0000; weight_addr_offset <= 30'h0000_0000;
		dma_p0_ib_data <= 16'h0000; dma_p1_ib_data <= 16'h0000;
		dma_p0_ib_valid <= 0; dma_p1_ib_valid <= 0;
		maxpool_rst <= 1; avepool_rst <= 1;
		for(a=0;a<BURST_LEN;a=a+1) begin
			dbuf[a] <= 16'h0000; 
			data[a] <= 16'h0000;
			cache[0][a] <= 0; cache[1][a] <= 0; cache[2][a] <= 0;
			cache_sum[0][a] <= 0; cache_sum[1][a] <= 0; cache_sum[2][a] <= 0;
			cmac_sum[0][a] <= 0; cmac_sum[1][a] <= 0; cmac_sum[2][a] <= 0;
			psum[a] <= 16'h0000;
		end
		for(a=0;a<BURST_LEN*9;a=a+1) begin
			wbuf[a] <= 16'h0000;
		end
		for(a=0;a<3;a=a+1) begin
			cache_count[a] <= 8'h00;
			idle_count[a] <= 8'h00;
			sum_count[a] <= 8'h00;
		end
		for(a=0;a<128;a=a+1)begin //FIXME: hardcode
			sum[a] <= 16'h0000;
		end
		cmac_data_ready <= 0; cmac_enable <= 0;
		i_channel_count <= 0; o_channel_count <= 0; cache_sel <= 3'b000; elec_count <= 0; atom_count <= 0; line_count <= 0; result_count <= 0;
		sum_index <= 0;
		
		fsum_data_ready <= 0;
		fsum_a <= 16'h0000; fsum_b <= 16'h0000; fsum_count <= 8'h00; fsum_enable <= 0; fsum_index <= 0;
		sum_id <= 0;
		gemm_count <= 0; layer_finish <= 0;
	end else begin
		case (curr_state)
			idle: begin
				maxpool_rst <= 1; avepool_rst <= 1;
				data_addr_block <= data_start_addr; weight_addr_block <= weight_start_addr;
			end
			gemm_busy: begin // de-serialize cache dma output to buffer
				case (op_type) 
					CONV: begin
						p2_addr <= data_addr_block + data_addr_offset; p3_addr <= weight_addr_block + weight_addr_offset;//TODO: Update start addr @ the same edge of reads_en
						if(dma_p2_burst_cnt == 0) dma_p2_reads_en <= 1;
						if(dma_p3_burst_cnt == 0) dma_p3_reads_en <= 1;

						//***PIPELINE STEP1: enable data read and weight read (this part is the slowest and defines the pipeline available timing space)
						if(dma_p2_ob_we) begin
							dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
							if(dma_p2_burst_cnt + 1 == para) begin	//NOTES: start cmac when finishing reading the first atom (1x1xpara)
								dma_p2_burst_cnt <= 0;
								conv_valid <= 1;
								if(&cmac_data_valid) begin
									cmac_enable <= 1;	//NOTES: use this signal to latch buffer
									for(a=0;a<3;a=a+1) 
										if (line_count + 1 > kernel * stride * a && cache_count[a] == 0 && idle_count[a] == 0 && (kernel - stride) >= a) begin
											cache_sel[a] <= 1; //FIXME: disable cache_sel at the end of a line
											sum_id <= a;
										end
								end
							end
							dbuf[dma_p2_burst_cnt] <= dma_p2_ob_data; // deserialize data to dbuf
							data_addr_offset <= data_addr_offset + 1;
							if(data_addr_offset + 1 == para) begin
								data_addr_offset <= 0;
								data_addr_block <= data_addr_block + para;
								if(atom_count + 1 == kernel) begin
									//jump to the next row
									//data_addr_block <= data_addr_block + (i_side - kernel) * para;
								end
							end
						end
						if(dma_p3_ob_we) begin // @ this edge dma_p3_ob_data is also updated.
							if(dma_p3_burst_cnt + 1 == para) begin
								dma_p3_burst_cnt <= 0;
								dma_p3_offset <= dma_p3_offset + 1;
							end else dma_p3_burst_cnt <= dma_p3_burst_cnt + 1;
							wbuf[dma_p3_offset * BURST_LEN + dma_p3_burst_cnt] <= dma_p3_ob_data; // wbuf is fixed in a channel operation of a GEMM //FIXME: replace multiplication of reg with new input
							weight_addr_offset <= weight_addr_offset + 1;
						end
						if(dma_p3_offset == kernel_size) begin
							dma_p3_reads_en <= 0; // force sync reset to generate a 1-cycle pulse
						end

						//***PIPELINE STEP1.5: Generate data ready signal for cmac
						if(cmac_enable) begin
							cmac_data_ready <= 1;
						end
						if(cmac_data_ready) begin
							elec_count <= elec_count + 1;
						end
						if(elec_count + 1 == kernel - stride + 1) begin
							elec_count <= 0;
							cmac_data_ready <= 0;
						end
						
						//***PIPELINE STEP2: start passing deserialized data and weight to cmac/sacc/scmp (including weight reuse) TODO: use cache_sel to enable partial sum
						if(cmac_enable) begin
							for(a=0;a<3;a=a+1) begin
								if(line_count + 1 <= kernel * stride * a || cache_count[a] + 1 == kernel_size) begin
									cache_sel[a] <= 0;
								end
							end
							for(a=0;a<BURST_LEN;a=a+1) begin
								data[a] <= dbuf[a];
							end
							for(a=0;a<BURST_LEN;a=a+1) begin
								cache[0][a] <= cache_sel[0]?wbuf[a+cache_count[0]*BURST_LEN]:16'h0000; //FIXME: replace multiplication of reg with new input
								cache[1][a] <= cache_sel[1]?wbuf[a+cache_count[1]*BURST_LEN]:16'h0000;
								cache[2][a] <= cache_sel[2]?wbuf[a+cache_count[2]*BURST_LEN]:16'h0000;
							end
							for(a=0;a<BURST_LEN;a=a+1) begin
								cache_sum[0][a] <= cmac_sum[0][a];
								cache_sum[1][a] <= cmac_sum[1][a];
								cache_sum[2][a] <= cmac_sum[2][a];
							end
							atom_count <= atom_count + 1;
							line_count <= line_count + 1;
							if(atom_count + 1 == kernel) begin
								atom_count <= 0;
							end
							for(a=0;a<3;a=a+1) begin
								if(line_count + 1 <= kernel * stride * a) begin //FIXME: replace multiplication of reg with new input
									cache_count[a] <= 0;
								end else if(cache_count[a] + 1 < kernel_size && idle_count[a] == 0) begin
									cache_count[a] <= cache_count[a] + 1;
								end else begin
									cache_count[a] <= 0;
									if(idle_count[a] == (stride - 1) * kernel) begin //FIXME: replace multiplication of reg with new input
										idle_count[a] <= 0;
									end else begin
										idle_count[a] <= idle_count[a] + 1;
									end
								end
							end
							if(line_count + 1 == kernel * i_side) begin //FIXME: replace multiplication of reg with new input
								line_count <= 0;
								for(a=0;a<3;a=a+1) begin
									cache_count[a] <= 0; //clear the counter and start a new channel group
								end
							end
						end
						if(dma_p2_burst_cnt == 0) begin
							cmac_enable <= 0; // sync reset to generate a 1-cycle pulse
						end

						//***PIPELINE STEP3: Partial SUM of para outputs
						if(result_count + 1 == kernel - stride + 1) begin
							result_count <= 0;
							for(a=0;a<3;a=a+1) begin
								sum_count[a] <= cache_count[a];
							end
							for(a=0;a<3;a=a+1) begin
								if(sum_count[a] + 1 == kernel_size) begin
									sum_index <= sum_index + 1; //FIXME: stride > 1
									if(sum_index + 1 == o_side) begin
										sum_index <= 0;
									end
									for(b=0;b<BURST_LEN;b=b+1) begin
										psum[b] <= cmac_sum[a][b]; //FIXME: stride > 1
									end
									fsum_enable <= 1; //Trigger for channel partial sum
								end
							end
							
						end else if(&cmac_ready) begin
							result_count <= result_count + 1;
						end
						if(&cmac_ready) begin
							for(a=0;a<BURST_LEN;a=a+1) begin
								cmac_sum[result_count][a] <= conv_result[a];
							end
						end
						// PIPELINE STEP4: full channel sum stored in -> sum, sum all channels and write back, TODO: bias operation
						// channel partial sum logic
						fsum_data_ready <= fsum_enable;
						fsum_b <= psum[fsum_count];
						if(fsum_enable) begin //FIXME: delay one cycle -> data ready
							if(fsum_count == 0) fsum_a <= sum[sum_index]; //accumulating
							else fsum_a <= fsum_result;
							fsum_count <= fsum_count + 1;
						end
						if(fsum_count + 1 == para) begin
							fsum_count <= 0;
							fsum_enable <= 0;
						end
						if(fsum_ready) begin
							if(fsum_count == 0) fsum_index <= sum_index; //pipeline index sampling (delay align)
							sum[fsum_index] <= fsum_result; //overwrite mode
							dma_p0_ib_data <= fsum_result; //FIXME: call sum[fsum_index]
							if(i_channel_count + para == i_channel) begin
								dma_p0_writes_en <= 1; // TODO: Update start addr @ the same edge of writes_en
							end
						end
						if(fsum_index + 1 == o_side && fsum_ready && fsum_count == 0) begin
							if(i_channel_count + para < i_channel) begin
								i_channel_count <= i_channel_count + para; 
							end else begin
								i_channel_count <= 0;
								gemm_count <= gemm_count + 1;//TODO: gemm addr parsing //NOTES: Go to the next gemm, gemm clear
								//updating gemm addr and data addr_block, TODO: stride = 2
								gemm_addr <= gemm_addr + para;
								data_addr_block <= gemm_addr + para;
								if(gemm_count + 1 == o_side) begin
									gemm_count <= 0;
									o_channel_count <= o_channel_count + 1; //NOTES: start the next weight group
									if(o_channel_count + 1 == o_channel) begin
										layer_finish <= 1;//FIXME: move this gemm logic to after-writeback 
									end
								end
							end
						end
						if(dma_p0_ib_re) begin
							dma_p0_writes_en <= 0;
							dma_p0_ib_valid <= 1;
						end else begin
							dma_p0_ib_valid <= 0;
						end
					end
				endcase
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
