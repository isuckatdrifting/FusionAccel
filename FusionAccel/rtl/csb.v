module csb(
    input clk,
    input rst_n,
    input op_en,

    input conv_valid_1x1, 
    output conv_ready_1x1,
    input conv_valid_3x3,
    output conv_ready_3x3,
    input pool_valid_3x3,
    output pool_ready_3x3,
    input pool_valid_13x13,
    output pool_ready_13x13,

    output dma_aux_we,      //P0: CSB & CONV1x1. P1: CONV3x3, POOL3x3 & POOL13x13
    output dma_aux_re,      //P0: CSB & CONV1x1. P1: CONV3x3, POOL3x3 & POOL13x13

    input [31:0] cmd,
    input [6:0] cmd_size,   //total command size received from okHost after loading memory.

    output [15:0] im_1x1,
    output [15:0] iw_1x1,
    output [143:0] im_3x3,
    output [143:0] iw_3x3,
    output [15:0] ib,
    output [2703:0] im_13x13,

    output [31:0] r_addr,
    output [31:0] w_addr,
    output irq
);

    //Notes: CMDs are loaded initially to SDRAM to be called multiple times.
    //Notes: DBB path is in CSB.
    //Notes: CMD Fifo: WR clock domain: c3clk0, RD clock domain: clk.

    //Compressed Commands from SDRAM
    //|----------CMD TYPE----------|
    //|     op_type: 3Bit(8Bit)    | 5Bit remained space
    //|       stride_1: 8bit       | Max line size = 224 < 256
    //|       stride_2: 16Bit      | Max surface size = image size = 224*224 = 50176 < 65536
    //|  input channel size: 16Bit |
    //| output channel size: 16Bit |
    //|  read_address_start: 32Bit |
    //|  write_back_address: 32Bit |
    //|----------------------------| Totally 128Bit

    //TODO: Command Translation from SDRAM --> FIFO i_port exposed to top, o_port called inside
    //TODO: Padding = 1
    //TODO: Multiple Channel Management, Little Endian, Jump Read --> Conv Buffer and Pooling Buffer
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

    //|---------------------type------------------------|----op_type----|
    //|IDLE                                             |      000      |
    //|CONV3x3 + ReLU Activation                        |      001      |
    //|CONV3x3(with padding) & CONV1x1 + ReLU Activation|      010      |
    //|POOLING_3x3_MAX                                  |      011      |
    //|POOLING_13x13_AVERAGE                            |      100      |
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
    localparam CMD_BURST_LEN = 4;
    localparam stride_0 = 1;
    reg cmd_burst_count;
    reg [7:0] op_type; //Actually use 3bits
    reg [7:0] stride_1;
    reg [15:0] stride_2;
    reg [15:0] ich_size;
    reg [15:0] och_size;
    reg [31:0] start_addr;

    //Translated Address Access Sequence
    reg dma_aux_re, dma_aux_we;
    reg [31:0] r_addr;
    reg [31:0] w_addr;

    //Handshake signals to submodules
    reg conv_ready_1x1, conv_ready_3x3, pool_ready_3x3, pool_ready_13x13;

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
                else next_state = finish;
            end
            finish: begin

            end
            default:
                next_state = idle;
        endcase
    end

    //    Output, non-blocking, Command issue and dma access throttle
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cmd_burst_count <= 0;
            op_type <= 8'h00;
            stride_1 <= 8'h00;
            stride_2 <= 16'h0000;
            ich_size <= 16'h0000;
            och_size <= 16'h0000;
            start_addr <= 32'h0000_0000;

            r_addr <= 32'h0000_0000;
            w_addr <= 32'h0000_0000;
            dma_aux_re <= 0;
            dma_aux_we <= 0;

            conv_ready_1x1 <= 0;
            conv_ready_3x3 <= 0;
            pool_ready_3x3 <= 0;
            pool_ready_13x13 <= 0;
        end
        else begin
            case (curr_state)
                idle: begin
                    cmd_burst_count <= CMD_BURST_LEN;
                end
                cmd_collect: begin
                    //TODO: fifo logic
                    //Split cmds from fifo into separate attributes
                    cmd_burst_count <= cmd_burst_count - 1;
                    case (cmd_burst_count)
                        1: begin op_type <= cmd[7:0]; stride_1 <= cmd[15:8]; stride_2 <= cmd[31:0]; end
                        2: begin ich_size <= cmd[15:0]; och_size <= cmd[31:16]; end
                        3: begin start_addr <= cmd; end
                        4: begin w_addr <= cmd; cmd_collect_done <= 1; end
                        default: ;
                    endcase 
                end
                cmd_issue: begin
                    cmd_burst_count <= CMD_BURST_LEN;
                    //TODO: Send out dma access signals to generate data to data port of submodules, then send out ready signals
                    case (op_type)
                        1: begin //CONV3x3
                            conv_ready_3x3 <= 1;
                            end
                        2: begin //CONV3x3(with padding) & CONV1x1 
                            conv_ready_3x3 <= 1; 
                            conv_ready_1x1 <= 1; 
                            end
                        3: begin //POOLING_3x3_MAX
                            pool_ready_3x3 <= 1; 
                            end
                        4: begin //POOLING_13x13_AVERAGE
                            pool_ready_13x13 <= 1; 
                            end
                    endcase
                end
                wait_op: begin
                    //Wait for submodules to finish --> wait for valid/done signals
                    if(conv_valid_3x3) begin conv_ready_3x3 <= 0; op_done <= 1; end
                    if(conv_valid_1x1) begin conv_ready_1x1 <= 0; op_done <= 1; end
                    if(pool_valid_3x3) begin pool_ready_3x3 <= 0; op_done <= 1; end
                    if(pool_valid_13x13) begin pool_ready_13x13 <= 0; op_done <= 1; end
                end
                finish: begin

                end
                default:  ;
            endcase
        end
    end
    
endmodule