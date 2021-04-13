macro sleep n
{
	mov ah,0x86
	int 0x15
}

macro drawScreen
{	
	mov dx,0x0100
	mov bl,5
	mov si,1
	mov al,0xC9
	call printBlock
	mov al,0xCD
.loop:
	add dx,si
	call printBlock
	cmp dx,0x0116
	je .RU
	cmp dx,0x1716
	je .RD
	cmp dx,0x1700
	je .LD
	cmp dx,0x0200
	je .LU
	
	jmp .loop
.RU:
	mov si,256
	mov al,0xBB
	call printBlock
	mov al,0xBA
	jmp .loop
.RD:
	mov si,65535
	mov al,0xBC
	call printBlock
	mov al,0xCD
	jmp .loop
.LD:
	mov si,65280
	mov al,0xC8
	call printBlock
	mov al,0xBA
	jmp .loop
.LU:
}

macro selNapr 
{
	mov al,[napr]
	cmp al,0x4d
	je .n1
	cmp al,0x4b
	je .n2
	cmp al,0x50
	je .n3
	dec dh
	jmp .exit
.n2:
	dec dl
	jmp .exit
.n3:
	inc dh
	jmp .exit
.n1:
	inc dl
.exit:
}
	
macro checkColission
{
	cmp dl, 22
	je sdl
	cmp dl, 0
	je adl
	cmp dh, 23
	je sdh
	cmp dh, 1
	jne nobord
adh:add dh,21
	jmp nobord
adl:add dl,21
	jmp nobord
sdh:sub dh,21
	jmp nobord
sdl:sub dl,21
nobord:
}

macro checkColissionInMemory
{
	sub esi,2;Смещаем esi по куче
	cmp esi, HEAPOS
	jge .nmesi
	add esi, 884
.nmesi:	

	sub edi,2;Смещаем edi по куче
	cmp edi, HEAPOS
	jge .nmedi
	add edi, 884
.nmedi:	
}

macro initScreen
{
	xor ax,ax               	; // Функуия устновки видео режима
	int  0x10                   ; // Прервывание биос  настройки экрана
}

macro readKey 
{
	mov ah,1
	int 16h
	mov al,[napr]
	cmp ah, 0x4b                 ; left arrow
	je .left  		             ; http://stackoverflow.com/questions/16939449/how-to-detect-arrow-keys-in-assembly
	cmp ah, 0x48                 ; up arrow
	je .up
	cmp ah, 0x4d				 ; right arrow
	je .right
	cmp ah,0x50					 ; down arrow 
	jne .e
	
	cmp al,0x48
	je .e
	jmp .ok
.left:
	cmp al,0x4d
	je .e
	jmp .ok
.right:
	cmp al,0x4b
	je .e
	jmp .ok
.up:
	cmp al,0x50
	je .e
.ok:
	mov [napr],ah
.e:
	CLI                   ;запрещаем прерывания
	SUB  AX,AX            ;обнуляем регистр
	MOV  ES,AX            ;добавочный сегмент - с начала памяти
	MOV  AL,[ES:41AH]     ;берем указатель на голову буфера
	MOV  [ES:41CH],AL     ;посылаем его в указатель хвоста
	STI                   ;разрешаем прерывания
}

macro PrintNum  ;Печатаем число ax в конец первой строки
{
	pushad
	mov edx,0x000B804F
.start:
	mov cx,0x020A
	div cl
	add ah,'0'
	mov [edx], ch
	dec dx
	mov [edx], ah
	xor ah,ah
	dec dx
	cmp ax,0
	jnz .start
	popad
}
