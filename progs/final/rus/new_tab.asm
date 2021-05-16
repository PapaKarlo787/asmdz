push cs
pop es
mov     bp, Font
mov     dx, 128
mov     cx, 48
mov     bx, 1000h
mov     ax, 1100h
int     10h

mov     bp, Font2
mov     dx, 224
mov     cx, 16
mov     bx, 1000h
mov     ax, 1100h
int     10h

xor ax, ax
mov bx, ax
mov cx, ax
mov dx, ax
mov bp, ax
