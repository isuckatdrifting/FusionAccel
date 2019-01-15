//-----------------------------------------------------------------//
//--------------type----------------|----op_type----|
//-IDLE                             |       000      |
//-CONVOLUTION_1x1+ReLU Activation  |       001      |
//-CONVOLUTION_3x3+ReLU Activation  |       010      |
//-POOLING_3x3_MAX                  |       011      |
//-POOLING_13x13_AVERAGE            |       100      |
//-----------------------------------------------------------------// 
 
module csb(
    input clk,
    input rst_n,
    input [2:0] op_type, //Conv+acti / Pool / MEM_READ / MEM_WRITE
    input conv_valid, 
    input pool_valid,
    input dma_valid,
    output conv_ready,
    output pool_ready,
    output dma_ready,
    output irq
);

    reg conv_ready, pool_ready, dma_ready;

    always@ (posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            conv_ready <= 0;
            pool_ready <= 0;
            dma_ready <= 0;
        end else begin
            if(op_type == 3'b001 || op_type == 3'b010) conv_ready <= 1;
            if(conv_valid) conv_ready <= 0;
            if(op_type == 3'b011 || op_type == 3'b100) pool_ready <= 1;
            if(pool_valid) pool_ready <= 0;
        end
    end
    
endmodule