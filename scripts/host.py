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

# np.set_printoptions(precision=4)

bit_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/top.bit'
command_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/command.txt'
weight_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/weight.npz'
image_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/data.npy'
RUN = 0
SANITY = 1
test_mode = 0

class host:
	def __init__(self):
		# All memory size should be multiple of 512
		self.blocksize = 512
		self.readsize = 1024
		self.rbuf = bytearray(self.readsize)
		# Run Parameters
		self.image = np.ndarray(0)
		self.command = bytearray()
		self.layer_weight = bytearray()
		self.bias = [] # list of numpy ndarrays
		self.weight = [] # list of numpy ndarrays
		return

	def InitializeDevice(self):
		# Open the first device we find.
		self.xem = ok.okCFrontPanel()
		if (self.xem.NoError != self.xem.OpenBySerial("")):
			print("[INITIAL]", "A device could not be opened.  Is one connected?")
			return(False)

		# Get some general information about the device.
		self.devInfo = ok.okTDeviceInfo()
		if (self.xem.NoError != self.xem.GetDeviceInfo(self.devInfo)):
			print("[INITIAL]", "Unable to retrieve device information.")
			return(False)
		print("[INITIAL]", "         Product: ", self.devInfo.productName)
		print("[INITIAL]", "Firmware version: %d.%d" % (self.devInfo.deviceMajorVersion, self.devInfo.deviceMinorVersion))
		print("[INITIAL]", "   Serial Number: %s" % self.devInfo.serialNumber)
		print("[INITIAL]", "       Device ID: %s" % self.devInfo.deviceID)
		
		self.xem.LoadDefaultPLLConfiguration()

		# Download the configuration file.
		if (self.xem.NoError != self.xem.ConfigureFPGA(bit_directory)):
			print("[INITIAL]", "FPGA configuration failed.")
			return(False)

		# Check for FrontPanel support in the FPGA configuration.
		if (False == self.xem.IsFrontPanelEnabled()):
			print("[INITIAL]", "FrontPanel support is not available.")
			return(False)
		
		print("[INITIAL]", "FrontPanel support is available.")
		return(True)
	
	def reset_cmd_fifo(self):
		self.xem.SetWireInValue(0x00, 0x0004) #ep00wire[2], reset fifo
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) # clear ep00wire
		self.xem.UpdateWireIns()
	
	def reset_dw_fifo(self):
		self.xem.SetWireInValue(0x00, 0x0001) #ep00wire[0], reset fifo
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) # clear ep00wire
		self.xem.UpdateWireIns()

	def reset_result_fifo(self):
		self.xem.SetWireInValue(0x00, 0x0002) #ep00wire[1], reset fifo
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) # clear ep00wire
		self.xem.UpdateWireIns()

	def readBlob(self):
		commandfile = open(command_directory, "r")
		for line in commandfile.readlines():
			tmp = bytearray.fromhex(line.replace('\t',' ').strip('\n'))
			self.command = self.command + tmp
		print("[INITIAL]", "Loading commands", len(self.command)) # Actually 30 Commands x 12 Bytes
		self.command = self.command + bytearray(512-len(self.command))

		self.image = np.load(image_directory)
		self.image = self.image.astype(dtype=np.float16)
		print("[INITIAL]", "Loading Image", self.image.shape)

		print("[INITIAL]", "Loading Weights")
		weight = np.load(weight_directory)
		for i in range(0,len(weight)):
			name = 'arr_' + str(i)
			self.layer_weight = bytearray()
			# Weight layer
			if i % 2 == 0:
				shape = weight[name].shape # get shape of weight layer
				print("[INITIAL]", "original shape:", str(shape))
				pad = 0
				if shape[1] <= 8:
					pad = 8 - shape[1] # channel dimension
				if pad > 0:
					padded_dat = np.pad(weight[name], ((0,0),(0,pad),(0,0),(0,0)), 'constant') # pad at channel axis
				else:
					padded_dat = weight[name]
				print("[INITIAL]", "padded shape:\t", str(padded_dat.shape))
				tmp = padded_dat.transpose((0,2,3,1)) # move channel axis to the inner most
				print("[INITIAL]", "trans shape:\t", str(tmp.shape))
				sliced_dat = np.stack(np.split(tmp, tmp.shape[3]/8, axis = 3), axis = 1) # create a new axis after splitting
				print("[INITIAL]", "sliced shape:\t", str(sliced_dat.shape))
				
				self.weight.append(sliced_dat.astype(dtype=np.float16)) # byteappend all weights
			# Bias layer
			if i % 2 == 1:
				self.bias.append(weight[name]) #append bias of all layers together
		print("[INITIAL]", "layers of weight = %d" % len(self.weight))
		print("[INITIAL]", "layers of bias = %d" % len(self.bias))

	def loadCommands(self):
		print("[INITIAL]", "Setting Commands...")
		self.reset_cmd_fifo()
		self.xem.SetWireInValue(0x01, 0x001d) # cmd_size
		self.xem.UpdateWireIns()
		self.xem.WriteToBlockPipeIn(0x80, self.blocksize, self.command) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()

	def loadWeights_Bias(self, bias, weight_bytes): # bias: integer(hex), weight_bytes: bytes
		tmp = bytearray()
		tmp = tmp + weight_bytes
		self.reset_dw_fifo()
		self.xem.SetWireInValue(0x02, bias) # bias value
		self.xem.UpdateWireIns()
		self.xem.WriteToBlockPipeIn(0x82, self.blocksize, tmp) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()

	def loadGemm(self, gemm_bytes):
		tmp = bytearray()
		tmp = tmp + gemm_bytes
		self.xem.WriteToBlockPipeIn(0x81, self.blocksize, tmp) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()
		self.xem.SetWireInValue(0x00, 0x0040) # ep00wire[6], engine reset
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0080) # ep00wire[6], engine reset
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) # clear ep00wire
		self.xem.UpdateWireIns()
		
	def startOp(self):
		self.reset_result_fifo()
		self.xem.SetWireInValue(0x00, 0x0008) #ep00wire[3], reset CSB
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) #clear ep00wire
		print("[INITIAL]", "Starting Operation...")
		self.xem.SetWireInValue(0x00, 0x0010) #ep00wire[4], op_en
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) #clear ep00wire
		self.xem.UpdateWireIns()
	
	def gemm_magic(self, data, pivot, kernel, layer, number, piece):
		tmp_bias = self.bias[layer][number].astype(dtype=np.float16).tobytes()
		hex_bias = struct.unpack("<H", tmp_bias)[0]

		print("[MAGIC]", "      GEMM data shape:", data.shape)
		tmp_data = data[pivot:pivot+kernel,:,:]
		tmp_data = tmp_data.transpose((1,0,2))
		tmp = np.dstack((tmp_data.reshape(-1), np.zeros_like(tmp_data.reshape(-1)))) # padding zero for fp16
		tmp = tmp.reshape(-1)
		gemm_data = tmp.tobytes() + bytearray((int(len(tmp.reshape(-1).tobytes())/512)+1)*512-int(len(tmp.reshape(-1).tobytes())))
		print("[MAGIC]", "  Reshaped data shape:", len(gemm_data))
		
		weight = self.weight[layer][number]
		print("[MAGIC]", "    GEMM weight shape:", weight.shape)
		weight[piece] = weight[piece].transpose((1,0,2))
		tmp_weight = np.dstack((weight[piece].reshape(-1), np.zeros_like(weight[piece].reshape(-1)))).astype(dtype=np.float16) # pad 16-bit zero for fp16
		weight_data = tmp_weight.reshape(-1).tobytes() + bytearray((int(len(tmp_weight.reshape(-1).tobytes())/512)+1)*512-int(len(tmp_weight.reshape(-1).tobytes())))
		print("[MAGIC]", "Reshaped weight shape:", len(weight_data))

		return gemm_data, hex_bias, weight_data

	def waitIrq(self):
		while True:
			self.xem.UpdateWireOuts()
			
			print("[COMMANDS]", hex(self.xem.GetWireOutValue(0x21)))
			print("[COMMANDS]", hex(self.xem.GetWireOutValue(0x22)))
			print("[COMMANDS]", hex(self.xem.GetWireOutValue(0x23)))
			print("[COMMANDS]", hex(self.xem.GetWireOutValue(0x24)))
			
			if self.xem.GetWireOutValue(0x20) == 0x0001:
				print("[INTERRUPT]", "Got Interrupt...")
				break
			if self.xem.GetWireOutValue(0x25) == 0x0001:
				print("[INTERRUPT]", "Got GEMM finish", 'timer = ' + str(hex(self.xem.GetWireOutValue(0x26))) + ', elapsed time = %f us' % (self.xem.GetWireOutValue(0x26)/100))
				break
		return
	
	def readOutput(self):
		print("[INTERRUPT]", 'rd_count = ' + str(hex(self.xem.GetWireOutValue(0x27))))
		print("[INTERRUPT]", 'wr_count = ' + str(hex(self.xem.GetWireOutValue(0x28))))
		count = self.xem.GetWireOutValue(0x27)
		print("[PARSING]", "Reading Output...")
		self.xem.ReadFromBlockPipeOut(0xa0, self.blocksize, self.rbuf)
		print(np.frombuffer(self.rbuf, dtype=np.float16)[0::2][0:count]) # Results
		self.xem.UpdateWireOuts()
		print("[PARSING]", 'rd_count = ' + str(hex(self.xem.GetWireOutValue(0x27))))
		print("[PARSING]", 'wr_count = ' + str(hex(self.xem.GetWireOutValue(0x28))))
		self.reset_result_fifo()

def main():   
	dev = host()
#----------------------------------------Run----------------------------------------#
	if test_mode == RUN:
		# read blob and store layers of weights in list, store image in bytearray
		dev.readBlob()
		blob = dev.image
		# initialize device
		if (False == dev.InitializeDevice()):
			exit
		else:
			# send all commands
			dev.loadCommands()
			# process, load all weights for this layer, --loop st
			dev.startOp()
			data, bias, weight = dev.gemm_magic(blob, 0, 3, 0, 0, 0)
			dev.loadWeights_Bias(bias, weight)
			dev.loadGemm(data)
			dev.waitIrq()
			dev.readOutput()
				# gemm magic, loop st
				# load gemm data and gemm weight (whole channel)
				# start engine operation
				# wait for engine ready and interrupt
				# read output fifo
				# --loop end (finish all channels for all weight groups)
			# --loop end (finish all layers)
			
#------------------------------Sanity without Hardware------------------------------#
	if test_mode == SANITY:
		dev.readBlob()
		dev.gemm_magic(dev.image, 0, 3, 0, 0, 0)

if __name__ == '__main__':
    main()