import os
names = []
main = "os"
while True:
	try:
		name = input()
		if name != main:
			names.append(name)
	except Exception:
		break


names = names[::-1]

fs = [len(names)]
for x in names:
	fs += list(x.encode() + b' '*31)[:31]+[0]

names.insert(0, main)
result = b''

fs = bytes(fs+[0]*512)[:512]

for name in names:
	with open("bin/"+name, 'rb') as f:
		result += f.read() + (fs if name == main else b'')

result += b'\x00' * (2048 * (720-len(names)))

with open("res.img", 'wb') as f:
	f.write(result)
