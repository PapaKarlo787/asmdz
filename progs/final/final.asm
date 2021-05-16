org 100h
call init
call create_info
call _info

main:
call update_positions
call print_points
call keyhandler
cmp word [speed1], 0xffff
je main
mov ax, [myflags]
and ax, 1
jnz main
call rotate
mov cx, [speed2]
mov dx, [speed1]
mov ah, 0x86
int 15h
jmp main

include 'general_funcs/print_line.asm'
include 'init.asm'
include 'sprites.asm'
include 'angry.asm'
include 'speeds.asm'
include 'info/print_points.asm'
include 'info/info.asm'
include 'rus/tab.asm'
include 'rus/new_tab.asm'
include 'sound.asm'
include 'general_funcs/keyhandler.asm'
include 'general_funcs/rotates.asm'
include 'general_funcs/updater_pos.asm'


m1:
db 'Катится'
db 'Шагает '
m2:
db 'Не грызет'
db 'Грызет   '
m3:
db 'Скорость:   '
m4:
db 'Направление:   '
m5:
db 'Очки:   0'

include 'variables.asm'
