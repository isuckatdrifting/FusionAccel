`timescale 1ns/1ps
//`default_nettype none

module dma
	(
	input  wire          clk,
	input  wire          reset,
	input  wire          writes_en,
	input  wire          reads_en,
	input  wire          calib_done, 
	//DDR Input Buffer (ib_)
	output reg           ib_re,
	input  wire [31:0]   ib_data,
	input  wire [9:0]    ib_count,
	input  wire          ib_valid,
	input  wire          ib_empty,
	//DDR Output Buffer (ob_)
	output reg           ob_we,
	output reg  [31:0]   ob_data,
	input  wire [9:0]    ob_count,
	
	output reg           rd_en, 
	input  wire          rd_empty,
	input  wire [31:0]   rd_data,
	
	input  wire          cmd_full,
	output reg           cmd_en,
	output reg  [2:0]    cmd_instr,
	output reg  [29:0]   cmd_byte_addr,
	output wire [5:0]    cmd_bl, 

	input  wire          wr_full,
	output reg           wr_en,
	output reg  [31:0]   wr_data,
	output wire [3:0]    wr_mask,

	input wire [29:0] 	 start_addr,
	input wire [15:0] 	 op_num
	);

localparam 	FIFO_SIZE = 1024;
localparam 	BURST_LEN = 6'd32;  // Number of 32bit(Port size) user words per DRAM command (Must be Multiple of 2)
localparam 	PARA = 16;

reg  [29:0] cmd_byte_addr_wr, cmd_byte_addr_rd;
reg  [5:0]  burst_cnt;

reg         write_mode;
reg         read_mode;
reg         reset_d;

assign cmd_bl = BURST_LEN - 1;
assign wr_mask = 4'b0000;
//Synchronous control signals
always @(posedge clk) write_mode <= writes_en;
always @(posedge clk) read_mode <= reads_en;
always @(posedge clk) reset_d <= reset;

localparam idle = 0,
           write_blob1 = 1,
           write_blob2 = 2,
           write_blob3 = 3,
           read_blob1 = 4,
           read_blob2 = 5,
           read_blob3 = 6,
           read_blob4 = 7;

reg [2:0] 	curr_state;
reg [2:0] 	next_state;

//    Current State, non-blocking
always @ (posedge clk or posedge reset_d)    begin
	if (reset_d)
		curr_state <= idle;
	else
		curr_state <= next_state;
end

//    Status Jump, blocking
always @ (*) begin
	next_state = idle;    // Initialize
	case (curr_state)
		// only start writing when initialization done
		idle: 			if (calib_done == 1 && write_mode == 1 && (ib_count >= BURST_LEN)) begin
							next_state = write_blob1;
						end else if (calib_done == 1 && read_mode == 1 && (ob_count < (FIFO_SIZE - 1 - BURST_LEN))) begin
							next_state = read_blob1;
						end else begin
							next_state = idle;
						end

		write_blob1: 	next_state = write_blob2;

		write_blob2: 	if(ib_valid == 1) next_state = write_blob3;
						else next_state = write_blob2;

		write_blob3: 	if(burst_cnt == 0) next_state = idle;
						else next_state = write_blob1;

		read_blob1: 	next_state = read_blob2;

		read_blob2: 	if(rd_empty == 0) next_state = read_blob3;
						else next_state = read_blob2;

		read_blob3: 	next_state = read_blob4;

		read_blob4: 	if (burst_cnt == 0) begin
							next_state = idle;
						end else begin
							next_state = read_blob2;
						end

		default:		next_state = idle;
	endcase
end

//    Output, non-blocking
always @(posedge clk or posedge reset_d) begin
	if (reset_d) begin
		burst_cnt <= 0;
		cmd_byte_addr_wr <= start_addr;
		cmd_byte_addr_rd <= start_addr;
		cmd_instr <= 3'b000;
		cmd_byte_addr <= 30'b0;
	end else begin
		cmd_en <= 1'b0;
		wr_en <= 1'b0;
		ib_re <= 1'b0;
		rd_en <= 1'b0;
		ob_we <= 1'b0;
		case (curr_state)
			idle: 			burst_cnt <= BURST_LEN;

			write_blob1: 	ib_re <= 1'b1;

			write_blob2: 	if(ib_valid == 1) begin
								wr_data <= ib_data;
								wr_en <= 1'b1;
								burst_cnt <= burst_cnt - 1;
							end

			write_blob3:	if (burst_cnt == 0) begin
								cmd_en <= 1'b1;
								cmd_byte_addr <= cmd_byte_addr_wr;
								cmd_byte_addr_wr <= cmd_byte_addr_wr + 4*BURST_LEN; //4Byte * BURST_LEN = Jump distance
								cmd_instr <= 3'b000;
							end

			read_blob1: 	begin
								cmd_byte_addr <= cmd_byte_addr_rd;
								cmd_byte_addr_rd <= cmd_byte_addr_rd + 4*BURST_LEN;
								cmd_instr <= 3'b001;
								cmd_en <= 1'b1;
							end

			read_blob2:		if(rd_empty == 0) rd_en <= 1'b1;

			read_blob3: 	begin
								ob_data <= rd_data;
								ob_we <= 1'b1;
								burst_cnt <= burst_cnt - 1;
							end

			read_blob4:		;
			default:;
		endcase
	end
end
endmodule
