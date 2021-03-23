mov bx, 2658
mov di, 228
mov cl, 16
std
flp:
	mov al, cl
	cmp al, 10
	sbb al, 0x69
	das
	stosd
	mov [es:di+bx], ax
	sub bx, 156
	loop flp
