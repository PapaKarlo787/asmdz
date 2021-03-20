mov cl, 6
mov sp, starts
draw:
	pop di
	push cx
	mov dx, cx
	and dl, 1
	mov bx, [sym+edx*2]
	mov al, bl
	mov cl, bh
lp:
	stosd
	add di, [steps+edx*2]
	loop lp
	pop cx
	loop draw
