`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate

`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC,unpk_idx)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module conv_3x3(
    input clk,
    input rst_n,
    input [144 - 1:0] im,
    input [144 - 1:0] iw,
    input [15:0] ib,
    output [15:0] om,
    input conv_ready,
    output conv_valid
);
    wire [15:0] im_array [0:8];
    `UNPACK_ARRAY(16, 9, im_array, im, unpk_idx_0)
    wire [15:0] iw_array [0:8];
    `UNPACK_ARRAY(16, 9, iw_array, iw, unpk_idx_1)

    wire [15:0] om_array [0:8];
    reg [15:0] om;
    reg conv_valid;

    reg [8:0] operation_nd;
    wire [8:0] operation_rfd;
    wire [8:0] rdy_mult;
    wire [8:0] sclr_mult;
    wire [8:0] ce_mult;

    reg [15:0] a0,b0,a1,b1,a2,b2,a3,b3;
    wire [15:0] o_buf0, o_buf1, o_buf2, o_buf3;
    reg [3:0] operation_nd_accum;
    wire [3:0] operation_rfd_accum;
    wire [3:0] rdy_accum;
    wire [3:0] sclr_accum;
    wire [3:0] ce_accum;

    assign ce_accum = ~rdy_accum;
    assign sclr_accum = rdy_accum;
    assign ce_mult = ~rdy_mult;
    assign sclr_mult = rdy_mult;

    assign accum__finish = (rdy_accum != 4'h0)?1:0;
    assign operation__rfd = (~operation_rfd_accum == 4'h0)?1:0;
    assign data_permit = accum__finish ^ operation__rfd;
    
    localparam idle = 3'b000;
    localparam mult = 3'b001;
    localparam accum1 = 3'b010;
    localparam accum2 = 3'b011;
    localparam accum3 = 3'b100;
    localparam accum4 = 3'b101;

    multiplier mult0 (.a(im_array[0]), .b(iw_array[0]), .operation_nd(operation_nd[0]), .operation_rfd(operation_rfd[0]), .clk(clk), 
    .sclr(sclr_mult[0]), .ce(ce_mult[0]), .result(om_array[0]), .underflow(underflow_0), .overflow(overflow_0), .invalid_op(invalid_op_0), .rdy(rdy_mult[0]));
    
    multiplier mult1 (.a(im_array[1]), .b(iw_array[1]), .operation_nd(operation_nd[1]), .operation_rfd(operation_rfd[1]), .clk(clk), 
    .sclr(sclr_mult[1]), .ce(ce_mult[1]), .result(om_array[1]), .underflow(underflow_1), .overflow(overflow_1), .invalid_op(invalid_op_1), .rdy(rdy_mult[1]));
    
    multiplier mult2 (.a(im_array[2]), .b(iw_array[2]), .operation_nd(operation_nd[2]), .operation_rfd(operation_rfd[2]), .clk(clk), 
    .sclr(sclr_mult[2]), .ce(ce_mult[2]), .result(om_array[2]), .underflow(underflow_2), .overflow(overflow_2), .invalid_op(invalid_op_2), .rdy(rdy_mult[2]));

    multiplier mult3 (.a(im_array[3]), .b(iw_array[3]), .operation_nd(operation_nd[3]), .operation_rfd(operation_rfd[3]), .clk(clk), 
    .sclr(sclr_mult[3]), .ce(ce_mult[3]), .result(om_array[3]), .underflow(underflow_3), .overflow(overflow_3), .invalid_op(invalid_op_3), .rdy(rdy_mult[3]));

    multiplier mult4 (.a(im_array[4]), .b(iw_array[4]), .operation_nd(operation_nd[4]), .operation_rfd(operation_rfd[4]), .clk(clk), 
    .sclr(sclr_mult[4]), .ce(ce_mult[4]), .result(om_array[4]), .underflow(underflow_4), .overflow(overflow_4), .invalid_op(invalid_op_4), .rdy(rdy_mult[4]));

    multiplier mult5 (.a(im_array[5]), .b(iw_array[5]), .operation_nd(operation_nd[5]), .operation_rfd(operation_rfd[5]), .clk(clk), 
    .sclr(sclr_mult[5]), .ce(ce_mult[5]), .result(om_array[5]), .underflow(underflow_5), .overflow(overflow_5), .invalid_op(invalid_op_5), .rdy(rdy_mult[5]));

    multiplier mult6 (.a(im_array[6]), .b(iw_array[6]), .operation_nd(operation_nd[6]), .operation_rfd(operation_rfd[6]), .clk(clk), 
    .sclr(sclr_mult[6]), .ce(ce_mult[6]), .result(om_array[6]), .underflow(underflow_6), .overflow(overflow_6), .invalid_op(invalid_op_6), .rdy(rdy_mult[6]));

    multiplier mult7 (.a(im_array[7]), .b(iw_array[7]), .operation_nd(operation_nd[7]), .operation_rfd(operation_rfd[7]), .clk(clk), 
    .sclr(sclr_mult[7]), .ce(ce_mult[7]), .result(om_array[7]), .underflow(underflow_7), .overflow(overflow_7), .invalid_op(invalid_op_7), .rdy(rdy_mult[7]));

    multiplier mult8 (.a(im_array[8]), .b(iw_array[8]), .operation_nd(operation_nd[8]), .operation_rfd(operation_rfd[8]), .clk(clk), 
    .sclr(sclr_mult[8]), .ce(ce_mult[8]), .result(om_array[8]), .underflow(underflow_8), .overflow(overflow_8), .invalid_op(invalid_op_8), .rdy(rdy_mult[8]));

    accum accum_0 (.a(a0), .b(b0), .operation_nd(operation_nd_accum[0]), .operation_rfd(operation_rfd_accum[0]), .clk(clk), 
    .sclr(sclr_accum[0]), .ce(ce_accum[0]), .result(o_buf0), .underflow(underflow_accum0), .overflow(overflow_accum0), .invalid_op(invalid_op_accum0), .rdy(rdy_accum[0]));

    accum accum_1 (.a(a1), .b(b1), .operation_nd(operation_nd_accum[1]), .operation_rfd(operation_rfd_accum[1]), .clk(clk), 
    .sclr(sclr_accum[1]), .ce(ce_accum[1]), .result(o_buf1), .underflow(underflow_accum1), .overflow(overflow_accum1), .invalid_op(invalid_op_accum1), .rdy(rdy_accum[1]));

    accum accum_2 (.a(a2), .b(b2), .operation_nd(operation_nd_accum[2]), .operation_rfd(operation_rfd_accum[2]), .clk(clk), 
    .sclr(sclr_accum[2]), .ce(ce_accum[2]), .result(o_buf2), .underflow(underflow_accum2), .overflow(overflow_accum2), .invalid_op(invalid_op_accum2), .rdy(rdy_accum[2]));

    accum accum_3 (.a(a3), .b(b3), .operation_nd(operation_nd_accum[3]), .operation_rfd(operation_rfd_accum[3]), .clk(clk), 
    .sclr(sclr_accum[3]), .ce(ce_accum[3]), .result(o_buf3), .underflow(underflow_accum3), .overflow(overflow_accum3), .invalid_op(invalid_op_accum3), .rdy(rdy_accum[3]));

    reg [2:0] curr_state;
    reg [2:0] next_state;
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
                if(conv_ready) next_state = mult;
                else next_state = idle;
            end
            mult: begin
                if(rdy_mult == 9'h1ff) next_state = accum1;
                else next_state = mult;
            end
            accum1: begin
                if(accum__finish) next_state = accum2;
                else next_state = accum1;
            end
            accum2: begin 
                if(accum__finish) next_state = accum3;
                else next_state = accum2;
            end
            accum3: begin
                if(accum__finish) next_state = accum4;
                else next_state = accum3;
            end
            accum4: begin
                if(accum__finish) next_state = idle;
                else next_state = accum4;
            end
            default:
                next_state = idle;
        endcase
    end

//    Output，blocking
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a0 <= 0; a1 <= 0; a2 <= 0; a3 <= 0; b0 <= 0; b1 <= 0; b2 <= 0; b3 <= 0; 
        operation_nd <= 9'h000;
        operation_nd_accum <= 4'h0;
        om <= 0;
        conv_valid <= 0;
    end
    else begin
        case (curr_state)
            mult: begin
                if(operation_rfd == 9'h1ff) operation_nd <= 9'h1ff;
                if(rdy_mult == 9'h1ff) begin operation_nd <= 9'h000; end
            end
            accum1: begin
                if(operation_rfd_accum == 4'hf) begin operation_nd_accum <= 4'hf; 
                                                    a0 <= om_array[0]; b0 <= om_array[1];
                                                    a1 <= om_array[2]; b1 <= om_array[3];
                                                    a2 <= om_array[4]; b2 <= om_array[5];
                                                    a3 <= om_array[6]; b3 <= om_array[7];
                                                    end
                if(rdy_accum == 4'hf) begin operation_nd_accum <= 4'h0; end
            end
            accum2: begin
                if(operation_rfd_accum[2:0] == 3'b111) begin operation_nd_accum[1:0] <= 2'b11; 
                                                        a0 <= o_buf0; b0 <= o_buf1;
                                                        a1 <= o_buf2; b1 <= o_buf3; 
                                                        a3 <= om_array[8]; b3 <= ib; end
                if(rdy_accum[1:0] == 2'b11)  begin operation_nd_accum[1:0] <= 2'b00; end
            end
            accum3: begin
                if(operation_rfd_accum[0] == 1'b1) begin operation_nd_accum[0] <= 1'b1; a0 <= o_buf0; b0 <= o_buf1;end
                if(rdy_accum[0] == 1'b1)  begin operation_nd_accum[0] <= 1'b0; end
            end
            accum4: begin
                if(operation_rfd_accum[0] == 1'b1) begin operation_nd_accum[0] <= 1'b1; a0 <= o_buf0; b0 <= o_buf2;end
                if(rdy_accum[0] == 1'b1)  begin operation_nd_accum[0] <= 1'b0; om <= o_buf0[15]?16'h0000:o_buf0; conv_valid <= 1; end
            end
            default:  ;
        endcase
    end
end
    
endmodule

module conv_1x1(
    input clk,
    input rst_n,
    input [15:0] im,
    input [15:0] iw,
    input [15:0] ib,
    output [15:0] om,
    input conv_ready,
    output conv_valid
);
    reg [15:0] om;
    reg conv_valid;

    reg operation_nd_mult, operation_nd_accum;
    reg [15:0] a0, b0;
    wire operation_rfd_mult, operation_rfd_accum;
    wire rdy_mult, rdy_accum;
    wire sclr_mult, sclr_accum;
    wire ce_mult, ce_accum;
    wire [15:0] result, o_buf0;

    assign ce_mult = ~rdy_mult;
    assign sclr_mult = rdy_mult;
    
    localparam idle = 3'b000;
    localparam mult = 3'b001;
    localparam accum = 3'b010;

    multiplier mult0 (.a(im), .b(iw), .operation_nd(operation_nd_mult), .operation_rfd(operation_rfd_mult), .clk(clk), 
    .sclr(sclr_mult), .ce(ce_mult), .result(result), .underflow(underflow_0), .overflow(overflow_0), .invalid_op(invalid_op_0), .rdy(rdy_mult));

    accum accum_0 (.a(a0), .b(b0), .operation_nd(operation_nd_accum), .operation_rfd(operation_rfd_accum), .clk(clk), 
    .sclr(sclr_accum), .ce(ce_accum), .result(o_buf0), .underflow(underflow_accum0), .overflow(overflow_accum0), .invalid_op(invalid_op_accum0), .rdy(rdy_accum));

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
                if(conv_ready) next_state = mult;
                else next_state = idle;
            end
            mult: begin
                if(rdy_mult) next_state = accum;
                else next_state = mult;
            end
            accum: begin
                if(rdy_accum) next_state = idle;
                else next_state = accum;
            end
            default:
                next_state = idle;
        endcase
    end

//    Output，blocking
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        operation_nd_mult <= 1'b0;
        operation_nd_accum <= 1'b0;
        om <= 0;
        conv_valid <= 0;
    end
    else begin
        case (curr_state)
            mult: begin
                if(operation_rfd_mult) operation_nd_mult <= 1'b1;
                if(rdy_mult) begin operation_nd_mult <= 1'b0; end
            end
            accum: begin
                if(operation_rfd_accum) begin operation_nd_accum <= 1'b1;
                                        a0 <= result; b0 <= ib;
                                        end
                if(rdy_accum) begin operation_nd_accum <= 1'b0; om <= o_buf0[15]?16'h0000:o_buf0; conv_valid <= 1'b1; end
            end
            default:  ;
        endcase
    end
end
endmodule
