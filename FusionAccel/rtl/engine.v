//Instantiate 16CMACs for conv3x3, 16CMACs for conv1x1, maxpool and avepool in engine.
module engine #(
	parameter CONV_BURST_LEN = 16,
	parameter POOL_BURST_LEN = 1
)
(
	input 			clk,
//Control signals csb->engine
	input 			rst,
	input 			engine_ready,
	input [2:0] 	op_type,
	input			padding,
	input [31:0] 	op_num,
	input [31:0]	data_start_addr,
	input [31:0]	weight_start_addr,
	input [31:0]    result_start_addr,
//Response signals engine->csb
	output 			engine_valid,
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

localparam CONV_CH0 = 1;
localparam CONV_CH1 = 2;
localparam CONV_DUAL = 3;
localparam MPOOL = 4;
localparam APOOL = 5;

reg  [7:0] conv_burst_cnt, conv_wb_burst_cnt;
reg  [7:0] pool_burst_cnt, pool_wb_burst_cnt;
reg  [CONV_BURST_LEN-1:0] conv_ready_0, conv_ready_1;
wire [CONV_BURST_LEN-1:0] rdy_acc_0, rdy_acc_1;
wire [CONV_BURST_LEN-1:0] conv_valid_0, conv_valid_1;

reg  [POOL_BURST_LEN-1:0] maxpool_ready_0, avepool_ready_0;
wire [POOL_BURST_LEN-1:0] rdy_maxpool, rdy_avepool;
wire [POOL_BURST_LEN-1:0] maxpool_valid_0, avepool_valid_0;

reg  [15:0] d0;
reg  [15:0] w0 [0:CONV_BURST_LEN-1];
reg  [15:0] d1;
reg  [15:0] w1 [0:CONV_BURST_LEN-1];
reg  [15:0] mp [0:POOL_BURST_LEN-1];
reg  [15:0] ap [0:POOL_BURST_LEN-1];

wire [15:0] conv_result_0 [0:CONV_BURST_LEN-1];
wire [15:0] conv_result_1 [0:CONV_BURST_LEN-1];
wire [15:0] maxpool_result [0:POOL_BURST_LEN-1];
wire [15:0] avepool_result [0:POOL_BURST_LEN-1];

reg 		engine_valid;
reg 		engine_finish, writeback_finish;

//DMA enable signal
reg			dma_p0_writes_en, dma_p1_writes_en, dma_p2_reads_en, dma_p3_reads_en, dma_p4_reads_en, dma_p5_reads_en;

reg [29:0]  p0_addr, p1_addr, p2_addr, p3_addr, p4_addr, p5_addr;              //Output to DMA, burst start address. 
reg [29:0]  data_start_addr_buf, weight_start_addr_buf;
reg [15:0]  dma_p0_ib_data, dma_p1_ib_data;
reg			dma_p0_ib_valid, dma_p1_ib_valid;

always @(op_type or conv_valid_0 or conv_valid_1 or avepool_valid_0 or maxpool_valid_0) begin //TODO: Use better finish signals
	case(op_type)
		CONV_CH0: begin
			if(conv_valid_0 == 16'hffff) engine_finish = 1;
			else engine_finish = 0;
		end
		CONV_CH1: begin
			if(conv_valid_1 == 16'hffff) engine_finish = 1;
			else engine_finish = 0;
		end
		CONV_DUAL: begin
			if(conv_valid_0 == 16'hffff && conv_valid_1 == 16'hffff) engine_finish = 1;
			else engine_finish = 0;
		end
		MPOOL: begin
			if(maxpool_valid_0 == 1) engine_finish = 1;
			else engine_finish = 0;
		end
		APOOL: begin
			if(avepool_valid_0 == 1) engine_finish = 1;
			else engine_finish = 0;
		end
		default: begin engine_finish = 0; end
	endcase
end

//Generate 16CMACs for CONV3x3
//Notes: CMACs start one by one, using the same data path. weight is enabled according to sel.
//Notes: Calculation of a cmac takes 20 cycles, if using pipeline fifo readout, 16 is the best.
genvar i;
generate 
	for (i = 0; i < CONV_BURST_LEN; i = i + 1) begin
		cmac cmac_0(.clk(clk), .rst(~engine_ready), .data(d0), .weight(w0[i]), .result(conv_result_0[i]), .conv_ready(conv_ready_0[i]), .op_num(op_num), .rdy_acc(rdy_acc_0[i]), .conv_valid(conv_valid_0[i]));
	end 
endgenerate

//Generate 16CMACs for CONV1x1
genvar j;
generate 
	for (j = 0; j < CONV_BURST_LEN; j = j + 1) begin
		cmac cmac_1(.clk(clk), .rst(~engine_ready), .data(d1), .weight(w1[j]), .result(conv_result_1[j]), .conv_ready(conv_ready_1[j]), .op_num(op_num), .rdy_acc(rdy_acc_1[j]), .conv_valid(conv_valid_1[j]));
	end 
endgenerate

genvar k;
generate
	for (k = 0; k < POOL_BURST_LEN; k = k + 1) begin
		sacc sacc_(.clk(clk), .rst(~engine_ready), .data(ap[k]), .result(avepool_result[k]), .pool_ready(avepool_ready_0[k]), .op_num(op_num), .rdy(rdy_avepool[k]), .pool_valid(avepool_valid_0[k]));
	end
endgenerate

genvar l;
generate
	for (l = 0; l < POOL_BURST_LEN; l = l + 1) begin
		scmp scmp_(.clk(clk), .rst(~engine_ready), .data(mp[l]), .result(maxpool_result[l]), .pool_ready(maxpool_ready_0[l]), .op_num(op_num), .rdy_cmp(rdy_maxpool[l]), .pool_valid(maxpool_valid_0[l]));
	end
endgenerate

//TODO: Instatiate Data FIFO and Weight FIFO

//State Machine
localparam idle = 4'b0000;
localparam busy = 4'b0001;
localparam clear = 4'b0010;
localparam writeback = 4'b0011;
localparam finish = 4'b0100;

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
            if(engine_ready) next_state = busy;
            else next_state = idle;
        end
        busy: begin
            if(conv_burst_cnt == CONV_BURST_LEN || pool_burst_cnt == POOL_BURST_LEN) next_state = clear;
            else next_state = busy;
        end
		clear: begin
			if(engine_finish) begin 
				next_state = writeback;
			end else if (rdy_acc_0[0] | rdy_maxpool[0] | rdy_avepool[0]) begin // use the first mac in the pipeline as flag
				next_state = busy;
			end else begin
				next_state = clear;
			end
		end
		writeback: begin
			if(writeback_finish) begin
				next_state = finish;
			end else begin
				next_state = writeback;
			end
		end
		finish: begin
		end
        default:
            next_state = idle;
    endcase
end

//    Output, non-blocking
integer a;
//Synchronous Port 0 MUX logic
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		conv_burst_cnt <= 0; conv_wb_burst_cnt <= 0;
		pool_burst_cnt <= 0; pool_wb_burst_cnt <= 0;
		conv_ready_0 <= 16'h0000;
		conv_ready_1 <= 16'h0000;
		avepool_ready_0 <= 0;
		maxpool_ready_0 <= 0;
		engine_valid <= 0;
		dma_p0_writes_en <= 0; dma_p1_writes_en <= 0;
		dma_p2_reads_en <= 0; dma_p3_reads_en <= 0;
        dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
		p0_addr <= 30'h0000_0000;
		p1_addr <= 30'h0000_0000;
		p2_addr <= 30'h0000_0000;
        p3_addr <= 30'h0000_0000;
        p4_addr <= 30'h0000_0000;
        p5_addr <= 30'h0000_0000;
		data_start_addr_buf <= 30'h0000_0000;
		weight_start_addr_buf <= 30'h0000_0000;
		d0 <= 16'h0000; d1 <= 16'h0000;
		for(a=0;a<CONV_BURST_LEN;a=a+1) begin
			w0[a] <= 16'h0000; w1[a] <= 16'h0000;
		end
		for(a=0;a<POOL_BURST_LEN;a=a+1) begin
			mp[a] <= 16'h0000;
		end
		for(a=0;a<POOL_BURST_LEN;a=a+1) begin
			ap[a] <= 16'h0000;
		end
		dma_p0_ib_data <= 16'h0000; dma_p1_ib_data <= 16'h0000;
		dma_p0_ib_valid <= 0; dma_p1_ib_valid <= 0;
	end else begin
		for(a=0;a<CONV_BURST_LEN;a=a+1) begin: clear_conv_ready
			if(conv_valid_0[a]) conv_ready_0[a] <= 0;
		end
		for(a=0;a<POOL_BURST_LEN;a=a+1) begin: clear_avepool_ready
			if(avepool_valid_0[a]) avepool_ready_0[a] <= 0;
			if(maxpool_valid_0[a]) maxpool_ready_0[a] <= 0;
		end
		case (curr_state)
			idle: begin
				data_start_addr_buf <= data_start_addr;
				weight_start_addr_buf <= weight_start_addr;
			end
			busy: begin	//Load data/weight to cmac/sacc/scmp, TODO: optimize logic here to pass timing closure --> not using index, better way to control the cmac array
				case (op_type)
					CONV_CH0: begin // TODO: Update start addr @ the same edge of reads_en, data read is `PARA times slower than weight read
						if(conv_burst_cnt == 0) begin
							dma_p2_reads_en <= 1; dma_p3_reads_en <= 1;
						end
						if(conv_burst_cnt == 1) dma_p2_reads_en <= 0;
						if(conv_burst_cnt == CONV_BURST_LEN) dma_p3_reads_en <= 0;						
						p2_addr <= data_start_addr_buf; p3_addr <= weight_start_addr_buf;  //<---
						if(dma_p3_ob_we) begin // @ this edge dma_p3_ob_data is also updated.
							conv_burst_cnt <= conv_burst_cnt + 1;
							conv_ready_0[conv_burst_cnt] <= 1;
							w0[conv_burst_cnt] <= dma_p3_ob_data; //input weight
						end
						if(dma_p2_ob_we) begin
							d0 <= dma_p2_ob_data; //input data
						end
					end
					CONV_CH1: begin 
						if(conv_burst_cnt == 0) begin
							dma_p4_reads_en <= 1; dma_p5_reads_en <= 1;
						end
						if(conv_burst_cnt == 1) dma_p4_reads_en <= 0;
						if(conv_burst_cnt == CONV_BURST_LEN) dma_p5_reads_en <= 0;	
						if(dma_p5_ob_we) begin // @ this edge dma_p3_ob_data is also updated.
							conv_burst_cnt <= conv_burst_cnt + 1;
							conv_ready_1[conv_burst_cnt] <= 1; 
							w1[conv_burst_cnt] <= dma_p5_ob_data; //input weight
						end
						if(dma_p4_ob_we) begin
							d1 <= dma_p4_ob_data; //input data
						end
					end
					CONV_DUAL: begin 
						
					end
					MPOOL: begin
						dma_p2_reads_en <= 1; // TODO: change the dma port to p3 if enabling para
						if(dma_p2_ob_we) begin
							pool_burst_cnt <= pool_burst_cnt + 1;
							maxpool_ready_0[pool_burst_cnt] <= 1;
							mp[pool_burst_cnt] <= dma_p2_ob_data;
						end
					end
					APOOL: begin
						dma_p2_reads_en <= 1; // TODO: change the dma port to p3 if enabling para
						if(dma_p2_ob_we) begin
							pool_burst_cnt <= pool_burst_cnt + 1;
							avepool_ready_0[pool_burst_cnt] <= 1;
							ap[pool_burst_cnt] <= dma_p2_ob_data;
						end
					end
					default:;
				endcase
			end
			clear: begin
				conv_burst_cnt <= 0; pool_burst_cnt <= 0;
				dma_p2_reads_en <= 0; dma_p3_reads_en <= 0; dma_p4_reads_en <= 0; dma_p5_reads_en <= 0;
			end
			writeback: begin
				// Load the next data. 0: center, 1: side, 2:corner
				// Jump to the next row, input: o_side_size
				// Jump to the next surface
				case (op_type)
					CONV_CH0: begin
						if(conv_wb_burst_cnt == 0) dma_p0_writes_en <= 1; // TODO: Update start addr @ the same edge of writes_en
						if(dma_p0_ib_re) begin
							dma_p0_ib_data <= conv_result_0[conv_wb_burst_cnt];
							dma_p0_ib_valid <= 1;
							conv_wb_burst_cnt <= conv_wb_burst_cnt + 1;
						end else begin
							dma_p0_ib_valid <= 0;
						end
						if(conv_wb_burst_cnt == CONV_BURST_LEN - 1) begin
							writeback_finish <= 1;
							conv_wb_burst_cnt <= 0;
						end
					end
					CONV_CH1: begin
						if(conv_wb_burst_cnt == 0) dma_p1_writes_en <= 1; // TODO: Update start addr @ the same edge of writes_en
						if(dma_p1_ib_re) begin
							dma_p1_ib_data <= conv_result_1[conv_wb_burst_cnt];
							dma_p1_ib_valid <= 1;
							conv_wb_burst_cnt <= conv_wb_burst_cnt + 1;
						end else begin
							dma_p1_ib_valid <= 0;
						end
						if(conv_wb_burst_cnt == CONV_BURST_LEN - 1) begin
							writeback_finish <= 1;
							conv_wb_burst_cnt <= 0;
						end
					end
					CONV_DUAL: begin
						
					end
					MPOOL: begin
						if(pool_wb_burst_cnt == 0) dma_p0_writes_en <= 1; // TODO: Update start addr @ the same edge of writes_en
						if(dma_p0_ib_re) begin
							dma_p0_ib_data <= maxpool_result[pool_wb_burst_cnt];
							dma_p0_ib_valid <= 1;
							pool_wb_burst_cnt <= pool_wb_burst_cnt + 1;
						end else begin
							dma_p0_ib_valid <= 0;
						end
						if(pool_wb_burst_cnt == POOL_BURST_LEN - 1) begin
							writeback_finish <= 1;
							pool_wb_burst_cnt <= 0;
						end
					end
					APOOL: begin
						if(pool_wb_burst_cnt == 0) dma_p0_writes_en <= 1; // TODO: Update start addr @ the same edge of writes_en
						if(dma_p0_ib_re) begin
							dma_p0_ib_data <= avepool_result[pool_wb_burst_cnt];
							dma_p0_ib_valid <= 1;
							pool_wb_burst_cnt <= pool_wb_burst_cnt + 1;
						end else begin
							dma_p0_ib_valid <= 0;
						end
						if(pool_wb_burst_cnt == POOL_BURST_LEN - 1) begin
							writeback_finish <= 1;
							pool_wb_burst_cnt <= 0;
						end
					end
					default:;
				endcase
			end
			finish: begin
				engine_valid <= 1;
				writeback_finish <= 0;
				dma_p0_writes_en <= 0;
				dma_p1_writes_en <= 0;
				// dma start addr update logic
				/*
				// data cube start_address parsing		
				if(done_width_count + 1 == o_side_size) begin // stride & next row conditions
					p2_addr <= p2_addr + {6'h00, op_num, 4'h0}; // Jump @ end, 6+20+4
					done_width_count <= 8'h00;
					done_height_count <= done_height_count + 1;
				end else begin
					p2_addr <= p2_addr + {22'h00_0000, stride, 4'h0}; //Only add data addr, x16, 22+4+4
				end
				*/
			end
			default:;
		endcase
	end
end
endmodule
