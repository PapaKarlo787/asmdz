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


mov_left:
	mov al, [coord]
	sub al, 1
	cmp al, -1
	jne .nxt
	mov al, 39
.nxt:
	mov [coord], al
ret

mov_right:
	mov al, [coord]
	add al, 1
	cmp al, 40
	jne .nxt
	mov al, 0
.nxt:
	mov [coord], al
ret

mov_up:
	mov al, [coord+1]
	sub al, 1
	cmp al, -1
	jne .nxt
	mov al, 24
.nxt:
	mov [coord+1], al
ret

mov_down:
	mov al, [coord+1]
	add al, 1
	cmp al, 25
	jne .nxt
	mov al, 0
.nxt:
	mov [coord+1], al
ret

spin:
	mov eax, [last_sym]
	inc al
	cmp al, 3
	jle .nxt
	mov al, 0
	call mov_vent
.nxt:
	mov [last_sym], eax
	mov al, [syms+eax]
	call coord_to_di
	stosb
	ret

coord_to_di:
	push ax
	mov al, [coord+1]
	mov cl, 80
	mul cl
	xor cx, cx
	mov cl, [coord]
	shl cl, 1
	add ax, cx
	mov dx, ax
	mov di, ax
	pop ax
	ret

mov_vent:
	pushad
	xor eax, eax
	call coord_to_di
	stosb
	mov al, [moves_vent]
	mov ax, [mov_funcs+eax*2]
	call ax
	popad
	ret

nonecmd:
	ret

last_sym: dd 0
syms: db '\|/-'
coord: db 0, 0
speed: db 3
moves_vent: db 0
mov_funcs: dw nonecmd, mov_left, mov_right, mov_down, mov_up
