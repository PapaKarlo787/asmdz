include 'macros.asm'
org 100h
    mov al, 03h
    int 10h
    push 0b817h
    pop es
    xor di, di
    mov eax, 0x1a001a00

	mov si, syms
	call tb
    stosd
    lodsb
    stosd

include 'hex.asm'

    lodsb
    call el
	call tb

nl:
    stosw
    mov al, bl
    shr al, 4
    al_to_hex
    stosw
    mov al, 0b3h
    stosd
    mov cl, 16
    
    table:
		mov al, bl
		stosd
		inc bx
		loop table
    
    mov al, 0bah
    call el
    test bh, bh
    jz nl

	call tb

    xor ah, ah
    int 16h
    ret

include 'data.asm'
include 'top.asm'
