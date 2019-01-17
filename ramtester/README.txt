README.txt for RAMTester
------------------------
This sample is a simple test application for FrontPanel-enabled devices which
have an attached SDRAM.  For those of you with the XEM3001+RAM3001 combination,
it is fairly straightforward to modify the XEM3010 version to suit that
configuration.


Usage
-----
To try this sample, simply place the executable and the bitfile appropriate
to your device in the same directory.  By default, the bitfile downloaded
to the FPGA must be named "ramtest.bit"

The sample will then proceed to write the full SDRAM with random data,
then read the full array and check it against what was written.  The memory
size depends on which Opal Kelly product you have.  RAMTester will also 
test multiple devices if your product has multiple SDRAM.

A device is only accessible in one application at a time. Ensure the 
FrontPanel application is closed before running the sample.


PLL Settings
------------
To simplify the C source for RAMTester, the code simply initializes the
on-board PLL to the default EEPROM configuration that you can set using
the FrontPanel Application.  To ensure proper functionality, you should 
make the following settings in the default PLL configuration:

   XEM3005 - Output #1 should be set to 100 MHz.  All other clocks may
             be disabled.
   XEM3010 - SYS_CLK1 should be set to 100 MHz.  All other clocks may
             be disabled.
   XEM3050 - SYS_CLK1 should be set to 100 MHz.  All other clocks may
             be disabled.
   XEM5010 - No PLL - the on-board clock oscillator generates 100 MHz.
   XEM6110 - No PLL - the on-board clock oscillator generates 100 MHz.
   XEM6010 - SYS_CLK1 should be set to 100 MHz.  All other clocks may
             be disabled.


Spartan-3 devices (XEM3005, XEM3010, XEM3050)
---------------------------------------------
The HDL for the tester includes a caching SDRAM controller.  The controller
is simple and optimized for block transfers to/from SDRAM.  It is a caching
controller because it mates best with the on-chip Block RAMs within the FPGA.
With the test application, data is streamed from the PC to the device and 
stored in SDRAM.  Data is then streamed out of the SDRAM to the PC to be 
verified.

As data streams into the FPGA, it is sent directly to a FIFO.  When that FIFO
has a full page of data, the SDRAM controller writes that page to SDRAM and
increments the page address.  Reading is done similarly, when the read FIFO
has room for at least one page, the SDRAM controller reads a page from SDRAM.
This method works well because the USB interface is much slower than the 
SDRAM interface, allowing the SDRAM to keep pace.

The controller can be used for all sorts of applications including video
capture and signal acquisition.  The controller is provided as a reference
only -- you are free to use it in your own designs, but it comes with 
absolutely no guarantees!


Virtex-5 devices (XEM5010)
--------------------------
The Xilinx Memory Interface Generator (MIG) is used to create the DDR2 
controller for this design.


Spartan-6 devices (XEM6110, XEM6010)
------------------------------------
The Xilinx Memory Interface Generator (MIG) is used to create the DDR2 
controller for this design.


Cyclone IV devices (ZEM4310)
----------------------------
The Altera High Performance Controller (HPC) is used to create the DDR2
controller for this design.


Cyclone V devices (ZEM5305, ZEM5310)
------------------------------------
The Altera Hard Memory Controller is used to create the DDR3 controller
for this design. To build this sample from sources you will need to
generate this memory controller using the IP configuration wizard in Quartus.
We are unable to redistribute the output from this IP.

Please see the users manual for a walkthrough of setting up the memory
controller. Note that different versions of the IP may generate products
that are not fully compatible with this sample. Some updates may be required
to the sample to bring it up to date with the latest output from this tool.

Kintex 7 devices (XEM7350, XEM7360, XEM7010, XEM7310)
-----------------------------------------------------
The Xilinx Memory Interface Generator (MIG) is used to create the DDR3
controller for this design. To build this sample from sources you will
need to generate this memory controller using the MIG IP in Vivado.
We are unable to redistribute the output from this IP.

Please see the users manual for a walkthrough of setting up the memory
controller. Note that different versions of the IP may generate products
that are not fully compatible with this sample. Some updates may be required
to the sample to bring it up to date with the latest output from this tool.
Xilinx recommends using Vivado for designs using memory interfaces on
7-series devices.


