import random
import struct
import numpy as np

m = np.random.rand(13,13).astype(dtype = np.float16)
s = np.sum(m) 
#print(m)
#print(s)
m_ = m.reshape([1,169])
#print(m_)
m_ = np.fliplr(m_)
#print(m_)
accum1 = []
accum2 = []
accum3 = []
accum4 = []
accum5 = []
accum6 = []
accum7 = []
accum8 = []
accum9 = []
accum10 = []
for i in range(0, 64, 2):
    accum1.append(m_[0, i] + m_[0, i+1])
#print(accum1)

for i in range(0, 32, 2):
    accum2.append(accum1[i]+accum1[i+1])
for i in range(64, 96, 2):
    accum2.append(m_[0, i] + m_[0, i+1])
#print(accum2)

for i in range(0, 32, 2):
    accum3.append(accum2[i]+accum2[i+1])
for i in range(96, 128, 2):
    accum3.append(m_[0, i] + m_[0, i+1])
#print(accum3)

for i in range(0, 32, 2):
    accum4.append(accum3[i]+accum3[i+1])
for i in range(128, 160, 2):
    accum4.append(m_[0, i] + m_[0, i+1])
#print(accum4)

for i in range(0, 32, 2):
    accum5.append(accum4[i]+accum4[i+1])
for i in range(160, 168, 2):
    accum5.append(m_[0, i] + m_[0, i+1])
#print(accum5)

for i in range(0, 20, 2):
    accum6.append(accum5[i]+accum5[i+1])
#print(accum6)

accum7.append(accum6[2]+accum6[3])
accum7.append(accum6[4]+accum6[5])
accum7.append(accum6[6]+accum6[7])
accum7.append(accum6[8]+accum6[9])
accum7.append(accum6[0]+accum6[1])
accum8.append(accum7[1]+accum7[2])
accum8.append(accum7[0]+accum7[3])
accum8.append(accum7[4]+m_[0, 168])
accum9.append(accum8[0]+accum8[1])
accum10.append(accum9[0]+accum8[2])

print('1->[', end='')
for i in accum1:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('2->[', end='')
for i in accum2:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('3->[', end='')
for i in accum3:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('4->[', end='')
for i in accum4:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('5->[', end='')
for i in accum5:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('6->[', end='')
for i in accum6:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('7->[', end='')
for i in accum7:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('8->[', end='')
for i in accum8:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('9->[', end='')
for i in accum9:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')

print('10->[', end='')
for i in accum10:
    print(hex(struct.unpack('<h', i)[0]).replace('0x','16\'h'), end=', ')
print(']')


#print(m.reshape([1,169]))
for i in range(13):
    for j in range(13):
        b = np.float16(m[i,j])
        print(hex(struct.unpack('<h', b)[0]).replace('0x','16\'h'), end=', ')
    print('')
print(hex(struct.unpack('<h', s)[0]), end=', ')
print(hex(struct.unpack('<h', s/np.float16(169.0))[0]), end=', ')