import caffe
import numpy as np
import struct
import os
np.set_printoptions(threshold=np.nan) 
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

  if not os.path.exists(output_path):
    os.makedirs(output_path)
  f = open(output_path + '/weight.txt', "w")
  for item in net.params.items():
    name, layer = item
    print('convert layer: ' + name)

    num = 0
    #=============================Print reshaped and split weights============================#
    pad = 0
    if net.params[name][0].data.shape[1] <= 8:
      pad = 8 - net.params[name][0].data.shape[1]
    # print(net.params[name][0].data.shape)
    for p in range(0, net.params[name][0].data.shape[0]):
      # print(net.params[name][0].data[p])
      shape = net.params[name][0].data.shape
      # print(np.vstack(np.dsplit(net.params[name][0].data[p].transpose((1,2,0)), shape[1]/8)))
      f.write(str(hex(struct.unpack('<H', net.params[name][1].data.astype(dtype=np.float16)[p])[0])).replace('0x','').zfill(4)+' ') #Little-endian，Write bias
      # print(str(hex(struct.unpack('<H', net.params[name][1].data.astype(dtype=np.float16)[p])[0])).replace('0x','').zfill(4), end = ' ')
      padded_dat = np.pad(net.params[name][0].data[p], ((0,0),(0,0),(0,pad)),'constant')
      if(shape[1]>8):
        split_dat = np.vstack(np.dsplit(padded_dat.transpose((1,2,0)), shape[1]/8))
      else:
        split_dat = padded_dat
      dat = split_dat.astype(dtype=np.float16).reshape(-1)
      for j in dat:
        f.write(str(hex(struct.unpack('<H', j)[0])).replace('0x','').zfill(4)+' ') #Little-endian, Write weights
        # print(str(hex(struct.unpack('<H', j)[0])).replace('0x','').zfill(4), end = ' ')
      f.write("\n")
      # print('')
    #=============================Print Original weights=======================================#
    '''
    for p in net.params[name]: #NCHW
      # TODO: Padding 0
      print(p.data.shape)
      dat = p.data.astype(dtype=np.float16).reshape(-1)
      for j in dat:
        f.write(str(hex(struct.unpack('<H', j)[0])).replace('0x','').zfill(4)+' ') #Little-endian
      print("layer %d, size = %d" % (num, p.data.size))
      num += 1
      f.write("\n")
    '''
  f.close()

if __name__ == '__main__':
  model = '/mnt/c/Users/shish/source/repos/SqueezeNet/SqueezeNet_v1.1/deploy.prototxt'
  weights = '/mnt/c/Users/shish/source/repos/SqueezeNet/SqueezeNet_v1.1/squeezenet_v1.1.caffemodel'
  output_path = '/mnt/c/Users/shish/source/repos/FusionAccel/scripts/tmp'
  extract_caffe_model(model, weights, output_path)
