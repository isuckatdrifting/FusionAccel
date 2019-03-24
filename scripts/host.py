import numpy as np
import os
import ok
import struct
import time
import sys
np.set_printoptions(suppress=True, precision=4, threshold=sys.maxsize)

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
				print("[INITIAL]", "padded shape:\t", padded_dat.shape)
				tmp = padded_dat.transpose((0,2,3,1)) 											# move channel axis to the inner most
				print("[INITIAL]", "trans shape:\t", tmp.shape)
				sliced_dat = np.stack(np.split(tmp, tmp.shape[3]/8, axis = 3), axis = 1) 		# create a new axis after splitting
				print("[INITIAL]", "sliced shape:\t", sliced_dat.shape)
				
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
		command_2 = self.xem.GetWireOutValue(0x23)
		op_type = (command_0 & 0x00000007)
		stride = (command_0 & 0x000000f0) >> 4
		kernel = (command_0 & 0x0000ff00) >> 8
		i_side = (command_0 & 0x00ff0000) >> 16
		o_side = (command_0 & 0xff000000) >> 24
		i_channel = (command_1 & 0x0000ffff)
		o_channel = (command_1 & 0xffff0000) >> 16
		id = (command_2 & 0x000000c0) >> 6
		total = (command_2 & 0x00000030) >> 4
		padding = (command_2 & 0x0000000f)
		print("[COMMANDS]", "0x%08x" % command_0)
		print("[COMMANDS]", "0x%08x" % command_1)
		print("[COMMANDS]", "  op_type %d" % op_type)
		print("[COMMANDS]", "   stride %d" % stride)
		print("[COMMANDS]", "   kernel %d" % kernel)
		print("[COMMANDS]", "   i_side %d" % i_side)
		print("[COMMANDS]", "   o_side %d" % o_side)
		print("[COMMANDS]", "i_channel %d" % i_channel)
		print("[COMMANDS]", "o_channel %d" % o_channel)
		print("[COMMANDS]", "  slot id %d" % id)
		print("[COMMANDS]", "    total %d" % total)
		print("[COMMANDS]", "  padding %d" % padding)
		return op_type, stride, kernel, i_side, o_side, i_channel, o_channel, id, total, padding

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

	def gemm_magic(self, data, gemm, kernel, layer): 													# CHW to CWH(W = kernel, MEC Algorithm)
		tmp_data = data[gemm:gemm+kernel,:,:]
		# print("GEMM DEBUG", tmp_data.shape)
		tmp_data = np.stack(np.split(tmp_data, tmp_data.shape[2]/8, axis = 2), axis = 0) 		# slice the data by i_channel/8, create a new axis after splitting
		# print("GEMM DEBUG", tmp_data.shape)
		tmp_data = tmp_data.transpose((0,2,1,3)) 												# transpose 0,1 and get the first gemm
		# print("GEMM DEBUG", tmp_data.shape)
		# print(tmp_data)
		# if(layer == 3 and gemm == 0):
			# np.save("gemm_data.npy", tmp_data)
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
		# print("WB DEBUG", self.weight[layer].shape)
		weight = self.weight[layer][number:number+8]
		# print("WB DEBUG", weight.shape)
		weight = weight.transpose((0,1,3,2,4)) 													# transpose 2,3 and get the first gemm
		# print("WB DEBUG", weight.shape)
		# if(layer == 3 and number == 0):
			# np.save("gemm_weight.npy", weight)
		tmp_weight = np.dstack((weight.reshape(-1), np.zeros_like(weight.reshape(-1)))).astype(dtype=np.float16) # pad 16-bit zero for fp16
		weight_data = tmp_weight.reshape(-1).tobytes() + bytearray((int(len(tmp_weight.reshape(-1).tobytes())/512)+1)*512-int(len(tmp_weight.reshape(-1).tobytes())))
		return bias_data, weight_data

	def waitIrq(self):
		while True:
			self.xem.UpdateWireOuts()
			if self.xem.GetWireOutValue(0x25) == 0x0001:
				# print("[INTERRUPT]", "Got GEMM finish", 'timer = 0x%04x' % self.xem.GetWireOutValue(0x26), ', elapsed time = %f us' % (self.xem.GetWireOutValue(0x26)/100))
				self.xem.SetWireInValue(0x00, 0x0000) 											# clear ep00wire, reset engine valid
				self.xem.UpdateWireIns()
				break
		return
	
	def readOutput(self):
		self.xem.UpdateWireOuts()
		# print("[INTERRUPT]", 'rd_count = 0x%08x' % self.xem.GetWireOutValue(0x27))
		count = self.xem.GetWireOutValue(0x28)
		# print("[INTERRUPT]", 'wr_count = 0x%08x' % count)
		self.xem.ReadFromBlockPipeOut(0xa0, self.blocksize, self.rbuf)
		self.xem.UpdateWireOuts()
		self.reset_result_fifo()
		result = np.copy(np.frombuffer(self.rbuf, dtype=np.float16)[0::2][0:count])				# preserve dimension of result, return copy of results to prevent being changed
		return result

