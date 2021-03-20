use16
org 100h

mov ax, 3
int 10h

push 0xb817
pop es

mov eax, 0x1a001a00

include 'table.asm'
include 'box.asm'
include 'edges.asm'
include 'hex.asm'

mov sp, 0xfffe
mov ah,0
int 16h
ret

include 'data.asm'
