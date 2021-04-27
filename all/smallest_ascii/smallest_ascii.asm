org 100h
	mov al, 3
	int 10h
	push 0b811h
	pop es
	mov eax, 0x1e001e00
	mov si, symbols

	call print_simple_line
	mov dl, "0"
	call print_complex_line
	call print_simple_line
	xor dl, dl
	mov bl, "0"-1
print_ascii_line:
	cmp bl, "9"
	jne not_add
	mov bl, 'A'-1
not_add:
	inc bx
	call print_complex_line
	jnz print_ascii_line
;print bot
	call print_simple_line
	
;end of programm
	xor ah, ah
	int	16h
	ret
	
print_complex_line:
	add di, 86
	mov al, 0bah
	stosw
	mov al, bl
	stosw
	mov al, 0b3h
	stosd
	mov cl, 16
lp:
	mov al, dl
	stosd
	cmp di, 256+36
	jne not_add1
	mov dl, 'A'-1
not_add1:
	inc dl
	loop lp
	mov al, 0bah
	stosw
	ret

print_simple_line:
	add di, 86
	
	lodsb
	stosw
	
	lodsb
	stosw
	
	push ax
	
	lodsb
	stosw

	pop ax
	mov cl, 16*2+1
	rep stosw

	lodsb
	stosw

	ret

symbols:
db 0c9h, 0cdh, 0d1h, 0bbh
db 0c7h, 0c4h, 0c5h, 0b6h
db 0c8h, 0cdh, 0cfh, 0bch
