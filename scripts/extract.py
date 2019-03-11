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
    weight_list.append(net.params[name][0].data)
    weight_list.append(net.params[name][1].data)
    if name == 'conv1':
      print(net.params[name][0].data)
      print(net.params[name][1].data)
    
  np.savez('./tmp/weight.npz', *weight_list)

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
