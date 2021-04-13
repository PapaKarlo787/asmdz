org 100h
vector equ 9

	xor	ax,	ax
	mov	es, ax
	mov	di,	4*vector
	mov	ax, keyhandler
	cli
	stosw
	mov	ax,	cs
	stosw
	sti
    mov ax, 3
	int 10h
    push 0b800h
    pop es
    xor di, di


lp:
    hlt
    call read_char
    jz lp
	call print_hex
	cmp al, 0xb9
	jne lp
	call space
	jmp lp


read_char:
	cmp byte [char], 0
	je .rt
	mov al, [char]
	mov byte [char], 0
.rt:
	ret


space:
	call rollup
	mov al, '-'
	mov ah, [es:1]
	stosw
	stosw
	stosw
	stosw
	stosw
	add di, 150
	ret


rollup:
	cmp di, 4000
	jne .nxt
	pushad
	mov ax, 0x0601
	mov dx, 0x1850
	xor cx, cx
	mov bh, [es:1]
	int 10h
	popad
	sub di, 160
.nxt:
	ret

print_hex:
	call rollup
	push ax
	push ax
	shr al, 4
	call send_hex
	pop ax
	and al, 15
	call send_hex
	add di, 156
	pop ax
	ret

send_hex:
	cmp al, 10
	sbb al, 0x69
	das
	stosb
	inc di
	ret

char db 0

keyhandler:
	push ax
    in al, 60h ; al = scancode
    mov [cs:char], al
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
