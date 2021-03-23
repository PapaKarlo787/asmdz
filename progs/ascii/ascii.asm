org 100h

mov al, 3
int 10h
push 0xb817
pop es

mov eax, 0x1a001a00

include 'table.asm'
include 'box.asm'
include 'edges.asm'
include 'hex.asm'

mov sp, 0xfffe
xor ax, ax
int 16h
ret

include 'data.asm'
