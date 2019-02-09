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
	output p1_data_fifo_rd_en,
	input [15:0] data_1,
	output p1_weight_fifo_rd_en,
	input [15:0] weight_1
	
	//Outputs write back
);

localparam PARA = 16;
localparam BURST_LEN = 16;
localparam POOL_BURST_LEN = 1;
localparam CONV1 = 1;
localparam CONV3 = 2;
localparam CONVP = 3;
//localparam MPOOL = 4;
localparam APOOL = 5;

reg [7:0] burst_cnt;
reg [7:0] pool_burst_cnt;
reg [PARA-1:0] conv_ready_0;
reg [PARA-1:0] conv_ready_1;
wire [PARA-1:0] rdy_acc_0;
wire [PARA-1:0] rdy_acc_1;
wire [PARA-1:0] conv_valid_0;
wire [PARA-1:0] conv_valid_1;

reg avepool_valid;
reg avepool_ready_0;
wire avepool_valid_0;

reg [15:0] d0 [0:15];
reg [15:0] w0 [0:15];
reg [15:0] d1 [0:15];
reg [15:0] w1 [0:15];

reg [15:0] mp, ap;
wire [15:0] result_0 [0:15];
wire [15:0] result_1 [0:15];

reg [15:0] op_count [0:15];
reg [15:0] pool_count;
reg op_finish;
reg conv_valid;

reg p0_data_fifo_rd_en, p1_data_fifo_rd_en, p0_weight_fifo_rd_en, p1_weight_fifo_rd_en;

