import os
import struct
import numpy as np
buf = bytearray.fromhex("a1ff 9200 0000")
print(buf)
buf2 = bytearray.fromhex("a1ff 9200 0000")
print(buf2)
buf = buf + buf2
print(buf)
'''
num = np.array(1e-5).astype(dtype = np.float16)
print(num)
num_s = str(hex(struct.unpack('H', num)[0])).replace('0x','').zfill(4)
print(num_s)
'''
weightpiece = open("C:/Users/shish/source/repos/FusionAccel/scripts/tmp/weight.txt","r")
weight = bytearray()
for line in weightpiece.readlines():
    #print(line)
    tmp = bytearray.fromhex(line.strip('\n'))
    weight = weight + tmp
    print(len(tmp), end = ", ")
    print(sum(tmp))
print(len(weight))