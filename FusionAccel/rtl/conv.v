`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate

`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC,unpk_idx)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module conv_3x3(
    input clk,
    input rst_n,
    input [144 - 1:0] im,
    input [144 - 1:0] iw,
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
    wire aclk;
    reg conv_valid;

    reg operation_nd_0, operation_nd_1, operation_nd_2, operation_nd_3, operation_nd_4, operation_nd_5, operation_nd_6, operation_nd_7, operation_nd_8;
    wire operation_rfd_0, operation_rfd_1, operation_rfd_2, operation_rfd_3, operation_rfd_4, operation_rfd_5, operation_rfd_6, operation_rfd_7, operation_rfd_8, operation_rfd_accum;
    wire rdy_0, rdy_1, rdy_2, rdy_3, rdy_4, rdy_5, rdy_6, rdy_7, rdy_8, rdy_accum0, rdy_accum1, rdy_accum2, rdy_accum3;

    reg sclr;
    reg ce;
    reg [15:0] a0,b0,a1,b1,a2,b2,a3,b3;
    wire [15:0] o_buf0, o_buf1, o_buf2, o_buf3;
    reg operation_nd_accum0, operation_nd_accum1, operation_nd_accum2, operation_nd_accum3;

    localparam idle = 4'b0000;
    localparam mult = 4'b0001;
    localparam accum1 = 4'b0010;
    localparam accum2 = 4'b0011;
    localparam accum3 = 4'b0100;
    localparam accum4 = 4'b0101;
    localparam finish = 4'b0110;

    multiplier mult0 (.a(im_array[0]), .b(iw_array[0]), .operation_nd(operation_nd_0), .operation_rfd(operation_rfd_0), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[0]), .underflow(underflow_0), .overflow(overflow_0), .invalid_op(invalid_op_0), .rdy(rdy_0));
    
    multiplier mult1 (.a(im_array[1]), .b(iw_array[1]), .operation_nd(operation_nd_1), .operation_rfd(operation_rfd_1), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[1]), .underflow(underflow_1), .overflow(overflow_1), .invalid_op(invalid_op_1), .rdy(rdy_1));
    
    multiplier mult2 (.a(im_array[2]), .b(iw_array[2]), .operation_nd(operation_nd_2), .operation_rfd(operation_rfd_2), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[2]), .underflow(underflow_2), .overflow(overflow_2), .invalid_op(invalid_op_2), .rdy(rdy_2));

    multiplier mult3 (.a(im_array[3]), .b(iw_array[3]), .operation_nd(operation_nd_3), .operation_rfd(operation_rfd_3), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[3]), .underflow(underflow_3), .overflow(overflow_3), .invalid_op(invalid_op_3), .rdy(rdy_3));

    multiplier mult4 (.a(im_array[4]), .b(iw_array[4]), .operation_nd(operation_nd_4), .operation_rfd(operation_rfd_4), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[4]), .underflow(underflow_4), .overflow(overflow_4), .invalid_op(invalid_op_4), .rdy(rdy_4));

    multiplier mult5 (.a(im_array[5]), .b(iw_array[5]), .operation_nd(operation_nd_5), .operation_rfd(operation_rfd_5), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[5]), .underflow(underflow_5), .overflow(overflow_5), .invalid_op(invalid_op_5), .rdy(rdy_5));

    multiplier mult6 (.a(im_array[6]), .b(iw_array[6]), .operation_nd(operation_nd_6), .operation_rfd(operation_rfd_6), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[6]), .underflow(underflow_6), .overflow(overflow_6), .invalid_op(invalid_op_6), .rdy(rdy_6));

    multiplier mult7 (.a(im_array[7]), .b(iw_array[7]), .operation_nd(operation_nd_7), .operation_rfd(operation_rfd_7), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[7]), .underflow(underflow_7), .overflow(overflow_7), .invalid_op(invalid_op_7), .rdy(rdy_7));

    multiplier mult8 (.a(im_array[8]), .b(iw_array[8]), .operation_nd(operation_nd_8), .operation_rfd(operation_rfd_8), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(om_array[8]), .underflow(underflow_8), .overflow(overflow_8), .invalid_op(invalid_op_8), .rdy(rdy_8));

    accum accum_0 (.a(a0), .b(b0), .operation_nd(operation_nd_accum0), .operation_rfd(operation_rfd_accum0), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(o_buf0), .underflow(underflow_accum0), .overflow(overflow_accum0), .invalid_op(invalid_op_accum0), .rdy(rdy_accum0));

    accum accum_1 (.a(a1), .b(b1), .operation_nd(operation_nd_accum1), .operation_rfd(operation_rfd_accum1), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(o_buf1), .underflow(underflow_accum1), .overflow(overflow_accum1), .invalid_op(invalid_op_accum1), .rdy(rdy_accum1));

    accum accum_2 (.a(a2), .b(b2), .operation_nd(operation_nd_accum2), .operation_rfd(operation_rfd_accum2), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(o_buf2), .underflow(underflow_accum2), .overflow(overflow_accum2), .invalid_op(invalid_op_accum2), .rdy(rdy_accum2));

    accum accum_3 (.a(a3), .b(b3), .operation_nd(operation_nd_accum3), .operation_rfd(operation_rfd_accum3), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(o_buf3), .underflow(underflow_accum3), .overflow(overflow_accum3), .invalid_op(invalid_op_accum3), .rdy(rdy_accum3));


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
                    next_state = mult;
                else
                    next_state = idle;
            end
            mult: begin
                if(rdy_0 & rdy_1 & rdy_2 & rdy_3 & rdy_4 & rdy_5 & rdy_6 & rdy_7 & rdy_8) begin
                    next_state = accum1;
                    sclr = 1;
                end
                else begin
                    next_state = mult;
                    sclr = 0;
                end
            end
            accum1: begin
                if(rdy_accum0 & rdy_accum1 & rdy_accum2 & rdy_accum3) begin
                    next_state = accum2;
                    sclr = 1;
                end
                else begin
                    next_state = accum1;
                    sclr = 0;
                end
            end
            accum2: begin 
                if(rdy_accum0 & rdy_accum1) begin
                    next_state = accum3;
                    sclr = 1;
                end
                else begin
                    next_state = accum2;
                    sclr = 0;
                end
            end
            accum3: begin
                if(rdy_accum0) begin
                    next_state = accum4;
                    sclr = 1;
                end
                else begin
                    next_state = accum3;
                    sclr = 0;
                end
            end
            accum4: begin
                if(rdy_accum0) begin
                    next_state = finish;
                    sclr = 1;
                end
                else begin
                    next_state = accum4;
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
        ce <= 0;
        conv_valid <= 0;
    end
    else begin
        case (curr_state)
            mult: begin
                ce <= 1; operation_nd_0 <= 1; operation_nd_1 <= 1; operation_nd_2 <= 1;
                operation_nd_3 <= 1; operation_nd_4 <= 1; operation_nd_5 <= 1; 
                operation_nd_6 <= 1; operation_nd_7 <= 1; operation_nd_8 <= 1; 
                if(rdy_0) operation_nd_0 <= 0;
                if(rdy_1) operation_nd_1 <= 0;
                if(rdy_2) operation_nd_2 <= 0;
                if(rdy_3) operation_nd_3 <= 0;
                if(rdy_4) operation_nd_4 <= 0;
                if(rdy_5) operation_nd_5 <= 0;
                if(rdy_6) operation_nd_6 <= 0;
                if(rdy_7) operation_nd_7 <= 0;
                if(rdy_8) operation_nd_8 <= 0;
            end
            accum1: begin
                ce <= 1; operation_nd_accum0 <= 1; operation_nd_accum1 <= 1; operation_nd_accum2 <= 1; operation_nd_accum3 <= 1;
                a0 <= om_array[0]; b0 <= om_array[1]; 
                a1 <= om_array[2]; b1 <= om_array[3]; 
                a2 <= om_array[4]; b2 <= om_array[5]; 
                a3 <= om_array[6]; b3 <= om_array[7];
                if(rdy_accum0) begin
                    operation_nd_0 <= 0;
                end
                if(rdy_accum1) begin
                    operation_nd_1 <= 0;
                end
                if(rdy_accum2) begin 
                    operation_nd_2 <= 0;
                end
                if(rdy_accum3) begin
                    operation_nd_3 <= 0;
                end
            end

            accum2: begin
                ce <= 1; operation_nd_accum0 <= 1; operation_nd_accum1 <= 1;
                a0 <= o_buf0; b0 <= o_buf1; 
                a1 <= o_buf2; b1 <= o_buf3; 
                if(rdy_accum0) begin
                    operation_nd_0 <= 0;
                end
                if(rdy_accum1) begin
                    operation_nd_1 <= 0;
                end
            end

            accum3: begin
                ce <= 1; operation_nd_accum0 <= 1;
                a0 <= o_buf0; b0 <= o_buf1; 
                if(rdy_accum0) begin
                    operation_nd_0 <= 0;
                end
            end

            accum4: begin
                ce <= 1; operation_nd_accum0 <= 1;
                a0 <= o_buf0; b0 <= om_array[8]; 
                if(rdy_accum0) begin
                    operation_nd_0 <= 0;
                    om <= o_buf0;
                end
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

    //TODO: Make Accum Pipelines
endmodule