def main():   
	dev = host()
	if test_mode == RUN:
		dev.readBlob()
		layer_output = dev.image
		if (False == dev.InitializeDevice()):
			exit
		else:
			dev.loadCommands() 																	# send all commands
			weight_layer = 0
			slot = []
			for layer in range(0, 30):
				op_type, stride, kernel, i_side, o_side, i_channel, o_channel, id, total, padding = dev.loadLayer()
				if padding > 0:
					# print("padding debug")
					# print(layer_output)
					blob = np.pad(layer_output, ((padding, padding), (padding, padding), (0,0)), 'constant')
					# print("padding debug")
					# print(blob)
				else:
					blob = layer_output
				result_layer = []
				
				if op_type == 1:
					for number in range(0, o_channel, 8):
						result = []
						gemm_bias, gemm_weight = dev.wb_magic(layer=weight_layer, number=number)
						dev.loadWeights_Bias(gemm_bias, gemm_weight)							# load gemm data and gemm weight (whole channel), then start operation
						for gemm in range(0, i_side-kernel+2*padding+stride, stride):
							gemm_data = dev.gemm_magic(blob, gemm=gemm, kernel=kernel, layer=weight_layer) 			# CWH. full channel
							dev.loadGemm(gemm_data)
							dev.restart_engine()							
							dev.waitIrq()
							# print("conv output", gemm, number)
							tmp = dev.readOutput() 												# WC. partial channel
							# print(tmp)
							tmp = tmp.reshape(8, -1).transpose(1,0)								# CW. partial channel
							# print(tmp)
							result.append(tmp)
						output = np.stack(result, axis = 0) 									# CWH. partial channel
						result_layer.append(output)
					slot_output = np.concatenate(result_layer, axis = 2) 						# CWH. full channel
					weight_layer += 1
				else:
					for number in range(0, i_channel, 8):
						result = []
						for gemm in range(0, i_side-kernel+2*padding+stride, stride):
							gemm_data = dev.planar_magic(blob, gemm=gemm, kernel=kernel, num=number)# CWH. partial channel
							dev.loadGemm(gemm_data)
							dev.restart_engine()
							dev.waitIrq()
							# print("pool output", gemm, number)
							tmp = dev.readOutput()												# CW. partial channel
							# print(tmp)
							tmp = tmp.reshape(-1, 8)
							# print(tmp)
							result.append(tmp)
						output = np.stack(result, axis = 0)										# CWH. partial channel
						result_layer.append(output)
					slot_output = np.concatenate(result_layer, axis = 2)						# CWH. full channel
				# print(slot_output)
				# print(slot_output.shape)
				slot.append(slot_output)
				if id == total:
					layer_output = np.concatenate(slot, axis = 2)
					slot = []
					if layer >= 28:
						print(layer_output.shape)
						print(layer_output)
		layer_output = layer_output.reshape(-1).astype(dtype=np.float)
		output_prob = np.exp(layer_output)/sum(np.exp(layer_output))
		print(output_prob)
		print('predicted class is: ', output_prob.argmax())
		# load ImageNet Labels
		labels_file = 'C:/Users/shish/source/repos/FusionAccel/scripts/synset_words.txt'

		labels = np.loadtxt(labels_file, str, delimiter = '\t')

		print('output label:', labels[output_prob.argmax()])

		top_inds = np.argsort(-output_prob.reshape(-1))[0:5] # reverse sort and take five largest items
			
	if test_mode == SANITY:
		dev.readBlob()
		dev.gemm_magic(dev.image, 0, 3, 0, 0)

if __name__ == '__main__':
    main()