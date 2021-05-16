fix_hex:
	cmp dh, 10
	jl exit_fix
	add dh, 7
exit_fix:
	add dh, 48
	ret

text:
db 'symbol scancode hex', 0

print:
	mov al, [ds:si]
	cmp al, 0
	jz ext
	mov [es:di], al
	inc di
	inc di
	inc si
	jmp print
ext:
	ret
