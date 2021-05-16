print_points:
	mov dl, 10
	mov al, [points]
	mov ah, 0
	div dl
	add ah, 0x30
	mov [es:24*80+36], ah
	mov ah, 0
	div dl
	cmp ah, 0
	je .rt
	add ah, 0x30
	mov [es:24*80+34], ah
	mov ah, 0
	div dl
	cmp ah, 0
	je .rt
	add ah, 0x30
	mov [es:24*80+32], ah
.rt:
	ret
