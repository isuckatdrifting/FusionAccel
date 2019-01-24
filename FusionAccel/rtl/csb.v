//-----------------------------------------------------------------//
//--------------type----------------|----op_type----|
//-IDLE                             |      000      |
//-CONVOLUTION_1x1+ReLU Activation  |      001      |
//-CONVOLUTION_3x3+ReLU Activation  |      010      |
//-POOLING_3x3_MAX                  |      011      |
//-POOLING_13x13_AVERAGE            |      100      |
//-----------------------------------------------------------------// 
 
module csb(
    input clk,
    input rst_n,
    input [2:0] op_type,
    input op_issue,

    input conv_valid_1x1, 
    input conv_valid_3x3,
    output conv_ready,
    input pool_valid_3x3,
    output pool_ready_3x3,
    input pool_valid_13x13,
    output pool_ready_13x13,

    output dma_we,          //Weight, Image & CONV1x1
    output dma_re,          //Weight, Image & CONV1x1
    output dma_aux_we,      //CONV3x3, POOL3x3 & POOL13x13
    output dma_aux_re,      //CONV3x3, POOL3x3 & POOL13x13

    output [31:0] r_addr,
    output [7:0] r_len,
    output [31:0] w_addr,
    output irq
);

    //TODO: Command Queue & Translation in PIPEIN_FIFO
    reg conv_ready, pool_ready, dma_ready;

    always@ (posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            conv_ready <= 0;
            pool_ready <= 0;
            dma_ready <= 0;
        end else begin
            if(op_type == 3'b001 || op_type == 3'b010) conv_ready <= 1;
            if(conv_valid_1x1 & conv_valid_3x3) conv_ready <= 0;
            if(op_type == 3'b011) pool_ready_3x3 <= 1;
            if(pool_valid_3x3) pool_ready_3x3 <= 0;
            if(op_type == 3'b100) pool_ready_13x13 <= 1;
            if(pool_valid_13x13) pool_ready_13x13 <= 0;
        end
    end
    
endmodule