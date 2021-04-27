
; ==============================================================================
; MACROS
; ==============================================================================
; Sleeps for the given number of microseconds.
macro sleep n
{
	pusha
	xor cx, cx
	mov dx, n
	mov ah, 0x86
	int 0x15
	popa
}

; Choose a brick at random.
macro select_brick
{
	mov ah, 2                    ; get current time
	int 0x1a
	mov al, byte [seed_value]
	xor ax, dx
	mov bl, 31
	mul bx
	inc ax
	mov byte [seed_value], al
	xor dx, dx
	mov bx, 7
	div bx
	shl dl, 3
	xchg ax, dx                  ; mov al, dl
}

; Sets video mode and hides cursor.
macro clear_screen
{
	xor ax, ax                   ; clear screen (40x25)
	int 0x10
	mov ah, 1                    ; hide cursor
	mov cx, 0x2607
	int 0x10
}

macro init_screen
{	
	xor bh,bh
	clear_screen
	mov dh, [start_row_col+1]          ; row
	mov cx, [number_of_rows]         ; number of rows
ia: push cx
	inc dh                           ; increment row
	mov dl, [field_left_col]         ; set column
	mov cx, [field_width]            ; width of box
	mov bl, 0x78                     ; color
	call set_and_write
	mov ah, [number_of_rows]
	add ah, [start_row_col+1]
	cmp dh, ah                       ; don't remove last line
	je ib                            ; if last line jump
	inc dl                           ; increase column
	mov cx, [inner_width]            ; width of box
	xor bl, bl                       ; color
	call set_and_write
ib: pop cx
	loop ia
}

; DH = current row
macro replace_current_row
{
	pusha                           ; replace current row with row above
 	mov dl, [inner_first_col]
 	mov cx, [inner_width]
cf_aa:
	push cx
	dec dh                          ; decrement row
	call set_and_read
	inc dh                          ; increment row
	mov bl, ah                      ; color from AH to BL
	mov cl, 1
	call set_and_write
	inc dx                          ; next column
	pop cx
	loop cf_aa
	popa
}


; ==============================================================================

