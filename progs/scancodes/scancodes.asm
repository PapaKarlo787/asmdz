org 100h

xor ax, ax
int 10h
push 0xb800
pop es

mov di, 0
mov si, text
call print

push 0xb805
pop es

main:
	xor ax, ax
	int 16h
	mov [es:0], al

	mov dh, ah
	shr dh, 4
	call fix_hex
	mov [es:14], dh
	
	mov dh, ah
	and dh, 15
	call fix_hex
	mov [es:16], dh
	jmp main


fix_hex:
	cmp dh, 10
	jl exit_fix
	add dh, 7
exit_fix:
	add dh, 48
	ret

text:
db 'symbol scancode', 0

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

times 2048-($-100h) db 0
