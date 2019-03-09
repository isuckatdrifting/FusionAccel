import caffe
import numpy as np
import struct
import os
#np.set_printoptions(threshold=np.nan) # print the whole ndarray without abbrev
def extract_caffe_model(model, weights, output_path):
  """extract caffe model's parameters to numpy array, and write them to files
  Args:
    model: path of '.prototxt'
    weights: path of '.caffemodel'
    output_path: output path of numpy params 
  Returns:
    None
  """
  net = caffe.Net(model, caffe.TEST)
  net.copy_from(weights)
  weight_list = [] # use a list to store the weights

  if not os.path.exists(output_path):
    os.makedirs(output_path)
  #f = open(output_path + '/weight.txt', "w")
  for item in net.params.items():
    name, layer = item
    print('convert layer: ' + name)
    #=============================Print reshaped and split weights============================#
    shape = net.params[name][0].data.shape
    print(shape)
    pad = 0
    if shape[1] <= 8:
      pad = 8 - shape[1]
    for p in range(0, shape[0]):
      #f.write(str(hex(struct.unpack('<H', net.params[name][1].data.astype(dtype=np.float16)[p])[0])).replace('0x','').zfill(8)+' ') #Little-endian，Write bias
      weight_list.append(net.params[name][1].data.astype(dtype=np.float16)[p:p+1])
      padded_dat = np.pad(net.params[name][0].data[p], ((0,0),(0,0),(0,pad)), 'constant')
      if(shape[1] > 8):
        sliced_dat = np.vstack(np.dsplit(padded_dat.transpose((1,2,0)), shape[1]/8))
      else:
        sliced_dat = padded_dat
      dat = sliced_dat.astype(dtype=np.float16).reshape(-1)
      weight_list.append(dat)
      #for j in dat:
      #  f.write(str(hex(struct.unpack('<H', j)[0])).replace('0x','').zfill(8)+' ') #Little-endian, Write weights
      #f.write("\n")
  merged_dat = np.hstack(weight_list)
  print('===================')
  print(merged_dat.shape)
  np.save('./tmp/weight.npy', merged_dat)

    #=============================Print Original weights=======================================#
  '''
    num = 0
    for p in net.params[name]: #NCHW
      print(p.data.shape)
      dat = p.data.astype(dtype=np.float16).reshape(-1)
      for j in dat:
        f.write(str(hex(struct.unpack('<H', j)[0])).replace('0x','').zfill(4)+' ') #Little-endian
      print("layer %d, size = %d" % (num, p.data.size))
      num += 1
      f.write("\n")
  '''
  #f.close()

if __name__ == '__main__':
  model = '/mnt/c/Users/shish/source/repos/SqueezeNet/SqueezeNet_v1.1/deploy.prototxt'
  weights = '/mnt/c/Users/shish/source/repos/SqueezeNet/SqueezeNet_v1.1/squeezenet_v1.1.caffemodel'
  output_path = '/mnt/c/Users/shish/source/repos/FusionAccel/scripts/tmp'
  extract_caffe_model(model, weights, output_path)
