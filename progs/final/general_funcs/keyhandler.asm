keyhandler:
	mov ah,1
	int 16h
	jz .rt
	mov ah, 0
	int 16h
	mov si, arrows
	mov cx, earrows - arrows
.lp:
	lodsb
	cmp ah, al
	je .hndl
	loop .lp
	jmp .rt
.hndl:
	sub si, arrows
	dec si
	mov ax, [hndls+esi*2]
	call Sound
	call ax
.rt:
	ret

arrows: db 0x4b, 0x48, 0x4d, 0x50, 0x39, 0x1c, 		  0x01,   0x10, 0x3b
db 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 			0x1f, 0x2e, 0x19
earrows:
hndls: dw  lk, 	 uk,   rk,   dk,   sk,   grizi_grunt, return, init, _info
dw s1, s2, s3, s4, s5, s6, s7, s8, s9, s0, by_steps, kolobcol, set_point
include 'handlers.asm'