always @(op_type or conv_valid_0 or conv_valid_1 or avepool_valid_0) begin
	case(op_type)
		CONV1: begin
			if(conv_valid_1 == 16'hffff) op_finish = 1;
			else op_finish = 0;
		end
		CONV3: begin
			if(conv_valid_0 == 16'hffff) op_finish = 1;
			else op_finish = 0;
		end
		CONVP: begin
			if(conv_valid_0 == 16'hffff && conv_valid_1 == 16'hffff) op_finish = 1;
			else op_finish = 0;
		end
		APOOL: begin
			if(avepool_valid_0) op_finish = 1;
			else op_finish = 0;
		end
		default: op_finish = 0;
	endcase
end

//Generate 16CMACs for CONV3x3
//TODO: CMACs start one by one, using the same data path. weight is enabled according to sel.
//Notes: Calculation of a cmac takes 20 cycles, if using pipeline fifo readout, 16 is the best.
genvar i;
generate 
	for (i = 0; i < 16; i = i + 1) begin
		cmac cmac_0(.clk(clk), .rst(~conv_ready), .data(d0[i]), .weight(w0[i]), .result(result_0[i]), .conv_ready(conv_ready_0[i]), .op_num(op_num), .rdy_acc(rdy_acc_0[i]), .conv_valid(conv_valid_0[i]));
	end 
endgenerate

//Generate 16CMACs for CONV1x1
genvar j;
generate 
	for (j = 0; j < 16; j = j + 1) begin
		cmac cmac_1(.clk(clk), .rst(~conv_ready), .data(d1[j]), .weight(w1[j]), .result(result_1[j]), .conv_ready(conv_ready_1[j]), .op_num(op_num), .rdy_acc(rdy_acc_1[j]), .conv_valid(conv_valid_1[j]));
	end 
endgenerate

sacc sacc_(.clk(clk), .rst(~avepool_ready), .data(ap), .result(), .pool_ready(avepool_ready_0), .op_num(op_num), .rdy(rdy_pool), .pool_valid(avepool_valid_0));

//State Machine
localparam idle = 3'b000;
localparam conv_busy = 3'b001;
localparam conv_clear = 3'b010;
localparam avepool_busy = 3'b011;
localparam avepool_clear = 3'b100;
localparam finish = 3'b101;

reg [2:0] curr_state;
reg [2:0] next_state;

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
            if(conv_ready) next_state = conv_busy;
			else if(avepool_ready) next_state = avepool_busy;
            else next_state = idle;
        end
        conv_busy: begin
            if(burst_cnt == BURST_LEN) next_state = conv_clear;
            else next_state = conv_busy;
        end
		conv_clear: begin
			if(op_finish) begin 
				next_state = finish;
			end
			else if (rdy_acc_0[0])begin
				next_state = conv_busy;
			end
			else next_state = conv_clear;
		end
		avepool_busy: begin
            if(pool_burst_cnt == POOL_BURST_LEN) next_state = avepool_clear;
            else next_state = avepool_busy;
        end
		avepool_clear: begin
			if(op_finish) begin 
				next_state = finish;
			end
			else if (rdy_pool)begin
				next_state = avepool_busy;
			end
			else next_state = avepool_clear;
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
		burst_cnt <= 0;
		pool_burst_cnt <= 0;
		conv_ready_1 <= 16'h0;
		conv_ready_0 <= 16'h0;
		avepool_ready_0 <= 0;
		p0_data_fifo_rd_en <= 0;
		p1_data_fifo_rd_en <= 0;
		p0_weight_fifo_rd_en <= 0;
		p1_weight_fifo_rd_en <= 0;
		conv_valid <= 0;
		avepool_valid <= 0;
	end else begin
		for(a=0;a<PARA;a=a+1) begin: clear_conv_ready
			if(conv_valid_0[a]) conv_ready_0[a] <= 0;
		end
		if(avepool_valid_0) avepool_ready_0 <= 0;
		case (curr_state)
			idle: begin
			end
			conv_busy: begin
				case (op_type)
					CONV1: begin 
						burst_cnt <= burst_cnt + 1;
						conv_ready_1[burst_cnt] <= 1; 
						if(burst_cnt < 16) begin 
							p1_data_fifo_rd_en <= 1; 
							p1_weight_fifo_rd_en <= 1;
						end 
					end
					CONV3: begin 
						burst_cnt <= burst_cnt + 1;
						conv_ready_0[burst_cnt] <= 1;
						if(burst_cnt < 16) begin 
							p0_data_fifo_rd_en <= 1; 
							p0_weight_fifo_rd_en <= 1;
						end else begin
							p0_data_fifo_rd_en <= 0; 
							p0_weight_fifo_rd_en <= 0;
						end
					end
					CONVP: begin 
						burst_cnt <= burst_cnt + 1;
						conv_ready_0[burst_cnt] <= 1; conv_ready_1[burst_cnt] <= 1; 
						if(burst_cnt < 16) begin 
							p0_data_fifo_rd_en <= 1; p0_weight_fifo_rd_en <= 1;
							p1_data_fifo_rd_en <= 1; p1_weight_fifo_rd_en <= 1; 
						end
					end
					default:;
				endcase
			end
			conv_clear: begin
				burst_cnt <= 0;
			end
			avepool_busy: begin
				case (op_type)
					APOOL: begin
						pool_burst_cnt <= pool_burst_cnt + 1;
						avepool_ready_0 <= 1;
						if(pool_burst_cnt < 1) begin
							p0_data_fifo_rd_en <= 1;
						end else begin
							p0_data_fifo_rd_en <= 0;
						end
					end
					default: ;
				endcase
			end
			avepool_clear: begin
				pool_burst_cnt <= 0;
			end
			finish: begin
				case(op_type)
					CONV3:conv_valid <= 1;
					APOOL:avepool_valid <= 1;
					default:;
				endcase
			end
			default:;
		endcase
	end
end

integer b;
always@(posedge clk) begin
	if(!conv_ready) begin
		for(b=0;b<PARA;b=b+1) begin
			d0[b] <= 16'h0000; w0[b] <= 16'h0000;
			d1[b] <= 16'h0000; w1[b] <= 16'h0000;
			op_count[b] <= op_num;
		end
	end else begin
		if(burst_cnt >= 2 && burst_cnt <= BURST_LEN + 1) begin
			d0[burst_cnt-2] <= data_0;
			w0[burst_cnt-2] <= weight_0;
			if(op_count[burst_cnt-2] != 0)
				op_count[burst_cnt-2] <= op_count[burst_cnt-2] - 1;
		end
	end
end

always@(posedge clk) begin
	if(!avepool_ready) begin
		ap <= 16'h0000;
		pool_count <= op_num;
	end else begin
		if(pool_burst_cnt >= 2 && pool_burst_cnt <= POOL_BURST_LEN + 1) begin
			ap <= data_0;
			if(pool_count != 0)
				pool_count <= pool_count - 1;
		end
	end
end
//TODO: Merged Write back to csb
endmodule
