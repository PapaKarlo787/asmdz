s1:
mov byte[es:1916], '1'
mov word[speed1], 0x3000
mov word[speed2], 2
ret

s2:
mov byte[es:1916], '2'
mov word[speed1], 0x0000
mov word[speed2], 2
ret

s3:
mov byte[es:1916], '3'
mov word[speed1], 0xd000
mov word[speed2], 1
ret

s4:
mov byte[es:1916], '4'
mov word[speed1], 0xa000
mov word[speed2], 1
ret

s5:
mov byte[es:1916], '5'
mov word[speed1], 0x7000
mov word[speed2], 1
ret

s6:
mov byte[es:1916], '6'
mov word[speed1], 0x4000
mov word[speed2], 1
ret

s7:
mov byte[es:1916], '7'
mov word[speed1], 0x1000
mov word[speed2], 1
ret

s8:
mov byte[es:1916], '8'
mov word[speed1], 0xe000
mov word[speed2], 0
ret

s9:
mov byte[es:1916], '9'
mov word[speed1], 0xb000
mov word[speed2], 0
ret

s0:
mov byte[es:1916], '0'
mov word[speed1], 0xffff
ret
