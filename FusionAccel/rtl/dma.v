
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
localparam BURST_LEN      = 32;  // Number of 32bit user words per DRAM command (Must be Multiple of 2)

wire        rd_fifo_afull;
reg  [29:0] cmd_byte_addr_wr, cmd_byte_addr_rd;
reg  [5:0]  burst_cnt;

reg         write_mode;
reg         read_mode;
reg         reset_d;

assign p0_cmd_bl_o = BURST_LEN - 1;
assign p0_wr_mask = 4'b0000;

always @(posedge clk) write_mode <= writes_en;
always @(posedge clk) read_mode <= reads_en;
always @(posedge clk) reset_d <= reset;

integer state;
localparam s_idle  = 0,
           s_write1 = 10,
           s_write2 = 11,
           s_write3 = 12,
           s_read1 = 20,
           s_read2 = 21,
           s_read3 = 22,
           s_read4 = 23;
always @(posedge clk) begin
	if (reset_d) begin
		state           <= s_idle;
		burst_cnt       <= 3'b000;
		cmd_byte_addr_wr  <= 0;
		cmd_byte_addr_rd  <= 0;
		p0_cmd_instr <= 3'b0;
		p0_cmd_byte_addr <= 30'b0;
	end else begin
		p0_cmd_en  <= 1'b0;
		p0_wr_en <= 1'b0;
		ib_re <= 1'b0;
		p0_rd_en_o   <= 1'b0;
		ob_we <= 1'b0;


		case (state)
			s_idle: begin
				burst_cnt <= BURST_LEN;

				// only start writing when initialization done
				if (calib_done==1 && write_mode==1 && (ib_count >= BURST_LEN)) begin
					state <= s_write1;
				end else if (calib_done==1 && read_mode==1 && (ob_count<(FIFO_SIZE-1-BURST_LEN) ) ) begin
					state <= s_read1;
				end
			end

			s_write1: begin
				state <= s_write2;
				ib_re <= 1'b1;
			end

			s_write2: begin
				if(ib_valid==1) begin
					p0_wr_data <= ib_data;
					p0_wr_en   <= 1'b1;
					burst_cnt <= burst_cnt - 1;
					state <= s_write3;
				end
			end
			
			s_write3: begin
				if (burst_cnt == 3'd0) begin
					p0_cmd_en    <= 1'b1;
					p0_cmd_byte_addr <= cmd_byte_addr_wr;
					cmd_byte_addr_wr <= cmd_byte_addr_wr + 4*BURST_LEN;
					p0_cmd_instr     <= 3'b000;
					state <= s_idle;
				end else begin
					state <= s_write1;
				end
			end

			s_read1: begin
				p0_cmd_byte_addr <= cmd_byte_addr_rd;
				cmd_byte_addr_rd <= cmd_byte_addr_rd + 4*BURST_LEN;
				p0_cmd_instr     <= 3'b001;
				p0_cmd_en    <= 1'b1;
				state <= s_read2;
			end
			
			s_read2: begin
				if(p0_rd_empty==0) begin
					p0_rd_en_o <= 1'b1;
					state <= s_read3;
				end
			end
			
			s_read3: begin
				ob_data <= p0_rd_data;
				ob_we <= 1'b1;
				burst_cnt <= burst_cnt - 1;
				state <= s_read4;
			end
			
			s_read4: begin
				if (burst_cnt == 3'd0) begin
					state <= s_idle;
				end else begin
					state <= s_read2;
				end
			end
			
				
		endcase
	end
end


endmodule
