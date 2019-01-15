`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate

`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC,unpk_idx)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module pool_3x3 (
    input clk,
    input rst_n,
    input [143:0] im,
    output [15:0] om,
    input pool_ready,
    output pool_valid
);

//Bitonic 3x3 = 8+1 --> 1-Stage Bitonic + 1-Stage Common
//Bitonic 8 + 1 --> 1 + 2 + 3 + 1 cycles
//Maximum 4 Comparators
wire [15:0] im_array [0:8];
`UNPACK_ARRAY(16, 9, im_array, im, unpk_idx_0)
reg [15:0] om;
reg [15:0] a0,b0,a1,b1,a2,b2,a3,b3;
reg [5:0] operation_0, operation_1, operation_2, operation_3;
reg operation_nd_0, operation_nd_1, operation_nd_2, operation_nd_3;
wire operation_rfd_0, operation_rfd_1, operation_rfd_2, operation_rfd_3;
wire rdy_0, rdy_1, rdy_2, rdy_3;
wire rdy;
reg sclr;
reg ce;
wire result_0, result_1, result_2, result_3;
reg pool_valid;

//Unordered             000100
//Less Than             001100
//Equal                 010100
//Less Than or Equal    011100
//Greater Than          100100
//Not Equal             101100
//Greater Than or Equal 110100
comparator cmp_0(.a(a0), .b(b0), .operation(operation_0), .operation_nd(operation_nd_0), .operation_rfd(operation_rfd_0), 
                .clk(clk), .sclr(sclr), .ce(ce), .result(result_0), .invalid_op(), .rdy(rdy_0));
comparator cmp_1(.a(a1), .b(b1), .operation(operation_1), .operation_nd(operation_nd_1), .operation_rfd(operation_rfd_1), 
                .clk(clk), .sclr(sclr), .ce(ce), .result(result_1), .invalid_op(), .rdy(rdy_1));
comparator cmp_2(.a(a2), .b(b2), .operation(operation_2), .operation_nd(operation_nd_2), .operation_rfd(operation_rfd_2), 
                .clk(clk), .sclr(sclr), .ce(ce), .result(result_2), .invalid_op(), .rdy(rdy_2));
comparator cmp_3(.a(a3), .b(b3), .operation(operation_3), .operation_nd(operation_nd_3), .operation_rfd(operation_rfd_3), 
                .clk(clk), .sclr(sclr), .ce(ce), .result(result_3), .invalid_op(), .rdy(rdy_3));

localparam idle = 4'b0000;
localparam bt1 = 4'b0001;
localparam bt2 = 4'b0010;
localparam bt3 = 4'b0011;
localparam bt4 = 4'b0100;
localparam bt5 = 4'b0101;
localparam bt6 = 4'b0110;
localparam bt7 = 4'b0111;
localparam finish = 4'b1000;

reg [3:0] curr_state;
reg [3:0] next_state;
//    Current State，non-blocking

always @ (posedge clk or negedge rst_n)    begin
    if (!rst_n)
        curr_state    <= idle;
    else
        curr_state    <= next_state;
end

//    Status Jump，blocking
always @ (*) begin
    next_state = idle;    //    Initialize
    case (curr_state)
        idle: begin
            if(pool_ready)
                next_state = bt1;
            else
                next_state = idle;
        end
        bt1: begin
            if(rdy_0 & rdy_1 & rdy_2 & rdy_3) begin
                next_state = bt2;
                sclr = 1;
            end
            else begin
                next_state = bt1;
                sclr = 0;
            end
        end
        bt2: begin 
            if(rdy_0 & rdy_1 & rdy_2 & rdy_3) begin
                next_state = bt3;
                sclr = 1;
            end
            else begin
                next_state = bt2;
                sclr = 0;
            end
        end
        bt3: begin
            if(rdy_0 & rdy_1 & rdy_2 & rdy_3) begin
                next_state = bt4;
                sclr = 1;
            end
            else begin
                next_state = bt3;
                sclr = 0;
            end
        end
        bt4: begin
            if(rdy_0 & rdy_1 & rdy_2 & rdy_3) begin
                next_state = bt5;
                sclr = 1;
            end
            else begin
                next_state = bt4;
                sclr = 0;
            end
        end
        bt5: begin
            if(rdy_0 & rdy_1 & rdy_2 & rdy_3) begin
                next_state = bt6;
                sclr = 1;
            end
            else begin
                next_state = bt5;
                sclr = 0;
            end
        end
        bt6: begin
            if(rdy_0 & rdy_1 & rdy_2 & rdy_3) begin
                sclr = 1;
                next_state = bt7;
            end
            else begin
                next_state = bt6;
                sclr = 0;
            end
            
        end
        bt7: begin
            if(rdy_0) begin
                sclr = 1;
                next_state = finish;
            end
            else begin
                next_state = bt7;
                sclr = 0;
            end
        end
        finish: begin
            next_state = idle;
        end
        default:
            next_state = idle;
    endcase
end

reg [3:0] id_0, id_1, id_2, id_3, id_4, id_5, id_6, id_7;
//    Output，blocking
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a0 <= 0; a1 <= 0; a2 <= 0; a3 <= 0; b0 <= 0; b1 <= 0; b2 <= 0; b3 <= 0; 
        operation_0 <= 0; operation_1 <= 0; operation_2 <= 0; operation_3 <= 0;
        operation_nd_0 <= 0; operation_nd_1 <= 0; operation_nd_2 <= 0; operation_nd_3 <= 0;
        ce <= 0;
        id_0 <= 0; id_1 <= 1; id_2 <= 2; id_3 <= 3; id_4 <= 4; id_5 <= 5; id_6 <= 6; id_7 <= 7;
        pool_valid <= 0;
    end
    else begin
        case (curr_state)
            bt1: begin
                ce <= 1; operation_nd_0 <= 1; operation_nd_1 <= 1; operation_nd_2 <= 1; operation_nd_3 <= 1;
                a0 <= im_array[id_0]; b0 <= im_array[id_1]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_2]; b1 <= im_array[id_3]; operation_1 <= 6'b001100;//LT
                a2 <= im_array[id_4]; b2 <= im_array[id_5]; operation_2 <= 6'b100100;//GT
                a3 <= im_array[id_6]; b3 <= im_array[id_7]; operation_3 <= 6'b001100;//LT
                if(rdy_0) begin
                    operation_nd_0 <= 0;
                    if(result_0) begin id_0 <= id_1; id_1 <= id_0; end
                end
                if(rdy_1) begin
                    operation_nd_1 <= 0;
                    if(result_1) begin id_2 <= id_3; id_3 <= id_2; end
                end
                if(rdy_2) begin 
                    operation_nd_2 <= 0;
                    if(result_2) begin id_4 <= id_5; id_5 <= id_4; end
                end
                if(rdy_3) begin
                    operation_nd_3 <= 0;
                    if(result_3) begin id_6 <= id_7; id_7 <= id_6; end
                end
            end
            bt2: begin
                ce <= 1; operation_nd_0 <= 1; operation_nd_1 <= 1; operation_nd_2 <= 1; operation_nd_3 <= 1;
                a0 <= im_array[id_0]; b0 <= im_array[id_2]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_1]; b1 <= im_array[id_3]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_4]; b2 <= im_array[id_6]; operation_2 <= 6'b001100;//LT
                a3 <= im_array[id_5]; b3 <= im_array[id_7]; operation_3 <= 6'b001100;//LT
                if(rdy_0) begin
                    operation_nd_0 <= 0;
                    if(result_0) begin id_0 <= id_2; id_2 <= id_0; end
                end
                if(rdy_1) begin
                    operation_nd_1 <= 0;
                    if(result_1) begin id_1 <= id_3; id_3 <= id_1; end
                end
                if(rdy_2) begin 
                    operation_nd_2 <= 0;
                    if(result_2) begin id_4 <= id_6; id_6 <= id_4; end
                end
                if(rdy_3) begin
                    operation_nd_3 <= 0;
                    if(result_3) begin id_5 <= id_7; id_7 <= id_5; end
                end
            end
            bt3: begin
                ce <= 1; operation_nd_0 <= 1; operation_nd_1 <= 1; operation_nd_2 <= 1; operation_nd_3 <= 1;
                a0 <= im_array[id_0]; b0 <= im_array[id_1]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_2]; b1 <= im_array[id_3]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_4]; b2 <= im_array[id_5]; operation_2 <= 6'b001100;//LT
                a3 <= im_array[id_6]; b3 <= im_array[id_7]; operation_3 <= 6'b001100;//LT
                if(rdy_0) begin
                    operation_nd_0 <= 0;
                    if(result_0) begin id_0 <= id_1; id_1 <= id_0; end
                end
                if(rdy_1) begin
                    operation_nd_1 <= 0;
                    if(result_1) begin id_2 <= id_3; id_3 <= id_2; end
                end
                if(rdy_2) begin 
                    operation_nd_2 <= 0;
                    if(result_2) begin id_4 <= id_5; id_5 <= id_4; end
                end
                if(rdy_3) begin
                    operation_nd_3 <= 0;
                    if(result_3) begin id_6 <= id_7; id_7 <= id_6; end
                end
            end
            bt4: begin
                ce <= 1; operation_nd_0 <= 1; operation_nd_1 <= 1; operation_nd_2 <= 1; operation_nd_3 <= 1;
                a0 <= im_array[id_0]; b0 <= im_array[id_4]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_1]; b1 <= im_array[id_5]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_2]; b2 <= im_array[id_6]; operation_2 <= 6'b100100;//GT
                a3 <= im_array[id_3]; b3 <= im_array[id_7]; operation_3 <= 6'b100100;//GT
                if(rdy_0) begin
                    operation_nd_0 <= 0;
                    if(result_0) begin id_0 <= id_4; id_4 <= id_0; end
                end
                if(rdy_1) begin
                    operation_nd_1 <= 0;
                    if(result_1) begin id_1 <= id_5; id_5 <= id_1; end
                end
                if(rdy_2) begin 
                    operation_nd_2 <= 0;
                    if(result_2) begin id_2 <= id_6; id_6 <= id_2; end
                end
                if(rdy_3) begin
                    operation_nd_3 <= 0;
                    if(result_3) begin id_3 <= id_7; id_7 <= id_3; end
                end
            end
            bt5: begin
                ce <= 1; operation_nd_0 <= 1; operation_nd_1 <= 1; operation_nd_2 <= 1; operation_nd_3 <= 1;
                a0 <= im_array[id_0]; b0 <= im_array[id_2]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_1]; b1 <= im_array[id_3]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_4]; b2 <= im_array[id_6]; operation_2 <= 6'b100100;//GT
                a3 <= im_array[id_5]; b3 <= im_array[id_7]; operation_3 <= 6'b100100;//GT
                if(rdy_0) begin
                    operation_nd_0 <= 0;
                    if(result_0) begin id_0 <= id_2; id_2 <= id_0; end
                end
                if(rdy_1) begin
                    operation_nd_1 <= 0;
                    if(result_1) begin id_1 <= id_3; id_3 <= id_1; end
                end
                if(rdy_2) begin 
                    operation_nd_2 <= 0;
                    if(result_2) begin id_4 <= id_6; id_6 <= id_4; end
                end
                if(rdy_3) begin
                    operation_nd_3 <= 0;
                    if(result_3) begin id_5 <= id_7; id_7 <= id_5; end
                end
            end
            bt6: begin
                ce <= 1; operation_nd_0 <= 1; operation_nd_1 <= 1; operation_nd_2 <= 1; operation_nd_3 <= 1;
                a0 <= im_array[id_0]; b0 <= im_array[id_1]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_2]; b1 <= im_array[id_3]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_4]; b2 <= im_array[id_5]; operation_2 <= 6'b100100;//GT
                a3 <= im_array[id_6]; b3 <= im_array[id_7]; operation_3 <= 6'b100100;//GT
                if(rdy_0) begin
                    operation_nd_0 <= 0;
                    if(result_0) begin id_0 <= id_1; id_1 <= id_0; end
                end
                if(rdy_1) begin
                    operation_nd_1 <= 0;
                    if(result_1) begin id_2 <= id_3; id_3 <= id_2; end
                end
                if(rdy_2) begin 
                    operation_nd_2 <= 0;
                    if(result_2) begin id_4 <= id_5; id_5 <= id_4; end
                end
                if(rdy_3) begin
                    operation_nd_3 <= 0;
                    if(result_3) begin id_6 <= id_7; id_7 <= id_6; end
                end
            end
            bt7: begin
                ce <= 1; operation_nd_0 <= 1;
                a0 <= im_array[id_7]; b0 <= im_array[8]; operation_0 <= 6'b100100;//GT
                if(rdy_0) begin
                    operation_nd_0 <= 0;
                    if(result_0) begin om <= im_array[id_7]; end
                    else om <= im_array[8];
                end
            end
            finish: begin
                pool_valid <= 1;
            end
            default:    begin
                ce <= 0;
            end
        endcase
    end
end

endmodule

//TODO: Bitonic Sort Logic for 13x13 pooling
//Bitonic 13x13 = 128 + 32 + 4 + 1 --> 2-Stage Bitnoic
//Bitonic 128 + 32 + 4 + 1 + 4 --> 
//Maximum 64 Comparators
module pool_13x13 (
    input clk,
    input rst_n,
    input im,
    input om,
    input pool_ready,
    output pool_valid
);

endmodule