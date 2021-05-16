update_positions:
	xor ecx, ecx
	mov cx, [n_positions]
	cmp cx, 0
	je .rt
.lp:
	dec cx
	mov di, [positions+ecx*2]
	or word [es:di], 0x0efe
	cmp cx, 0
	jne .lp
.rt:
	ret

