module csb(
    input           clk,
    input           rst_n,
    input           op_en,

    input           conv_valid,
    output          conv_ready,
    input           maxpool_valid,
    output          maxpool_ready,
    input           avepool_valid,
    output          avepool_ready,

    //FIFO Interface
    input  [9:0]    cmd_fifo_wr_count,
    input  [31:0]   cmd,
    input           cmd_fifo_empty,
    input  [6:0]    cmd_size,   //total command size received from okHost after loading memory.
    output          cmd_fifo_rd_en,

    output [2:0]    op_type,
    output [15:0]   op_num,
    output [31:0]   weight_start_addr,
    output [31:0]   data_start_addr,
    output [31:0]   writeback_addr,
    output          op_run,

    output          dma_p0_reads_en,
    output          dma_p0_writes_en,
    output          dma_p1_reads_en,
    output          dma_p1_writes_en,
    output          dma_p2_reads_en,
    output          dma_p2_writes_en,
    output          dma_p3_reads_en,
    output          dma_p3_writes_en,
    
    output          irq
);
//Notes: CMDs are loaded initially to SDRAM to be called multiple times.
//Notes: DBB path is in CSB.
//Notes: CMD Fifo: WR clock domain: c3clk0, RD clock domain: clk.

//TODO: Use Img2col/MEC Convolution
//TODO: Padding = 1 --> Add 0 in memory
//TODO: Use csb to reset submodules
//TODO: Dropout Layer
//TODO: Concatenation Layer

//Compressed Commands from SDRAM
//|----------CMD TYPE----------|
//|        op_type: 3Bit       | 
//|    padding = 1: 1Bit       | 4Bit remained space
//|       stride_1: 8bit       | Max line size = 224 < 256
//|       stride_2: 16Bit      | Max surface size = image size = 224*224 = 50176 < 65536
//|  input channel size: 16Bit |
//| output channel size: 16Bit |
//|   input kernel size: 8Bit  |
//|  output kernel size: 8Bit  |
//|     op_num per cmac: 16Bit |
//|   weight_start_addr: 32Bit |
//|     data_start_addr: 32Bit |
//|  write_back_address: 32Bit |
//|----------------------------| Totally 192Bit

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

//Handshake signals to submodules
reg         conv_ready, maxpool_ready, avepool_ready;

//Command Parsing
localparam  CMD_BURST_LEN = 3'd6;
localparam  stride_0 = 1;
reg         cmd_fifo_rd_en;
reg [2:0]   cmd_burst_count;

reg [2:0]   op_type;              //Output
reg         padding;
reg [7:0]   stride_1;
reg [15:0]  stride_2;
reg [15:0]  i_channel_size;
reg [15:0]  o_channel_size;
reg [15:0]  i_kernel_size;
reg [15:0]  o_kernel_size;
reg [15:0]  op_num;              //Output
reg [31:0]  weight_start_addr;   //Output
reg [31:0]  data_start_addr;     //Output
reg [31:0]  writeback_addr;      //Output

reg [15:0]  n_count;             //TODO: n_count from 0 to op_num, step = conv kernel size, // +64 per read = +4 per read per channel
reg         op_run;                     //Output, indicating p0 transfers command or data

//DMA enable signal
reg         dma_p0_reads_en, dma_p0_writes_en, dma_p1_reads_en, dma_p1_writes_en, dma_p2_reads_en, dma_p2_writes_en, dma_p3_reads_en, dma_p3_writes_en;
reg         irq;                        //Output, interrupt signal

//State Machine
localparam  idle = 3'b000;
localparam  cmd_collect = 3'b001; //Get command from SDRAM
localparam  cmd_issue = 3'b010; //Generate DMA access commands
localparam  wait_op = 3'b011; //Get done signals from submodule macs
localparam  finish = 3'b100;

reg         cmd_collect_done;
reg         cmd_issue_done;
reg         op_done;

