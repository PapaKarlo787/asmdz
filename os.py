import os
names = []
main = "os.com"
while True:
	try:
		name = input()
		if name != main:
			names.append(name)
	except Exception:
		break


fs = [len(names)]
for x in names:
	fs += list(x.encode() + b' '*31)[:31]+[0]

names.insert(0, main)
result = b''

fs = bytes(fs+[0]*512)[:512]

for name in names:
	with open("bin/"+name, 'rb') as f:
		result += (f.read() + (fs if name == main else b'') + b'\x00'*8192)[:8192]

result += b'\x00' * (8192 * (180-len(names)))

with open("res.img", 'wb') as f:
	f.write(result)
