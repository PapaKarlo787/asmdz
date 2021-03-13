printBlock:
	mov ah, 2
	int 10h
	mov ah,0x09
	int 10h
	ret

setRead:
	mov ah, 2
	int 10h
	mov ah,0x08
	int 10h
	ret

randApple:
	pushad
	mov ax, word [rand + 0]
	mov dx, word [rand + 2]
	
	shr dx, 9
	xor ax, dx ; 0 ^ 25
	shr dx, 2
	xor ax, dx ; 27
	shr dx, 2
	xor ax, dx ; 29
	shr dx, 1
	xor ax, dx ; 30
	shr dx, 1
	xor dx, ax ; 31

	; rnd <= { next_bit, rnd[31:1] };
	mov eax, [rand]
	shr dx, 1
	rcr eax, 1
	mov [rand], eax
	
	and ax,0x0F0F
	add ax,0x0303
	mov [apple],ax	
	popad
	ret
