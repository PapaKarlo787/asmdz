mov di, 488

new:
	mov cl,10h
	slp:
		stosd
		inc ax
		loop slp
	add di, 96
	cmp al, 0
	jne new
