org 100h

xor ax, ax
int 10h

push 0xb800
pop es

mov di, 0
mov si, text
call print

push 0xb805
pop es

main:
	xor ax, ax
	int 16h
	mov [es:0], al

	mov dh, ah
	shr dh, 4
	call fix_hex
	mov [es:14], dh
	
	mov dh, ah
	and dh, 15
	call fix_hex
	mov [es:16], dh
	
	mov dh, al
	shr dh, 4
	call fix_hex
	mov [es:32], dh

	mov dh, al
	and dh, 15
	call fix_hex
	mov [es:34], dh

	jmp main

include 'f.asm'

times 2048-($-100h) db 0
