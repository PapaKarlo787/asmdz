mov cl, 16
hlp:
    mov al, 16
    sub al, cl
    al_to_hex
	stosd
	loop hlp
