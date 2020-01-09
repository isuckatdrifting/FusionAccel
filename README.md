# FusionAccel
RTL-level Neural Network Accelerator Implementation on Xilinx Spartan 6. Evaluation for Scalability. This is a source code repo for the following article:

FusionAccel: A General Re-configurable Deep Learning Inference Accelerator on FPGA for Convolutional Neural Networks. https://arxiv.org/abs/1907.02217.

I am not currenly developing this repo due to limited time, but I am ready to answer questions under this repo. Please submit an issue if necessary. You may visit this [Youtube Video Link](https://youtu.be/SMSY97nOUzo) for more details.

## 1 Network Support
[Current_Support] SqueezeNet v1.1, since the network structure is extremely simple.

Theoretically any network with convolution, ReLu activation, average pooling, max pooling and concatenation only are supported, like `AlexNet, GoogLeNet, VGGNet, LeNet, ResNet50/101, Fully Convolutional Network, Deep Convolutional Network`, but you have to write your own conv core with optimization algorithms.

## 2 IO Interface
USB 3.0 loading CaffeModels & return outputs (FrontPanel SDK library required -- chose this for light weight dependency concerns). Though the bandwidth of USB 3 is high, the latency is considerable. Meanwhile with restricted on-chip resources, split blobs have to be moved piece by piece, which increases the latency even more.

## 3 Reference
- Lukas Cavigelli. Origami: A 803 GOp/s/W Convolutional Network Accelerator. 2015.
- Clement Farabet. NeuFlow: A Runtime Reconfigurable Dataflow Processor for Vision.
- Clement Farabet. CNP:AN FPGA-BASED PROCESSOR FOR CONVOLUTIONAL NETWORKS.
- Vinayak Gokhale. Nn-X - a hardware accerlerator for convolutional neural networks.
- Song Han. Efficient Methods and Hardware for Deep Learning.
- Any other articles mentioned in the reference of the article.

## 4 Modern Acceleration, Performance & Resource Strategy
- SRAM (BRAM in FPGA) size
- DMA (if there was CPU)
- Number representation: INT8/INT16/INT32/FP16/FP32
    - Half precision floating point (FP16) for each engine, i.e. conv3x3, conv7x7
- How to define signed numbers in verilog logic
- Fully connected layers may be executed on host -- too many weights

## 5 NOTES & Developing Drafts
Draw Network Flowcharts

`sudo python3 ./draw_net.py ../../SqueezeNet/SqueezeNet_v1.1/deploy.prototxt ./squeezenet.png --rankdir=TB`

Cannot use CHaiDNN INT8/INT6 or NVDLA INT16 inference, because it requires TensorRT or quantization, and cannot directly get weight from caffemodel.
Can directly use pretrained FP32 models.
Architecture like NVDLA, but much simplified.
No CPU Architecture means no DMA.

Available SDRAM Resource = 1Gbits = 128MBytes = 64MWords

- 3x3 Conv, Multiply Takes 9 Cycles, Accumulate Takes 42 Cycles, Totally Takes 51 Cycles, 65 FFs.
- Use Bitonic Sort for 3x3 Max Pooling, Takes 31 Cycles, 213 FFs.
- Use Sum/Divide for 13x13 Average Pooling. fp sum calc takes 11 cycles. Takes 110 Cycles totally. Divider takes 26 cycles. Totally takes 136 Cycles, 600FFs.

fp_mult aresetn must be asserted for minimum 2 cycles, fp mult takes 7 cycles.

Maybe RCB or CRB is better than BRC or BCR, since it stores different channels on different banks

| Unit | Conventional Unit Cycle |  MEC Unit Cycle |
| ---- | ----- | ----- |
| Mult |   8   |   8   |
| Sum  |   11   |   11   |
| Compare |   5   |   5   |
| Divide |  26  |  26  |
| Conv 1x1 | Mult + 1 = 9 |  Mult + 1 + Sum = 20 (Conv Single) |
| Conv 3x3 | Mult + 1 + Sum * 3 = 42 |
| Pool 3x3 | Compare * 7 = 35 | Compare * 7 = 35 |
| Pool 13x13 | Sum * 10 + Divide = 136 | Sum * 10 + Divide = 136 |

Memory access time: width = 32, depth = 32, time = 32 * 30 + 10 = 970ns. 64 per 970ns.

Dropout Layer is disabled in test. Average fanout 4.40->3.59
