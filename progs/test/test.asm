org 100h
begin:
xor ax, ax
mov bx, ax
mov cx, 1
int 10h
lp:
mov ah, 0
int 16h
cmp ah, 1
je exit
mov dh, ah
mov ah, 0eh
int 10h
cmp dh, 0eh
jne lp
mov ax, 0a00h
int 10h
jmp lp

exit:
ret 

times 2048 - ($ - 100h) db 0
