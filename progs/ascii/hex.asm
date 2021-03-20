mov bx, 2650
mov di, 228
mov cl, 16
flp:
	mov al, cl
	dec ax
	cmp al, 10
	sbb al, 0x69
	das
	stosd
	mov [es:di+bx], ax
	sub di, 8
	sub bx, 156
	loop flp
