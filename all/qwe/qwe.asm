org 100h
xor ax, ax
int 10h
push 0b800h
pop es
mov di, 0


mov di, 0
mov si, hello

	lp:
xor ax, ax
int 16h
ret


print:
	mov al, [ds:si]
	cmp al, 0
	jz ext
	mov [es:di], al
	inc di
	inc di
	inc si
	jmp print
ext:
	ret

hello db 'hello!!!',0
times 2048-($-100h) db 0
