`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate

`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC,unpk_idx)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module conv_3x3(
    input [144 - 1:0] im,
    input [144 - 1:0] iw,
    input clk,
    input rst_n,
    input conv_ready,
    output conv_valid,
    output [15:0] om
);
    wire [15:0] im_array [0:8];
    `UNPACK_ARRAY(16, 9, im_array, im, unpk_idx_0)
    wire [15:0] iw_array [0:8];
    `UNPACK_ARRAY(16, 9, iw_array, iw, unpk_idx_1)

    wire [15:0] om_array [0:8];
    reg [15:0] om;
    wire aclk;
    reg aresetn;
    reg conv_valid;

    assign aclk = clk;
    always@(posedge clk) begin
        aresetn <= rst_n & conv_ready;
    end

    reg operation_nd_0, operation_nd_1, operation_nd_2, operation_nd_3, operation_nd_4, operation_nd_5, operation_nd_6, operation_nd_7, operation_nd_8, operation_nd_accum;
    wire operation_rfd_0, operation_rfd_1, operation_rfd_2, operation_rfd_3, operation_rfd_4, operation_rfd_5, operation_rfd_6, operation_rfd_7, operation_rfd_8, operation_rfd_accum;
    wire rdy_0, rdy_1, rdy_2, rdy_3, rdy_4, rdy_5, rdy_6, rdy_7, rdy_8, rdy_accum;

    reg sclr;
    reg ce;

    reg [15:0] i_buf_accum;
    reg [15:0] i_buf;
    wire [15:0] o_buf;

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

    accum accum_0 (.a(i_buf_accum), .b(i_buf), .operation_nd(operation_nd_accum), .operation_rfd(operation_rfd_accum), .clk(clk), 
    .sclr(sclr), .ce(ce), .result(o_buf), .underflow(underflow_accum), .overflow(overflow_accum), .invalid_op(invalid_op_accum), .rdy(rdy_accum));

    reg [3:0] count;

    always @ (posedge rdy_accum, negedge aresetn) begin
        if(!aresetn) begin
            count <= 0;
        end else begin
            if(count < 9) begin
                count <= count + 1;
            end
        end
    end
    always @ (posedge clk, negedge aresetn) begin
        if(!aresetn) begin
            operation_nd_0 <= 0; operation_nd_1 <= 0; operation_nd_2 <= 0; 
            operation_nd_3 <= 0; operation_nd_4 <= 0; operation_nd_5 <= 0; 
            operation_nd_6 <= 0; operation_nd_7 <= 0; operation_nd_8 <= 0; 
            operation_nd_accum <= 0;
            sclr <= 1;
            ce <= 1;
            conv_valid <= 0;
            i_buf_accum <= 0;
            i_buf <= 0;
        end else begin
            if(conv_ready) sclr <= 0;
            if(operation_rfd_0 == 1) operation_nd_0 <= 1;
            if(rdy_0) operation_nd_0 <= 0;
            if(operation_rfd_1 == 1) operation_nd_1 <= 1;
            if(rdy_1) operation_nd_1 <= 0;
            if(operation_rfd_2 == 1) operation_nd_2 <= 1;
            if(rdy_2) operation_nd_2 <= 0;
            if(operation_rfd_3 == 1) operation_nd_3 <= 1;
            if(rdy_3) operation_nd_3 <= 0;
            if(operation_rfd_4 == 1) operation_nd_4 <= 1;
            if(rdy_4) operation_nd_4 <= 0;
            if(operation_rfd_5 == 1) operation_nd_5 <= 1;
            if(rdy_5) operation_nd_5 <= 0;
            if(operation_rfd_6 == 1) operation_nd_6 <= 1;
            if(rdy_6) operation_nd_6 <= 0;
            if(operation_rfd_7 == 1) operation_nd_7 <= 1;
            if(rdy_7) operation_nd_7 <= 0;
            if(operation_rfd_8 == 1) operation_nd_8 <= 1;
            if(rdy_8) operation_nd_8 <= 0;

            if(operation_rfd_accum & rdy_0 & rdy_1 & rdy_2 & rdy_3 & rdy_4 & rdy_5 & rdy_6 & rdy_7 & rdy_8) begin
                operation_nd_accum <= 1;
                i_buf <= om_array[count];
            end
            if(rdy_accum) begin
                i_buf_accum <= o_buf;
                operation_nd_accum <= 0;
                if(count == 9) begin
                    conv_valid <= 1;
                    om <= o_buf;
                end
            end
        end
    end
    
endmodule
