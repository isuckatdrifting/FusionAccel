module csb # (
    parameter CMD_BURST_LEN = 3'd8
)
(
    input           clk,
    input           rst,
    input           op_en,

    input           conv_valid,
    output          conv_ready,
    input           maxpool_valid,
    output          maxpool_ready,
    input           avepool_valid,
    output          avepool_ready,

    //FIFO Interface
    input           dma_p1_ob_we,
    input  [31:0]   cmd,
    input  [6:0]    cmd_size,   //total command size received from okHost after loading memory.
    output          dma_p1_reads_en,

    output [2:0]    op_type,
    output          padding,
    output [3:0]    stride,
    output [19:0]   op_num,
    output [31:0]   data_start_addr,
    output [31:0]   weight_start_addr,
    output [31:0]   result_start_addr,
    output [3:0]    kernel_size,
    output [7:0]    o_side_size,
    output [15:0]   i_surf_size,
    output          engine_reset,

    output          irq
);
//Notes: CMDs are loaded initially to SDRAM to be called multiple times.
//Notes: CMD Fifo: WR clock domain: c3clk0, RD clock domain: clk.
//Notes: Use Img2col(MEC) Convolution

//TODO: Padding = 1 --> totally 9 conditions.

//Compressed Commands from SDRAM    |MEM-Block|---------Address---------|---Space--|---Used-Space---|
//|----------CMD TYPE----------|    |---------|-------------------------|----------|----------------|
//|        op_type:  3Bit(1Bit)|    |   Cmd   | 0x000_0000 - 0x000_007f |    128   |                |
//|    padding = 1:  1Bit(3Bit)|    |  Weight | 0x000_1000 - 0x009_D3FF |1280k / 2 |1231552+CONVBIAS|
//|         stride:  4Bit(4Bit)|    |  Image  | 0x00A_0000 - 0x00B_1F1B | 147k / 2 |                |
//|      op_center: 16Bit      |    |  Outbuf | 0x00C_0000 - 0x7ff_ffff | 125M-128 |    3071416     |
//|      op_corner: 16Bit      |    |---------|-------------------------|----------|----------------|
//|        op_side: 16Bit      |
//|  input channel size: 16Bit |    
//| output channel size: 16Bit |    
//|         kernel size:  8Bit |    |---------------------type------------------------|----op_type----|
//|     input side size:  8Bit |    |IDLE                                             |      000      |
//|    output side size:  8Bit |    |CONV1x1 + ReLU Activation                        |      001      |
//|  input surface size: 16Bit |    |CONV3x3 + ReLU Activation                        |      010      |
//| output surface size: 16Bit |    |CONV3x3(with padding) & CONV1x1 + ReLU Activation|      011      |
//|   weight_start_addr: 32Bit |    |Max Pooling                                      |      100      |
//|     data_start_addr: 32Bit |    |Average Pooling                                  |      101      |
//|  write_back_address: 32Bit |    |-------------------------------------------------|---------------| 
//|-------Totally 256Bit-------|    

//Handshake signals to submodules
reg         conv_ready, maxpool_ready, avepool_ready;

//Command Parsing
reg [3:0]   cmd_burst_count;
reg         dma_p1_reads_en;

//Commands
reg [2:0]   op_type;                    //Output
reg         padding;
reg [3:0]   stride;
reg [15:0]  op_num;                     //Output
reg [15:0]  op_num_center;
reg [15:0]  op_num_corner;
reg [15:0]  op_num_side;
reg [15:0]  i_channel_size, o_channel_size;
reg [7:0]   kernel_size, i_side_size, o_side_size;
reg [15:0]  i_surf_size, o_surf_size;
reg [31:0]  weight_start_addr;
reg [31:0]  data_start_addr;
reg [31:0]  result_start_addr;                //Output

reg [7:0]   done_width_count;           // from 0 to o_side_size
reg [15:0]  done_surf_count;            // from 0 to o_surf_size
reg [15:0]  done_channel_count;         // from 0 to o_channel_size, step = PARA = 16
reg [6:0]   done_cmd_count;
reg         engine_reset;

reg         irq;                        //Output, interrupt signal

//State Machine
localparam  idle = 3'b000;
localparam  cmd_get = 3'b001; //Get command from SDRAM
localparam  cmd_issue = 3'b010; //Generate DMA access commands
localparam  op_run = 3'b011; //Get done signals from submodule macs
localparam  finish = 3'b100;
// State jump triggers
reg         cmd_collect_done;
reg         cmd_issue_done;
reg         op_done;

reg [2:0]   curr_state;
reg [2:0]   next_state;
//    Current State, non-blocking
always @ (posedge clk or posedge rst)    begin
    if (rst)
        curr_state    <= idle;
    else
        curr_state    <= next_state;
end

