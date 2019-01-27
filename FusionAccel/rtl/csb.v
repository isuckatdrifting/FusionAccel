module csb(
    input clk,
    input rst_n,
    input op_en,

    input conv_valid,
    output conv_ready,
    input maxpool_valid,
    output maxpool_ready,
    input avepool_valid,
    output avepool_ready,

    output dma_aux_we,      //P0: CSB & CONV1x1. P1: CONV3x3, POOL3x3 & POOL13x13
    output dma_aux_re,      //P0: CSB & CONV1x1. P1: CONV3x3, POOL3x3 & POOL13x13
    //FIFO Interface
    input [31:0] cmd,
    output cmd_fifo_rd_en,
    input cmd_fifo_empty,
    input [6:0] cmd_size,   //total command size received from okHost after loading memory.

    input [31:0] data,
    output data_fifo_rd_en,
    output [15:0] im,
    
    input [31:0] weightbias,
    output weight_fifo_rd_en,
    output [15:0] iw,
    output [15:0] ib,

    output [31:0] r_addr,
    output [31:0] w_addr,

    output p0_reads_en,
    output p0_writes_en,
    output p1_reads_en,
    output p1_writes_en,
    input cmd_fifo_wr_count,
    output irq
);

    //Notes: CMDs are loaded initially to SDRAM to be called multiple times.
    //Notes: DBB path is in CSB.
    //Notes: CMD Fifo: WR clock domain: c3clk0, RD clock domain: clk.

    //Compressed Commands from SDRAM
    //|----------CMD TYPE----------|
    //|        op_type: 3Bit       | 
    //|    padding = 1: 1Bit       | 4Bit remained space
    //|       stride_1: 8bit       | Max line size = 224 < 256
    //|       stride_2: 16Bit      | Max surface size = image size = 224*224 = 50176 < 65536
    //|  input channel size: 16Bit |
    //| output channel size: 16Bit |
    //|   input kernel size: 16Bit |
    //|  output kernel size: 16Bit |
    //|   weight_start_addr: 32Bit |
    //|     data_start_addr: 32Bit |
    //|  write_back_address: 32Bit |
    //|----------------------------| Totally 160Bit

    //TODO: Command Translation from SDRAM --> Command Buffer
    //TODO: Use Img2col/MEC Convolution
    //TODO: Bias Operation in Conv is incorrect. Add bias after conv all channels.!!!!
    //TODO: Padding = 1 --> Add 0 in memory
    //TODO: Multiple Channel Management, Little Endian, Jump Read --> Conv Buffer and Pooling Buffer
    //TODO: Use csb to reset submodules
    //TODO: CONV3x3 CONV 1x1 Parallelism
    //TODO: Dropout Layer
    //TODO: Concatenation Layer
    //TODO: CONV3x3 Optimization

    //|MEM-Block|---------Address---------|---Space--|---Used-Space---|
    //|---------|-------------------------|----------|----------------|
    //|   Cmd   | 0x000_0000 - 0x000_007f |    128   |                |
    //|  Weight | 0x000_1000 - 0x009_D3FF |1280k / 2 |1231552+CONVBIAS|
    //|  Image  | 0x00A_0000 - 0x00B_1F1B | 147k / 2 |                |
    //|  Outbuf | 0x00C_0000 - 0x7ff_ffff | 125M-128 |    3071416     |
    //|---------|-------------------------|----------|----------------|

    //|---------------------type------------------------|----op_type----|
    //|IDLE                                             |      000      |
    //|CONV1x1 + ReLU Activation                        |      001      |
    //|CONV3x3 + ReLU Activation                        |      010      |
    //|CONV3x3(with padding) & CONV1x1 + ReLU Activation|      011      |
    //|POOLING_3x3_MAX                                  |      100      |
    //|POOLING_13x13_AVERAGE                            |      101      |
    //|-------------------------------------------------|---------------| 

    //State Machine
    localparam idle = 3'b000;
    localparam cmd_collect = 3'b001; //Get cmd from SDRAM
    localparam cmd_issue = 3'b010; //Generate DMA access commands
    localparam wait_op = 3'b011; //Get done signals from submodule macs
    localparam finish = 3'b100;

    reg cmd_collect_done;
    reg cmd_issue_done;
    reg op_done;

    //Command Parsing
    localparam CMD_BURST_LEN = 6;
    localparam stride_0 = 1;
    reg cmd_fifo_rd_en;
    reg [2:0] cmd_burst_count;
    reg [2:0] op_type; //Actually use 3bits
    reg padding;
    reg [7:0] stride_1;
    reg [15:0] stride_2;
    reg [15:0] ich_size;
    reg [15:0] och_size;
    reg [15:0] ikn_size;
    reg [15:0] okn_size;
    reg [31:0] data_start_addr;
    reg [31:0] weight_start_addr;
    reg [31:0] op_num; //0-1048576, Max op num = 512000 @ conv10

    //Translated Address Access Sequence
    reg dma_aux_re, dma_aux_we;
    reg [31:0] r_addr;
    reg [31:0] w_addr;

    reg [31:0] data_burst_count;
    reg [31:0] wb_burst_count;
    
    reg data_fifo_rd_en;
    reg weight_fifo_rd_en;
    reg [15:0] im;
    reg [15:0] iw;
    reg [15:0] ib;

    //Handshake signals to submodules
    reg conv_ready, maxpool_ready, avepool_ready;

    reg irq;

    reg [2:0] curr_state;
    reg [2:0] next_state;
    //    Current State, non-blocking
    always @ (posedge clk or negedge rst_n)    begin
        if (!rst_n)
            curr_state    <= idle;
        else
            curr_state    <= next_state;
    end

    //    Status Jump, blocking
    always @ (*) begin
        next_state = idle;    //    Initialize
        case (curr_state)
            idle: begin
                if(op_en) next_state = cmd_collect;
                else next_state = idle;
            end
            cmd_collect: begin
                if(cmd_collect_done) next_state = cmd_issue;
                else next_state = cmd_collect;
            end
            cmd_issue: begin
                if(cmd_issue_done) next_state = wait_op;
                else next_state = cmd_issue;
            end
            wait_op: begin
                if(op_done) begin
                    if(cmd_fifo_empty) next_state = finish;
                    else next_state = cmd_collect;
                end
                else next_state = wait_op;
            end
            finish: begin

            end
            default:
                next_state = idle;
        endcase
    end

    //DMA Accesss commands
    always @ (posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            p0_reads_en <= 0;
            p1_reads_en <= 0;
        end else begin
            //Fifo logic: reads_en --> ob_we --> din->fifo --> fifo_rd_en
            if(op_en) p0_reads_en <= 1; //Assert to DMA readout, DMA writing data to FIFO
            if(p0_wr_data_count == cmd_size * 5) begin
                p0_reads_en <= 0;       //Read command
            end
            if(cmd_collect_done) begin
                p0_reads_en <= 1;   //Read data
                if(op_type == 3'd1 || op_type == 3'd2) begin p1_reads_en <= 1; end  //Read weight
                //TODO: reset p0_reads_en
            end

        end
    end

    //    Output, non-blocking, Command issue, Interface with FIFO
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cmd_fifo_rd_en <= 0;
            cmd_burst_count <= 3'd0;
            op_type <= 3'd0;
            stride_1 <= 8'h00;
            stride_2 <= 16'h0000;
            ich_size <= 16'h0000;
            och_size <= 16'h0000;
            ikn_size <= 16'h0000;
            okn_size <= 16'h0000;
            data_start_addr <= 32'h0000_0000;
            weight_start_addr <= 32'h0000_0000;

            r_addr <= 32'h0000_0000;
            w_addr <= 32'h0000_0000;
            dma_aux_re <= 0;
            dma_aux_we <= 0;

            conv_ready <= 0;
            maxpool_ready <= 0;
            avepool_ready <= 0;

            cmd_collect_done <= 0;
            cmd_issue_done <= 0;
            op_done <= 0;

            data_burst_count <= 32'd0;
            wb_burst_count <= 32'd0;

            data_fifo_rd_en <= 0;
            weight_fifo_rd_en <= 0;
            im <= 16'h0000;
            iw <= 16'h0000;
            ib <= 16'h0000;

            irq <= 0;
        end
        else begin
            case (curr_state)
                idle: begin
                    cmd_burst_count <= CMD_BURST_LEN;
                    data_burst_count <= 0;
                    wb_burst_count <= 0;
                end
                cmd_collect: begin
                    cmd_fifo_rd_en <= 1; //Assert to FIFO, CSB reading data from FIFO            
                    //Split cmds from fifo into separate attributes
                    cmd_burst_count <= cmd_burst_count - 1;
                    op_done <= 0;
                    case (cmd_burst_count)
                        6: begin op_type <= cmd[2:0]; padding <= cmd[3]; stride_1 <= cmd[15:8]; stride_2 <= cmd[31:16]; end
                        5: begin ich_size <= cmd[15:0]; och_size <= cmd[31:16]; end
                        4: begin ikn_size <= cmd[15:0]; okn_size <= cmd[31:16]; end
                        3: begin weight_start_addr <= cmd; end
                        2: begin data_start_addr <= cmd; end
                        1: begin w_addr <= cmd; cmd_collect_done <= 1; cmd_fifo_rd_en <= 0; end
                        default: ;
                    endcase 
                end
                cmd_issue: begin
                    cmd_burst_count <= CMD_BURST_LEN;
                    cmd_collect_done <= 0;
                    //TODO: Send out dma access signals to get data to submodules, then send out ready signals
                    data_fifo_rd_en <= 1;
                    weight_fifo_rd_en <= 1;
                    data_burst_count <= data_burst_count + 1;
                    wb_burst_count <= wb_burst_count + 1;
                    //TODO: Set data and weight access according to op_type
                    //Port0: data, Port1: weight
                    case (op_type)
                        1:if(wb_burst_count == 0) begin
                                conv_ready <= 1;
                                cmd_issue_done <= 1;
                            end
                        2:if(wb_burst_count == 0) begin
                                conv_ready <= 1;
                                cmd_issue_done <= 1;
                            end
                        3:if(wb_burst_count == 0) begin
                                conv_ready <= 1; 
                                //TODO: dual channel conv_ready
                                cmd_issue_done <= 1;
                            end
                        4:if(data_burst_count == 0) begin
                                maxpool_ready <= 1;
                                cmd_issue_done <= 1;
                            end
                        5:if(data_burst_count == 0) begin
                                avepool_ready <= 1;
                                cmd_issue_done <= 1;
                            end
                        default:;
                    endcase
                end
                wait_op: begin
                    //Reset register in cmd_issue
                    cmd_issue_done <= 0;
                    data_burst_count <= 0;
                    wb_burst_count <= 0;
                    //Wait for submodules to finish --> wait for valid/done signals
                    if(conv_valid) begin conv_ready <= 0; op_done <= 1; end
                    if(maxpool_valid) begin maxpool_ready <= 0; op_done <= 1; end
                    if(avepool_valid) begin avepool_ready <= 0; op_done <= 1; end
                end
                finish: begin
                    op_done <= 0;
                    irq <= 1;
                end
                default:  ;
            endcase
        end
    end
    
endmodule