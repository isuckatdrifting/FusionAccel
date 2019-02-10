///////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------AVE Pooling-----------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////
module sacc(
    input           clk,
    input           rst,
    input  [15:0]   data,
    output [15:0]   result,
    input           pool_ready,
    input  [31:0]   op_num, //input op_num changes the same time as conv_ready pulls up
    output          rdy,
    output          pool_valid
);

reg [15:0] result;
reg [15:0] a_div, b_div, a_acc, b_acc;
reg pool_valid;
reg [15:0] remain_op_num;

reg operation_nd_div, operation_nd_acc;
wire operation_rfd_div, operation_rfd_acc;
wire rdy_div, rdy_acc;
wire sclr_div, sclr_acc;
wire ce_div, ce_acc;
wire [15:0] result_div, result_acc;

assign ce_div = ~rdy_div;
assign sclr_div = rdy_div;
assign ce_acc = ~rdy_acc;
assign sclr_acc = rdy_acc;

assign data_permit_div = (~rdy_div) ^ operation_rfd_div;
assign data_permit_acc = (~rdy_acc) ^ operation_rfd_acc;
assign rdy = rdy_acc | rdy_div;
localparam idle = 3'b000;
localparam acc = 3'b001;
localparam div = 3'b010;
localparam finish = 3'b011;

accum acc_ (.a(a_acc), .b(b_acc), .operation_nd(operation_nd_acc), .operation_rfd(operation_rfd_acc), .clk(clk), 
.sclr(sclr_acc), .ce(ce_acc), .result(result_acc), .underflow(), .overflow(), .invalid_op(), .rdy(rdy_acc));

divider div_(.a(a_div), .b(b_div), .operation_nd(operation_nd_div), .operation_rfd(operation_rfd_div),
.clk(clk), .sclr(sclr_div), .ce(ce_div), .result(result_div), .underflow(), .overflow(), .invalid_op(), .rdy(rdy_div));

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
            if(pool_ready) next_state = acc;
            else next_state = idle;
        end
        acc: begin
            if(rdy_acc) begin
                if(remain_op_num == 0) next_state = div;
                else next_state = acc;
            end
            else next_state = acc;
        end
        div: begin
            if(rdy_div) next_state = finish;
            else next_state = div;
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
        operation_nd_div <= 1'b0;
        operation_nd_acc <= 1'b0;
        result <= 0;
        pool_valid <= 0;
        remain_op_num <= 0;
        a_div <= 0;
        b_div <= 16'h3c00;
        a_acc <= 0;
        b_acc <= 0;
    end
    else begin
        case (curr_state)
            idle: begin
                remain_op_num <= op_num;
            end
            acc: begin
                if(operation_rfd_acc) begin operation_nd_acc <= 1'b1; end
                if(data_permit_acc) begin a_acc <= result_acc; b_acc <= data; end
                if(rdy_acc) begin 
                    operation_nd_acc <= 1'b0; 
                    if(remain_op_num != 0) remain_op_num <= remain_op_num - 1; 
                end
            end
            div: begin
                if(operation_rfd_div) begin operation_nd_div <= 1'b1; end
                //if(data_permit_div) begin 
                a_div <= result_acc; b_div <= 16'h5948; 
                //end
                if(rdy_div) begin 
                    a_div <= 0; b_div <= 0;
                    operation_nd_div <= 1'b0; 
                    pool_valid <= 1; 
                end
            end
            default:;
        endcase
    end
end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------MAX Pooling-----------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////
module scmp(
    input clk,
    input rst,
    input [15:0] data,
    output [15:0] result,
    input pool_ready,
    input [31:0] op_num, //input op_num changes the same time as conv_ready pulls up
    output rdy_cmp,
    output pool_valid
);

reg [15:0]  result;
reg [15:0]  a_cmp, b_cmp;
reg         pool_valid;
reg [15:0]  remain_op_num;

reg         operation_nd_cmp;
wire        operation_rfd_cmp;
wire        rdy_cmp;
wire        sclr_cmp;
wire        ce_cmp;
wire        result_cmp;
reg [15:0]  tmp;

assign ce_cmp = ~rdy_cmp;
assign sclr_cmp = rdy_cmp;
assign data_permit_cmp = (~rdy_cmp) ^ operation_rfd_cmp;

localparam idle = 3'b000;
localparam cmp = 3'b001;
localparam finish = 3'b010;

//Unordered             000100
//Less Than             001100
//Equal                 010100
//Less Than or Equal    011100
//Greater Than          100100
//Not Equal             101100
//Greater Than or Equal 110100

comparator cmp_ (.a(a_cmp), .b(b_cmp), .operation(6'b100100), .operation_nd(operation_nd_cmp), .operation_rfd(operation_rfd_cmp), .clk(clk), .sclr(sclr_cmp), .ce(ce_cmp), .result(result_cmp), .invalid_op(), .rdy(rdy_cmp));

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
            if(pool_ready) next_state = cmp;
            else next_state = idle;
        end
        cmp: begin
            if(rdy_cmp) begin
                if(remain_op_num == 0) next_state = finish;
                else next_state = cmp;
            end
            else next_state = cmp;
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
        operation_nd_cmp <= 1'b0;
        result <= 0;
        pool_valid <= 0;
        remain_op_num <= 0;
        a_cmp <= 0;
        b_cmp <= 0;
        tmp <= 0;
    end
    else begin
        case (curr_state)
            idle: begin
                remain_op_num <= op_num;
            end
            cmp: begin
                if(operation_rfd_cmp) begin operation_nd_cmp <= 1'b1; end
                if(data_permit_cmp) begin 
                a_cmp <= tmp; b_cmp <= data; 
                end
                if(rdy_cmp) begin 
                    operation_nd_cmp <= 1'b0; 
                    if(!result_cmp) tmp <= b_cmp;
                    if(remain_op_num != 0) remain_op_num <= remain_op_num - 1; 
                    else pool_valid <= 1;
                end
            end
            finish: begin
                result <= tmp;
            end
            default:;
        endcase
    end
end
endmodule