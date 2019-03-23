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
		self.blocksize = 512
		self.readsize = 4096
		self.rbuf = bytearray(self.readsize)
		self.image = np.ndarray(0)
		self.command = bytearray()
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
		print("[INITIAL]", "Loading commands", len(self.command)) 								# Actually 30 Commands x 12 Bytes
		self.command = self.command + bytearray(512-len(self.command))

		self.image = np.load(image_directory)
		self.image = self.image.astype(dtype=np.float16)
		print("[INITIAL]", "Loading Image", self.image.shape)

		print("[INITIAL]", "Loading Weights")
		weight = np.load(weight_directory)
		for i in range(0,len(weight)):
			name = 'arr_' + str(i)
			if i % 2 == 0: 																		# Weight layer
				shape = weight[name].shape 														# get shape of weight layer
				print("[INITIAL]", "original shape:", str(shape))
				pad = 0
				if shape[1] <= 8:
					pad = 8 - shape[1] 															# channel dimension
				if pad > 0:
					padded_dat = np.pad(weight[name], ((0,0),(0,pad),(0,0),(0,0)), 'constant') 	# pad at channel axis
				else:
					padded_dat = weight[name]
				print("[INITIAL]", "padded shape:\t", str(padded_dat.shape))
				tmp = padded_dat.transpose((0,2,3,1)) 											# move channel axis to the inner most
				print("[INITIAL]", "trans shape:\t", str(tmp.shape))
				sliced_dat = np.stack(np.split(tmp, tmp.shape[3]/8, axis = 3), axis = 1) 		# create a new axis after splitting
				print("[INITIAL]", "sliced shape:\t", str(sliced_dat.shape))
				
				self.weight.append(sliced_dat.astype(dtype=np.float16)) 						# byteappend all weights
			if i % 2 == 1: 																		# Bias layer
				self.bias.append(weight[name]) 													# append bias of all layers together
		print("[INITIAL]", "layers of weight = %d" % len(self.weight))
		print("[INITIAL]", "layers of bias = %d" % len(self.bias))
		return 
		
	def reset_cmd_fifo(self):
		self.xem.SetWireInValue(0x00, 0x0004) 													# ep00wire[2]
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000)
		self.xem.UpdateWireIns()
	
	def reset_blob_dma(self):
		self.xem.SetWireInValue(0x00, 0x0001) 													# ep00wire[0]
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000)
		self.xem.UpdateWireIns()

	def reset_result_fifo(self):
		self.xem.SetWireInValue(0x00, 0x0002) 													# ep00wire[1]
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000)
		self.xem.UpdateWireIns()

	def restart_engine(self):
		self.xem.SetWireInValue(0x00, 0x0040) 													# ep00wire[6], engine reset
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000)
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0080) 													# ep00wire[7], engine valid
		self.xem.UpdateWireIns()

	def loadCommands(self):
		print("[INITIAL]", "Setting Commands...")
		self.reset_cmd_fifo()
		self.xem.WriteToBlockPipeIn(0x80, self.blocksize, self.command) 						# Write buf must be times of blocksize
		self.xem.UpdateWireOuts()

	def loadLayer(self):
		self.xem.UpdateWireOuts()
		print("[INTERRUPT]", 'rd_count = 0x%08x' % self.xem.GetWireOutValue(0x31))
		print("[INTERRUPT]", 'wr_count = 0x%08x' % self.xem.GetWireOutValue(0x32))
		self.xem.SetWireInValue(0x00, 0x0008) 													# ep00wire[3], csb reset
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000)
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0010) 													# ep00wire[4], op_en
		self.xem.UpdateWireIns()
		self.xem.SetWireInValue(0x00, 0x0000)
		self.xem.UpdateWireIns()
		self.xem.UpdateWireOuts()
		command_0 = self.xem.GetWireOutValue(0x21)
		command_1 = self.xem.GetWireOutValue(0x22)
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
		return op_type, stride, kernel, i_side, o_side, i_channel, o_channel

	def loadWeights_Bias(self, bias_bytes, weight_bytes): 
		tmp_weight = bytearray() + weight_bytes
		tmp_bias = bytearray() + bias_bytes
		self.reset_blob_dma()
		self.xem.WriteToBlockPipeIn(0x82, self.blocksize, tmp_weight) 							# Write buf must be times of blocksize
		self.xem.UpdateWireOuts()
		self.xem.WriteToBlockPipeIn(0x83, self.blocksize, tmp_bias) 							# Write buf must be times of blocksize
		self.xem.UpdateWireOuts()

	def loadGemm(self, gemm_bytes):
		tmp = bytearray() + gemm_bytes
		self.reset_blob_dma()
		self.xem.WriteToBlockPipeIn(0x81, self.blocksize, tmp) 									# Write buf must be times of blocksize
		self.xem.UpdateWireOuts()

	def gemm_magic(self, data, gemm, kernel): 													# CHW to CWH(W = kernel, MEC Algorithm)
		tmp_data = data[gemm:gemm+kernel,:,:]
		tmp_data = tmp_data.transpose((1,0,2)) 													# transpose 0,1 and get the first gemm
		tmp = np.dstack((tmp_data.reshape(-1), np.zeros_like(tmp_data.reshape(-1)))) 			# padding zero for fp16
		tmp = tmp.reshape(-1)
		gemm_data = tmp.tobytes() + bytearray((int(len(tmp.tobytes())/512)+1)*512-int(len(tmp.tobytes())))
		return gemm_data

	def planar_magic(self, data, gemm, kernel, num):											# CHW to CWH(W = kernel, MEC Algorithm)
		tmp_data = data[gemm:gemm+kernel,:,num:num+8]
		tmp_data = tmp_data.transpose((1,0,2)) 													# transpose 0,1 and get the first gemm
		tmp = np.dstack((tmp_data.reshape(-1), np.zeros_like(tmp_data.reshape(-1)))) 			# padding zero for fp16
		tmp = tmp.reshape(-1)
		gemm_data = tmp.tobytes() + bytearray((int(len(tmp.tobytes())/512)+1)*512-int(len(tmp.tobytes())))
		return gemm_data

	def wb_magic(self, layer, number):															# CHW to CWH(W = kernel, Sliced, MEC Algorithm)
		bias = self.bias[layer][number:number+8].astype(dtype=np.float16)
		tmp_bias = np.dstack((bias.reshape(-1), np.zeros_like(bias.reshape(-1)))).astype(dtype=np.float16) # pad 16-bit zero for fp16
		bias_data = tmp_bias.reshape(-1).tobytes() + bytearray((int(len(tmp_bias.reshape(-1).tobytes())/512)+1)*512-int(len(tmp_bias.reshape(-1).tobytes())))
		weight = self.weight[layer][number:number+8]
		weight = weight.transpose((0,1,3,2,4)) 													# transpose 2,3 and get the first gemm
		tmp_weight = np.dstack((weight.reshape(-1), np.zeros_like(weight.reshape(-1)))).astype(dtype=np.float16) # pad 16-bit zero for fp16
		weight_data = tmp_weight.reshape(-1).tobytes() + bytearray((int(len(tmp_weight.reshape(-1).tobytes())/512)+1)*512-int(len(tmp_weight.reshape(-1).tobytes())))
		return bias_data, weight_data

	def waitIrq(self):
		while True:
			self.xem.UpdateWireOuts()
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
		count = self.xem.GetWireOutValue(0x28)
		# print("[PARSING]", "Reading Output...")
		self.xem.ReadFromBlockPipeOut(0xa0, self.blocksize, self.rbuf)
		self.xem.UpdateWireOuts()
		self.reset_result_fifo()
		result = np.copy(np.frombuffer(self.rbuf, dtype=np.float16)[0::2][0:count])					# preserve dimension of result, return copy of results to prevent being changed
		return result

