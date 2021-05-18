include 'macros.asm'

org 100h
    mov al, 3
    int 10h
include 'new_tab.asm'
    push 0xb817
    pop es
    stosw
    mov eax, 0x1a001a00

	mov si, syms
	call tb
    stosd
    mov al, 0xb3
    stosd

include 'hex.asm'

    mov al, 0xba
    call el
	call tb

nl:
    stosw
    mov al, bl
    shr al, 4
    al_to_hex
    stosw
    mov al, 0xb3
    stosd
    mov cl, 16

    table:
		mov al, bl
		inc bx
		stosd
		loop table

    mov al, 0xba
    call el
    test bh, bh
    jz nl
	call tb

    mov ah, 0
    int 16h
    ret

include 'data.asm'
include 'top.asm'
include 'tab.asm'
