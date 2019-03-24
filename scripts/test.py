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

mat0 = np.array([[[-26.05,    30.38,    24.36 ],
                    [-24.56,    36.22,    30.2],
                    [-19.73,    47.84,    38.94 ]],

                   [[-23.58,    36.22,    28.25],
                    [-31.67,    30.61,    22.64],
                    [-33.66,    34.5,     25.52]],

                   [[-37.,      24.78,    16.8 ],
                    [-42.53,    21.7,     11.805],
                    [-42.72,    26.44,    15.52]]])

mat1 = np.array(
    [[[-37.,      24.78,    16.8 ],
    [-42.53,    21.7,     11.805],
    [-42.72,    26.44,    15.52]],

 [[-53.56,   15.87,    2.184],
 [-47.88,   22.17,    8.35 ],
 [-46.84,   25.28,   11.41 ]],
 
 [[-59.94,    15.45,     0.5605 ],
 [-58.38,    17.61,     2.652 ],
 [-54.66,    18.7,      4.668]]])

mat2 = np.array([[[-59.94,    15.45,     0.5605],
 [-58.38,    17.61,     2.652 ],
 [-54.66,    18.7 ,     4.668]],
[[-67.7,     8.086,  -7.79],
 [-69.2,     7.168,  -8.77],
 [-56.38,   17.97,    2.094]],
[[-52.8,     17.5,      2.457],
 [-54.44,    14.63,    -0.4622 ],
 [-39.16,    27.92,    11.06]]])

mat3 = np.array([[[-52.8,     17.5,      2.457 ],
 [-54.44,    14.63,    -0.4622 ],
 [-39.16,    27.92,    11.06]],
 [[-32.56,  33.66,  18.7 ],
 [-34.94,  29.84,  15.72 ],
 [-31.72,  31.95,  15.05 ]],
[[-34.03,   31.8,    16.84  ],
 [-40.84,   23.53,    9.5 ],
 [-45.06,   17.44,    3.107]]])

weight = np.array([[[ 0.2573,   0.5503,   0.3147],
                    [-0.10046, -0.1483,  -0.1552],
                    [-0.07056, -0.2095,  -0.1145]],

                   [[ 0.3594,   0.678,    0.43],
                    [-0.1581,  -0.271,   -0.2114],
                    [-0.1886,  -0.464,   -0.248]],

                   [[ 0.2034,   0.4646,   0.3135],
                    [-0.098,   -0.1844,  -0.07715],
                    [-0.1964,  -0.448,   -0.2256]]])

print(mat0*weight)
print(np.sum((mat0*weight).reshape(-1))-0.01437416)
print("==========            ===============")
print(mat1*weight)
print(np.sum((mat1*weight).reshape(-1))-0.01437416)
print("==========            ===============")
print(mat2*weight)
print(np.sum((mat2*weight).reshape(-1))-0.01437416)
print("==========            ===============")
print(mat3*weight)
print(np.sum((mat3*weight).reshape(-1))-0.01437416)
'''
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
'''
print("squeeze")
d = np.array([ 22.1,     18.95,    12.19,     0.,      14.97 ,    3.205,  183.1,
    20.73,     8.09,     4.6  ,   25.86   ,  0.4827 , 56.3 ,    20.81,
     8.9 ,    18.84 ,    0. ,      5.93  ,  17.12 ,   15.83 ,   15.625,
     0.  ,     0.  ,    13.75 ,   16.11 ,   23.84 ,   53.44 ,    3.191,
    64.2  ,    0.  ,    12.35 ,   43.5  ,   20.75 ,    0.   ,    8.52,
     0.  ,     6.016 ,   0.0347 ,  0.   ,    0.   ,   25.23 ,   18.88,
    18.19 ,   34.4 ,    26.45 ,    0.3984,   0.   ,   10.06 ,   27.89,
    62.2  ,    7.164 , 156.1 ,    14.72 ,   10.125 ,  34.28 ,   65.06,
     0.   ,   31.48 ,    9.25 ,   13.   ,   25.5  ,   13.4  ,   18.66,
    42.38 , ])

w = np.array([-0.0449  0.0469 -0.026  -0.0687  0.0371  0.0241  0.1017  0.0242]
    [ 0.0463 -0.012  -0.183   0.0119 -0.0004  0.0172  0.0199  0.0231]
    [ 0.0132 -0.0115 -0.1247  0.0176  0.0413 -0.0465  0.0908 -0.0512]]

   [[-0.0671  0.0975 -0.0014 -0.0958  0.0521  0.077  -0.0892  0.0194]
    [-0.0986  0.0364 -0.0016 -0.0034 -0.2349 -0.091  -0.2947 -0.1306]
    [ 0.0001  0.0511 -0.0019  0.0602  0.1293  0.0164 -0.0358  0.0091]]

   [[-0.0069  0.0206 -0.1047 -0.1252  0.0244  0.0535  0.0718  0.0258]
    [ 0.0041 -0.0472 -0.1412 -0.0272 -0.0386  0.087   0.0556 -0.0085]
    [ 0.0001  0.0057 -0.0284 -0.0034  0.0657  0.0064  0.1445 -0.0322]]]


  [[[-0.0101  0.045   0.0927  0.0127  0.043  -0.0505  0.0168  0.0391]
    [-0.0386 -0.0375  0.0029  0.0648  0.001   0.0435 -0.0256  0.0337]
    [ 0.0089  0.1014  0.0374  0.0286  0.1011 -0.0442 -0.0414  0.0085]]

   [[-0.1465 -0.0194  0.0731 -0.0108 -0.0444  0.0366  0.011   0.1165]
    [-0.4941 -0.1877 -0.0038 -0.5205 -0.1378 -0.0456 -0.3281 -0.0525]
    [-0.028   0.1139  0.0102 -0.0351  0.108   0.0815 -0.1447  0.09  ]]

   [[ 0.0145  0.0869  0.0371  0.1422  0.02   -0.0235  0.0643  0.0613]
    [ 0.0347  0.016  -0.036   0.1703 -0.0112  0.0074 -0.0122 -0.0764]
    [ 0.0591  0.1947  0.0585  0.1416  0.1016 -0.0035  0.018   0.0418])
print(d*w)
print(np.sum((d*w).reshape(-1))-0.0708)
num = 0
'''
for i in d.astype(dtype=np.float16):
   print("data[%d] = 16'h"%num + str(hex(struct.unpack('H', i)[0])).replace('0x','').zfill(4), end='; ')
   num += 1
print("\n")
num = 0
for i in w.astype(dtype=np.float16):
   print("weight[%d] = 16'h"%num + str(hex(struct.unpack('H', i)[0])).replace('0x','').zfill(4), end='; ')
   num += 1
'''