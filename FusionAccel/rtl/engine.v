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
//Command path engine->dma
	output          output_en,
	output [9:0]	d_ram_read_addr,
	output [12:0]	w_ram_read_addr,
	output [9:0]	b_ram_read_addr,
//Data path dma->engine
	input  [16*`BURST_LEN-1:0] 	input_data,
	input  [16*`BURST_LEN-1:0] 	input_weig,
//Data path engine->dma
	output [15:0]	output_data,
	input  [9:0]	output_count,
	output [3:0]	curr_state,
	output [31:0]   timer
);

localparam CONV = 1, MPOOL = 2, APOOL = 3;

reg  [16*`BURST_LEN-1:0] data; 			
reg  [16*`BURST_LEN-1:0] weight; 

//==================== CONV Wires and Registers ====================//
reg  					 cmac_data_ready, cmac_enable;
wire [`BURST_LEN-1:0] 	 cmac_data_valid;
wire [16*`BURST_LEN-1:0] cmac_result; 	
wire [`BURST_LEN-1:0] 	 rdy_cmac;

genvar i;
generate 
	for (i = 0; i < `BURST_LEN; i = i + 1) begin: gencmac
		cmac cmac_(.clk(clk), .rst(rst), .data(data[i*16 +: 16]), .weight(weight[i*16 +: 16]), .result(cmac_result[i*16 +: 16]), .data_ready(cmac_data_ready), .data_valid(cmac_data_valid[i]), .conv_ready(rdy_cmac[i]));
	end 
endgenerate

reg 					 c_fifo_wr_en;
wire 					 c_fifo_rd_en;
wire 					 c_fifo_empty;
wire [`BURST_LEN-1:0]	 c_fifo_rd_en_mux;
assign c_fifo_rd_en = &c_fifo_rd_en_mux;

wire [16*`BURST_LEN-1:0] csum_;
wire [16*`BURST_LEN-1:0] csum_result;
wire [`BURST_LEN-1:0] 	 csum_ready;
wire					 c_fifo_valid;
wire [`BURST_LEN-1:0]	 csum_data_valid;
fifo_fsum cc_(
	.rst			(rst),			// i
	.wr_clk			(clk),			// i
	.rd_clk			(clk),			// i
	.din			(cmac_result), 	// i
	.wr_en			(c_fifo_wr_en),	// i
	.rd_en			(c_fifo_rd_en),	// i
	.dout			(csum_), 		// o
	.full			(),				// o
	.empty			(c_fifo_empty),	// o
	.valid			(c_fifo_valid));
genvar j;
generate
	for (j = 0; j < `BURST_LEN; j = j + 1) begin: gencsum
		csum c_(.clk(clk), .rst(rst), .fifo_empty(c_fifo_empty), .reads_en(c_fifo_rd_en_mux[j]), .kernel_size(kernel_size), .data(csum_[j*16 +: 16]), .data_ready(c_fifo_valid), .data_valid(csum_data_valid[j]), .csum_result(csum_result[j*16 +: 16]), .csum_ready(csum_ready[j]));
	end
endgenerate

reg						 f_fifo_wr_en;
wire					 f_fifo_rd_en;
wire [15:0]				 fsum_result;
wire					 fsum_ready;
reg  [7:0]				 fsum_index;
reg  [15:0] 			 i_channel_count;
wire [16*`BURST_LEN-1:0] fsum_;
wire 					 f_fifo_empty;
wire					 f_fifo_valid;

fifo_fsum ff_ (
	.rst			(rst),			// i
	.wr_clk			(clk),			// i
	.rd_clk			(clk),			// i
	.din			(csum_result), 	// i
	.wr_en			(f_fifo_wr_en),	// i
	.rd_en			(f_fifo_rd_en),	// i
	.dout			(fsum_), 		// o
	.full			(),				// o
	.empty			(f_fifo_empty),	// o
	.valid			(f_fifo_valid));// o

fsum f_ (.clk(clk), .rst(rst), .fifo_empty(f_fifo_empty), .reads_en(f_fifo_rd_en), .bias(bias), .data(fsum_), .valid(f_fifo_valid), .i_channel(i_channel), .fsum_result(fsum_result), .i_channel_count(i_channel_count), .fsum_index(fsum_index), .ready(fsum_ready));

//==================== SCMP Wires and Registers ====================//
reg 					 maxpool_enable;
reg						 m_fifo_wr_en;
wire					 m_fifo_rd_en;
wire [`BURST_LEN-1:0]	 m_fifo_rd_en_mux;
wire 					 m_fifo_empty;
assign m_fifo_rd_en = &m_fifo_rd_en_mux;

