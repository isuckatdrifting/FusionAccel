//Instantiate 16CMACs for conv3x3, 16CMACs for conv1x1, maxpool and avepool in engine.
module engine(
	input clk,
	input rst,
	//Control signals from csb
	input conv_ready,
	input maxpool_ready,
	input avepool_ready,
	input [2:0] op_type,
	input [31:0] op_num,

	output conv_valid,
	output maxpool_valid,
	output avepool_valid,

	//Data path from dma -> fifos
	output p0_data_fifo_rd_en,
	input [15:0] data_0,
	output p0_weight_fifo_rd_en,
	input [15:0] weight_0,
	input [15:0] bias_0,
	output p1_data_fifo_rd_en,
	input [15:0] data_1,
	output p1_weight_fifo_rd_en,
	input [15:0] weight_1,
	input [15:0] bias_1
	
	//Outputs directly back to dma
);

localparam PARA = 16;
localparam BURST_LEN = 16;
localparam CONV1 = 1;
localparam CONV3 = 2;
localparam CONVP = 3;
//localparam MPOOL = 4;
//localparam APOOL = 5;

reg [7:0] burst_cnt;
reg [PARA-1:0] conv_ready_0;
reg [PARA-1:0] conv_ready_1;
wire [PARA-1:0] rdy_acc_0;
wire [PARA-1:0] rdy_acc_1;
wire [PARA-1:0] conv_valid_0;
wire [PARA-1:0] conv_valid_1;

reg [15:0] d0 [0:15];
reg [15:0] w0 [0:15];
reg [15:0] b0 [0:15];
reg [15:0] d1 [0:15];
reg [15:0] w1 [0:15];
reg [15:0] b1 [0:15];

reg [15:0] mp, ap;
wire [15:0] result_0 [0:15];
wire [15:0] result_1 [0:15];

reg [15:0] op_count [0:15];

reg p0_data_fifo_rd_en, p1_data_fifo_rd_en, p0_weight_fifo_rd_en, p1_weight_fifo_rd_en;

//Generate 16CMACs for CONV3x3
//TODO: CMACs start one by one, using the same data path. weight is enabled according to sel.
//Notes: Calculation of a cmac takes 20 cycles, if using pipeline fifo readout, 16 is the best.
genvar i;
generate 
	for (i = 0; i < 16; i = i + 1) begin
		cmac cmac_0(.clk(clk), .rst(rst), .data(d0[i]), .weight(w0[i]), .bias(b0[i]), .result(result_0[i]), .conv_ready(conv_ready_0[i]), .op_num(op_num), .rdy_acc(rdy_acc_0[i]), .conv_valid(conv_valid_0[i]));
	end 
endgenerate

//Generate 16CMACs for CONV1x1
genvar j;
generate 
	for (j = 0; j < 16; j = j + 1) begin
		cmac cmac_1(.clk(clk), .rst(rst), .data(d1[j]), .weight(w1[j]), .bias(b1[j]), .result(result_1[j]), .conv_ready(conv_ready_1[j]), .op_num(op_num), .rdy_acc(rdy_acc_1[j]), .conv_valid(conv_valid_1[j]));
	end 
endgenerate

//Instantiate MAXPOOL
//------------------------------------------------
// Bitonic 3x3 Max Pooling Core
//------------------------------------------------
pool_3x3 pool_3x3_(
    .clk		(sys_clk),
    .rst_n		(~rst),
    .im			(mp),					//Input Matrix 3x3 [143:0]
    .om			(),					//Output Matrix 1x1[15:0]
    .pool_ready	(maxpool_ready),
    .pool_valid	(maxpool_valid));

//Instantiate AVEPOOL
//------------------------------------------------
// Pipeline 13x13 Average Pooling Core
//------------------------------------------------
pool_13x13 pool_13x13_(
    .clk		(sys_clk),
    .rst_n		(~rst),
    .im			(ap),					//Input Matrix 13x13[2703:0]
    .om			(),					//Output Matrix 1x1 [15:0]
    .pool_ready	(avepool_ready),
    .pool_valid	(avepool_valid));

localparam idle = 2'b00;
localparam busy = 2'b01;
localparam clear = 2'b10;
localparam finish = 2'b11;

reg [1:0] curr_state;
reg [1:0] next_state;
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
            if(conv_ready) next_state = busy;
            else next_state = idle;
        end
        busy: begin
            if(burst_cnt == BURST_LEN) next_state = clear;
            else next_state = busy;
        end
		clear: begin
			if(op_count[0] == 0) begin 
				next_state = finish;
			end
			else next_state = busy;
		end
		finish: begin
		end
        default:
            next_state = idle;
    endcase
