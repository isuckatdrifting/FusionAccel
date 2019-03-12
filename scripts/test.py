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
mem = b'\x00\x00\x01<\x00@\x00B'
x = np.fromstring(mem, dtype=np.uint8)
print(np.unpackbits(x).reshape(-1,8))
print(num.byteswap().tobytes().hex()) # endian swap

mem = b'\x00\x00\x00<\x00@\x00B'
w = np.frombuffer(mem, dtype=np.float16)
print(mem.hex())
print(w)
'''

mat1 = np.array([[[-26.05,    30.38,    24.36 ],
                    [-24.56,    36.22,    30.2],
                    [-19.73,    47.84,    38.94 ]],

                   [[-23.58,    36.22,    28.25],
                    [-31.67,    30.61,    22.64],
                    [-33.66,    34.5,     25.52]],

                   [[-37.,      24.78,    16.8 ],
                    [-42.53,    21.7,     11.805],
                    [-42.72,    26.44,    15.52]]])

mat3 = np.array(

    [[[-37.,      24.78,    16.8 ],
    [-42.53,    21.7,     11.805],
    [-42.72,    26.44,    15.52]],

 [[-53.56,   15.87,    2.184],
 [-47.88,   22.17,    8.35 ],
 [-46.84,   25.28,   11.41 ]],
 
 [[-59.94,    15.45,     0.5605 ],
 [-58.38,    17.61,     2.652 ],
 [-54.66,    18.7,      4.668]]])

mat2 = np.array([[[ 0.2573,   0.5503,   0.3147],
                    [-0.10046, -0.1483,  -0.1552],
                    [-0.07056, -0.2095,  -0.1145]],

                   [[ 0.3594,   0.678,    0.43],
                    [-0.1581,  -0.271,   -0.2114],
                    [-0.1886,  -0.464,   -0.248]],

                   [[ 0.2034,   0.4646,   0.3135],
                    [-0.098,   -0.1844,  -0.07715],
                    [-0.1964,  -0.448,   -0.2256]]])

print(mat1*mat2)
print(np.sum((mat1*mat2).reshape(-1))-0.01437416)
print("==========            ===============")
print(mat3*mat2)
print(np.sum((mat3*mat2).reshape(-1))-0.01437416)

print("==================================================================")
mat4 = np.array([[[ -26.04759216,  -23.58161163,  -36.99021912],
   [ -24.55531311,  -31.67391205,  -42.52264404],
   [ -19.73277283,  -33.64813232,  -42.70744705]],

  [[  30.36858559,   36.21514511,   24.78676796],
   [  36.21514511,   30.60404396,   21.7098484],
   [  47.84046555,   34.49119186,   26.4314518]],

  [[  24.35843849,   28.25760841,   16.78983498],
   [  30.20499611,   22.63355446,   11.80411816],
   [  38.94860458,   25.5153904,    15.52041149]]])

mat5 = np.array([[[  2.57234633e-01,   3.59365553e-01,   2.03427270e-01],
   [ -1.00434266e-01,  -1.58038974e-01,  -9.80390310e-02],
   [ -7.05568120e-02,  -1.88632116e-01,  -1.96386009e-01]],

  [[  5.50186992e-01,   6.78221345e-01,   4.64654207e-01],
   [ -1.48362771e-01,  -2.71091938e-01,  -1.84496120e-01],
   [ -2.09430471e-01,  -4.64008331e-01,  -4.47882265e-01]],

  [[  3.14683497e-01,   4.29874837e-01,   3.13388258e-01],
   [ -1.55168936e-01,  -2.11414427e-01,  -7.71227255e-02],
   [ -1.14496820e-01,  -2.47987881e-01,  -2.25608483e-01]]])

print(mat4*mat5)
print(np.sum((mat4*mat5).reshape(-1))-0.01437416)
print("==================================================================")
