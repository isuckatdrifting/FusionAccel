'''
Host Client for FusionAccel
Functions:
- Send FP16 Caffemodel and configs
- Receive FP16 Output from FPGA
'''

import numpy as np
import os
import ok
import struct

#bit_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/ramtest.bit'
bit_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/top.bit'

class host:
	def __init__(self):
		self.memsize = 128 * 1024 * 1024
		self.blocksize = 512
		self.writesize = 8 * 1024 * 1024
		self.readsize = 8 * 1024 * 1024
		self.numtests = 10
		self.num_of_rams = 1
		self.buf = bytearray(self.memsize)
		self.rbuf = bytearray(self.readsize)
		return

	def InitializeDevice(self):
		# Open the first device we find.
		self.xem = ok.okCFrontPanel()
		if (self.xem.NoError != self.xem.OpenBySerial("")):
			print("A device could not be opened.  Is one connected?")
			return(False)

		# Get some general information about the device.
		self.devInfo = ok.okTDeviceInfo()
		if (self.xem.NoError != self.xem.GetDeviceInfo(self.devInfo)):
			print("Unable to retrieve device information.")
			return(False)
		print("         Product: " + self.devInfo.productName)
		print("Firmware version: %d.%d" % (self.devInfo.deviceMajorVersion, self.devInfo.deviceMinorVersion))
		print("   Serial Number: %s" % self.devInfo.serialNumber)
		print("       Device ID: %s" % self.devInfo.deviceID)
		
		self.xem.LoadDefaultPLLConfiguration()

		# Download the configuration file.
		if (self.xem.NoError != self.xem.ConfigureFPGA(bit_directory)):
			print("FPGA configuration failed.")
			return(False)

		# Check for FrontPanel support in the FPGA configuration.
		if (False == self.xem.IsFrontPanelEnabled()):
			print("FrontPanel support is not available.")
			return(False)
		
		print("FrontPanel support is available.")
		return(True)
	
	def reset_fifo(self):
		self.xem.SetWireInValue(0x00, 0x0004)
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000)
		self.xem.UpdateWireIns()
	
	def writeSDRAM(self, mem):
		self.reset_fifo()
		self.xem.SetWireInValue(0x00, 0x0002)
		self.xem.UpdateWireIns()
		print("Writing to memory(%d)..." % mem)
		for i in range(0, int(self.memsize/self.writesize)):
			self.xem.WriteToBlockPipeIn(0x80 + mem, self.blocksize, self.buf[i*self.writesize:(i+1)*self.writesize])
		self.xem.UpdateWireOuts()


	def testSDRAM(self, mem):
		self.reset_fifo()
		self.xem.SetWireInValue(0x00, 0x0001)
		self.xem.UpdateWireIns()
		print("Reading from memory(%d)..." % mem)
		passed = True
		for i in range(0, self.memsize, self.readsize):
			self.xem.ReadFromBlockPipeOut(0xa0 + mem, self.blocksize, self.rbuf)
			for j in range(0, self.blocksize):
				if self.buf[i+j] != self.rbuf[j]:
					for k in range(0, 8):
						print("[0x%X = 0x%02X / 0x%02X // 0x%02X\n" %(
					       i+j+k,
						   self.buf[i+j+k],
						   self.rbuf[j+k],
						   self.buf[i+j+k] ^ self.rbuf[j+k]))
					passed = False
		return passed

	def loadModel(self):
		self.reset_fifo()
	
	def readOutput(self):
		self.reset_fifo()

def main():
    
	dev = host()
	if (False == dev.InitializeDevice()):
		exit
	else:
		pass_num = 0
		fail_num = 0
		for i in range(0, dev.numtests):
			for j in range(0, dev.num_of_rams):
				dev.buf = bytearray(os.urandom(dev.memsize))
				dev.writeSDRAM(j)
				if True == dev.testSDRAM(j):
					pass_num += 1
				else:
					fail_num += 1
				print("Passed: %d  Failed: %d\n" % (pass_num, fail_num))

if __name__ == '__main__':
    main()