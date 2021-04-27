org 100h
mov	di,	4*9
mov	ax,	cs
shl eax, 16
mov	ax, keyhandler
mov dx, oldkey
call set_handler
mov	ax,	cs
shl eax, 16
mov	di,	4*8
mov dx, oldtimer
mov	ax, timerhandler
call set_handler

xor ax, ax
int 10h
mov dx, 0x1900
mov ah, 2
int 10h
push 0b800h
pop es

lp:
	hlt
	xor eax, eax
	mov al, [ncmd]
    mov ax, [cmds+eax*2]
    call ax
    mov byte [ncmd], 0
    jmp lp

sup:
	inc byte[speed]
	ret

sdown:
	dec byte[speed]
	ret

ncmd: db 0

cmds: dw nonecmd, spin, return, sup, sdown

include 'handlers.asm'
include 'funcs.asm'
