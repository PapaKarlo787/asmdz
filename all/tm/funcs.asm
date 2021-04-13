set_handler:
	push 0
	pop es
	mov ecx, [es:di]
	mov [edx], ecx
	cli
	stosd
	sti
	ret


return:
	mov ax, 3
	int 10h
	mov dx, oldkey
	mov	di,	4*9
	mov	eax, [oldkey]
	call set_handler
	mov dx, oldtimer
	mov	di,	4*8
	mov eax, [oldtimer]
	call set_handler
	pop ax
	ret

spin:
	mov eax, [last_sym]
	inc al
	cmp al, 3
	jle .nxt
	mov al, 0
.nxt:
	mov [last_sym], eax
	mov al, [syms+eax]
	mov di, 6
	stosb
	ret

nonecmd:
	ret

last_sym: dd 0
syms: db '|\-/'
