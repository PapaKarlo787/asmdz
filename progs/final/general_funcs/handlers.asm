lk:
	mov byte[es:1996], 0x1b
	cmp byte [napr], 1
	je .rt
	cmp byte [napr], 2
	je .ch
	mov byte [face], 3
.ch:
	mov byte [napr], 1
.rt:
	mov ax, [myflags]
	and ax, 1
	jnz l
	ret

rk:
	mov byte[es:1996], 0x1a
	cmp byte [napr], 1
	je .ch
	cmp byte [napr], 2
	je .rt
	mov byte [face], 3
.ch:
	mov byte [napr], 2
.rt:
	mov ax, [myflags]
	and ax, 1
	jnz r
	ret

uk:
	mov byte[es:1996], 0x18
	cmp byte [napr], 3
	je .rt
	cmp byte [napr], 4
	je .ch
	mov byte [face], 242
.ch:
	mov byte [napr], 3
.rt:
	mov ax, [myflags]
	and ax, 1
	jnz u
	ret

dk:
	mov byte[es:1996], 0x19
	cmp byte [napr], 4
	je .rt
	cmp byte [napr], 3
	je .ch
	mov byte [face], 242
.ch:
	mov byte [napr], 4
.rt:
	mov ax, [myflags]
	and ax, 1
	jnz d
	ret

sk:
	mov byte[es:1996], 0xf9
	mov byte [napr], 0
	ret

grizi_grunt:
	mov al, [face+1]
	and al, 0xf0
	je .nxt
	and byte [face+1], 0x0f
	set_for_print 0xc, 9, 0x1800, m2+9
	call print_info
	mov bp, angry
	call load_sprites
	mov al, [face+1]
	and al, 0xf0
	add al, 0x4
	mov [face+1], al
	jmp .rt
.nxt:
	and byte [face+1], 0x0f
	or byte [face+1], 0x20
	set_for_print 0xa, 9, 0x1800, m2
	call print_info
	mov bp, sprites
	call load_sprites
	mov al, [face+1]
	and al, 0xf0
	add al, 0xe
	mov [face+1], al
.rt:
	mov di, [position]
	mov ax, [face]
	call mov_rotate
	ret

by_steps:
	mov ax, [myflags]
	and ax, 1
	jnz .to0
	or word [myflags], 1
	set_for_print 0xc, 7, 0x1700, m1+7
	call print_info
	ret
.to0:
	and word [myflags], 0xffff-1
	set_for_print 0xa, 7, 0x1700, m1
	call print_info
	ret

_info:
	mov ax, 0x0501
	int 10h
	mov ah, 0
	int 16h
	mov ax, 0x0500
	int 10h
	ret

kolobcol:
	mov al, [face+1]
	inc al
	and al, 0x0f
	and byte [face+1], 0xf0
	add [face+1], al
	ret

set_point:
	mov ax, [n_positions]
	mov bx, [position]
	mov [positions+eax*2], bx
	inc ax
	mov [n_positions], ax
	inc byte[points]
	ret

return:
	pop eax
	ret
