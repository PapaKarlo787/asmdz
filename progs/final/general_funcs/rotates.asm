rotate:
	xor eax, eax
	mov ax, [napr]
	mov ax, [.rotates+eax*2]
	call ax
	ret
.rotates: dw s, l, r, u, d

l:
	call clear_old_pos
	sub di, 2
	cmp di, 0
	jl .ad
	call div_160
	jne .nxt1
.ad:
	add di, 78
	jmp .nxt2
.nxt1:
	call check_zabor
.nxt2:
	mov [position], di
	mov ax, [face]
	add ax, 2
	cmp al, 17
	jne .nxt
	mov al, 1
.nxt:
	call mov_rotate
	sub ax, 2
	mov [face], ax
	ret


r:
	call clear_old_pos
	add di, 2
	call div_160
	jne .nxt1
	sub di, 78
	jmp .nxt2
.nxt1:
	call check_zabor
.nxt2:
	mov [position], di
	mov ax, [face]
	add ax, 2
	sub al, 4
	cmp al, 255
	jne .nxt
	mov al, 15
.nxt:
	call mov_rotate
	sub ax, 2
	mov [face], ax
	ret

u:
	call clear_old_pos
	sub di, 80
	cmp di, 0
	jnl .nxt1
	add di, 2000-160
	jmp .nxt2
.nxt1:
	call check_zabor
.nxt2:
	call check_zabor
	mov [position], di
	mov ax, [face]
	add ax, 2
	sub al, 4
	cmp al, 238
	jne .nxt
	mov al, 246
.nxt:
	call mov_rotate
	sub ax, 2
	mov [face], ax
	ret

d:
	call clear_old_pos
	add di, 80
	cmp di, 2000-160
	jnae .nxt1
	sub di, 2000-160
	jmp .nxt2
.nxt1:
	call check_zabor
.nxt2:
	mov [position], di
	mov ax, [face]
	add ax, 2
	cmp al, 248
	jne .nxt
	mov al, 240
.nxt:
	call mov_rotate
	sub ax, 2
	mov [face], ax
	ret

s:
	mov ax, [face]
	cmp al, 1
	je .r
	mov al, 1
	mov di, [position]
	stosb
	and [es:di], ah
	inc di
	inc al
	stosb
	and [es:di], ah
	inc al
	mov [face], ax
.r:
	ret

div_160:
	mov ax, di
	mov cl, 80
	div cl
	cmp ah, 78
	ret

mov_rotate:
	stosb
	call attr_col
	inc di
	stosb
	call attr_col
	ret

attr_col:
	push ax
	cmp byte[es:di], 15
	ja .to0
	and ah, 15
.to0:
	mov [es:di], ah
	pop ax
	inc al
	ret
	
clear_old_pos:
	mov di, [position]
	mov si, di
	and dword [es:di], 0xff00ff00
	ret

check_zabor:
	cmp byte[es:di], 0
	jne .ne_ok
	cmp byte[es:di+2], 0
	jne .ne_ok
	ret
.ne_ok:
	mov di, si
	ret
