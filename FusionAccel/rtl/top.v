module top(

);

csb csb_(); //Control Bus for all cores
lut lut_(); //Loop up table for activation and lrn cores
conv conv_(); //Convolutional Core
acti acti_(); //Activation Core
pool pool_(); //Pooling Core
lrn lrn_(); //Local response normalization Core
reshape reshape_(); //Memory Reshape Core
dma dma_(); //Direct Memory Access Core
usb usb_(); //USB Slave
endmodule

module conv(

);

endmodule

module acti(

);

endmodule

module pool(

);

endmodule

module lrn(

);

endmodule

module reshape(

);

endmodule

module dma(

);

endmodule