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
reg [3:0] operation_nd;
wire [3:0] operation_rfd;
wire [3:0] rdy;
wire [3:0] sclr;
wire [3:0] ce;

assign sclr = rdy;
assign ce = ~rdy;

assign cmp__finish = (rdy != 4'h0)?1:0;
assign operation__rfd = (~operation_rfd == 4'h0)?1:0;
assign data_permit = cmp__finish ^ operation__rfd;

wire result_0, result_1, result_2, result_3;
reg pool_valid;

//Unordered             000100
//Less Than             001100
//Equal                 010100
//Less Than or Equal    011100
//Greater Than          100100
//Not Equal             101100
//Greater Than or Equal 110100
comparator cmp_0(.a(a0), .b(b0), .operation(operation_0), .operation_nd(operation_nd[0]), .operation_rfd(operation_rfd[0]), 
                .clk(clk), .sclr(sclr[0]), .ce(ce[0]), .result(result_0), .invalid_op(), .rdy(rdy[0]));
comparator cmp_1(.a(a1), .b(b1), .operation(operation_1), .operation_nd(operation_nd[1]), .operation_rfd(operation_rfd[1]), 
                .clk(clk), .sclr(sclr[1]), .ce(ce[1]), .result(result_1), .invalid_op(), .rdy(rdy[1]));
comparator cmp_2(.a(a2), .b(b2), .operation(operation_2), .operation_nd(operation_nd[2]), .operation_rfd(operation_rfd[2]), 
                .clk(clk), .sclr(sclr[2]), .ce(ce[2]), .result(result_2), .invalid_op(), .rdy(rdy[2]));
comparator cmp_3(.a(a3), .b(b3), .operation(operation_3), .operation_nd(operation_nd[3]), .operation_rfd(operation_rfd[3]), 
                .clk(clk), .sclr(sclr[3]), .ce(ce[3]), .result(result_3), .invalid_op(), .rdy(rdy[3]));

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
            //sclr = 1;
            if(pool_ready)
                next_state = bt1;
            else
                next_state = idle;
        end
        bt1: begin
            if(cmp__finish) begin
                next_state = bt2;
                //sclr = 1;
            end
            else begin
                next_state = bt1;
                //sclr = 0;
            end
        end
        bt2: begin 
            if(cmp__finish) begin
                next_state = bt3;
                //sclr = 1;
            end
            else begin
                next_state = bt2;
                //sclr = 0;
            end
        end
        bt3: begin
            if(cmp__finish) begin
                next_state = bt4;
                //sclr = 1;
            end
            else begin
                next_state = bt3;
                //sclr = 0;
            end
        end
        bt4: begin
            if(cmp__finish) begin
                next_state = bt5;
                //sclr = 1;
            end
            else begin
                next_state = bt4;
                //sclr = 0;
            end
        end
        bt5: begin
            if(cmp__finish) begin
                next_state = bt6;
                //sclr = 1;
            end
            else begin
                next_state = bt5;
                //sclr = 0;
            end
        end
        bt6: begin
            if(cmp__finish) begin
                //sclr = 1;
                next_state = bt7;
            end
            else begin
                next_state = bt6;
                //sclr = 0;
            end
            
        end
        bt7: begin
            if(cmp__finish) begin
                //sclr = 1;
                next_state = idle;
            end
            else begin
                next_state = bt7;
                //sclr = 0;
            end
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
        operation_nd <= 4'h0;
        om <= 0;
        id_0 <= 0; id_1 <= 1; id_2 <= 2; id_3 <= 3; id_4 <= 4; id_5 <= 5; id_6 <= 6; id_7 <= 7;
        pool_valid <= 0;
    end
    else begin
        case (curr_state)
            bt1: begin
                if(operation_rfd == 4'hf) operation_nd <= 4'hf;
                a0 <= im_array[id_0]; b0 <= im_array[id_1]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_2]; b1 <= im_array[id_3]; operation_1 <= 6'b001100;//LT
                a2 <= im_array[id_4]; b2 <= im_array[id_5]; operation_2 <= 6'b100100;//GT
                a3 <= im_array[id_6]; b3 <= im_array[id_7]; operation_3 <= 6'b001100;//LT
                if(rdy[0]) begin
                    operation_nd[0] <= 0;
                    if(result_0) begin id_0 <= id_1; id_1 <= id_0; end
                end
                if(rdy[1]) begin
                    operation_nd[1] <= 0;
                    if(result_1) begin id_2 <= id_3; id_3 <= id_2; end
                end
                if(rdy[2]) begin 
                    operation_nd[2] <= 0;
                    if(result_2) begin id_4 <= id_5; id_5 <= id_4; end
                end
                if(rdy[3]) begin
                    operation_nd[3] <= 0;
                    if(result_3) begin id_6 <= id_7; id_7 <= id_6; end
                end
            end
            bt2: begin
                if(operation_rfd == 4'hf) operation_nd <= 4'hf;
                a0 <= im_array[id_0]; b0 <= im_array[id_2]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_1]; b1 <= im_array[id_3]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_4]; b2 <= im_array[id_6]; operation_2 <= 6'b001100;//LT
                a3 <= im_array[id_5]; b3 <= im_array[id_7]; operation_3 <= 6'b001100;//LT
                if(rdy[0]) begin
                    operation_nd[0] <= 0;
                    if(result_0) begin id_0 <= id_2; id_2 <= id_0; end
                end
                if(rdy[1]) begin
                    operation_nd[1] <= 0;
                    if(result_1) begin id_1 <= id_3; id_3 <= id_1; end
                end
                if(rdy[2]) begin 
                    operation_nd[2] <= 0;
                    if(result_2) begin id_4 <= id_6; id_6 <= id_4; end
                end
                if(rdy[3]) begin
                    operation_nd[3] <= 0;
                    if(result_3) begin id_5 <= id_7; id_7 <= id_5; end
                end
            end
            bt3: begin
                if(operation_rfd == 4'hf) operation_nd <= 4'hf;
                a0 <= im_array[id_0]; b0 <= im_array[id_1]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_2]; b1 <= im_array[id_3]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_4]; b2 <= im_array[id_5]; operation_2 <= 6'b001100;//LT
                a3 <= im_array[id_6]; b3 <= im_array[id_7]; operation_3 <= 6'b001100;//LT
                if(rdy[0]) begin
                    operation_nd[0] <= 0;
                    if(result_0) begin id_0 <= id_1; id_1 <= id_0; end
                end
                if(rdy[1]) begin
                    operation_nd[1] <= 0;
                    if(result_1) begin id_2 <= id_3; id_3 <= id_2; end
                end
                if(rdy[2]) begin 
                    operation_nd[2] <= 0;
                    if(result_2) begin id_4 <= id_5; id_5 <= id_4; end
                end
                if(rdy[3]) begin
                    operation_nd[3] <= 0;
                    if(result_3) begin id_6 <= id_7; id_7 <= id_6; end
                end
            end
            bt4: begin
                if(operation_rfd == 4'hf) operation_nd <= 4'hf;
                a0 <= im_array[id_0]; b0 <= im_array[id_4]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_1]; b1 <= im_array[id_5]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_2]; b2 <= im_array[id_6]; operation_2 <= 6'b100100;//GT
                a3 <= im_array[id_3]; b3 <= im_array[id_7]; operation_3 <= 6'b100100;//GT
                if(rdy[0]) begin
                    operation_nd[0] <= 0;
                    if(result_0) begin id_0 <= id_4; id_4 <= id_0; end
                end
                if(rdy[1]) begin
                    operation_nd[1] <= 0;
                    if(result_1) begin id_1 <= id_5; id_5 <= id_1; end
                end
                if(rdy[2]) begin 
                    operation_nd[2] <= 0;
                    if(result_2) begin id_2 <= id_6; id_6 <= id_2; end
                end
                if(rdy[3]) begin
                    operation_nd[3] <= 0;
                    if(result_3) begin id_3 <= id_7; id_7 <= id_3; end
                end
            end
            bt5: begin
                if(operation_rfd == 4'hf) operation_nd <= 4'hf;
                a0 <= im_array[id_0]; b0 <= im_array[id_2]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_1]; b1 <= im_array[id_3]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_4]; b2 <= im_array[id_6]; operation_2 <= 6'b100100;//GT
                a3 <= im_array[id_5]; b3 <= im_array[id_7]; operation_3 <= 6'b100100;//GT
                if(rdy[0]) begin
                    operation_nd[0] <= 0;
                    if(result_0) begin id_0 <= id_2; id_2 <= id_0; end
                end
                if(rdy[1]) begin
                    operation_nd[1] <= 0;
                    if(result_1) begin id_1 <= id_3; id_3 <= id_1; end
                end
                if(rdy[2]) begin 
                    operation_nd[2] <= 0;
                    if(result_2) begin id_4 <= id_6; id_6 <= id_4; end
                end
                if(rdy[3]) begin
                    operation_nd[3] <= 0;
                    if(result_3) begin id_5 <= id_7; id_7 <= id_5; end
                end
            end
            bt6: begin
                if(operation_rfd == 4'hf) operation_nd <= 4'hf;
                a0 <= im_array[id_0]; b0 <= im_array[id_1]; operation_0 <= 6'b100100;//GT
                a1 <= im_array[id_2]; b1 <= im_array[id_3]; operation_1 <= 6'b100100;//GT
                a2 <= im_array[id_4]; b2 <= im_array[id_5]; operation_2 <= 6'b100100;//GT
                a3 <= im_array[id_6]; b3 <= im_array[id_7]; operation_3 <= 6'b100100;//GT
                if(rdy[0]) begin
                    operation_nd[0] <= 0;
                    if(result_0) begin id_0 <= id_1; id_1 <= id_0; end
                end
                if(rdy[1]) begin
                    operation_nd[1] <= 0;
                    if(result_1) begin id_2 <= id_3; id_3 <= id_2; end
                end
                if(rdy[2]) begin 
                    operation_nd[2] <= 0;
                    if(result_2) begin id_4 <= id_5; id_5 <= id_4; end
                end
                if(rdy[3]) begin
                    operation_nd[3] <= 0;
                    if(result_3) begin id_6 <= id_7; id_7 <= id_6; end
                end
            end
            bt7: begin
                if(operation_rfd[0] == 1'b1) operation_nd[0] <= 1'b1;
                a0 <= im_array[id_7]; b0 <= im_array[8]; operation_0 <= 6'b100100;//GT
                if(rdy[0]) begin
                    operation_nd[0] <= 0;
                    pool_valid <= 1;
                    if(result_0) begin om <= im_array[id_7]; end
                    else om <= im_array[8];
                end
            end
            default: ;
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
    output [15:0] om,
    input pool_ready,
    output pool_valid
);

    localparam div = 16'h5948; //169
    localparam OFFSET2 = 32;
    localparam OFFSET3 = 64;
    localparam OFFSET4 = 96;
    reg [15:0] div_a;
    reg operation_nd_div;
    wire operation_rfd_div;
    wire rdy_div;

    wire [31:0] sclr;
    wire [31:0] ce;
    wire [31:0] rdy;

    wire sclr_div;
    wire ce_div;
    wire [15:0] result_div;
    divider div0(.a(div_a), .b(div), .operation_nd(operation_nd_div), .operation_rfd(operation_rfd_div),
                .clk(clk), .sclr(sclr_div), .ce(ce_div), .result(result_div), .underflow(), .overflow(), .invalid_op(), .rdy(rdy_div));

    wire [15:0] im_array [0:168];
    `UNPACK_ARRAY(16, 169, im_array, im, unpk_idx_1)

    reg [15:0] om;
    reg pool_valid;

    reg [31:0] operation_nd;
    wire [31:0] operation_rfd;

    reg [15:0] a [0:31];
    reg [15:0] b [0:31];
    wire [15:0] o_buf [0:31];

    localparam idle = 4'b0000,
                accum1 = 4'b0001, 
                accum2 = 4'b0010,
                accum3 = 4'b0011,
                accum4 = 4'b0100,
                accum5 = 4'b0101,
                accum6 = 4'b0110,
                accum7 = 4'b0111,
                accum8 = 4'b1000,
                accum9 = 4'b1001,
                accum10 = 4'b1010,
                division = 4'b1011;

    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            accum accum_0 (.a(a[i]), .b(b[i]), .operation_nd(operation_nd[i]), .operation_rfd(operation_rfd[i]), .clk(clk), 
            .sclr(sclr[i]), .ce(ce[i]), .result(o_buf[i]), .underflow(), .overflow(), .invalid_op(), .rdy(rdy[i]));
        end 
    endgenerate

    assign sclr = rdy;//(rdy != 32'h00000000)?1:0;
    assign ce = ~rdy;//(rdy != 32'h00000000)?0:1;
    assign sclr_div = rdy_div;
    assign ce_div = ~rdy_div;

    assign accum__finish = (rdy != 32'h00000000)?1:0;
    assign operation__rfd = (~operation_rfd == 32'h00000000)?1:0;
    assign data_permit = accum__finish ^ operation__rfd;


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
                    next_state = accum1;
                else
                    next_state = idle;
            end
            accum1: begin
                if(accum__finish) begin
                    next_state = accum2;
                end
                else begin
                    next_state = accum1;
                end
            end
            accum2: begin 
                if(accum__finish) begin
                    next_state = accum3;
                end
                else begin
                    next_state = accum2;
                end
            end
            accum3: begin
                if(accum__finish) begin
                    next_state = accum4;
                end
                else begin
                    next_state = accum3;
                end
            end
            accum4: begin
                if(accum__finish) begin
                    next_state = accum5;
                end
                else begin
                    next_state = accum4;
                end
            end
            accum5: begin
                if(accum__finish) begin
                    next_state = accum6;
                end
                else begin
                    next_state = accum5;
                end
            end
            accum6: begin
                if(accum__finish) begin
                    next_state = accum7;
                end
                else begin
                    next_state = accum6;
                end
            end
            accum7: begin
                if(accum__finish) begin
                    next_state = accum8;
                end
                else begin
                    next_state = accum7;
                end
            end
            accum8: begin
                if(accum__finish) begin
                    next_state = accum9;
                end
                else begin
                    next_state = accum8;
                end
            end
            accum9: begin
                if(accum__finish) begin
                    next_state = accum10;
                end
                else begin
                    next_state = accum9;
                end
            end
            accum10: begin
                if(accum__finish) begin
                    next_state = division;
                end
                else begin
                    next_state = accum10;
                end
            end
            division: begin
                if(rdy_div) begin
                    next_state = idle;
                end
                else begin
                    next_state = division;
                end
            end
            default:
                next_state = idle;
        endcase
    end

//    Output，blocking
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a[0] <= 0; b[0] <= 0; 
        a[1] <= 0; b[1] <= 0;
        a[2] <= 0; b[2] <= 0;
        a[3] <= 0; b[3] <= 0;
        a[4] <= 0; b[4] <= 0;
        a[5] <= 0; b[5] <= 0;
        a[6] <= 0; b[6] <= 0;
        a[7] <= 0; b[7] <= 0;
        a[8] <= 0; b[8] <= 0; 
        a[9] <= 0; b[9] <= 0;
        a[10] <= 0; b[10] <= 0;
        a[11] <= 0; b[11] <= 0;
        a[12] <= 0; b[12] <= 0;
        a[13] <= 0; b[13] <= 0;
        a[14] <= 0; b[14] <= 0;
        a[15] <= 0; b[15] <= 0;
        a[16] <= 0; b[16] <= 0; 
        a[17] <= 0; b[17] <= 0;
        a[18] <= 0; b[18] <= 0;
        a[19] <= 0; b[19] <= 0;
        a[20] <= 0; b[20] <= 0;
        a[21] <= 0; b[21] <= 0;
        a[22] <= 0; b[22] <= 0;
        a[23] <= 0; b[23] <= 0;
        a[24] <= 0; b[24] <= 0; 
        a[25] <= 0; b[25] <= 0;
        a[26] <= 0; b[26] <= 0;
        a[27] <= 0; b[27] <= 0;
        a[28] <= 0; b[28] <= 0;
        a[29] <= 0; b[29] <= 0;
        a[30] <= 0; b[30] <= 0;
        a[31] <= 0; b[31] <= 0;
        div_a <= 0;
        operation_nd_div <= 0;
        operation_nd <= 32'h00000000;
        om <= 0;
        pool_valid <= 0;
    end
    else begin
        case (curr_state)
            accum1: begin
                if(operation_rfd == 32'hffffffff) operation_nd <= 32'hffffffff;
                if(data_permit) begin
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
                end;
                if(rdy == 32'hffffffff) begin operation_nd <= 32'h00000000; end
            end
            accum2: begin
                if(operation_rfd == 32'hffffffff) operation_nd <= 32'hffffffff;
                if(data_permit) begin
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
                end;
                if(rdy == 32'hffffffff) begin operation_nd <= 32'h00000000; end
            end
            accum3: begin
                if(operation_rfd == 32'hffffffff)  operation_nd <= 32'hffffffff;
                if(data_permit) begin
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
                end;
                if(rdy == 32'hffffffff) begin operation_nd <= 32'h00000000; end
            end
            accum4: begin
                if(operation_rfd == 32'hffffffff) operation_nd <= 32'hffffffff;
                if(data_permit) begin
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
                end;
                if(rdy == 32'hffffffff) begin operation_nd <= 32'h00000000; end
            end
/////////////////////////REMAINING 9 INPUTS////////////////////////
            accum5: begin
                if(operation_rfd[19:0] == 20'hfffff) operation_nd[19:0] <= 20'hfffff;
                if(data_permit) begin
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
                end; 
                if(rdy[19:0] == 20'hfffff) begin operation_nd[19:0] <= 20'h00000; end
            end
            accum6: begin
                if(operation_rfd[9:0] == 10'h3ff) operation_nd[9:0] <= 10'h3ff;
                if(data_permit) begin
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
                end;
                if(rdy[9:0] == 10'h3ff) begin operation_nd[9:0] <= 10'h000; end
            end
            accum7: begin
                if(operation_rfd[4:0] == 5'h1f) operation_nd[4:0] <= 5'h1f;
                if(data_permit) begin
                a[0] <= o_buf[2]; b[0] <= o_buf[3]; 
                a[1] <= o_buf[4]; b[1] <= o_buf[5]; 
                a[2] <= o_buf[6]; b[2] <= o_buf[7]; 
                a[3] <= o_buf[8]; b[3] <= o_buf[9]; 
                a[4] <= o_buf[0]; b[4] <= o_buf[1];  
                end;
                if(rdy[4:0] == 5'h1f) begin operation_nd[4:0] <= 5'h00; end
            end
            accum8: begin
                if(operation_rfd[2:0] == 3'h7)  operation_nd[2:0] <= 3'h7;
                if(data_permit) begin
                a[0] <= o_buf[1]; b[0] <= o_buf[2]; 
                a[1] <= o_buf[0]; b[1] <= o_buf[3]; 
                a[2] <= o_buf[4]; b[2] <= im_array[168]; 
                end;
                if(rdy[2:0] == 3'h7) begin operation_nd[2:0] <= 3'h0; end 
            end
            accum9: begin
                if(operation_rfd[0] == 1'b1)  operation_nd[0] <= 1'b1;
                if(data_permit) begin
                a[0] <= o_buf[0]; b[0] <= o_buf[1];  
                end;
                if(rdy[0] == 1'b1) begin operation_nd[0] <= 1'b0; end
            end
            accum10: begin
                if(operation_rfd[0] == 1'b1) operation_nd[0] <= 1'b1;
                if(data_permit) begin
                a[0] <= o_buf[0]; b[0] <= o_buf[2]; 
                end;
                if(rdy[0] == 1'b1) begin operation_nd[0] <= 1'b0; end
            end
            division: begin
                if(operation_rfd_div) operation_nd_div <= 1;
                div_a <= o_buf[0]; 
                if(rdy_div) begin operation_nd_div <= 0; pool_valid <= 1; om <= result_div; end
            end
            default:    begin
            end
        endcase
    end
end
endmodule