import numpy as np
import sys
import caffe
import struct
import time

#######################Inference###########################
start_0 = time.clock()
caffe.set_mode_cpu()
model_def = '/mnt/c/Users/shish/source/repos/SqueezeNet/SqueezeNet_v1.1/deploy.prototxt'
model_weights = '/mnt/c/Users/shish/source/repos/SqueezeNet/SqueezeNet_v1.1/squeezenet_v1.1.caffemodel'

# Load net
net = caffe.Net(model_def, model_weights, caffe.TEST)

# Preprocessing
# Load the mean ImageNet image for subtraction
mu = np.load('./ilsvrc_2012_mean.npy')
mu = mu.mean(1).mean(1)
print('mean-substracted values: ', list(zip('BGR', mu)))

# create transformer for the input called 'data'
transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})

transformer.set_transpose('data', (2,0,1)) # move image channels to outermost dimension
transformer.set_mean('data', mu) # subtract the dataset-mean value in each channel
transformer.set_raw_scale('data', 255) # rescale from [0,1] to [0, 255]
transformer.set_channel_swap('data', (2,1,0)) # swap channels from RGB to BGR

net.blobs['data'].reshape(1,       # batch size
                          3,        # 3-channel (BGR) images
                          227, 227) # image size is 227x227

image = caffe.io.load_image('./images/dog.jpg')
transformed_image = transformer.preprocess('data', image)

# copy the image data into the memory allocated for the net
net.blobs['data'].data[...] = transformed_image
np.save("./tmp/data.npy",transformed_image)
print(transformed_image)
print(transformed_image.shape)
print('=================================')
print(net.blobs['data'].data)
print(net.blobs['data'].data.shape)