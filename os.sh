rm -rf bin 2>/dev/null
mkdir bin 2>/dev/null

for f in `ls progs`; do
	echo $f
	fasm progs/$f/$f.asm bin/$f.com
done
python3 os.py <<< `ls bin`
