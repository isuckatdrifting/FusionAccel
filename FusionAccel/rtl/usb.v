`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: PhotonIC Technologies 
// Engineer: Geralt Shi
// 
// Create Date:    13:03:38 08/14/2018 
// Design Name: 
// Module Name:    Transmit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Transmit(
	input		wire 	[4:0]   	okUH,
	output	wire 	[2:0]   	okHU,
	inout		wire 	[31:0]  	okUHU,
	inout		wire         	okAA,
	input							clk,
   input    wire    			reset_n,
	input							transmit_en,
	input							enable,
	input				[23:0]	time1,
	input				[23:0]	calib1,
	input				[23:0]	calib2,
   input          [23:0]  	b_htime,
	input				[7:0] 	x_counter,
	input				[7:0]		y_counter,
	output	reg				done,
   output 	wire 	[23:0] 	b_pulsewidth
    );

wire [31:0] addra;
assign addra = {18'h0, y_counter[6:0],x_counter[6:0]};
reg [31:0] read_addrb;
wire [31:0] time1_doutb;
wire [31:0] cali1_doutb;
wire [31:0] cali2_doutb;

always@(posedge clk, negedge reset_n) begin
	if(!reset_n) begin
		read_addrb <= 0;
	end
	else begin
		if((ep1read | ep2read | ep3read) && read_addrb < 16384) begin
			read_addrb <= read_addrb + 1;
		end
		else read_addrb <= 0;
	end
end
			
// Three simple dual port rams, port A for writing, and port B for reading
ram time_ram (
  .clka(clk), // input clka
  .ena(1'b1), // input ena
  .wea({4{transmit_en}}), // input [3 : 0] wea
  .addra(addra), // input [31 : 0] addra
  .dina({8'h00,time1}), // input [31 : 0] dina
  .clkb(clk), // input clkb
  .addrb(read_addrb), // input [31 : 0] addrb
  .doutb(time1_doutb) // output [31 : 0] doutb);
);

ram cali1_ram (
  .clka(clk), // input clka
  .ena(1'b1), // input ena
  .wea({4{transmit_en}}), // input [3 : 0] wea
  .addra(addra), // input [31 : 0] addra
  .dina({8'h00,calib1}), // input [31 : 0] dina
  .clkb(clk), // input clkb
  .addrb(read_addrb), // input [31 : 0] addrb
  .doutb(cali1_doutb) // output [31 : 0] doutb
);

ram cali2_ram (
  .clka(clk), // input clka
  .ena(1'b1), // input ena
  .wea({4{transmit_en}}), // input [3 : 0] wea
  .addra(addra), // input [31 : 0] addra
  .dina({8'h00,calib2}), // input [31 : 0] dina
  .clkb(clk), // input clkb
  .addrb(read_addrb), // input [31 : 0] addrb
  .doutb(cali2_doutb) // output [31 : 0] doutb
);


wire [23:0] timeVal;
wire [23:0] calibration1Val;
wire [23:0] calibration2Val;

//---------
// Output Buffer
//---------
reg [23:0] timebuf;
reg [23:0] cali1buf;
reg [23:0] cali2buf;

always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        timebuf <= 0;
        cali1buf <= 0;
        cali2buf <= 0;
    end
    else if(transmit_en) begin
        timebuf <= time1;
        cali1buf <= calib1;
        cali2buf <= calib2;
    end
end

assign timeVal          = timebuf;
assign calibration1Val	= cali1buf;
assign calibration2Val	= cali2buf;

reg	[4:0] count;
always @(posedge clk, negedge reset_n) begin
	if(!reset_n) begin
		count <= 2'h0;
		done <= 0;
	end
	else if(enable) begin
			done <= 0;
			count <= count + 1;
			if (count == 5'd24) begin done <= 1; end
			if (count == 5'd25) begin count <= 0; done <= 0; end
	 end
end

// Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

wire	[31:0]	psWire;
wire  [31:0] time1ValWire;
wire	[31:0] cal1ValWire;
wire	[31:0] cal2ValWire;
wire [31:0] b_htimeWire;
wire [31:0] y_cntWire;
wire [31:0] x_cntWire;
wire [31:0] triggerWire;

assign triggerWire	= {24'h000000,6'b0,transmit_en,done};
assign time1ValWire = {8'h00,timeVal};
assign cal1ValWire = {8'h00,calibration1Val};
assign cal2ValWire = {8'h00,calibration2Val};

assign b_htimeWire = {8'h00, b_htime};
wire [23:0] b_pwwire;
assign b_pulsewidth = b_pwwire[23:0];
assign y_cntWire = {24'h0000, y_counter};
assign x_cntWire = {24'h0000, x_counter};

// Instantiate the okHost and connect endpoints.
wire [65*11-1:0]  okEHx;
okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE), 
	.okEH(okEH)
);

okWireOR # (.N(11)) wireOR (okEH, okEHx);
okWireIn  ep03 (.okHE(okHE),  .ep_addr(8'h03), .ep_dataout(b_pwwire));
//-----------------------------Wires for UI Panel-----------------------------//
okWireOut to60(.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h27), .ep_datain(triggerWire));
okWireOut tiVal(.okHE(okHE), .okEH(okEHx[ 1*65 +: 65 ]), .ep_addr(8'h28), .ep_datain(time1ValWire));
okWireOut cal1Val(.okHE(okHE), .okEH(okEHx[ 2*65 +: 65 ]), .ep_addr(8'h29), .ep_datain(cal1ValWire));
okWireOut cal2Val(.okHE(okHE), .okEH(okEHx[ 3*65 +: 65 ]), .ep_addr(8'h2A), .ep_datain(cal2ValWire));
okWireOut bhtime(.okHE(okHE), .okEH(okEHx[ 4*65 +: 65]), .ep_addr(8'h2B), .ep_datain(b_htimeWire));
okWireOut ycnt(.okHE(okHE), .okEH(okEHx[ 5*65 +: 65]), .ep_addr(8'h2C), .ep_datain(y_cntWire));
okWireOut xcnt(.okHE(okHE), .okEH(okEHx[ 6*65 +: 65]), .ep_addr(8'h2D), .ep_datain(x_cntWire));
//-----------------------------Data Block for Frame-----------------------------//
okPipeOut pipeOut1 (.okHE(okHE), .okEH(okEHx[ 7*65 +: 65]),  .ep_addr(8'ha0), .ep_datain(time1_doutb), .ep_read(ep1read));
okPipeOut pipeOut2 (.okHE(okHE), .okEH(okEHx[ 8*65 +: 65]),  .ep_addr(8'ha1), .ep_datain(cali1_doutb), .ep_read(ep2read));
okPipeOut pipeOut3 (.okHE(okHE), .okEH(okEHx[ 9*65 +: 65]),  .ep_addr(8'ha2), .ep_datain(cali2_doutb), .ep_read(ep3read));
okPipeOut pipeRef (.okHE(okHE), .okEH(okEHx[ 10*65 +: 65]),  .ep_addr(8'ha3), .ep_datain({32'hDEADBEEF}), .ep_read(ep4read));
endmodule
