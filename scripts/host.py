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

bit_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/top.bit'
weight_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/weight.txt'
image_directory = ''
test_enable = 1

class host:
	def __init__(self):
		# RamTest Parameters
		self.memsize = 128 * 1024 * 1024
		self.blocksize = 512
		self.writesize = 8 * 1024 * 1024
		self.readsize = 8 * 1024 * 1024
		self.numtests = 1
		self.num_of_rams = 1
		self.buf = bytearray(self.memsize)
		self.rbuf = bytearray(self.readsize)
		# Run Parameters
		self.commandsize = 65 * 256 # TODO: memory align and padding
		self.weightsize = 2470992 # TODO: memory align and padding
		self.imagesize = 309 * 512 # TODO: 227*227*3/512 = 154587/512 = 309...475 --> padding 37 0s at the end
		self.outputsize = 4096
		self.weight = bytearray() #dynamic array allocation
		self.image = bytearray(self.imagesize)
		self.output = bytearray(self.outputsize)
		self.command = bytearray()
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

	def readSDRAM(self, mem):
		self.reset_fifo()
		self.xem.SetWireInValue(0x00, 0x0001)
		self.xem.UpdateWireIns()
		print("Reading from memory(%d)..." % mem)
		passed = True
		for i in range(0, self.memsize, self.readsize):
			self.xem.ReadFromBlockPipeOut(0xa0 + mem, self.blocksize, self.rbuf)
			for j in range(0, self.blocksize):
				if self.buf[i+j] != self.rbuf[j]:
					'''
					for k in range(0, 8):
						print("[0x%X = 0x%02X / 0x%02X // 0x%02X\n" %(
					       i+j+k,
						   self.buf[i+j+k],
						   self.rbuf[j+k],
						   self.buf[i+j+k] ^ self.rbuf[j+k]))
					'''
					passed = False
			print(sum(self.buf[i:i+self.readsize]), ", ", sum(self.rbuf)) # Checksum
			if i == 0:
				print(self.buf[0], ", ", self.rbuf[0])
		return passed

	def loadData(self):
		self.reset_fifo()
		self.xem.SetWireInValue(0x00, 0x0002)
		self.xem.UpdateWireIns()

		print("Reading Weights from file")
		weightfile = open(weight_directory, "r")
		for line in weightfile.readlines():
			tmp = bytearray.fromhex(line.strip('\n'))
			self.weight = self.weight + tmp
			#print(len(tmp))
		print(len(self.weight))

		print("Loading Weights")
		self.buf = bytearray(os.urandom(self.memsize))
		# Notes: Write cube must be times of blocksize ------------------↓
		self.xem.WriteToBlockPipeIn(0x80, self.blocksize, self.weight[0:2470912])
		self.xem.UpdateWireOuts()
		'''
		print("Loading Image")
		for i in range(0, int(self.weightsize/self.writesize)):
			self.xem.WriteToBlockPipeIn(0x80, self.blocksize, self.image[i*self.writesize:(i+1)*self.writesize])
		self.xem.UpdateWireOuts()
		'''
	def startOp(self):
		print("Loading commands")
		commandfile = open(command_directory, "r")
		for line in commandfile.readlines():
			tmp = bytearray.fromhex(line.strip('\n'))
			self.command = self.command + tmp
		self.xem.WriteToBlockPipeIn(0x80, self.blocksize, self.command[0:1024]) # Actually 30 Commands x 24 Bytes
		self.xem.UpdateWireOuts()

		print("Resetting CSB...")
		#self.xem.SetWireInValue(0x00, 0x0008)
		#self.xem.UpdateWireIns()
		#self.xem.SetWireInValue(0x00, 0x0010)
		#self.xem.UpdateWireIns()
		pass
	
	def readOutput(self):
		self.reset_fifo()
		self.xem.SetWireInValue(0x00, 0x0001)
		self.xem.UpdateWireIns()
		print("Reading Output...")
		for i in range(0, self.outputsize, self.blocksize):
			self.xem.ReadFromBlockPipeOut(0xa0, self.blocksize, self.output)
			for j in range(0, self.blocksize):
				if j % 2 == 0:
					print("%02x" % self.output[i+j], end="")
				else:
					print("%02x" % self.output[i+j], end=" ")

def main():   
	dev = host()
	if (False == dev.InitializeDevice()):
		exit
	else:
#----------------------------------------Test---------------------------------------#
		if(test_enable):
			pass_num = 0
			fail_num = 0
			for i in range(0, dev.numtests):
				for j in range(0, dev.num_of_rams):
					dev.buf = bytearray(os.urandom(dev.memsize))
					dev.writeSDRAM(j)
					if True == dev.readSDRAM(j):
						pass_num += 1
					else:
						fail_num += 1
					print("Passed: %d  Failed: %d\n" % (pass_num, fail_num))
#----------------------------------------Run----------------------------------------#
		else:
			dev.loadData()
			#dev.startOp()
			dev.readOutput()

if __name__ == '__main__':
    main()