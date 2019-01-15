module top(
    ///////////////////////////////////////
	// Front Panel Interface
	//////////////////////////////////////
	input  wire [4:0]   okUH,
	output wire [2:0]   okHU,
	inout  wire [31:0]  okUHU,
	inout  wire         okAA,
	input  wire         sys_clkp,
	input  wire         sys_clkn,
	output [7:0]   led
);

//------------------------Clock PLL and ODDR2------------------------------//

//-------------------------LED Stage Monitor-------------------------------//

//--------------v1, Minimum Hardware Cores for SqueezeNet------------------//
csb csb_(
    .clk(clk),
    .rst_n(rst_n),
    .op_type(op_type),
    .conv_valid(conv_valid),
    .pool_valid(pool_valid),
    .dma_valid(dma_valid),
    .conv_ready(conv_ready),
    .pool_ready(pool_ready),
    .dma_ready(dma_ready),
    .irq(irq)
); //Control Bus for all cores

conv_3x3 conv_(
    .im(im),
    .iw(iw),
    .clk(clk),
    .rst_n(rst_n),
    .conv_ready(conv_ready),
    .conv_valid(conv_valid),
    .om(om)
); //Convolutional Core

pool pool_(); //Pooling Core

dma dma_(
    .clk(clk),
    .rst_n(rst_n),
    .addr(addr),
    .dma_ready(dma_ready),
    .dma_valid(dma_valid),
    .data(data)
); //Direct Memory Access Core

//------------------------------------------------
// Send to PC using Front Panel(TM)
//------------------------------------------------
usb usb_(
    //USB3.0 Bus
    .okUH(okUH), 
    .okHU(okHU), 
    .okUHU(okUHU), 
    .okAA(okAA), 
    .clk(sys_clk),
    .reset_n(reset_n), 
	.transmit_en(transmit_valid),
    .enable(transmit_valid),
    //Data bus
    //TODO: Define CSB and Data path buses
    .time1(time1), 
    .calib1(calib1), 
    .calib2(calib2),
    .b_htime(b_htime), 
    .done(transmit_done),
    .b_pulsewidth(b_pulsewidth),
	.y_counter(y_counter),
	.x_counter(x_counter)
); //USB Slave

//--------------v2, More complicate Cores for Other Function and Networks--//
//reshape reshape_(); //Memory Reshape and Concatenation Core
//acti acti_(); //Activation Core
//lut lut_(); //Loop up table for activation and lrn cores
//lrn lrn_(); //Local response normalization Core

endmodule