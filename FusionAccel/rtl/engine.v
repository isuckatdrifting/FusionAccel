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
	input [31:0] 	op_num,
	input [31:0]	data_start_addr,
	input [31:0]	weight_start_addr,
	input [31:0]    result_start_addr,
	input [7:0]     i_channel,
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
wire [BURST_LEN - 1:0] cmac_data_valid, avepool_data_valid, maxpool_data_valid;
reg  cmac_data_ready, avepool_data_ready, maxpool_data_ready;
wire conv_ready, maxpool_ready, avepool_ready;
reg  [31:0] op_count;

//Data BUF and Weight BUF of serializer
reg  [15:0] dbuf [0:BURST_LEN-1]; // serial
reg  [15:0] wbuf [0:BURST_LEN-1]; // serial

reg  [15:0] data [0:BURST_LEN-1]; // parallel
reg  [15:0] weight [0:BURST_LEN-1]; // parallel
reg  [7:0]  dma_p2_burst_cnt, dma_p3_burst_cnt; // de-serializer counter, burst cache 16 data, then send to operation unit.

//Writeback BUF
wire [15:0] conv_result [0:BURST_LEN-1]; // parallel
wire [15:0] maxpool_result [0:BURST_LEN-1]; // parallel
wire [15:0] avepool_result [0:BURST_LEN-1]; // parallel
reg  [15:0] rbuf [0:BURST_LEN-1]; // serial
reg  [7:0]  conv_wb_burst_cnt, pool_wb_burst_cnt; // serializer counter, burst cache 16 data, then send to writeback.

//Ping-pong registers
reg  [15:0] cache [0:2];
reg  [0:2]  cache_sel;

reg 		engine_ready;

//DMA enable signal
reg			dma_p0_writes_en, dma_p1_writes_en, dma_p2_reads_en, dma_p3_reads_en, dma_p4_reads_en, dma_p5_reads_en;
reg [29:0]  p0_addr, p1_addr, p2_addr, p3_addr, p4_addr, p5_addr;              //Output to DMA, burst start address. 
reg [29:0]  data_start_addr_buf, weight_start_addr_buf;
reg [15:0]  dma_p0_ib_data, dma_p1_ib_data;
reg			dma_p0_ib_valid, dma_p1_ib_valid;

wire [7:0]  para;
assign para = i_channel > 16? para: i_channel;
// TODO: Generate accumulator for atom(1 * 1 * channel) and cube(k * k * channel), this data path is dedicated to convolution only.
// NOTES: deserializer for write back is only enabled in pooling

genvar i;
generate 
	for (i = 0; i < BURST_LEN; i = i + 1) begin: gencmac
		cmac cmac_(.clk(clk), .rst(conv_rst), .data(data[i]), .weight(weight[i]), .result(conv_result[i]), .conv_valid(conv_valid), .data_ready(cmac_data_ready), .data_valid(cmac_data_valid[i]), .conv_ready(conv_ready)); // TODO: reset cmac with rst signals after finish an atom
	end 
endgenerate
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
localparam deser = 4'b0001;
localparam busy = 4'b0010;
localparam clear = 4'b0011;
localparam sum = 4'b0100;
localparam write = 4'b0101;
localparam finish = 4'b0110;

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
            if(engine_valid) next_state = deser;
            else next_state = idle;
        end
		deser: begin
			if(dma_p2_burst_cnt == para) next_state = busy;
			else next_state = deser;
		end
        busy: begin
            /*if(conv_ready)*/ next_state = clear;
            //else next_state = busy;
        end
		clear: begin
			if(op_count == op_num) next_state = sum; // One point in the output matrix is finished
			else next_state = deser;
		end
		sum: begin
			next_state = write;
		end
		write: begin
			if(conv_wb_burst_cnt == BURST_LEN) next_state = finish;
			else next_state = write;
		end
		finish: begin
		end
        default:
            next_state = idle;
    endcase
