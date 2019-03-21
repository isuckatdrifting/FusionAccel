module scmp( //max pooling
    input  wire         clk,
    input  wire         rst,
    input  wire         fifo_empty,
    output reg          reads_en,
    input  wire [7:0]   kernel_size,
    input  wire [15:0]  data,
    input  wire         data_ready,
    output reg          data_valid,
    output reg  [15:0]  scmp_result,
    output reg          scmp_ready
);

reg [15:0]  a_cmp, b_cmp;
wire        result_cmp;
wire        operation_rfd_cmp;
wire        rdy;
reg [7:0]   count;

// Output is high if a > b

comparator cmp_ (.a(a_cmp), .b(b_cmp), .clk(clk), .operation_nd(data_ready), .operation_rfd(operation_rfd_cmp), .result(result_cmp), .rdy(rdy));

localparam idle 		= 0;
localparam busy         = 1;

reg [1:0] curr_state;
reg [1:0] next_state;

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
            if(!fifo_empty) next_state = busy;
            else next_state = idle;
        end
		busy: begin
            if(scmp_ready) next_state = idle;
            else next_state = busy;
        end
    endcase
end
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        a_cmp <= 16'h0000; b_cmp <= 16'h0000;
        scmp_ready <= 0;
        scmp_result <= 0;
        data_valid <= 0;
        count <= 0;
        reads_en <= 0;
    end else begin
        case(curr_state)
            idle: begin
                if(!fifo_empty) reads_en <= 1;     
                scmp_ready <= 0;    
            end
            busy: begin
                data_valid <= operation_rfd_cmp;
                if(reads_en) reads_en <= 0;
                if(data_ready) begin 
                    if(count == 0) begin
                        a_cmp <= data; b_cmp <= 0; 
                    end else begin
                        a_cmp <= data; b_cmp <= result_cmp? a_cmp: b_cmp;
                    end
                end
                if(rdy) begin
                    if(count + 1 < kernel_size) begin
                        count <= count + 1;
                        reads_en <= 1;
                    end else begin
                        count <= 0;
                        scmp_ready <= 1;
                    end
                end
                if(scmp_ready) begin
                    scmp_ready <= 0;
                    scmp_result <= result_cmp? a_cmp: b_cmp;
                end
            end
        endcase
    end
end
endmodule