end

//    Output, non-blocking

//Synchronous Port 0 MUX logic
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		d0[0] <= 16'h0000; w0[0] <= 16'h0000; b0[0] <= 16'h0000;
		d1[0] <= 16'h0000; w1[0] <= 16'h0000; b1[0] <= 16'h0000;
		d0[1] <= 16'h0000; w0[1] <= 16'h0000; b0[1] <= 16'h0000;
		d1[1] <= 16'h0000; w1[1] <= 16'h0000; b1[1] <= 16'h0000;
		d0[2] <= 16'h0000; w0[2] <= 16'h0000; b0[2] <= 16'h0000;
		d1[2] <= 16'h0000; w1[2] <= 16'h0000; b1[2] <= 16'h0000;
		d0[3] <= 16'h0000; w0[3] <= 16'h0000; b0[3] <= 16'h0000;
		d1[3] <= 16'h0000; w1[3] <= 16'h0000; b1[3] <= 16'h0000;
		d0[4] <= 16'h0000; w0[4] <= 16'h0000; b0[4] <= 16'h0000;
		d1[4] <= 16'h0000; w1[4] <= 16'h0000; b1[4] <= 16'h0000;

		d0[5] <= 16'h0000; w0[5] <= 16'h0000; b0[5] <= 16'h0000;
		d1[5] <= 16'h0000; w1[5] <= 16'h0000; b1[5] <= 16'h0000;
		d0[6] <= 16'h0000; w0[6] <= 16'h0000; b0[6] <= 16'h0000;
		d1[6] <= 16'h0000; w1[6] <= 16'h0000; b1[6] <= 16'h0000;
		d0[7] <= 16'h0000; w0[7] <= 16'h0000; b0[7] <= 16'h0000;
		d1[7] <= 16'h0000; w1[7] <= 16'h0000; b1[7] <= 16'h0000;
		d0[8] <= 16'h0000; w0[8] <= 16'h0000; b0[8] <= 16'h0000;
		d1[8] <= 16'h0000; w1[8] <= 16'h0000; b1[8] <= 16'h0000;
		d0[9] <= 16'h0000; w0[9] <= 16'h0000; b0[9] <= 16'h0000;
		d1[9] <= 16'h0000; w1[9] <= 16'h0000; b1[9] <= 16'h0000;

		d0[10] <= 16'h0000; w0[10] <= 16'h0000; b0[10] <= 16'h0000;
		d1[10] <= 16'h0000; w1[10] <= 16'h0000; b1[10] <= 16'h0000;
		d0[11] <= 16'h0000; w0[11] <= 16'h0000; b0[11] <= 16'h0000;
		d1[11] <= 16'h0000; w1[11] <= 16'h0000; b1[11] <= 16'h0000;
		d0[12] <= 16'h0000; w0[12] <= 16'h0000; b0[12] <= 16'h0000;
		d1[12] <= 16'h0000; w1[12] <= 16'h0000; b1[12] <= 16'h0000;
		d0[13] <= 16'h0000; w0[13] <= 16'h0000; b0[13] <= 16'h0000;
		d1[13] <= 16'h0000; w1[13] <= 16'h0000; b1[13] <= 16'h0000;
		d0[14] <= 16'h0000; w0[14] <= 16'h0000; b0[14] <= 16'h0000;
		d1[14] <= 16'h0000; w1[14] <= 16'h0000; b1[14] <= 16'h0000;

		d0[15] <= 16'h0000; w0[15] <= 16'h0000; b0[15] <= 16'h0000;
		d1[15] <= 16'h0000; w1[15] <= 16'h0000; b1[15] <= 16'h0000;

		burst_cnt <= 0;
		conv_ready_1 <= 16'h0;
		conv_ready_0 <= 16'h0;
		p0_data_fifo_rd_en <= 0;
		p1_data_fifo_rd_en <= 0;
		p0_weight_fifo_rd_en <= 0;
		p1_weight_fifo_rd_en <= 0;
	end else begin
		case (curr_state)
			idle: begin
			end
			busy: begin
				burst_cnt <= burst_cnt + 1;
				case (op_type)
					CONV1: begin 
						conv_ready_1[burst_cnt] <= 1; 
						p1_data_fifo_rd_en <= 1; p1_weight_fifo_rd_en <= 1; 
						end
					CONV3: begin 
						conv_ready_0[burst_cnt] <= 1;
						p0_data_fifo_rd_en <= 1; p0_weight_fifo_rd_en <= 1;
						end
					CONVP: begin 
						conv_ready_0[burst_cnt] <= 1; conv_ready_1[burst_cnt] <= 1; 
						p0_data_fifo_rd_en <= 1; p0_weight_fifo_rd_en <= 1;
						p1_data_fifo_rd_en <= 1; p1_weight_fifo_rd_en <= 1; 
						end
					default: ;
				endcase
			end
			clear: begin
				burst_cnt <= 0;
			end
			default:;
		endcase
		if(maxpool_ready) begin
			mp <= data_0;
		end
		if(avepool_ready) begin
			ap <= data_0;
		end
	end
