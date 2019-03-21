import numpy as np
import os
import ok
import struct
import time

np.set_printoptions(suppress=True, precision=4, threshold=np.inf)

bit_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/top.bit'
command_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/command.txt'
weight_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/weight.npz'
image_directory = 'C:/Users/shish/source/repos/FusionAccel/scripts/tmp/data.npy'
RUN = 0
SANITY = 1
test_mode = RUN

class host:
	def __init__(self):
		# All memory size should be multiple of 512
		self.blocksize = 512
		self.readsize = 4096
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
		return 
		
	def reset_cmd_fifo(self):
		self.xem.SetWireInValue(0x00, 0x0004) #ep00wire[2], reset fifo
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) # clear ep00wire
		self.xem.UpdateWireIns()
	
	def reset_blob_ram(self):
		self.xem.SetWireInValue(0x00, 0x0001) #ep00wire[0], reset fifo
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) # clear ep00wire
		self.xem.UpdateWireIns()

	def reset_result_fifo(self):
		self.xem.SetWireInValue(0x00, 0x0002) #ep00wire[1], reset fifo
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000) # clear ep00wire
		self.xem.UpdateWireIns()

	def loadCommands(self):
		print("[INITIAL]", "Setting Commands...")
		self.reset_cmd_fifo()
		self.xem.SetWireInValue(0x01, 0x001d) # cmd_size
		self.xem.UpdateWireIns()
		self.xem.WriteToBlockPipeIn(0x80, self.blocksize, self.command) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()

	def loadWeights_Bias(self, bias_bytes, weight_bytes): # bias: integer(hex), weight_bytes: bytes
		tmp_weight = bytearray()
		tmp_weight = tmp_weight + weight_bytes
		tmp_bias = bytearray()
		tmp_bias = tmp_bias + bias_bytes
		self.reset_blob_ram()
		self.xem.WriteToBlockPipeIn(0x82, self.blocksize, tmp_weight) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()
		self.xem.WriteToBlockPipeIn(0x83, self.blocksize, tmp_bias) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()

	def loadGemm(self, gemm_bytes):
		tmp = bytearray()
		tmp = tmp + gemm_bytes
		self.reset_blob_ram()
		self.xem.UpdateWireIns()
		self.xem.WriteToBlockPipeIn(0x81, self.blocksize, tmp) # Notes: Write buf must be times of blocksize
		self.xem.UpdateWireOuts()

	def gemm_magic(self, data, gemm, kernel):
		# print("[MAGIC]", "      GEMM data shape:", data.shape)
		tmp_data = data[gemm:gemm+kernel,:,:]
		# if(gemm == 0):
			# print("magic data: ", tmp_data)
		# print(tmp_data.shape)

		tmp_data = tmp_data.transpose((1,0,2)) # transpose and get the first gemm
		# print(tmp_data.shape)
		
		tmp = np.dstack((tmp_data.reshape(-1), np.zeros_like(tmp_data.reshape(-1)))) # padding zero for fp16
		# print(tmp.shape)
		tmp = tmp.reshape(-1)
		# print(tmp.shape)
		gemm_data = tmp.tobytes() + bytearray((int(len(tmp.reshape(-1).tobytes())/512)+1)*512-int(len(tmp.reshape(-1).tobytes())))
		# print("[MAGIC]", "  Reshaped data shape:", len(gemm_data))
		return gemm_data

	def planar_magic(self, data, gemm, kernel, num):
		tmp_data = data[gemm:gemm+kernel,:,num:num+8]
		# print(tmp_data.shape)
		# print(tmp_data)
		tmp_data = tmp_data.transpose((1,0,2)) # transpose and get the first gemm
		print(tmp_data.shape)
		print(tmp_data)
		tmp = np.dstack((tmp_data.reshape(-1), np.zeros_like(tmp_data.reshape(-1)))) # padding zero for fp16
		# print(tmp.shape)
		tmp = tmp.reshape(-1)
		# print(tmp.shape)
		gemm_data = tmp.tobytes() + bytearray((int(len(tmp.reshape(-1).tobytes())/512)+1)*512-int(len(tmp.reshape(-1).tobytes())))
		# print("[MAGIC]", "  Reshaped data shape:", len(gemm_data))
		return gemm_data

	def wb_magic(self, layer, number):
		bias = self.bias[layer][number:number+8].astype(dtype=np.float16)
		tmp_bias = np.dstack((bias.reshape(-1), np.zeros_like(bias.reshape(-1)))).astype(dtype=np.float16) # pad 16-bit zero for fp16
		bias_data = tmp_bias.reshape(-1).tobytes() + bytearray((int(len(tmp_bias.reshape(-1).tobytes())/512)+1)*512-int(len(tmp_bias.reshape(-1).tobytes())))
		# print("[MAGIC]", "Reshaped weight shape:", len(bias_data))

		# print("[MAGIC]", "   Layer weight shape:", self.weight[layer].shape)
		weight = self.weight[layer][number:number+8]
		# print("[MAGIC]", "    GEMM weight shape:", weight.shape)
		weight = weight.transpose((0,1,3,2,4)) # transpose and get the first gemm
		tmp_weight = np.dstack((weight.reshape(-1), np.zeros_like(weight.reshape(-1)))).astype(dtype=np.float16) # pad 16-bit zero for fp16
		weight_data = tmp_weight.reshape(-1).tobytes() + bytearray((int(len(tmp_weight.reshape(-1).tobytes())/512)+1)*512-int(len(tmp_weight.reshape(-1).tobytes())))
		# print("[MAGIC]", "Reshaped weight shape:", len(weight_data))
		return bias_data, weight_data

	def waitIrq(self):
		while True:
			self.xem.UpdateWireOuts()
			# print("[INTERRUPT]", 'wr_count = 0x%08x' % self.xem.GetWireOutValue(0x28))
			# print("[INTERRUPT]", 'gemmfinish = %d' % self.xem.GetWireOutValue(0x25))
			if self.xem.GetWireOutValue(0x25) == 0x0001:
				# print("[INTERRUPT]", "Got GEMM finish", 'timer = 0x%04x' % self.xem.GetWireOutValue(0x26), ', elapsed time = %f us' % (self.xem.GetWireOutValue(0x26)/100))
				self.xem.SetWireInValue(0x00, 0x0000) # clear ep00wire
				self.xem.UpdateWireIns()
				break
		return
	
	def readOutput(self):
		self.xem.UpdateWireOuts()
		# print("[INTERRUPT]", 'rd_count = 0x%08x' % self.xem.GetWireOutValue(0x27))
		# print("[INTERRUPT]", 'wr_count = 0x%08x' % self.xem.GetWireOutValue(0x28))
		count = self.xem.GetWireOutValue(0x27)
		# print("[PARSING]", "Reading Output...")
		self.xem.ReadFromBlockPipeOut(0xa0, self.blocksize, self.rbuf)
		self.xem.UpdateWireOuts()
		# print("[PARSING]", 'rd_count = 0x%08x' % self.xem.GetWireOutValue(0x27))
		# print("[PARSING]", 'wr_count = 0x%08x' % self.xem.GetWireOutValue(0x28))
		self.reset_result_fifo()
		result = np.copy(np.frombuffer(self.rbuf, dtype=np.float16)[0::2][0:count]).reshape(8,-1).transpose(1,0) # Return copy of results, otherwise will be changed
		return result

