mov cl, 9
mov si, syms

edges:
	pop di
	lodsb
	stosw
	loop edges
