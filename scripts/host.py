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

np.set_printoptions(precision=4)

bit_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/top.bit'
command_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/command.txt'
weight_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/weight.npz'
image_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/data.npy'
RUN = 0
SANITY = 1
test_mode = 1

class host:
	def __init__(self):
		# All memory size should be multiple of 512
		self.blocksize = 512
		self.readsize = 1024
		self.rbuf = bytearray(self.readsize)
		# Run Parameters
		self.image = bytearray()
		self.command = bytearray()
		self.layer_weight = bytearray()
		self.bias = [] # list of numpy ndarrays
		self.weight = [] # list of ?
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
		self.xem.SetWireInValue(0x00, 0x0004) #ep00wire[2], reset fifo
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000)
		self.xem.UpdateWireIns()
	
	def readBlob(self):
		print("Loading commands")
		commandfile = open(command_directory, "r")
		for line in commandfile.readlines():
			tmp = bytearray.fromhex(line.replace('\t',' ').strip('\n'))
			self.command = self.command + tmp
		print(len(self.command)) # Actually 30 Commands x 32 Bytes
		# print(self.command)
		self.command = self.command + bytearray(1024-len(self.command))

		print("Loading Weights")
		weight = np.load(weight_directory)
		i = 0
		for i in range(0,len(weight)):
			name = 'arr_' + str(i)
			self.layer_weight = bytearray()
			# Weight layer
			if i % 2 == 0:
				shape = weight[name].shape # get shape of weight layer
				print(shape)
				pad = 0
				if shape[1] <= 8:
					pad = 8 - shape[1] # channel dimension
				for p in range(0, shape[0]):
					padded_dat = np.pad(weight[name][p], ((0,0),(0,0),(0,pad)), 'constant')
					if(shape[1] > 8):
						sliced_dat = np.vstack(np.dsplit(padded_dat.transpose((1,2,0)), shape[1]/8))
					else:
						sliced_dat = padded_dat
					# print(sliced_dat.shape)
					# print(sliced_dat)
				self.layer_weight = self.layer_weight.join(bytearray.fromhex(str(hex(struct.unpack('<H', j)[0]))[2:].zfill(8)) for j in sliced_dat.reshape(-1).astype(dtype=np.float16))
				print(self.layer_weight)
				self.weight.append(self.layer_weight) # byteappend all weights
			# Bias layer
			if i % 2 == 1:
				self.bias.append(weight[name]) #append bias of all layers together
				print(weight[name])

		print("Loading Image")
		data = np.load(image_directory)
		print(data.shape)
		self.image = self.image.join(bytearray.fromhex(str(hex(struct.unpack('<H', j)[0]))[2:].zfill(8)) for j in data.reshape(-1))
		print(len(self.image))

	def loadBlob(self):
		self.reset_fifo()
		self.xem.SetWireInValue(0x00, 0x0002) #ep00wire[1], write memblock
		self.xem.UpdateWireIns()
		self.xem.WriteToBlockPipeIn(0x80, self.blocksize, self.command) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()
		self.xem.WriteToBlockPipeIn(0x81, self.blocksize, self.image) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()
		self.xem.WriteToBlockPipeIn(0x82, self.blocksize, self.weight) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()
		
	def startOp(self):
		print("Resetting CSB...")
		self.xem.SetWireInValue(0x01, 0x001d) #cmd_size
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0008) #ep00wire[3], reset CSB
		self.xem.UpdateWireIns()
		print("Starting Operation...")
		self.xem.SetWireInValue(0x00, 0x0010) #ep00wire[4], op_en
		self.xem.UpdateWireIns()

	def waitIrq(self):
		i = 0
		while True:
			i = i + 1
			if i == 10000: 
				i = 0
				print("Querying")
			self.xem.UpdateWireOuts()
			
			print("=========COMMANDS===========")
			print(hex(self.xem.GetWireOutValue(0x20)))
			print(hex(self.xem.GetWireOutValue(0x21)))
			print(hex(self.xem.GetWireOutValue(0x22)))
			print(hex(self.xem.GetWireOutValue(0x23)))
			
			if self.xem.GetWireOutValue(0x20) != 0x0000:
				print("Got Interrupt...")
				break
		return
	
	def readOutput(self):
		self.reset_fifo()
		self.xem.SetWireInValue(0x00, 0x0001) #ep00wire[0], read memblock
		self.xem.UpdateWireIns()
		print("Reading Output...")
		self.xem.ReadFromBlockPipeOut(0xa0, self.blocksize, self.rbuf)
		print('block sum', sum(self.rbuf)) # Checksum

def main():   
	dev = host()
#----------------------------------------Run----------------------------------------#
	if test_mode == RUN:
		dev.readBlob()
		if (False == dev.InitializeDevice()):
			exit
		else:
			dev.loadBlob()
			dev.startOp()
			dev.waitIrq()
			dev.readOutput()
#------------------------------Sanity without Hardware------------------------------#
	if test_mode == SANITY:
		dev.readBlob()

if __name__ == '__main__':
    main()