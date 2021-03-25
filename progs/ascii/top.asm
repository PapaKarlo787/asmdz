tb:
	mov cl, 4
.lp:
		lodsb
		stosw
	loop .lp
	mov cl, 32
	rep stosw
	lodsb
el:
	stosw
	add di, 86
	mov al, 0xba
	ret
