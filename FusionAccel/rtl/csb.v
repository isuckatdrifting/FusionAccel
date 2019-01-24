//-------------------------------------------------//
//|-------------type----------------|----op_type----|
//|IDLE                             |      000      |
//|CONV3x3 + ReLU Activation        |      001      |
//|CONV3x3 & CONV1x1+ReLU Activation|      010      |
//|POOLING_3x3_MAX                  |      011      |
//|POOLING_13x13_AVERAGE            |      100      |
//|-------------------------------------------------| 
 
module csb(
    input clk,
    input rst_n,
    input [2:0] op_type,
    input op_issue,

    input conv_valid_1x1, 
    output conv_ready_1x1,
    input conv_valid_3x3,
    output conv_ready_3x3,
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

    //TODO: Command Queue (FIFO) & Translation in PIPEIN_FIFO
    //TODO: Multiple Channel Management, Little Endian, Jump Read
    //TODO: Use ep00wire to reset csb
    //TODO: Use csb to reset submodules
    //TODO: CONV3x3 CONV 1x1 Parallelism
    //TODO: Dropout Layer
    //TODO: Concatenation Layer
    //TODO: CONV3x3 Optimization
    //|MEM-Block|---------Address---------|---Space--|---Used-Space---|
    //|---------|-------------------------|----------|----------------|
    //|   Cmd   | 0x000_0000 - 0x000_007f |    128   |                |
    //|  Weight | 0x000_1000 - 0x028_0FFF |1280k x 2 |1231552+CONVBIAS|
    //|  Image  | 0x029_0000 - 0x02d_9800 | 147k x 2 |     150528     |
    //|  Outbuf | 0x02e_0000 - 0x7ff_ffff | 125M-128 |    3071416     |
    //|---------|-------------------------|----------|----------------|

    reg conv_ready_1x1, conv_ready_3x3, pool_ready_3x3, pool_ready13x13;
    reg dma_we, dma_re, dma_aux_we, dma_aux_re;
    reg [31:0] r_addr, w_addr;
    reg [7:0] r_len;

    always@ (posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            conv_ready_1x1 <= 0;
            conv_ready_3x3 <= 0;
            pool_ready_3x3 <= 0;
            pool_ready_13x13 <= 0;
            r_addr <= 32'h0000_0000;
            r_len <= 8'h00;
            w_addr <= 32'h0000_0000;
        end else begin
            if(op_type == 3'b001) conv_ready_3x3 <= 1;
            if(op_type == 3'b010) begin conv_ready_3x3 <= 1; conv_ready_1x1 <= 1;
            if(conv_valid_3x3) conv_ready_3x3 <= 0;
            if(conv_valid_1x1) conv_ready_1x1 <= 0;
            if(op_type == 3'b011) pool_ready_3x3 <= 1;
            if(pool_valid_3x3) pool_ready_3x3 <= 0;
            if(op_type == 3'b100) pool_ready_13x13 <= 1;
            if(pool_valid_13x13) pool_ready_13x13 <= 0;
        end
    end
    
endmodule