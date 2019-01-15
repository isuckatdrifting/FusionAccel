# FusionAccel
RTL-level Neural Network Accelerator Implementation on Xilinx Spartan6

## 1 Network Support

### 1.1 Conventional Networks
- AlexNet
- GoogLeNet
- VGGNet
- LeNet
- ResNet50/101
- Fully Convolutional Network
- Deep Convolutional Network
- SqueezeNet

### 1.2 Segmentation Networks
- YOLO
- Faster R-CNN
- Mask R-CNN

### 1.3 Customized Networks
- FotonNet
- 3D

## 2 IO Interface
### 2.1 How to load CaffeModels & give outputs
- USB3.0

### 2.2 PC Host Software

## 3 Performance List

## 4 Generic Engines
### 4.1 Cores
- Fully Connected
- Dropout
- Linear Operation
- Zero Padding
- Power

### 4.2 Convolution
- Convolutional
- Average Pooling - LUT Support
- Max Pooling - LUT Support
- Deconvolutional *
- Average Unpooling - LUT Support *
- Max Unpooling - LUT Support *

### 4.3 Normalization *
- Contrast Normalization
- Batch Normalization

### 4.4 Split/Merge
- Concatenation
- Slice
- Elementwise-add

### 4.5 Activation Functions - LUT Support
- tanh
- asinh
- sigmoid
- softmax
- softplus
- softsign
- relu
- leaky relu
- identity
- scaled tanh
- exponential linear
- scaled exponential linear

## 5 Modern Acceleration, Performance & Resource Strategy
- SRAM
- DMA (if there was CPU)
- Number representation: INT8/INT16/INT32/FP16/FP32
    - Half precision floating point (FP16) for each engine, i.e. conv3x3, conv7x7
- How to define signed numbers in verilog logic
- Fully connected layers may be executed on host -- too many weights

## 6 Reference
- Lukas Cavigelli. Origami: A 803 GOp/s/W Convolutional Network Accelerator. 2015.
- Clement Farabet. NeuFlow: A Runtime Reconfigurable Dataflow Processor for Vision.
- Clement Farabet. CNP:AN FPGA-BASED PROCESSOR FOR CONVOLUTIONAL NETWORKS.
- Vinayak Gokhale. Nn-X - a hardware accerlerator for convolutional neural networks.
- Song Han. Efficient Methods and Hardware for Deep Learning.

## 7 NOTES
Draw Network Flowcharts

`sudo python3 ./draw_net.py ../../SqueezeNet/SqueezeNet_v1.1/deploy.prototxt ./squeezenet.png --rankdir=TB`

Cannot use CHaiDNN INT8/INT6 or NVDLA INT16 inference, because it requires TensorRT or quantization, and cannot directly get weight from caffemodel.
Can directly use pretrained FP32 models
Architecture like NVDLA, but much simplified.
No CPU Architecture means no DMA.

Available SDRAM Resource = 1Gbit = 128MByte = 64MWord

3x3 Conv, Multiply Takes 9 Cycles, Accumulate Takes 42 Cycles, Totally Takes 51 Cycles, 65 FFs.
Use Bitonic Sort for 3x3 Max Pooling, Takes 31 Cycles, 213 FFs.
Use Bitonic Sort for 13x13 Average Pooling

fp mult aresetn must be asserted for minimum 2 cycles, fp mult takes 7 cycles