end

//TODO: Handle the last bias
always @ (posedge rdy_acc_0[0] or posedge conv_ready_0[0] or posedge rst) begin if(rst) begin op_count[0] <= op_num; end else begin d0[0] <= data_0; w0[0] <= weight_0; op_count[0] <= op_count[0] - 1; end end
always @ (posedge rdy_acc_0[1] or posedge conv_ready_0[1] or posedge rst) begin if(rst) begin op_count[1] <= op_num; end else begin d0[1] <= data_0; w0[1] <= weight_0; op_count[1] <= op_count[1] - 1; end end
always @ (posedge rdy_acc_0[2] or posedge conv_ready_0[2] or posedge rst) begin if(rst) begin op_count[2] <= op_num; end else begin d0[2] <= data_0; w0[2] <= weight_0; op_count[2] <= op_count[2] - 1; end end
always @ (posedge rdy_acc_0[3] or posedge conv_ready_0[3] or posedge rst) begin if(rst) begin op_count[3] <= op_num; end else begin d0[3] <= data_0; w0[3] <= weight_0; op_count[3] <= op_count[3] - 1; end end
always @ (posedge rdy_acc_0[4] or posedge conv_ready_0[4] or posedge rst) begin if(rst) begin op_count[4] <= op_num; end else begin d0[4] <= data_0; w0[4] <= weight_0; op_count[4] <= op_count[4] - 1; end end
always @ (posedge rdy_acc_0[5] or posedge conv_ready_0[5] or posedge rst) begin if(rst) begin op_count[5] <= op_num; end else begin d0[5] <= data_0; w0[5] <= weight_0; op_count[5] <= op_count[5] - 1; end end
always @ (posedge rdy_acc_0[6] or posedge conv_ready_0[6] or posedge rst) begin if(rst) begin op_count[6] <= op_num; end else begin d0[6] <= data_0; w0[6] <= weight_0; op_count[6] <= op_count[6] - 1; end end
always @ (posedge rdy_acc_0[7] or posedge conv_ready_0[7] or posedge rst) begin if(rst) begin op_count[7] <= op_num; end else begin d0[7] <= data_0; w0[7] <= weight_0; op_count[7] <= op_count[7] - 1; end end
always @ (posedge rdy_acc_0[8] or posedge conv_ready_0[8] or posedge rst) begin if(rst) begin op_count[8] <= op_num; end else begin d0[8] <= data_0; w0[8] <= weight_0; op_count[8] <= op_count[8] - 1; end end
always @ (posedge rdy_acc_0[9] or posedge conv_ready_0[9] or posedge rst) begin if(rst) begin op_count[9] <= op_num; end else begin d0[9] <= data_0; w0[9] <= weight_0; op_count[9] <= op_count[9] - 1; end end
always @ (posedge rdy_acc_0[10] or posedge conv_ready_0[10] or posedge rst) begin if(rst) begin op_count[10] <= op_num; end else begin d0[10] <= data_0; w0[10] <= weight_0; op_count[10] <= op_count[10] - 1; end end
always @ (posedge rdy_acc_0[11] or posedge conv_ready_0[11] or posedge rst) begin if(rst) begin op_count[11] <= op_num; end else begin d0[11] <= data_0; w0[11] <= weight_0; op_count[11] <= op_count[11] - 1; end end
always @ (posedge rdy_acc_0[12] or posedge conv_ready_0[12] or posedge rst) begin if(rst) begin op_count[12] <= op_num; end else begin d0[12] <= data_0; w0[12] <= weight_0; op_count[12] <= op_count[12] - 1; end end
always @ (posedge rdy_acc_0[13] or posedge conv_ready_0[13] or posedge rst) begin if(rst) begin op_count[13] <= op_num; end else begin d0[13] <= data_0; w0[13] <= weight_0; op_count[13] <= op_count[13] - 1; end end
always @ (posedge rdy_acc_0[14] or posedge conv_ready_0[14] or posedge rst) begin if(rst) begin op_count[14] <= op_num; end else begin d0[14] <= data_0; w0[14] <= weight_0; op_count[14] <= op_count[14] - 1; end end
always @ (posedge rdy_acc_0[15] or posedge conv_ready_0[15] or posedge rst) begin if(rst) begin op_count[15] <= op_num; end else begin d0[15] <= data_0; w0[15] <= weight_0; op_count[15] <= op_count[15] - 1; end end

