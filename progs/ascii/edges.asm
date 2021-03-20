mov cl, 9

edges:
	pop di
	mov al, [syms-1+ecx]
	stosw
	loop edges
