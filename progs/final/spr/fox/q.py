a = [[], [], [], []]

with open('fox.txt') as f:
	for k in range(32):
		l = f.readline()[:-1]
		for i in range(4):
			a[i].append(int(l[i*8:(i+1)*8], 2))
print(len(a[3]))
with open("fox_res.txt", 'w') as f:
	for l in range(2):
		for i in range(4):
			line = "dd "
			for t in range(4):
				num = 0
				for k in range(4):
					num += a[i].pop(0) << k*8
				line += hex(num)+","
			f.write(line[:-1]+"\n")