always @ (posedge rdy_acc_1[0] or posedge conv_ready_1[0] or posedge rst) begin if(rst) begin op_count[0] <= op_num; end else begin d1[0] <= data_1; w1[0] <= weight_1; op_count[0] <= op_count[0] + 1; end end
always @ (posedge rdy_acc_1[1] or posedge conv_ready_1[1] or posedge rst) begin if(rst) begin op_count[1] <= op_num; end else begin d1[1] <= data_1; w1[1] <= weight_1; op_count[1] <= op_count[1] + 1; end end
always @ (posedge rdy_acc_1[2] or posedge conv_ready_1[2] or posedge rst) begin if(rst) begin op_count[2] <= op_num; end else begin d1[2] <= data_1; w1[2] <= weight_1; op_count[2] <= op_count[2] + 1; end end
always @ (posedge rdy_acc_1[3] or posedge conv_ready_1[3] or posedge rst) begin if(rst) begin op_count[3] <= op_num; end else begin d1[3] <= data_1; w1[3] <= weight_1; op_count[3] <= op_count[3] + 1; end end
always @ (posedge rdy_acc_1[4] or posedge conv_ready_1[4] or posedge rst) begin if(rst) begin op_count[4] <= op_num; end else begin d1[4] <= data_1; w1[4] <= weight_1; op_count[4] <= op_count[4] + 1; end end
always @ (posedge rdy_acc_1[5] or posedge conv_ready_1[5] or posedge rst) begin if(rst) begin op_count[5] <= op_num; end else begin d1[5] <= data_1; w1[5] <= weight_1; op_count[5] <= op_count[5] + 1; end end
always @ (posedge rdy_acc_1[6] or posedge conv_ready_1[6] or posedge rst) begin if(rst) begin op_count[6] <= op_num; end else begin d1[6] <= data_1; w1[6] <= weight_1; op_count[6] <= op_count[6] + 1; end end
always @ (posedge rdy_acc_1[7] or posedge conv_ready_1[7] or posedge rst) begin if(rst) begin op_count[7] <= op_num; end else begin d1[7] <= data_1; w1[7] <= weight_1; op_count[7] <= op_count[7] + 1; end end
always @ (posedge rdy_acc_1[8] or posedge conv_ready_1[8] or posedge rst) begin if(rst) begin op_count[8] <= op_num; end else begin d1[8] <= data_1; w1[8] <= weight_1; op_count[8] <= op_count[8] + 1; end end
always @ (posedge rdy_acc_1[9] or posedge conv_ready_1[9] or posedge rst) begin if(rst) begin op_count[9] <= op_num; end else begin d1[9] <= data_1; w1[9] <= weight_1; op_count[9] <= op_count[9] + 1; end end
always @ (posedge rdy_acc_1[10] or posedge conv_ready_1[10] or posedge rst) begin if(rst) begin op_count[10] <= op_num; end else begin d1[10] <= data_1; w1[10] <= weight_1; op_count[10] <= op_count[10] + 1; end end
always @ (posedge rdy_acc_1[11] or posedge conv_ready_1[11] or posedge rst) begin if(rst) begin op_count[11] <= op_num; end else begin d1[11] <= data_1; w1[11] <= weight_1; op_count[11] <= op_count[11] + 1; end end
always @ (posedge rdy_acc_1[12] or posedge conv_ready_1[12] or posedge rst) begin if(rst) begin op_count[12] <= op_num; end else begin d1[12] <= data_1; w1[12] <= weight_1; op_count[12] <= op_count[12] + 1; end end
always @ (posedge rdy_acc_1[13] or posedge conv_ready_1[13] or posedge rst) begin if(rst) begin op_count[13] <= op_num; end else begin d1[13] <= data_1; w1[13] <= weight_1; op_count[13] <= op_count[13] + 1; end end
always @ (posedge rdy_acc_1[14] or posedge conv_ready_1[14] or posedge rst) begin if(rst) begin op_count[14] <= op_num; end else begin d1[14] <= data_1; w1[14] <= weight_1; op_count[14] <= op_count[14] + 1; end end
always @ (posedge rdy_acc_1[15] or posedge conv_ready_1[15] or posedge rst) begin if(rst) begin op_count[15] <= op_num; end else begin d1[15] <= data_1; w1[15] <= weight_1; op_count[15] <= op_count[15] + 1; end end

//Merged Wire out to csb
endmodule
