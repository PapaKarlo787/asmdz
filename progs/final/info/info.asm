create_info:
	mov ah, 2
	mov bh, 1
	mov dx, 0x1900
	int 10h
	set_for_print 0x10a, infolines_end-infolines, 16, infolines
	call print_info
	set_for_print 0x10c, 4, 0x320, foxnums
	call print_info
	set_for_print 0x10c, 4, 0x420, foxnums+4
	call print_info
	set_for_print 0x10e, 2, 0x31c, foxnums+8
	call print_info
	ret
	




infolines:
db '�����', 15, 16, '�', 0x0d, 0xa
db 'F1 - ���ଠ��', 0x0d, 0xa
db 'S - �������� �� 蠣��', 0x0d, 0xa
db 'Q - ����', 0x0d, 0xa
db 'Enter - �������� �����', 0x0d, 0xa
db 'C - �������� 梥� �������', 0x0d, 0xa
db 'P - ����ந�� ���� �����', 0x0d, 0xa
db '0-9 - �������', 0x0d, 0xa
infolines_end:

foxnums:
db 0xb0,0xb1,0xb2,0xb3 
db 0xb4,0xb5,0xb6,0xb7 
db 1,2