def main():   
	dev = host()
	if test_mode == RUN:
		dev.readBlob()
		layer_output = dev.image
		if (False == dev.InitializeDevice()):
			exit
		else:
			dev.loadCommands() 																		# send all commands
			for layer in range(0, 2):
				op_type, stride, kernel, i_side, o_side, i_channel, o_channel = dev.loadLayer()
				blob = layer_output
				result_layer = []
				
				if op_type == 1:
					for number in range(0, o_channel, 8):
						# print("[DEBUG]", blob.shape)
						result = []
						gemm_bias, gemm_weight = dev.wb_magic(layer=layer, number=number)
						# load gemm data and gemm weight (whole channel), then start operation
						dev.loadWeights_Bias(gemm_bias, gemm_weight)
						for gemm in range(0, i_side-kernel+1, stride):
							# print(gemm)
							gemm_data = dev.gemm_magic(blob, gemm=gemm, kernel=kernel) 				#CWH. full channel
							dev.loadGemm(gemm_data)
							dev.restart_engine()							
							dev.waitIrq()
							print("conv output", gemm, number)
							tmp = dev.readOutput() 													#WC. partial channel
							# print(tmp)
							tmp = tmp.reshape(8, -1).transpose(1,0)									#CW. partial channel
							# print(tmp)
							result.append(tmp)
						# print(len(result))
						output = np.stack(result, axis = 0) 										#CWH. partial channel
						result_layer.append(output)
					layer_output = np.concatenate(result_layer, axis = 2) 							#CWH. full channel
				else:
					for number in range(0, i_channel, 8):
						result = []
						for gemm in range(0, i_side-kernel+1, stride):
							gemm_data = dev.planar_magic(blob, gemm=gemm, kernel=kernel, num=number)#CWH. partial channel
							dev.loadGemm(gemm_data)
							dev.restart_engine()
							dev.waitIrq()
							print("pool output", gemm, number)
							tmp = dev.readOutput()													#CW. partial channel
							print(tmp)
							tmp = tmp.reshape(-1, 8)
							result.append(tmp)
							print(tmp)
						# print(len(result))
						output = np.stack(result, axis = 0)											#CWH. partial channel
						result_layer.append(output)
					layer_output = np.concatenate(result_layer, axis = 2)							#CWH. full channel

				print(layer_output.shape)
			
	if test_mode == SANITY:
		dev.readBlob()
		dev.gemm_magic(dev.image, 0, 3, 0, 0)

if __name__ == '__main__':
    main()