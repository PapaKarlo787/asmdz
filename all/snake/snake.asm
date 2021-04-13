;Помошник проекта - https://github.com/HFoxtail/
org 100h
	Rdtsc
	mov [rand],eax
	
include 'macros.asm'
	mov cx,1
	initScreen
	drawScreen
	
	mov esi,HEAPOS ;Занoсим в esi адрес кучи
	mov edi,HEAPOS+2
	call randApple
	
start_snake:
	mov dx,[edi]
	mov al,0x00
	mov bl,1
	call printBlock ;Стираем отрисованный символ в хвосте (нулевой символ = пустой)
	mov dx,[esi]
	
	readKey		;Читаем нажатую клавишу и проверяем ее корректность 
	selNapr		;Выбираем направление движения в соответствии с нажатой кнопкой
	checkColission ;Проверяем и корректируем столкновения со стенами
	checkColissionInMemory ;Проерка на то, зашол ли указатель на голову в область программы 

;Определяем клетку, куда пойдет змея
	call setRead
	cmp al,0xB1
	je return
	cmp al,0xFE
	jnz .end
.food:
	call randApple
	mov ax,[score]
	inc ax
	PrintNum
	mov [score],ax
	add edi,2
.end:

	mov [esi],dx
	mov al,0xB1;Рисуем голову змее
	mov bl,7
	call printBlock
.pA:
	mov dx,[apple] ;Рисуем яблоко
	call setRead
	cmp al,0xB1
	jnz .e
	call randApple
	jmp .pA
.e:	
	mov al,0xFE
	mov bl,4
	call printBlock
	mov dx,0xFFFF;Прячем курсор
	call setRead
	
	sleep 1
	
	jmp start_snake
return:
	ret
;Переменные
include 'functions.asm'
score: dw 0x0000
apple: dw 0x0000
napr:  db 0x4d
rand:  dd 0x11010001
HEAPOS:
	times 2048-($-100h) DB 0x02
 ; Сигнатруа загрузочного сектора
