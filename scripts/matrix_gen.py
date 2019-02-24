import random
import struct
import numpy as np

data = np.random.rand(5,5,3).astype(dtype = np.float16)
weight = np.random.rand(3,3,3).astype(dtype = np.float16)
print(data)
print("\n")
print(weight)

data_list = []
weight_list = []

data_reshape = data.reshape([1,75])
weight_reshape = weight.reshape([1,27])

for i in range(0, 75):
    data_list.append(data_reshape[0, i])
for i in range(0, 27):
    weight_list.append(weight_reshape[0, i])

for i in range(0,75):
    print("data[%d] = " % (i) + hex(struct.unpack('<h', data_list[i])[0]).replace('0x','16\'h')+ "; ", end = "")
    if i%5 == 4:
        print("")
print("\n")
for i in range(0,27):
    print("weight[%d] = " % (i) + hex(struct.unpack('<h', weight_list[i])[0]).replace('0x','16\'h')+ "; ", end = "")
    if i%5 == 4:
        print("")
print("\n")
