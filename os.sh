rm -rf bin 2>/dev/null
mkdir bin 2>/dev/null

for f in `ls progs`; do
	echo $f
	fasm progs/$f/$f.asm bin/$f
#	echo tasm progs\\$f\\$f.asm bin\\$f >> exec.bat#
#	echo tlink bin\\$f.obj /x /t /3 >> exec.bat
done
#echo exit >> exec.bat
python3 os.py <<< `ls bin`
