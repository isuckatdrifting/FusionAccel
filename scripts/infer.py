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

# perform classification
start_1 = time.clock()
output = net.forward()
end_1 = time.clock()
output_prob = output['prob'][0] # the output probability vector for the first image in the batch

print('predicted class is: ', output_prob.argmax())

# load ImageNet Labels
labels_file = './synset_words.txt'

labels = np.loadtxt(labels_file, str, delimiter = '\t')

print('output label:', labels[output_prob.argmax()])

top_inds = np.argsort(-output_prob.reshape(-1))[0:5] # reverse sort and take five largest items

print('probabilities and labels:')
for i in top_inds:
    print(str(output_prob[i]) + '\t' + str(labels[i]))
end_0 = time.clock()

#################Report Execution Time####################
print('Net forward time: %s' % str(end_1-start_1))
print('Overall execution time: %s' % str(end_0-start_0))

##################Intermediate Output#####################
f = open('./tmp/intermediate.txt', "w")
for layer_name, blob in net.blobs.items():
    print(layer_name + '\t' + str(blob.data.shape))
    filters = net.blobs[layer_name].data # intermediate responses of the filters (first 36 only) 
                                         # output_channels, input_channels, filter_height, filter_width
    # print(filters)
    if layer_name == 'data':
        print(filters.shape)
        # print(image)
        # print(net.blobs[layer_name].data)
        print(net.blobs['conv1'].data[0][0][0])
        print(net.blobs['conv1'].data[0][0][1])
        print(net.blobs['conv1'].data[0][1][0])
        print(net.blobs['conv1'].data[0][1][1])
        print(net.blobs['conv1'].data.shape)
        print(net.blobs['conv1'].data[0].shape)
        # print(net.params['conv1'][0].data)
        # print(net.params['conv1'][1].data)
    dat = filters.reshape(1, -1)[0][0:1].astype(dtype=np.float16) # get the first two of the layer output
    print(filters.size, dat)
    f.write(str(layer_name) + '\t')
    for i in dat:
        f.write(str(hex(struct.unpack('<H', i)[0]))[2:].zfill(4)+' ') #Little-endian
    f.write("\n")
f.close()

for layer_name, param in net.params.items():
    print(layer_name + '\t' + str(param[0].data.shape), str(param[1].data.shape) + str(param[0].data.size))
