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
print(data_reshape)
print("\n")
print(weight_reshape)