def main():   
	dev = host()
#----------------------------------------Run----------------------------------------#
	if test_mode == RUN:
		# read blob and store layers of weights in list, store image in bytearray
		dev.readBlob()
		layer_output = dev.image
		# initialize device
		if (False == dev.InitializeDevice()):
			exit
		else:
			# send all commands
			dev.loadCommands()
			# process, load all weights for this layer
			# gemm magic, loop start
			timestamp_0 = time.clock()
			timestamp_engine = 0
			for layer in range(0, 2):
				dev.xem.UpdateWireOuts()
				print("[INTERRUPT]", 'rd_count = 0x%08x' % dev.xem.GetWireOutValue(0x31))
				print("[INTERRUPT]", 'wr_count = 0x%08x' % dev.xem.GetWireOutValue(0x32))
				dev.xem.SetWireInValue(0x00, 0x0008) #ep00wire[3], csb reset
				dev.xem.UpdateWireIns()
				dev.xem.SetWireInValue(0x00, 0x0000)
				dev.xem.UpdateWireIns()
				dev.xem.SetWireInValue(0x00, 0x0010) #ep00wire[4], op_en
				dev.xem.UpdateWireIns()
				dev.xem.SetWireInValue(0x00, 0x0000)
				dev.xem.UpdateWireIns()
				dev.xem.UpdateWireOuts()
				command_0 = dev.xem.GetWireOutValue(0x21)
				command_1 = dev.xem.GetWireOutValue(0x22)
				op_type = (command_0 & 0x00000007)
				stride = (command_0 & 0x000000f0) >> 4
				kernel = (command_0 & 0x0000ff00) >> 8
				i_side = (command_0 & 0x00ff0000) >> 16
				o_side = (command_0 & 0xff000000) >> 24
				i_channel = (command_1 & 0x0000ffff)
				o_channel = (command_1 & 0xffff0000) >> 16
				print("[COMMANDS]", "0x%08x" % command_0)
				print("[COMMANDS]", "0x%08x" % command_1)
				print("[COMMANDS]", "  op_type %d" % op_type)
				print("[COMMANDS]", "   stride %d" % stride)
				print("[COMMANDS]", "   kernel %d" % kernel)
				print("[COMMANDS]", "   i_side %d" % i_side)
				print("[COMMANDS]", "   o_side %d" % o_side)
				print("[COMMANDS]", "i_channel %d" % i_channel)
				print("[COMMANDS]", "o_channel %d" % o_channel)
				blob = layer_output
				result_layer = []
				
				if op_type == 1:
					for number in range(0, o_channel, 8):
						# print("[DEBUG]", blob.shape)
						result = []
						gemm_bias, gemm_weight = dev.wb_magic(layer=layer, number=number)
						dev.loadWeights_Bias(gemm_bias, gemm_weight)
						for gemm in range(0, i_side-kernel+1, stride):
							# print(gemm)
							gemm_data = dev.gemm_magic(blob, gemm=gemm, kernel=kernel)
							# print(len(gemm_data))
							# load gemm data and gemm weight (whole channel), then start operation
							dev.loadGemm(gemm_data)
							dev.xem.SetWireInValue(0x00, 0x0040) # ep00wire[6], engine reset
							dev.xem.UpdateWireIns()
							dev.xem.SetWireInValue(0x00, 0x0000)
							dev.xem.UpdateWireIns()
							dev.xem.SetWireInValue(0x00, 0x0080) # ep00wire[7], engine valid
							dev.xem.UpdateWireIns()
							timestamp_1 = time.clock()
							dev.waitIrq()
							timestamp_2 = time.clock()
							timestamp_engine = timestamp_engine + timestamp_2 - timestamp_1
							tmp = dev.readOutput()
							result.append(tmp)
							# print(tmp)
							# print(tmp.shape)
						# print(len(result))
						output = np.stack(result, axis = 0)
						if(gemm == 0):
							print(output[0][0])
						# print("shape", output.shape)
						result_layer.append(output)
					layer_output = np.concatenate(result_layer, axis = 2)
				else:
					for number in range(0, i_channel, 8):
						result = []
						for gemm in range(0, i_side-kernel+1, stride):
							gemm_data = dev.planar_magic(blob, gemm=gemm, kernel=kernel, num=number)
							# load gemm data and gemm weight (whole channel), then start operation
							dev.loadGemm(gemm_data)
							dev.xem.SetWireInValue(0x00, 0x0040) # ep00wire[6], engine reset
							dev.xem.UpdateWireIns()
							dev.xem.SetWireInValue(0x00, 0x0000)
							dev.xem.UpdateWireIns()
							dev.xem.SetWireInValue(0x00, 0x0080) # ep00wire[7], engine valid
							dev.xem.UpdateWireIns()
							timestamp_1 = time.clock()
							dev.waitIrq()
							timestamp_2 = time.clock()
							timestamp_engine = timestamp_engine + timestamp_2 - timestamp_1
							tmp = dev.readOutput()
							result.append(tmp)
							# print(tmp)
							# print(tmp.shape)
						print("number_result", result[0])
						# print(len(result))
						output = np.stack(result, axis = 0)
						result_layer.append(output)
					layer_output = np.concatenate(result_layer, axis = 2)
							
				print(layer_output.shape)
			timestamp_3 = time.clock()
			# print(layer_output.shape)
			# print(layer_output)
			print("[PARSING]", "Engine elapsed", timestamp_engine)
			print("[PARSING]", "Host elapsed", str(timestamp_3-timestamp_0))
			
#------------------------------Sanity without Hardware------------------------------#
	if test_mode == SANITY:
		dev.readBlob()
		dev.gemm_magic(dev.image, 0, 3, 0, 0)

if __name__ == '__main__':
    main()