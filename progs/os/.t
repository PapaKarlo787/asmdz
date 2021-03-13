fasm main.asm q.bin
mkisofs -b q.bin -o q.iso q.bin  2> /dev/null
#rm q.bin
virtualbox --startvm dos  2> /dev/null 
# To use last command you need install virtualbox, create there new virtual mashine 
# "MyVM" and make thete CD drive with q.iso from your path  
