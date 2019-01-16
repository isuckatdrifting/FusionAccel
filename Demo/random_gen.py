import random
import struct
import numpy as np

m = np.random.rand(13,13)
s = np.float16(np.sum(m)) 
# Accuracy Loss
s_ = np.float16(0)
for i in range (13):
    for j in range(13):
        s_ = s_ +  np.float16(m[i,j])
s_ = np.float16(s_) 
print(m)
print(s)
print(s_)
for i in range(13):
    for j in range(13):
        b = np.float16(m[i,j])
        print(hex(struct.unpack('<h', b)[0]).replace('0x','16\'h'), end=', ')
    print('')
print(hex(struct.unpack('<h', s)[0]), end=', ')
print(hex(struct.unpack('<h', s_)[0]), end=', ')
print(hex(struct.unpack('<h', s/np.float16(169.0))[0]), end=', ')
print(hex(struct.unpack('<h', s_/np.float16(169.0))[0]), end=', ')