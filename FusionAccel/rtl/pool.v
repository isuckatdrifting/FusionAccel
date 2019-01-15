`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate

`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC,unpk_idx)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

`define OFFSET2 32
`define OFFSET3 64
`define OFFSET4 96

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
        ce <= 0; om <= 0;
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

//TODO: Sum/Divide Logic for 13x13 pooling
//Sum 13x13 = 64 + 64 + 41 --> 32 adder, pipeline
module pool_13x13 (
    input clk,
    input rst_n,
    input [169*16-1:0] im,
    input [15:0] om,
    input pool_ready,
    output pool_valid
);

    localparam div = 16'h5948; //169

    divider div0(.a(a), .b(b), .operation_nd(operation_nd), .operation_rfd(operation_rfd),
                .clk(clk), .sclr(sclr), .ce(ce), .result(result), .underflow(underflow), .overflow(overflow), .invalid_op(), .rdy(rdy));

    wire [15:0] im_array [0:168];
    `UNPACK_ARRAY(16, 9, im_array, im, unpk_idx_1)

    wire [15:0] im_array [0:8];
    reg [15:0] om;
    reg pool_valid;

    reg [31:0] operation_nd;
    wire [31:0] operation_rfd;
    wire [31:0] rdy;

    reg sclr;
    reg ce;
    reg [15:0] a [0:31];
    reg [15:0] b [0:31];
    wire [15:0] o_buf [0:31];

    localparam idle = 4'b0000;
    localparam accum1 = 4'b0001;
    localparam accum2 = 4'b0010;
    localparam accum3 = 4'b0011;
    localparam accum4 = 4'b0100;
    localparam accum5 = 4'b0101;
    localparam accum6 = 4'b0110;
    localparam accum7 = 4'b0111;
    localparam accum8 = 4'b1000;
    localparam accum9 = 4'b1001;
    localparam accum10 = 4'b1010;
    localparam finish = 4'b1011;

    /*accum accum_0 (.a(a0), .b(b0), .operation_nd(operation_nd_accum0), .operation_rfd(operation_rfd_accum0), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(o_buf0), .underflow(underflow_accum0), .overflow(overflow_accum0), .invalid_op(invalid_op_accum0), .rdy(rdy_accum0));*/

    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            accum accum_0 (.a(a[i]), .b(b[i]), .operation_nd(operation_nd[i]), .operation_rfd(operation_rfd[i]), .clk(clk), 
            .sclr(sclr), .ce(ce), .result(o_buf[i]), .underflow(), .overflow(), .invalid_op(), .rdy(rdy[i]));
        end 
    endgenerate

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
                sclr = 1;
                if(conv_ready)
                    next_state = accum1;
                else
                    next_state = idle;
            end
            accum1: begin
                if(rdy == 32'h00000000) begin
                    next_state = accum2;
                    sclr = 1;
                end
                else begin
                    next_state = accum1;
                    sclr = 0;
                end
            end
            accum2: begin 
                if(rdy == 32'h00000000) begin
                    next_state = accum3;
                    sclr = 1;
                end
                else begin
                    next_state = accum2;
                    sclr = 0;
                end
            end
            accum3: begin
                if(rdy == 32'h00000000) begin
                    next_state = accum4;
                    sclr = 1;
                end
                else begin
                    next_state = accum3;
                    sclr = 0;
                end
            end
            accum4: begin
                if(rdy == 32'h00000000) begin
                    next_state = accum5;
                    sclr = 1;
                end
                else begin
                    next_state = accum4;
                    sclr = 0;
                end
            end
            accum5: begin
                if(rdy[19:0] == 20'h00000) begin
                    next_state = accum6;
                    sclr = 1;
                end
                else begin
                    next_state = accum5;
                    sclr = 0;
                end
            end
            accum6: begin
                if(rdy[9:0] == 10'b00_0000_0000) begin
                    next_state = accum7;
                    sclr = 1;
                end
                else begin
                    next_state = accum6;
                    sclr = 0;
                end
            end
            accum7: begin
                if(rdy[4:0] == 5'b0_0000) begin
                    next_state = accum8;
                    sclr = 1;
                end
                else begin
                    next_state = accum7;
                    sclr = 0;
                end
            end
            accum8: begin
                if(rdy[2:0] == 3'b000) begin
                    next_state = accum9;
                    sclr = 1;
                end
                else begin
                    next_state = accum8;
                    sclr = 0;
                end
            end
            accum9: begin
                if(rdy[0] == 1'b0) begin
                    next_state = accum10;
                    sclr = 1;
                end
                else begin
                    next_state = accum9;
                    sclr = 0;
                end
            end
            accum10: begin
                if(rdy[0] == 1'b0) begin
                    next_state = finish;
                    sclr = 1;
                end
                else begin
                    next_state = accum10;
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

//    Output，blocking
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a0 <= 0; a1 <= 0; a2 <= 0; a3 <= 0; b0 <= 0; b1 <= 0; b2 <= 0; b3 <= 0; 
        operation_nd_0 <= 0; operation_nd_1 <= 0; operation_nd_2 <= 0; 
        operation_nd_3 <= 0; operation_nd_4 <= 0; operation_nd_5 <= 0; 
        operation_nd_6 <= 0; operation_nd_7 <= 0; operation_nd_8 <= 0; 
        operation_nd_accum0 <= 0; operation_nd_accum1 <= 0; operation_nd_accum2 <= 0; operation_nd_accum3 <= 0;
        ce <= 0; om <= 0;
        conv_valid <= 0;
    end
    else begin
        if(rdy[0]) operation_nd[0] <= 0;
        if(rdy[1]) operation_nd[1] <= 0;
        if(rdy[2]) operation_nd[2] <= 0;
        if(rdy[3]) operation_nd[3] <= 0;
        if(rdy[4]) operation_nd[4] <= 0;
        if(rdy[5]) operation_nd[5] <= 0;
        if(rdy[6]) operation_nd[6] <= 0;
        if(rdy[7]) operation_nd[7] <= 0;
        if(rdy[8]) operation_nd[8] <= 0;
        if(rdy[9]) operation_nd[9] <= 0;
        if(rdy[10]) operation_nd[10] <= 0;
        if(rdy[11]) operation_nd[11] <= 0;
        if(rdy[12]) operation_nd[12] <= 0;
        if(rdy[13]) operation_nd[13] <= 0;
        if(rdy[14]) operation_nd[14] <= 0;
        if(rdy[15]) operation_nd[15] <= 0;
        if(rdy[16]) operation_nd[16] <= 0;
        if(rdy[17]) operation_nd[17] <= 0;
        if(rdy[18]) operation_nd[18] <= 0;
        if(rdy[19]) operation_nd[19] <= 0;
        if(rdy[20]) operation_nd[20] <= 0;
        if(rdy[21]) operation_nd[21] <= 0;
        if(rdy[22]) operation_nd[22] <= 0;
        if(rdy[23]) operation_nd[23] <= 0;
        if(rdy[24]) operation_nd[24] <= 0;
        if(rdy[25]) operation_nd[25] <= 0;
        if(rdy[26]) operation_nd[26] <= 0;
        if(rdy[27]) operation_nd[27] <= 0;
        if(rdy[28]) operation_nd[28] <= 0;
        if(rdy[29]) operation_nd[29] <= 0;
        if(rdy[30]) operation_nd[30] <= 0;
        if(rdy[31]) operation_nd[31] <= 0;
        case (curr_state)
            accum1: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= im_array[0]; b[0] <= im_array[1]; 
                a[1] <= im_array[2]; b[1] <= im_array[3]; 
                a[2] <= im_array[4]; b[2] <= im_array[5]; 
                a[3] <= im_array[6]; b[3] <= im_array[7]; 
                a[4] <= im_array[8]; b[4] <= im_array[9]; 
                a[5] <= im_array[10]; b[5] <= im_array[11]; 
                a[6] <= im_array[12]; b[6] <= im_array[13]; 
                a[7] <= im_array[14]; b[7] <= im_array[15]; 
                a[8] <= im_array[16]; b[8] <= im_array[17]; 
                a[9] <= im_array[18]; b[9] <= im_array[19]; 
                a[10] <= im_array[20]; b[10] <= im_array[21]; 
                a[11] <= im_array[22]; b[11] <= im_array[23]; 
                a[12] <= im_array[24]; b[12] <= im_array[25]; 
                a[13] <= im_array[26]; b[13] <= im_array[27]; 
                a[14] <= im_array[28]; b[14] <= im_array[29]; 
                a[15] <= im_array[30]; b[15] <= im_array[31]; 
                a[16] <= im_array[32]; b[16] <= im_array[33]; 
                a[17] <= im_array[34]; b[17] <= im_array[35]; 
                a[18] <= im_array[36]; b[18] <= im_array[37]; 
                a[19] <= im_array[38]; b[19] <= im_array[39]; 
                a[20] <= im_array[40]; b[20] <= im_array[41]; 
                a[21] <= im_array[42]; b[21] <= im_array[43]; 
                a[22] <= im_array[44]; b[22] <= im_array[45]; 
                a[23] <= im_array[46]; b[23] <= im_array[47]; 
                a[24] <= im_array[48]; b[24] <= im_array[49]; 
                a[25] <= im_array[50]; b[25] <= im_array[51]; 
                a[26] <= im_array[52]; b[26] <= im_array[53]; 
                a[27] <= im_array[54]; b[27] <= im_array[55]; 
                a[28] <= im_array[56]; b[28] <= im_array[57]; 
                a[29] <= im_array[58]; b[29] <= im_array[59]; 
                a[30] <= im_array[60]; b[30] <= im_array[61]; 
                a[31] <= im_array[62]; b[31] <= im_array[63]; 
            end
            accum2: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[0]; b[0] <= o_buf[1]; 
                a[1] <= o_buf[2]; b[1] <= o_buf[3]; 
                a[2] <= o_buf[4]; b[2] <= o_buf[5]; 
                a[3] <= o_buf[6]; b[3] <= o_buf[7]; 
                a[4] <= o_buf[8]; b[4] <= o_buf[9]; 
                a[5] <= o_buf[10]; b[5] <= o_buf[11]; 
                a[6] <= o_buf[12]; b[6] <= o_buf[13]; 
                a[7] <= o_buf[14]; b[7] <= o_buf[15]; 
                a[8] <= o_buf[16]; b[8] <= o_buf[17]; 
                a[9] <= o_buf[18]; b[9] <= o_buf[19]; 
                a[10] <= o_buf[20]; b[10] <= o_buf[21]; 
                a[11] <= o_buf[22]; b[11] <= o_buf[23]; 
                a[12] <= o_buf[24]; b[12] <= o_buf[25]; 
                a[13] <= o_buf[26]; b[13] <= o_buf[27]; 
                a[14] <= o_buf[28]; b[14] <= o_buf[29]; 
                a[15] <= o_buf[30]; b[15] <= o_buf[31]; 
                a[16] <= im_array[32+OFFSET2]; b[16] <= im_array[33+OFFSET2]; 
                a[17] <= im_array[34+OFFSET2]; b[17] <= im_array[35+OFFSET2]; 
                a[18] <= im_array[36+OFFSET2]; b[18] <= im_array[37+OFFSET2]; 
                a[19] <= im_array[38+OFFSET2]; b[19] <= im_array[39+OFFSET2]; 
                a[20] <= im_array[40+OFFSET2]; b[20] <= im_array[41+OFFSET2]; 
                a[21] <= im_array[42+OFFSET2]; b[21] <= im_array[43+OFFSET2]; 
                a[22] <= im_array[44+OFFSET2]; b[22] <= im_array[45+OFFSET2]; 
                a[23] <= im_array[46+OFFSET2]; b[23] <= im_array[47+OFFSET2]; 
                a[24] <= im_array[48+OFFSET2]; b[24] <= im_array[49+OFFSET2]; 
                a[25] <= im_array[50+OFFSET2]; b[25] <= im_array[51+OFFSET2]; 
                a[26] <= im_array[52+OFFSET2]; b[26] <= im_array[53+OFFSET2]; 
                a[27] <= im_array[54+OFFSET2]; b[27] <= im_array[55+OFFSET2]; 
                a[28] <= im_array[56+OFFSET2]; b[28] <= im_array[57+OFFSET2]; 
                a[29] <= im_array[58+OFFSET2]; b[29] <= im_array[59+OFFSET2]; 
                a[30] <= im_array[60+OFFSET2]; b[30] <= im_array[61+OFFSET2]; 
                a[31] <= im_array[62+OFFSET2]; b[31] <= im_array[63+OFFSET2]; 
            end
            accum3: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[0]; b[0] <= o_buf[1]; 
                a[1] <= o_buf[2]; b[1] <= o_buf[3]; 
                a[2] <= o_buf[4]; b[2] <= o_buf[5]; 
                a[3] <= o_buf[6]; b[3] <= o_buf[7]; 
                a[4] <= o_buf[8]; b[4] <= o_buf[9]; 
                a[5] <= o_buf[10]; b[5] <= o_buf[11]; 
                a[6] <= o_buf[12]; b[6] <= o_buf[13]; 
                a[7] <= o_buf[14]; b[7] <= o_buf[15]; 
                a[8] <= o_buf[16]; b[8] <= o_buf[17]; 
                a[9] <= o_buf[18]; b[9] <= o_buf[19]; 
                a[10] <= o_buf[20]; b[10] <= o_buf[21]; 
                a[11] <= o_buf[22]; b[11] <= o_buf[23]; 
                a[12] <= o_buf[24]; b[12] <= o_buf[25]; 
                a[13] <= o_buf[26]; b[13] <= o_buf[27]; 
                a[14] <= o_buf[28]; b[14] <= o_buf[29]; 
                a[15] <= o_buf[30]; b[15] <= o_buf[31]; 
                a[16] <= im_array[32+OFFSET3]; b[16] <= im_array[33+OFFSET3]; 
                a[17] <= im_array[34+OFFSET3]; b[17] <= im_array[35+OFFSET3]; 
                a[18] <= im_array[36+OFFSET3]; b[18] <= im_array[37+OFFSET3]; 
                a[19] <= im_array[38+OFFSET3]; b[19] <= im_array[39+OFFSET3]; 
                a[20] <= im_array[40+OFFSET3]; b[20] <= im_array[41+OFFSET3]; 
                a[21] <= im_array[42+OFFSET3]; b[21] <= im_array[43+OFFSET3]; 
                a[22] <= im_array[44+OFFSET3]; b[22] <= im_array[45+OFFSET3]; 
                a[23] <= im_array[46+OFFSET3]; b[23] <= im_array[47+OFFSET3]; 
                a[24] <= im_array[48+OFFSET3]; b[24] <= im_array[49+OFFSET3]; 
                a[25] <= im_array[50+OFFSET3]; b[25] <= im_array[51+OFFSET3]; 
                a[26] <= im_array[52+OFFSET3]; b[26] <= im_array[53+OFFSET3]; 
                a[27] <= im_array[54+OFFSET3]; b[27] <= im_array[55+OFFSET3]; 
                a[28] <= im_array[56+OFFSET3]; b[28] <= im_array[57+OFFSET3]; 
                a[29] <= im_array[58+OFFSET3]; b[29] <= im_array[59+OFFSET3]; 
                a[30] <= im_array[60+OFFSET3]; b[30] <= im_array[61+OFFSET3]; 
                a[31] <= im_array[62+OFFSET3]; b[31] <= im_array[63+OFFSET3]; 
            end
            accum4: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[0]; b[0] <= o_buf[1]; 
                a[1] <= o_buf[2]; b[1] <= o_buf[3]; 
                a[2] <= o_buf[4]; b[2] <= o_buf[5]; 
                a[3] <= o_buf[6]; b[3] <= o_buf[7]; 
                a[4] <= o_buf[8]; b[4] <= o_buf[9]; 
                a[5] <= o_buf[10]; b[5] <= o_buf[11]; 
                a[6] <= o_buf[12]; b[6] <= o_buf[13]; 
                a[7] <= o_buf[14]; b[7] <= o_buf[15]; 
                a[8] <= o_buf[16]; b[8] <= o_buf[17]; 
                a[9] <= o_buf[18]; b[9] <= o_buf[19]; 
                a[10] <= o_buf[20]; b[10] <= o_buf[21]; 
                a[11] <= o_buf[22]; b[11] <= o_buf[23]; 
                a[12] <= o_buf[24]; b[12] <= o_buf[25]; 
                a[13] <= o_buf[26]; b[13] <= o_buf[27]; 
                a[14] <= o_buf[28]; b[14] <= o_buf[29]; 
                a[15] <= o_buf[30]; b[15] <= o_buf[31]; 
                a[16] <= im_array[32+OFFSET4]; b[16] <= im_array[33+OFFSET4]; 
                a[17] <= im_array[34+OFFSET4]; b[17] <= im_array[35+OFFSET4]; 
                a[18] <= im_array[36+OFFSET4]; b[18] <= im_array[37+OFFSET4]; 
                a[19] <= im_array[38+OFFSET4]; b[19] <= im_array[39+OFFSET4]; 
                a[20] <= im_array[40+OFFSET4]; b[20] <= im_array[41+OFFSET4]; 
                a[21] <= im_array[42+OFFSET4]; b[21] <= im_array[43+OFFSET4]; 
                a[22] <= im_array[44+OFFSET4]; b[22] <= im_array[45+OFFSET4]; 
                a[23] <= im_array[46+OFFSET4]; b[23] <= im_array[47+OFFSET4]; 
                a[24] <= im_array[48+OFFSET4]; b[24] <= im_array[49+OFFSET4]; 
                a[25] <= im_array[50+OFFSET4]; b[25] <= im_array[51+OFFSET4]; 
                a[26] <= im_array[52+OFFSET4]; b[26] <= im_array[53+OFFSET4]; 
                a[27] <= im_array[54+OFFSET4]; b[27] <= im_array[55+OFFSET4]; 
                a[28] <= im_array[56+OFFSET4]; b[28] <= im_array[57+OFFSET4]; 
                a[29] <= im_array[58+OFFSET4]; b[29] <= im_array[59+OFFSET4]; 
                a[30] <= im_array[60+OFFSET4]; b[30] <= im_array[61+OFFSET4]; 
                a[31] <= im_array[62+OFFSET4]; b[31] <= im_array[63+OFFSET4]; 
            end
/////////////////////////REMAINING 9 INPUTS////////////////////////
            accum5: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[0]; b[0] <= o_buf[1]; 
                a[1] <= o_buf[2]; b[1] <= o_buf[3]; 
                a[2] <= o_buf[4]; b[2] <= o_buf[5]; 
                a[3] <= o_buf[6]; b[3] <= o_buf[7]; 
                a[4] <= o_buf[8]; b[4] <= o_buf[9]; 
                a[5] <= o_buf[10]; b[5] <= o_buf[11]; 
                a[6] <= o_buf[12]; b[6] <= o_buf[13]; 
                a[7] <= o_buf[14]; b[7] <= o_buf[15]; 
                a[8] <= o_buf[16]; b[8] <= o_buf[17]; 
                a[9] <= o_buf[18]; b[9] <= o_buf[19]; 
                a[10] <= o_buf[20]; b[10] <= o_buf[21]; 
                a[11] <= o_buf[22]; b[11] <= o_buf[23]; 
                a[12] <= o_buf[24]; b[12] <= o_buf[25]; 
                a[13] <= o_buf[26]; b[13] <= o_buf[27]; 
                a[14] <= o_buf[28]; b[14] <= o_buf[29]; 
                a[15] <= o_buf[30]; b[15] <= o_buf[31]; 
                a[16] <= im_array[160]; b[16] <= im_array[161]; 
                a[17] <= im_array[162]; b[17] <= im_array[163]; 
                a[18] <= im_array[164]; b[18] <= im_array[165]; 
                a[19] <= im_array[166]; b[19] <= im_array[167]; 
                 
            end
            accum6: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[0]; b[0] <= o_buf[1]; 
                a[1] <= o_buf[2]; b[1] <= o_buf[3]; 
                a[2] <= o_buf[4]; b[2] <= o_buf[5]; 
                a[3] <= o_buf[6]; b[3] <= o_buf[7]; 
                a[4] <= o_buf[8]; b[4] <= o_buf[9]; 
                a[5] <= o_buf[10]; b[5] <= o_buf[11]; 
                a[6] <= o_buf[12]; b[6] <= o_buf[13]; 
                a[7] <= o_buf[14]; b[7] <= o_buf[15]; 
                a[8] <= o_buf[16]; b[8] <= o_buf[17]; 
                a[9] <= o_buf[18]; b[9] <= o_buf[19]; 

            end
            accum7: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[2]; b[0] <= o_buf[3]; 
                a[1] <= o_buf[4]; b[1] <= o_buf[5]; 
                a[2] <= o_buf[6]; b[2] <= o_buf[7]; 
                a[3] <= o_buf[8]; b[3] <= o_buf[9]; 
                a[4] <= o_buf[0]; b[4] <= o_buf[1]; 
                
            end
            accum8: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[1]; b[0] <= o_buf[2]; 
                a[1] <= o_buf[0]; b[1] <= o_buf[3]; 
                a[2] <= o_buf[4]; b[2] <= im_array[168]; 
                
            end
            accum9: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[0]; b[0] <= o_buf[1]; 
                
            end
            accum10: begin
                ce <= 1; operation_nd <= 32'h00000000;
                a[0] <= o_buf[0]; b[0] <= o_buf[2]; 
                
            end
            finish: begin
                conv_valid <= 1;
            end
            default:    begin
                ce <= 0;
            end
        endcase
    end
end
endmodule