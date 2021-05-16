keyhandler:
	push ax
    in al, 60h
    cmp al, 1
    jne .nxt
    mov byte [ncmd], 2
.nxt:
	cmp al, 0x10
	jne .nxt1
	mov byte [ncmd], 3
.nxt1:
	cmp al, 0x1e
	jne .nxt2
	mov byte [ncmd], 4
.nxt2:
	call check_vent
    in al, 61h
    mov ah, al
    or al, 80h
    out 61h, al
    xchg ah,al
    out 61h, al
    mov al, 20h
    out 20h, al
    pop ax
    iret

check_vent:
	cmp al, 0xb9
	je .pr
	cmp al, 0xcb
	je .n1
	cmp al, 0xcd
	je .n2
	cmp al, 0xd0
	je .n3
	cmp al, 0xc8
	je .n4
	ret
.pr:
	mov byte [moves_vent], 0
	ret
.n1:
	mov byte [moves_vent], 1
	ret
.n2:
	mov byte [moves_vent], 2
	ret
.n3:
	mov byte [moves_vent], 3
	ret
.n4:
	mov byte [moves_vent], 4
	ret


timerhandler:
	inc byte [ntick]
	mov al, [speed]
	cmp [ntick], al
	jne .ext
	mov byte [ntick], 0
	mov byte [ncmd], 1
.ext:
    mov al, 20h
    out 20h, al
    iret

ntick: db 0
oldkey: dd 0
oldtimer: dd 0
