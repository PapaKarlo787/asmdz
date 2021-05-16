init:
	mov ax, 0
	int 10h
	mov ah, 2
	mov bh, 0
	mov dx, 0x1900
	int 10h
	include 'rus/new_tab.asm'
	mov bp, sprites
	call load_sprites
	mov di, 0
	mov word [napr], 0
	mov word [position], 0
	mov word [speed1], 0xf000
	mov word [speed2], 1
	mov word [myflags], 0
	mov word [n_positions], 0
	mov word [points], 0
	mov word [face], init_face
	mov ax, 0x2e00
	mov cx, 920
	rep stosw
	call .print_info
	mov byte[es:1996], 0xf9
	mov byte[es:1916], '2'
	ret

.print_info:
	set_for_print 0xa, 7, 0x1700, m1
	call print_info
	set_for_print 0xa, 9, 0x1800, m2
	call print_info
	set_for_print 3, 9, 0x171c, m3
	call print_info
	set_for_print 3, 12, 0x1819, m4
	call print_info
	set_for_print 13, 9, 0x180a, m5
	call print_info
	ret

load_sprites:
	push ds
	pop es
	mov dx, 1
	mov cx, 16
	mov bx, 1000h
	mov ax, 1100h
	int 10h
	mov bp, sprites+256
	mov dx, 0xf0
	mov cx, 8
	mov bx, 1000h
	mov ax, 1100h
	int 10h
	mov bp, fox
	mov dx, 0xb0
	mov cx, 8
	mov bx, 1000h
	mov ax, 1100h
	int 10h
	push 0xb800
	pop es
	ret
