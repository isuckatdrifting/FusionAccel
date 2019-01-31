
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
	
	output reg           rd_en_o, 
	input  wire          rd_empty,
	input  wire [31:0]   rd_data,
	
	input  wire          cmd_full,
	output reg           cmd_en,
	output reg  [2:0]    cmd_instr,
	output reg  [29:0]   cmd_byte_addr,
	output wire [5:0]    cmd_bl_o, 
	input  wire          wr_full,
	output reg           wr_en,
	output reg  [31:0]   wr_data,
	output wire [3:0]    wr_mask
	);

localparam FIFO_SIZE      = 1024;
localparam BURST_LEN      = 32;  // Number of 32bit user words per DRAM command (Must be Multiple of 2)

reg  [29:0] cmd_byte_addr_wr, cmd_byte_addr_rd;
reg  [5:0]  burst_cnt;

reg         write_mode;
reg         read_mode;
reg         reset_d;

assign cmd_bl_o = BURST_LEN - 1;
assign wr_mask = 4'b0000;

always @(posedge clk) write_mode <= writes_en;
always @(posedge clk) read_mode <= reads_en;
always @(posedge clk) reset_d <= reset;

integer state;
localparam idle  = 0,
           write1 = 1,
           write2 = 2,
           write3 = 3,
           read1 = 4,
           read2 = 5,
           read3 = 6,
           read4 = 7;

always @(posedge clk) begin
	if (reset_d) begin
		state           <= idle;
		burst_cnt       <= 3'b000;
		cmd_byte_addr_wr  <= 0;
		cmd_byte_addr_rd  <= 0;
		cmd_instr <= 3'b0;
		cmd_byte_addr <= 30'b0;
	end else begin
		cmd_en  <= 1'b0;
		wr_en <= 1'b0;
		ib_re <= 1'b0;
		rd_en_o   <= 1'b0;
		ob_we <= 1'b0;

		case (state)
			idle: begin
				burst_cnt <= BURST_LEN;

				// only start writing when initialization done
				if (calib_done==1 && write_mode==1 && (ib_count >= BURST_LEN)) begin
					state <= write1;
				end else if (calib_done==1 && read_mode==1 && (ob_count<(FIFO_SIZE-1-BURST_LEN) ) ) begin
					state <= read1;
				end
			end

			write1: begin
				state <= write2;
				ib_re <= 1'b1;
			end

			write2: begin
				if(ib_valid==1) begin
					wr_data <= ib_data;
					wr_en   <= 1'b1;
					burst_cnt <= burst_cnt - 1;
					state <= write3;
				end
			end
			
			write3: begin
				if (burst_cnt == 3'd0) begin
					cmd_en    <= 1'b1;
					cmd_byte_addr <= cmd_byte_addr_wr;
					cmd_byte_addr_wr <= cmd_byte_addr_wr + 4*BURST_LEN;
					cmd_instr     <= 3'b000;
					state <= idle;
				end else begin
					state <= write1;
				end
			end

			read1: begin
				cmd_byte_addr <= cmd_byte_addr_rd;
				cmd_byte_addr_rd <= cmd_byte_addr_rd + 4*BURST_LEN;
				cmd_instr     <= 3'b001;
				cmd_en    <= 1'b1;
				state <= read2;
			end
			
			read2: begin
				if(rd_empty==0) begin
					rd_en_o <= 1'b1;
					state <= read3;
				end
			end
			
			read3: begin
				ob_data <= rd_data;
				ob_we <= 1'b1;
				burst_cnt <= burst_cnt - 1;
				state <= read4;
			end
			
			read4: begin
				if (burst_cnt == 3'd0) begin
					state <= idle;
				end else begin
					state <= read2;
				end
			end

		endcase
	end
end


endmodule
