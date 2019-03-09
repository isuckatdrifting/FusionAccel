import os
import struct
import numpy as np
import sys
'''
buf = bytearray.fromhex("a1ff 9200 0000")
print(buf)
buf2 = bytearray.fromhex("a1ff 9200 0000")
print(buf2)
buf = buf + buf2
print(buf)

num = np.array(1e-5).astype(dtype = np.float16)
print(num)
num_s = str(hex(struct.unpack('H', num)[0])).replace('0x','').zfill(4)
print(num_s)

weightpiece = open("C:/Users/shish/source/repos/FusionAccel/scripts/tmp/weight.txt","r")
weight = bytearray()
for line in weightpiece.readlines():
    #print(line)
    tmp = bytearray.fromhex(line.strip('\n'))
    weight = weight + tmp
    print(len(tmp), end = ", ")
    print(sum(tmp))
print(len(weight))

num = np.arange(144).reshape((16,3,3))
print(num)
print(num.shape)
num2 = np.transpose(num, (1,2,0))
print(num2)
num3 = np.dsplit(num2, num2.shape[2]/8)
print(num3)

num2 = np.dsplit(num, num.shape[2]/8)
print(num2)
'''
num = np.arange(4).astype(dtype=np.float16)
for j in num:
    print(str(hex(struct.unpack('<H', j)[0])).replace('0x','').zfill(4), end = ' ')
print('')
print(num.tobytes())

mem = b'\x00\x00\x00<\x00@\x00B'
x = np.fromstring(mem, dtype=np.uint8)
print(np.unpackbits(x).reshape(-1,8))
print(num.byteswap().tobytes().hex()) # endian swap

endian = bytearray.fromhex('0000 3c00 4000 4200')
print(endian)
print(endian.hex())
print(sys.byteorder.capitalize())