reg [2:0]   curr_state;
reg [2:0]   next_state;
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
        dma_p0_reads_en <= 0; dma_p1_reads_en <= 0;
        dma_p2_reads_en <= 0; dma_p3_reads_en <= 0;
    end else begin
        //Fifo logic: reads_en --> ob_we --> din->fifo --> fifo_rd_en
        //DMA Access: get command
        if(op_en) dma_p0_reads_en <= 1; //Assert to DMA readout, DMA writing data to FIFO
        if(cmd_fifo_wr_count == cmd_size * 6) begin
            dma_p0_reads_en <= 0;       //Read command
        end
        //DMA Access: get data and weight
        if(cmd_collect_done) begin
            case(op_type)
                1:begin dma_p2_reads_en <= 1; dma_p3_reads_en <= 1; end  //Conv1x1
                2:begin dma_p0_reads_en <= 1; dma_p1_reads_en <= 1; end  //Conv3x3
                3:begin dma_p0_reads_en <= 1; dma_p1_reads_en <= 1; dma_p2_reads_en <= 1; dma_p3_reads_en <= 1; end  //Conv3x3
                4:begin dma_p0_reads_en <= 1; dma_p1_reads_en <= 1; end  //Maxpool3x3
                5:begin dma_p0_reads_en <= 1; dma_p1_reads_en <= 1; end  //Avepool13x13
                default:;
            endcase
        end
        if(op_done) begin
            case(op_type)
                1:begin dma_p2_reads_en <= 0; dma_p3_reads_en <= 0; end  //Conv1x1
                2:begin dma_p0_reads_en <= 0; dma_p1_reads_en <= 0; end  //Conv3x3
                3:begin dma_p0_reads_en <= 0; dma_p1_reads_en <= 0; dma_p2_reads_en <= 0; dma_p3_reads_en <= 0; end  //Conv3x3
                4:begin dma_p0_reads_en <= 0; dma_p1_reads_en <= 0; end  //Maxpool3x3
                5:begin dma_p0_reads_en <= 0; dma_p1_reads_en <= 0; end  //Avepool13x13
                default:;
            endcase
        end
    end
end

//    Output, non-blocking, Command issue, Interface with FIFO
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cmd_fifo_rd_en <= 0;
        cmd_burst_count <= 3'd0;
        //Commands
        op_type <= 3'd0; stride_1 <= 8'h00; stride_2 <= 16'h0000;
        i_channel_size <= 16'h0000; o_channel_size <= 16'h0000;
        i_kernel_size <= 8'h00; o_kernel_size <= 8'h00; op_num <= 16'h0000;
        data_start_addr <= 32'h0000_0000;
        weight_start_addr <= 32'h0000_0000;
        writeback_addr <= 32'h0000_0000;
        op_run <= 0;
        n_count <= 16'h0000;

        conv_ready <= 0;
        maxpool_ready <= 0;
        avepool_ready <= 0;

        cmd_collect_done <= 0;
        cmd_issue_done <= 0;
        op_done <= 0;

        irq <= 0;
    end
    else begin
        case (curr_state)
            idle: begin
                cmd_burst_count <= CMD_BURST_LEN;
            end
            cmd_collect: begin
                cmd_fifo_rd_en <= 1; //Assert to FIFO, CSB reading data from FIFO            
                //Split cmds from fifo into separate attributes
                cmd_burst_count <= cmd_burst_count - 1;
                op_done <= 0;
                case (cmd_burst_count)
                    6: begin op_type <= cmd[2:0]; padding <= cmd[3]; stride_1 <= cmd[15:8]; stride_2 <= cmd[31:16]; end
                    5: begin i_channel_size <= cmd[15:0]; o_channel_size <= cmd[31:16]; end
                    4: begin i_kernel_size <= cmd[7:0]; o_kernel_size <= cmd[15:8]; op_num <= cmd[31:16]; end
                    3: begin weight_start_addr <= cmd; end
                    2: begin data_start_addr <= cmd; end
                    1: begin writeback_addr <= cmd; cmd_collect_done <= 1; cmd_fifo_rd_en <= 0; op_run <= 1; end
                    default: ;
                endcase 
            end
            cmd_issue: begin
                cmd_burst_count <= CMD_BURST_LEN;
                cmd_collect_done <= 0;
                //Notes: Send out dma access signals (addr) to get data and weight (according to op_type) to submodules (ready signals)
                case (op_type)
                    1,2,3: begin conv_ready <= 1; cmd_issue_done <= 1; end
                    4:begin maxpool_ready <= 1; cmd_issue_done <= 1; end
                    5:begin avepool_ready <= 1; cmd_issue_done <= 1; end
                    default:;
                endcase
            end
            wait_op: begin
                //Reset register in cmd_issue
                cmd_issue_done <= 0;
                //Wait for submodules to finish --> wait for valid/done signals
                if(conv_valid | maxpool_valid | avepool_valid) n_count <= n_count + 16; // n parallelism is 16
                if(n_count + 16 == o_channel_size) begin
                    if(conv_valid) begin conv_ready <= 0; end
                    if(maxpool_valid) begin maxpool_ready <= 0; end
                    if(avepool_valid) begin avepool_ready <= 0;end
                    op_done <= 1; // op_done only issues for once after the whole operation is done
                end
            end
            finish: begin
                op_run <= 0;
                op_done <= 0;
                irq <= 1;
            end
            default:  ;
        endcase
    end
end
    
endmodule