//    Status Jump, blocking
always @ (*) begin
    next_state = idle;    //    Initialize
    case (curr_state)
        idle: begin
            if(op_en) next_state = cmd_get;
            else next_state = idle;
        end
        cmd_get: begin
            if(cmd_collect_done) next_state = cmd_issue;
            else next_state = cmd_get;
        end
        cmd_issue: begin
            if(cmd_issue_done) next_state = op_run;
            else next_state = cmd_issue;
        end
        op_run: begin
            if(op_done) begin
                if(done_cmd_count == cmd_size) next_state = finish;
                else next_state = cmd_get;
            end
            else next_state = op_run;
        end
        finish: begin

        end
        default:
            next_state = idle;
    endcase
end

//    Output, non-blocking, Command issue, Interface with FIFO
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        cmd_burst_count <= 4'd0;
        //Commands
        op_type <= 3'd0; stride <= 4'h0; padding <= 1'b0; op_num_center <= 16'h0000;
        op_num_corner <= 16'h0000; op_num_side <= 16'h0000;
        i_channel_size <= 16'h0000; o_channel_size <= 16'h0000;
        i_side_size <= 8'h00; o_side_size <= 8'h00; kernel_size <= 8'h00;
        i_surf_size <= 16'h0000; o_surf_size <= 16'h0000;
        data_start_addr <= 32'h0000_0000;
        weight_start_addr <= 32'h0000_0000;
        result_start_addr <= 32'h0000_0000;
        dma_p1_reads_en <= 0;

        op_num <= 16'h0000;
        done_width_count <= 8'h00; done_surf_count <= 16'h0000; 
        done_channel_count <= 16'h0000; done_cmd_count <= 8'd0;
        conv_ready <= 0; maxpool_ready <= 0; avepool_ready <= 0;
        cmd_collect_done <= 0; cmd_issue_done <= 0; op_done <= 0;

        engine_reset <= 1;
        irq <= 0;
    end else begin
        case (curr_state)
            idle: begin
                cmd_burst_count <= CMD_BURST_LEN;
            end
            cmd_get: begin
                engine_reset <= 1;
                dma_p1_reads_en <= 1;
                if(dma_p1_ob_we) begin
                    cmd_burst_count <= cmd_burst_count - 1;
                end
                case (cmd_burst_count) //Split cmds from fifo into separate attributes
                    8: begin op_type <= cmd[2:0]; padding <= cmd[4]; stride <= cmd[11:8]; op_num_center <= cmd[31:16]; end
                    7: begin op_num_corner <= cmd[15:0]; op_num_side <= cmd[31:16]; end
                    6: begin i_channel_size <= cmd[15:0]; o_channel_size <= cmd[31:16]; end
                    5: begin i_side_size <= cmd[7:0]; o_side_size <= cmd[15:8]; kernel_size <= cmd[23:16]; end
                    4: begin i_surf_size <= cmd[15:0]; o_surf_size <= cmd[31:16]; end
                    3: begin weight_start_addr <= cmd; end
                    2: begin data_start_addr <= cmd; end
                    1: begin result_start_addr <= cmd; cmd_collect_done <= 1; dma_p1_reads_en <= 0; end
                    default: ;
                endcase
                op_done <= 0;
            end
            cmd_issue: begin
                engine_reset <= 0;
                cmd_burst_count <= CMD_BURST_LEN;
                cmd_collect_done <= 0;
                //Notes: Send out dma access signals(ready, addr) to submodules according to op_type to get data and weight
                op_num <= op_num_center; // three op_num* are the same. TODO: check if these variables are necessary.
                case (op_type)
                    1,2,3: begin conv_ready <= 1; cmd_issue_done <= 1; end
                    4:begin maxpool_ready <= 1; cmd_issue_done <= 1; end
                    5:begin avepool_ready <= 1; cmd_issue_done <= 1; end
                    default:;
                endcase
            end
            op_run: begin
                cmd_issue_done <= 0; //Reset the registers in cmd_issue and wait for submodules to finish
                if(conv_valid | maxpool_valid | avepool_valid) begin
                    done_surf_count <= done_surf_count + 1; 
                    // Notes: in-convolution next-row logic in engine
                    done_width_count <= done_width_count + 1;
                end
                if(done_surf_count + 1 == o_surf_size) begin
                    done_channel_count <= done_channel_count + 16; // parallelism is 16
                    done_surf_count <= 0;
                    done_width_count <= 0;
                end
                if(done_channel_count + 16 == o_channel_size) begin
                    if(conv_valid) begin conv_ready <= 0; end
                    if(maxpool_valid) begin maxpool_ready <= 0; end
                    if(avepool_valid) begin avepool_ready <= 0;end
                    op_done <= 1; // op_done only issues for once after the whole operation is done
                    done_cmd_count <= done_cmd_count + 1;
                end
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