end
//    Output, non-blocking
//TODO: Use MEC convolution: 3x3 kernel in PARA -> channel += PARA -> next_line -> next_gemm
//TODO: ping-pong line cache, pipeline weight-mac
//NOTES: Sum point is ready only after the all channel 3x3 kernel mac is complete
//FIXME: Padding Layer: Load the next data. 0: center, 1: side, 2:corner
integer a;
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		dma_p2_burst_cnt <= 0; dma_p3_burst_cnt <= 0;
		conv_wb_burst_cnt <= 0; pool_wb_burst_cnt <= 0;
		conv_valid <= 0; avepool_valid <= 0; maxpool_valid <= 0; engine_ready <= 0;
		dma_p0_writes_en <= 0; dma_p1_writes_en <= 0;
		dma_p2_reads_en <= 0; dma_p3_reads_en <= 0;
        dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
		p0_addr <= 30'h0000_0000; p1_addr <= 30'h0000_0000; p2_addr <= 30'h0000_0000; 
		p3_addr <= 30'h0000_0000; p4_addr <= 30'h0000_0000; p5_addr <= 30'h0000_0000;
		data_start_addr_buf <= 30'h0000_0000; weight_start_addr_buf <= 30'h0000_0000;
		for(a=0;a<BURST_LEN;a=a+1) begin
			data[a] <= 16'h0000; weight[a] <= 16'h0000;
			dbuf[a] <= 16'h0000; wbuf[a] <= 16'h0000;
		end
		dma_p0_ib_data <= 16'h0000; dma_p1_ib_data <= 16'h0000;
		dma_p0_ib_valid <= 0; dma_p1_ib_valid <= 0;
		conv_rst <= 1; maxpool_rst <= 1; avepool_rst <= 1;
		cmac_data_ready <= 0;
		op_count <= 0;
	end else begin
		case (curr_state)
			idle: begin
				conv_rst <= 1; maxpool_rst <= 1; avepool_rst <= 1;
				data_start_addr_buf <= data_start_addr;
				weight_start_addr_buf <= weight_start_addr;
				op_count <= 0;
			end
			deser: begin // de-serialize cache dma output to buffer
				conv_rst <= 0;
				case (op_type) 
					CONV: begin //FIXME: reuse data and start new pipeline
						p2_addr <= data_start_addr_buf; p3_addr <= weight_start_addr_buf;//TODO: Update start addr @ the same edge of reads_en
						// enable data read and weight read
						if(dma_p2_burst_cnt == 0) dma_p2_reads_en <= 1;
						if(dma_p3_burst_cnt == 0) dma_p3_reads_en <= 1;
						if(dma_p2_burst_cnt == para) dma_p2_reads_en <= 0;	
						if(dma_p3_burst_cnt == para) dma_p3_reads_en <= 0;		
						if(dma_p2_ob_we) begin
							dma_p2_burst_cnt <= dma_p2_burst_cnt + 1;
							dbuf[dma_p2_burst_cnt] <= dma_p2_ob_data; // deserialize data to dbuf
						end
						if(dma_p3_ob_we) begin // @ this edge dma_p3_ob_data is also updated.
							dma_p3_burst_cnt <= dma_p3_burst_cnt + 1;
							wbuf[dma_p3_burst_cnt] <= dma_p3_ob_data; // deserialize weight to wbuf
						end
					end
				
				endcase
			end
			busy: begin	//Load data/weight to cmac/sacc/scmp
				case (op_type)
					CONV: begin 
						conv_valid <= 1;
						if(&cmac_data_valid) begin
							for(a=0;a<para;a=a+1) begin
								data[a] <= dbuf[a]; weight[a] <= wbuf[a];
							end
							cmac_data_ready <= 1;
						end
					end
					MPOOL: begin
					end
					APOOL: begin
					end
					default:;
				endcase
			end
			clear: begin
				cmac_data_ready <= 0;
				dma_p2_burst_cnt <= 0; dma_p3_burst_cnt <= 0;
				dma_p2_reads_en <= 0; dma_p3_reads_en <= 0; dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
				op_count <= op_count + para;
			end
			sum: begin //TODO: reset cmac after finish one atom convolution (clear accumulator), TODO: use line accumulator (sum of 3) and pipeline it
				for(a=0;a<BURST_LEN;a=a+1) begin
					rbuf[a] <= conv_result[a];
				end
			end
			write: begin
				case (op_type)
					CONV: begin
						if(conv_wb_burst_cnt == 0) dma_p0_writes_en <= 1; // TODO: Update start addr @ the same edge of writes_en
						if(dma_p0_ib_re) begin
							dma_p0_ib_data <= conv_result[conv_wb_burst_cnt];
							dma_p0_ib_valid <= 1;
							conv_wb_burst_cnt <= conv_wb_burst_cnt + 1;
						end else begin
							dma_p0_ib_valid <= 0;
						end
						if(conv_wb_burst_cnt == BURST_LEN - 1) begin
							conv_wb_burst_cnt <= 0;
						end
					end
					MPOOL: begin
					end
					APOOL: begin
					end
					default:;
				endcase
			end
			finish: begin
				engine_ready <= 1;
				dma_p0_writes_en <= 0; dma_p1_writes_en <= 0;
			end
			default:;
		endcase
	end
end
endmodule
