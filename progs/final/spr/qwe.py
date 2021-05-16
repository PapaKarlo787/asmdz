def make(f1):
	a1 = []
	a2 = []
	with open(f1) as f:
		for i in range(16):
			l = f.readline()[:-1]
			a1.append(int(l[:8], 2))
			a2.append(int(l[8:], 2))
	aa1 = []
	aa2 = []
	for i in range(4):
		res1 = 0
		res2 = 0
		for l in range(4):
			res1 += a1[i*4+l] << (8*l)
			res2 += a2[i*4+l] << (8*l)
		aa1.append(hex(res1))
		aa2.append(hex(res2))

	print("dd "+",".join(aa1))
	print("dd "+",".join(aa2))


def zvert(f1, f2):
	lines = []
	with open(f1, 'r') as f:
		for i in range(16):
			lines.append(f.readline()[:-1][::-1])
	with open(f2, 'w') as f:
		for l in lines:
			f.write(l+"\n")


def zhor(f1, f2):
	lines = []
	with open(f1, 'r') as f:
		for i in range(16):
			lines.insert(0, f.readline()[:-1])
	with open(f2, 'w') as f:
		for l in lines:
			f.write(l+"\n")


def transp(f1, f2):
	columns = [""]*16
	with open(f1, 'r') as f:
		for i in range(16):
			l = f.readline()[:-1]
			for k in range(16):
				columns[k] += l[k]
	with open(f2, 'w') as f:
		for i in columns:
			f.write(i+'\n')


make("1")
make("2")
make("3")
make("4")
'''
transp("1", "3")
transp("8", "4")
zhor("1", "5")
zhor("8", "6")
zvert("8", "2")
zvert("3", "7")
make("1")
make("2")
make("3")
make("4")
make("5")
make("6")
make("7")
make("8")

'''
