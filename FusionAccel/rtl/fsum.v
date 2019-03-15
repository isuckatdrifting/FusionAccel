`include "macros.vh"
module fsum(
    input           clk,
    input           rst,
    input           fsum_enable,
    output          reads_en,
    input [15:0]    bias,
    input [127:0]   data,
    input           valid,
    output [15:0]   fsum_result,
    input [15:0]    i_channel_count,
    input [7:0]    fsum_index,
    output          ready

);

//Full sum registers
reg  [15:0] 			 fsum [`MAX_O_SIDE-1:0]; //max support 128 x 128 output side
reg  [15:0] 			 fsum_a, fsum_b, fsum_result;
reg  [7:0]  			 fsum_count;
reg         			 fsum_data_valid;
reg						 fsum_data_ready;
reg		    			 fsum_ready;
reg                      ready;
reg                      reads_en;

wire operation_rfd_fsum, rdy_fsum;
wire [15:0] result_fsum;

integer a; // initialize buffer for cmac
initial begin
	for (a=0; a<`MAX_O_SIDE; a=a+1) begin
		fsum[a] <= 16'h0000;
	end
end

accum fsum_ (.a(fsum_a), .b(fsum_b), .clk(clk), .operation_nd(fsum_data_ready), .operation_rfd(operation_rfd_fsum), .result(result_fsum), .rdy(rdy_fsum));

always @(posedge clk) fsum_data_valid <= operation_rfd_fsum;
always @(posedge clk) fsum_result <= result_fsum;
always @(posedge clk) fsum_ready <= rdy_fsum;

always @ (posedge clk or posedge rst) begin
	if(rst) begin
        fsum_data_ready <= 0; fsum_a <= 16'h0000; fsum_b <= 16'h0000; fsum_count <= 8'h00; ready <= 0; reads_en <= 0;
    end else begin
        if(fsum_enable) begin
            reads_en <= 1;
            fsum_count <= 0;
        end
        if(valid) begin 
            fsum_data_ready <= 1; 
            reads_en <= 0; 
            if(i_channel_count == 0) fsum_a <= bias;
            else fsum_a <= fsum[fsum_index];
            fsum_b <= data[16*fsum_count +: 16];
        end
        if(fsum_data_ready) begin
            fsum_data_ready <= 0;
            if(fsum_count < `BURST_LEN) begin
                fsum_count <= fsum_count + 1;
            end else begin
                fsum_count <= 0;
            end
        end
        if(fsum_ready) begin
            fsum_a <= result_fsum;
            if(fsum_count < `BURST_LEN) begin
                fsum_b <= data[16*fsum_count +: 16];
                fsum_data_ready <= 1;
            end else begin
                fsum_b <= 0;
                ready <= 1;
            end
        end
        if(ready) ready <= 0;
    end
end
endmodule