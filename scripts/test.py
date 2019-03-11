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
num = np.arange(4).reshape(2,2).reshape(-1).astype(dtype=np.float16)
for j in num:
    print(str(hex(struct.unpack('<H', j)[0]))[2:].zfill(8), end = ' ')
print('')
print(num.byteswap().tobytes())
mem = b'\x00\x00\x00<\x00@\x00B'
x = np.fromstring(mem, dtype=np.uint8)
print(np.unpackbits(x).reshape(-1,8))
print(num.byteswap().tobytes().hex()) # endian swap

endian = bytearray.fromhex('0000 3c00 4000 4200')
print(endian)
print(endian.hex())
print(sys.byteorder.capitalize())


data = b'\xAD\xDE\xDE\xC0\xAD\xDE\xDE\xC0'
swap_data = bytearray(data).reverse()
print(swap_data)

data = [np.arange(8).reshape(2, 4), np.arange(10).reshape(2, 5)]
np.savez('C:/Users/shish/source/repos/FusionAccel/scripts/tmp/mat.npz', *data)
container = np.load('C:/Users/shish/source/repos/FusionAccel/scripts/tmp/mat.npz')
print(container['arr_0'])
'''
num = np.arange(4).reshape(2,2).reshape(-1).astype(dtype=np.float16)
print(num.tobytes())
x = np.fromstring(num.tobytes(), dtype=np.uint8) #little endian
print(x.tobytes())
print(np.unpackbits(x.reshape(-1,8)))
print("")
y = np.dstack((np.zeros_like(num), num)).reshape(num.shape[0],-1)
print(y)
print(y.tobytes())
print("")
z = np.fromstring(y.tobytes(), dtype=np.uint8) #little endian
print(z.tobytes())
print(np.unpackbits(z.reshape(-1,8)))

print("==================")
mem = b'\x00\x00\x00<\x00@\x00B'
x = np.fromstring(mem, dtype=np.uint8)
print(np.unpackbits(x).reshape(-1,8))
print(num.byteswap().tobytes().hex()) # endian swap