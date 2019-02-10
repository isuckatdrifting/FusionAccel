module cmac(
    input clk,
    input rst,
    input [15:0] data,
    input [15:0] weight,
    output [15:0] result,
    input conv_ready,
    input [31:0] op_num, //input op_num changes the same time as conv_ready pulls up
    output rdy_acc,
    output conv_valid
);

reg [15:0] result;
reg [15:0] a_mult, b_mult, a_acc, b_acc;
reg conv_valid;
reg [31:0] remain_op_num;

reg operation_nd_mult, operation_nd_acc;
wire operation_rfd_mult, operation_rfd_acc;
wire rdy_mult, rdy_acc;
wire sclr_mult, sclr_acc;
wire ce_mult, ce_acc;
wire [15:0] result_mult, result_acc;

assign ce_mult = ~rdy_mult;
assign sclr_mult = rdy_mult;
assign ce_acc = ~rdy_acc;
assign sclr_acc = rdy_acc;

assign data_permit_mult = (~rdy_mult) ^ operation_rfd_mult;
assign data_permit_acc = (~rdy_acc) ^ operation_rfd_acc;

localparam idle = 3'b000;
localparam mult = 3'b001;
localparam acc = 3'b010;
localparam bia = 3'b011;
localparam finish = 3'b100;

multiplier mult_ (.a(a_mult), .b(b_mult), .operation_nd(operation_nd_mult), .operation_rfd(operation_rfd_mult), .clk(clk), 
.sclr(sclr_mult), .ce(ce_mult), .result(result_mult), .underflow(), .overflow(), .invalid_op(), .rdy(rdy_mult));

accum acc_ (.a(a_acc), .b(b_acc), .operation_nd(operation_nd_acc), .operation_rfd(operation_rfd_acc), .clk(clk), 
.sclr(sclr_acc), .ce(ce_acc), .result(result_acc), .underflow(), .overflow(), .invalid_op(), .rdy(rdy_acc));

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
            if(conv_ready) next_state = mult;
            else next_state = idle;
        end
        mult: begin
            if(rdy_mult) next_state = acc;
            else next_state = mult;
        end
        acc: begin
            if(rdy_acc) begin
                if(remain_op_num == 0) next_state = bia;
                else next_state = mult;
            end
            else next_state = acc;
        end
        bia: begin
            if(rdy_acc) next_state = finish;
            else next_state = bia;
        end
        finish: begin
        end
        default:
            next_state = idle;
    endcase
end

//    Output, non-blocking
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        operation_nd_mult <= 0;
        operation_nd_acc <= 0;
        result <= 0;
        conv_valid <= 0;
        remain_op_num <= 0;
        a_mult <= 0;
        b_mult <= 0;
        a_acc <= 0;
        b_acc <= 0;
    end
    else begin
        case (curr_state)
            idle: begin
                remain_op_num <= op_num;
            end
            mult: begin
                if(operation_rfd_mult) begin operation_nd_mult <= 1; end
                if(data_permit_mult) begin a_mult <= data; b_mult <= weight; end
                if(rdy_mult) begin
                    operation_nd_mult <= 0;
                    if(remain_op_num == 0) begin a_mult <= 0; b_mult <= 0; end
                end
            end
            acc: begin
                if(operation_rfd_acc) begin operation_nd_acc <= 1; end
                if(data_permit_acc) begin a_acc <= result_acc; b_acc <= result_mult; end
                if(rdy_acc) begin 
                    operation_nd_acc <= 0; 
                    if(remain_op_num != 0) remain_op_num <= remain_op_num - 1; 
                    else b_acc <= weight;
                end
            end
            bia: begin
                if(operation_rfd_acc) begin operation_nd_acc <= 1; end
                if(data_permit_acc) begin a_acc <= result_acc; b_acc <= weight; end
                if(rdy_acc) begin 
                    a_acc <= 0; b_acc <= 0;
                    operation_nd_acc <= 0; 
                    conv_valid <= 1; 
                    result <= result_acc[15]?16'h0000:result_acc; 
                end
            end
            default:;
        endcase
    end
end

endmodule