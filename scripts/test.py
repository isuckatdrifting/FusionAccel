import os
buf = bytearray(os.urandom(1024))
print(buf)
buf_ = buf[1:5]
print(buf_)