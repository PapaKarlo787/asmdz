keyhandler:
	push ax
    in al, 60h
    cmp al, 1
    jne .nxt
    mov byte [ncmd], 2
.nxt:
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

timerhandler:
	inc byte [ntick]
	cmp byte [ntick], 3
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
