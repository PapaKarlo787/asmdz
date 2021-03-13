; Tetris
	org 100h
include "macros.asm"

field_left_col:  db 13
inner_first_col: db 14 ;Связан с field_left_col
field_width:     dw 12
inner_width:     dw 10 ;Связан с field_width
number_of_rows:  dw 20
start_row_col:   dw 0x0212 ; Устанавливает позицию откуда лететь кубикам
delay:      dw 0x7f00
seed_value: dw 0x7f02

start_tetris:
	xor ax, ax
	mov ds, ax
	init_screen

new_brick:
	mov byte [delay], 100            ; 3 * 100 = 300ms
	select_brick                     ; returns the selected brick in AL
	mov dx, [start_row_col]          ; start at row 4 and col 38
lp:
	call check_collision
	jne over                            ; collision -> game over
	call print_brick

wait_or_keyboard:
	xor cx, cx
	mov cl, byte [delay]
wait_a:
	push cx
	sleep 3000                       ; wait 3ms

	push ax
	mov ah, 1                    ; check for keystroke; AX modified
	int 0x16                     ; http://www.ctyme.com/intr/rb-1755.htm
	mov cx, ax
	pop ax
	jz no_key                    ; no keystroke
	call clear_brick
                                 ; 4b left, 48 up, 4d right, 50 down
	cmp ch, 0x4b                 ; left arrow
	je left_arrow                ; http://stackoverflow.com/questions/16939449/how-to-detect-arrow-keys-in-assembly
	cmp ch, 0x48                 ; up arrow
	je up_arrow
	cmp ch, 0x4d
	je right_arrow

	mov byte [delay], 10         ; every other key is fast down
	jmp clear_keys
left_arrow:
	dec dx
	call check_collision
	je clear_keys                 ; no collision
	inc dx
	jmp clear_keys
right_arrow:
	inc dx
	call check_collision
	je clear_keys                ; no collision
	dec dx
	jmp clear_keys
up_arrow:
	mov bl, al
	inc ax
	inc ax
	test al, 00000111b           ; check for overflow
	jnz nf                       ; no overflow
	sub al, 8
nf: call check_collision
	je clear_keys                ; no collision
	mov al, bl
clear_keys:
	call print_brick
	push ax
	xor ah, ah                   ; remove key from buffer
	int 0x16
	pop ax
no_key:
	pop cx
	loop wait_a

	call clear_brick
	inc dh                       ; increase row
	call check_collision
	je lp                        ; no collision
	dec dh
	call print_brick
	call check_filled
	jmp new_brick

over:
	ret
; ------------------------------------------------------------------------------

set_and_write:
	mov ah, 2                    ; set cursor
	int 0x10
	mov ax, 0x0920               ; write boxes
	int 0x10
	ret

set_and_read:
	mov ah, 2                    ; set cursor position
	int 0x10
	mov ah, 8                    ; read character and attribute, BH = 0
	int 0x10                     ; result in AX
	ret

; ------------------------------------------------------------------------------

check_filled:
	pusha
	mov dh, [start_row_col+1]        ; from start_row_col
	add dh, [number_of_rows]		 ; to number_of_rows
next_row:
	dec dh                           ; decrement row
	jz cf_done                       ; at row 0 we are done
	xor bx, bx
	mov cx, [inner_width]
	mov dl, [inner_first_col]          ; start at first inner column
cf_loop:
	call set_and_read
	shr ah, 4                        ; rotate to get background color in AH
	jz cf_is_zero                    ; jmp if background color is 0
	inc bx                           ; increment counter
	inc dx                           ; go to next column
cf_is_zero:
	loop cf_loop
	cmp bl, [inner_width]              ; if counter is 12 full we found a full row
	jne next_row
replace_next_row:                    ; replace current row with rows above
	replace_current_row
	dec dh                           ; replace row above ... and so on
	jnz replace_next_row
	call check_filled                ; check for other full rows
cf_done:
	popa
	ret

clear_brick:
	xor bx, bx
	jmp print_brick_no_color
print_brick:  ; al = 0AAAARR0
	mov bl, al                   ; select the right color
	shr bl, 3
	inc bx
	shl bl, 4
print_brick_no_color:
	inc bx                       ; set least significant bit
	mov di, bx
	jmp check_collision_main
	; BL = color of brick
	; DX = position (DH = row), AL = brick offset
	; return: flag
check_collision:
	mov di, 0
check_collision_main:            ; DI = 1 -> check, 0 -> print
	pusha
	xor bx, bx                   ; load the brick into AX
	mov bl, al
	mov ax, word [bricks + bx]

	xor bx, bx                   ; BH = page number, BL = collision counter
	mov cx, 4
cc:
	push cx
	mov cl, 4
zz:
	test ah, 10000000b
	jz is_zero

	push ax
	or di, di
	jz ee                        ; we just want to check for collisions
	pusha                        ; print space with color stored in DI
	mov bx, di                   ; at position in DX
	xor al, al
	mov cx, 1
	call set_and_write
	popa
	jmp is_zero_a
ee:
	call set_and_read
	shr ah, 4                    ; rotate to get background color in AH
	jz is_zero_a                 ; jmp if background color is 0
	inc bx
is_zero_a:
	pop ax

is_zero:
	shl ax, 1                    ; move to next bit in brick mask
	inc dx                       ; move to next column
	loop zz
	sub dl, 4                    ; reset column
	inc dh                       ; move to next row
	pop cx
	loop cc
	or bl, bl                    ; bl != 0 -> collision
	popa
	ret

; ==============================================================================

bricks:
	;  in AL      in AH
	;  3rd + 4th  1st + 2nd row
	db 01000100b, 01000100b, 00000000b, 11110000b
	db 01000100b, 01000100b, 00000000b, 11110000b
	db 01100000b, 00100010b, 00000000b, 11100010b
	db 01000000b, 01100100b, 00000000b, 10001110b
	db 01100000b, 01000100b, 00000000b, 00101110b
	db 00100000b, 01100010b, 00000000b, 11101000b
	db 00000000b, 01100110b, 00000000b, 01100110b
	db 00000000b, 01100110b, 00000000b, 01100110b
	db 00000000b, 11000110b, 01000000b, 00100110b
	db 00000000b, 11000110b, 01000000b, 00100110b
	db 00000000b, 01001110b, 01000000b, 01001100b
	db 00000000b, 11100100b, 10000000b, 10001100b
	db 00000000b, 01101100b, 01000000b, 10001100b
	db 00000000b, 01101100b, 01000000b, 10001100b

; At the end we need the boot sector signature.
times 2048-($-100h) db 0
