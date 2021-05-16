macro set_for_print a1, a2, a3, a4{
	mov bx, a1
	mov cx, a2
	mov dx, a3
	mov bp, a4
}

print_info:
	push es
	push ds
	pop es
	mov ax, 0x1300
	int 10h
	pop es
	ret

