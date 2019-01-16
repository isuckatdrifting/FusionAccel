import random
import struct
import numpy as np

m = np.random.rand(13,13)
s = np.float16(np.sum(m))
print(m)
print(s)
for i in range(13):
    for j in range(13):
        b = np.float16(m[i,j])
        print(hex(struct.unpack('<h', b)[0]).replace('0x','16\'h'), end=', ')
    print('')
print(hex(struct.unpack('<h', s)[0]), end=', ')