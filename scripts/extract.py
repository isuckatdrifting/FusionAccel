import caffe
import numpy as np
import struct
import os

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
    for p in net.params[name]:
      #f = open(output_path + '/' + str(name).replace('/', '_') + '_' + str(num) + '.txt', "w")
      dat = p.data.astype(dtype=np.float16).reshape(1, -1)
      for i in dat:
        for j in i:
          f.write(str(hex(struct.unpack('<H', j)[0])).replace('0x','').zfill(4)+' ') #Little-endian
      print("layer %d, size = %d" % (num, p.data.size))
      num += 1
      f.write("\n")
  f.close()

if __name__ == '__main__':
  model = '/mnt/c/Users/shish/source/repos/SqueezeNet/SqueezeNet_v1.1/deploy.prototxt'
  weights = '/mnt/c/Users/shish/source/repos/SqueezeNet/SqueezeNet_v1.1/squeezenet_v1.1.caffemodel'
  output_path = '/mnt/c/Users/shish/source/repos/FusionAccel/scripts/tmp'
  extract_caffe_model(model, weights, output_path)
