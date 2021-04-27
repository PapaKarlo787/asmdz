ldn:
	xor dx, dx
	mov ax, bx
	mov cl, 4
	mul cl
	mov cx, ax
	push 0x2000
	pop es
	mov bx, 00h
	mov sp, 0
	push sp
	mov ax, 0204h
	int 13h
	mov ax, 0x2010
	mov ds, ax
	mov ss, ax
	push 0xb817
	pop es
	mov dword [ds:0], 7c00eah
	mov byte [ds:4], 0
	xor ax, ax
	mov di, 0xfffe
	jmp 0x2010:100h

print:
	lp:
	mov al, [si]
	cmp al, 0
	jz ext
	mov [es:di], al
	add di, 2
	inc si
	jmp lp
	ext:
	inc si
	ret
