
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
	
	output reg           p0_rd_en_o, 
	input  wire          p0_rd_empty,
	input  wire [31:0]   p0_rd_data,
	
	input  wire          p0_cmd_full,
	output reg           p0_cmd_en,
	output reg  [2:0]    p0_cmd_instr,
	output reg  [29:0]   p0_cmd_byte_addr,
	output wire [5:0]    p0_cmd_bl_o, 
	input  wire          p0_wr_full,
	output reg           p0_wr_en,
	output reg  [31:0]   p0_wr_data,
	output wire [3:0]    p0_wr_mask
	);

localparam FIFO_SIZE      = 1024;
localparam P0_BURST_LEN      = 32;  // Number of 32bit user words per DRAM command (Must be Multiple of 2)

reg  [29:0] p0_cmd_byte_addr_wr, p0_cmd_byte_addr_rd;
reg  [5:0]  p0_burst_cnt;

reg         p0_write_mode;
reg         p0_read_mode;
reg         reset_d;

assign p0_cmd_bl_o = P0_BURST_LEN - 1;
assign p0_wr_mask = 4'b0000;

always @(posedge clk) p0_write_mode <= writes_en;
always @(posedge clk) p0_read_mode <= reads_en;
always @(posedge clk) reset_d <= reset;

integer p0_state;
localparam p0_idle  = 0,
           p0_write1 = 1,
           p0_write2 = 2,
           p0_write3 = 3,
           p0_read1 = 4,
           p0_read2 = 5,
           p0_read3 = 6,
           p0_read4 = 7;

always @(posedge clk) begin
	if (reset_d) begin
		p0_state           <= p0_idle;
		p0_burst_cnt       <= 3'b000;
		p0_cmd_byte_addr_wr  <= 0;
		p0_cmd_byte_addr_rd  <= 0;
		p0_cmd_instr <= 3'b0;
		p0_cmd_byte_addr <= 30'b0;
	end else begin
		p0_cmd_en  <= 1'b0;
		p0_wr_en <= 1'b0;
		ib_re <= 1'b0;
		p0_rd_en_o   <= 1'b0;
		ob_we <= 1'b0;

		case (p0_state)
			p0_idle: begin
				p0_burst_cnt <= P0_BURST_LEN;

				// only start writing when initialization done
				if (calib_done==1 && p0_write_mode==1 && (ib_count >= P0_BURST_LEN)) begin
					p0_state <= p0_write1;
				end else if (calib_done==1 && p0_read_mode==1 && (ob_count<(FIFO_SIZE-1-P0_BURST_LEN) ) ) begin
					p0_state <= p0_read1;
				end
			end

			p0_write1: begin
				p0_state <= p0_write2;
				ib_re <= 1'b1;
			end

			p0_write2: begin
				if(ib_valid==1) begin
					p0_wr_data <= ib_data;
					p0_wr_en   <= 1'b1;
					p0_burst_cnt <= p0_burst_cnt - 1;
					p0_state <= p0_write3;
				end
			end
			
			p0_write3: begin
				if (p0_burst_cnt == 3'd0) begin
					p0_cmd_en    <= 1'b1;
					p0_cmd_byte_addr <= p0_cmd_byte_addr_wr;
					p0_cmd_byte_addr_wr <= p0_cmd_byte_addr_wr + 4*P0_BURST_LEN;
					p0_cmd_instr     <= 3'b000;
					p0_state <= p0_idle;
				end else begin
					p0_state <= p0_write1;
				end
			end

			p0_read1: begin
				p0_cmd_byte_addr <= p0_cmd_byte_addr_rd;
				p0_cmd_byte_addr_rd <= p0_cmd_byte_addr_rd + 4*P0_BURST_LEN;
				p0_cmd_instr     <= 3'b001;
				p0_cmd_en    <= 1'b1;
				p0_state <= p0_read2;
			end
			
			p0_read2: begin
				if(p0_rd_empty==0) begin
					p0_rd_en_o <= 1'b1;
					p0_state <= p0_read3;
				end
			end
			
			p0_read3: begin
				ob_data <= p0_rd_data;
				ob_we <= 1'b1;
				p0_burst_cnt <= p0_burst_cnt - 1;
				p0_state <= p0_read4;
			end
			
			p0_read4: begin
				if (p0_burst_cnt == 3'd0) begin
					p0_state <= p0_idle;
				end else begin
					p0_state <= p0_read2;
				end
			end

		endcase
	end
end


endmodule
