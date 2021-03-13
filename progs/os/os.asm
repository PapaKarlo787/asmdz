org 7c00h
xor dx, dx
mov ss, dx
mov ds, dx
mov es, dx
mov cx, 1
mov bx, 0x7c00
mov ax, 0x0204
int 13h

push 0b800h
pop es
xor bx, bx
mov cx, bx

mov ax, 2
int 10h

mov si, hello
mov di, 0
call print

mov cl, [cs:8200h]
mov si, 08201h
mov di, 2

.print_loop:
	add di, 160
	push di
	call print
	pop di
	loop .print_loop

mov bx, 1
jmp .setflag

.loop:
	xor ax, ax
	int 16h
	cmp ah, 01ch
	je ldn
	cmp ah, 010h
	je .down
	cmp ah, 01eh
	jne .loop
.up:
	call .noflag
	inc bl
	cmp bl, [cs:08200h]
	jbe .setflag
	mov bl, 1
	jmp .setflag
.down:
	call .noflag
	dec bl
	cmp bl, 0
	jne .setflag
	mov bl, [cs:08200h]
.setflag:
	mov ax, 160
	mul bx
	mov di, ax
	mov byte [es:di], 16
	jmp .loop

.noflag:
	mov ax, 160
	mul bx
	mov di, ax
	mov byte [es:di], 0
	ret

times 510 - ($-7c00h)  db 0x00
db 055h, 0aah

hello:
db 'Hello! Select the programm!', 0
include 'f.asm'

times 0x600 - ($-7c00h)  db 0x00