wire [16*`BURST_LEN-1:0] scmp_;
wire [16*`BURST_LEN-1:0] scmp_result;
wire 	 			  	 m_fifo_valid;
wire [`BURST_LEN-1:0] 	 scmp_data_valid;

wire [`BURST_LEN-1:0] 	 cmp_ready;
reg  [`BURST_LEN-1:0] 	 scmp_ready;
reg  [7:0]				 scmp_index;

fifo_fsum mm_(
	.rst			(rst),			// i
	.wr_clk			(clk),			// i
	.rd_clk			(clk),			// i
	.din			(data), 		// i
	.wr_en			(m_fifo_wr_en),	// i
	.rd_en			(m_fifo_rd_en),	// i
	.dout			(scmp_), 		// o
	.full			(),				// o
	.empty			(m_fifo_empty),	// o
	.valid			(m_fifo_valid));

genvar l;
generate
	for (l = 0; l < `BURST_LEN; l = l + 1) begin: genscmp
		scmp cmp_ (.clk(clk), .rst(rst), .fifo_empty(m_fifo_empty), .reads_en(m_fifo_rd_en_mux[l]), .kernel_size(kernel_size), .data(scmp_[l*16+:16]), .data_ready(m_fifo_valid), .data_valid(scmp_data_valid[l]), .scmp_result(scmp_result[l*16 +: 16]), .scmp_ready(cmp_ready[l]));
	end
endgenerate
always @(posedge clk) scmp_ready <= cmp_ready;

//==================== SACC Wires and Registers ====================//
reg 					 avepool_enable;
reg						 s_fifo_wr_en;
wire					 s_fifo_rd_en;
wire [`BURST_LEN-1:0]	 s_fifo_rd_en_mux;
wire 					 s_fifo_empty;
assign s_fifo_rd_en = &s_fifo_rd_en_mux;

wire [16*`BURST_LEN-1:0] ssum_;
wire [16*`BURST_LEN-1:0] ssum_result;
wire [`BURST_LEN-1:0] 	 ssum_ready;
wire 	 			  	 s_fifo_valid;
wire [`BURST_LEN-1:0] 	 ssum_data_valid;
reg  [`BURST_LEN-1:0] 	 sacc_ready;

fifo_fsum ss_(
	.rst			(rst),			// i
	.wr_clk			(clk),			// i
	.rd_clk			(clk),			// i
	.din			(data), 		// i
	.wr_en			(s_fifo_wr_en),	// i
	.rd_en			(s_fifo_rd_en),	// i
	.dout			(ssum_), 		// o
	.full			(),				// o
	.empty			(s_fifo_empty),	// o
	.valid			(s_fifo_valid));

reg  [16*`BURST_LEN-1:0] a_div, b_div;
reg 					 div_data_ready;
wire [16*`BURST_LEN-1:0] result_div;
wire [`BURST_LEN-1:0]	 div_data_valid, div_ready;

genvar k;
generate
	for (k = 0; k < `BURST_LEN; k = k + 1) begin: gensacc
		csum s_(.clk(clk), .rst(rst), .fifo_empty(s_fifo_empty), .reads_en(s_fifo_rd_en_mux[k]), .kernel_size(kernel_size), .data(ssum_[k*16 +: 16]), .data_ready(s_fifo_valid), .data_valid(ssum_data_valid[k]), .csum_result(ssum_result[k*16 +: 16]), .csum_ready(ssum_ready[k]));
		divider div_(.a(a_div[k*16+:16]), .b(b_div[k*16+:16]), .clk(clk), .operation_nd(div_data_ready), .operation_rfd(div_data_valid[k]), .result(result_div[k*16 +:16]), .rdy(div_ready[k]));
	end
endgenerate
always @(posedge clk) sacc_ready <= div_ready;

//==================== Address registers ===========================//
reg  [15:0] o_channel_count;
reg			gemm_finish;
reg 		to_clear;
reg  [9:0]  d_ram_read_addr, b_ram_read_addr;
reg	 [7:0]  o_side_count;
reg  [12:0] w_ram_read_addr, w_ram_read_offset;
reg			output_en;
reg  [15:0] output_data;
reg			p0_writeback_en;
reg	 [7:0]	p0_writeback_count;
reg	 [7:0]	writeback_num; // 1 for conv, `BURST_LEN for scmp and sacc
reg  [31:0] timer;

// NOTES: Generate accumulator for atom(1 * 1 * channel) and cube(k * k * channel), this data path is dedicated to convolution only.
//State Machine
localparam idle 		= 7'b0000001;
localparam gemm_busy 	= 7'b0000010;
localparam sacc_busy 	= 7'b0000100;
localparam scmp_busy 	= 7'b0001000;
localparam clear 		= 7'b0010000;
localparam wait_		= 7'b0100000;
localparam finish 		= 7'b1000000;

reg [6:0] curr_state;
reg [6:0] next_state;

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
			case(op_type)
				CONV: if(o_channel_count == `BURST_LEN-1) begin
						next_state = wait_;
					  end else next_state = idle;
				MPOOL, APOOL: next_state = wait_;
			endcase
		end
		wait_: begin
			next_state = wait_;
		end
        default:
            next_state = idle;
    endcase
end
//NOTES: MEC convolution: k * k kernel in BURST_LEN -> finish the line -> next channel group(channel += BURST_LEN) -> next_gemm
//NOTES: Sum point is ready only after the all channel is complete

//    Output, non-blocking
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		data <= 'd0; weight <= 'd0;
		//==================== Pipeline registers ====================
		cmac_enable <= 0; cmac_data_ready <= 0; 
		avepool_enable <= 0; div_data_ready <= 0; a_div <= 0; b_div <= {16{16'h3c00}};
		maxpool_enable <= 0; 
		c_fifo_wr_en <= 0; f_fifo_wr_en <= 0; s_fifo_wr_en <= 0; m_fifo_wr_en <= 0; fsum_index <= 8'h00; scmp_index <= 8'h00;
		to_clear <= 0; 
		gemm_finish <= 0;
		//==================== Cross-channel registers ====================
		d_ram_read_addr <= 'd0; w_ram_read_addr <= 'd0; b_ram_read_addr <= 0; w_ram_read_offset <= 'd0; o_side_count <= 'd0;
		i_channel_count <= 16'h0000; o_channel_count <= 16'h0000;
		p0_writeback_en <= 0; p0_writeback_count <= 8'h00; timer <= 0;
		output_en <= 0; output_data <= 16'h0000; writeback_num <= 8'h00;
	end else begin
		case (curr_state)
			//==================== Clear all registers except cross-channel registers ====================
			idle: begin 
				data <= 'd0; weight <= 'd0;
				//==================== Pipeline registers ====================
				cmac_enable <= 0; cmac_data_ready <= 0; 
				avepool_enable <= 0; div_data_ready <= 0; a_div <= 0; b_div <= {16{16'h3c00}}; 
				maxpool_enable <= 0; 
				c_fifo_wr_en <= 0; f_fifo_wr_en <= 0; s_fifo_wr_en <= 0; m_fifo_wr_en <= 0; fsum_index <= 8'h00;
				to_clear <= 0;
				gemm_finish <= 0;
				w_ram_read_addr <= w_ram_read_offset;
			end
// CMD = 1 ==================== CONVOLUTION: Process a line ====================//
			gemm_busy: begin
				timer <= timer + 1;
				if(engine_valid) begin
					if(o_side_count < o_side) begin
						if((w_ram_read_addr - w_ram_read_offset) + 1 < kernel_size) begin
							d_ram_read_addr <= d_ram_read_addr + 1;
							w_ram_read_addr <= w_ram_read_addr + 1;
						end	else begin
							d_ram_read_addr <= (d_ram_read_addr + stride2) - (kernel_size - 1);
							w_ram_read_addr <= w_ram_read_offset;
							o_side_count <= o_side_count + 1;
						end
						cmac_enable <= 1;
					end else begin
						cmac_enable <= 0;
					end
				end
				if(cmac_enable) begin // STEP1: enable data read and weight read
					if(cmac_data_valid == {`BURST_LEN{1'b1}}) begin
						data <= input_data;
						weight <= input_weig;
					end
					cmac_data_ready <= 1;
				end else cmac_data_ready <= 0;
				if(rdy_cmac == {`BURST_LEN{1'b1}}) begin // STEP2: channel sum
					c_fifo_wr_en <= 1;
				end else c_fifo_wr_en <= 0;
				if(csum_ready == {`BURST_LEN{1'b1}}) begin //STEP3: full sum
					f_fifo_wr_en <= 1;
				end
				if(f_fifo_wr_en) f_fifo_wr_en <= 0;
				if(fsum_ready) begin 
					p0_writeback_en <= 1; 
					writeback_num <= 1; 
					fsum_index <= fsum_index + 1;
				end
				if(fsum_index == o_side) to_clear <= 1; 
			end

// CMD = 2 ==================== MAXPOOLING: Process a line ====================//
			scmp_busy: begin
				if(engine_valid) begin
					if(o_side_count < o_side) begin
						if(w_ram_read_addr + 1 < kernel_size) begin
							d_ram_read_addr <= d_ram_read_addr + 1;
							w_ram_read_addr <= w_ram_read_addr + 1;
						end	else begin
							d_ram_read_addr <= (d_ram_read_addr + stride2) - (kernel_size - 1);
							w_ram_read_addr <= 0;
							o_side_count <= o_side_count + 1;
						end
						maxpool_enable <= 1;
					end else maxpool_enable <= 0;
				end
				if(maxpool_enable) begin
					m_fifo_wr_en <= 1;
					data <= input_data;
				end else m_fifo_wr_en <= 0;
				if(scmp_ready == {`BURST_LEN{1'b1}}) begin
					p0_writeback_en <= 1; //NOTES: Writeback all channels
					writeback_num <= `BURST_LEN;
					scmp_index <= scmp_index + 1;
				end
				if(scmp_index == o_side && p0_writeback_count == `BURST_LEN-1) to_clear <= 1;
			end

// CMD = 3 ==================== AVEPOOLING: Process a line * surface ====================//
			sacc_busy: begin
				if(engine_valid) begin
					if(d_ram_read_addr + 1 < kernel_size) begin
						d_ram_read_addr <= d_ram_read_addr + 1;
					end	else begin
						d_ram_read_addr <= 0;
					end
					avepool_enable <= 1;
				end
				if(avepool_enable) begin
					s_fifo_wr_en <= 1;
					data <= input_data;
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
				o_side_count <= 0;
				scmp_index <= 0;
				to_clear <= 0;
				case(op_type)
					CONV: begin
						if(i_channel_count + `BURST_LEN < i_channel) begin
							i_channel_count <= i_channel_count + `BURST_LEN;
						end else begin
							i_channel_count <= 0;
							d_ram_read_addr <= 'd0;
							b_ram_read_addr <= b_ram_read_addr + 1;
							w_ram_read_offset <= w_ram_read_offset + kernel_size;
							o_channel_count <= o_channel_count + 1; 
							if(o_channel_count == `BURST_LEN-1) gemm_finish <= 1;
						end
					end
					MPOOL, APOOL: gemm_finish <= 1;
				endcase
			end
			// wait_: if(output_count == {o_side, 3'b000}) gemm_finish <= 1;
			default:;
		endcase

		//==================== Write back logic and write address ====================
		if(p0_writeback_en) begin
			output_en <= 1;
			if(p0_writeback_count + 1 < writeback_num) begin
				p0_writeback_count <= p0_writeback_count + 1;
			end else begin
				p0_writeback_en <= 0;
				p0_writeback_count <= 0;
			end
			case(op_type)
				CONV: output_data <= fsum_result[15]? 16'h0000: fsum_result; //Notes: ReLu Activation
				MPOOL: output_data <= scmp_result[p0_writeback_count * 16 +: 16];
				APOOL: output_data <= result_div[p0_writeback_count * 16 +: 16];
			endcase
		end else begin
			output_en <= 0;
		end

	end
end
endmodule
