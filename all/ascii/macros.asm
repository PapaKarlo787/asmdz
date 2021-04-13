macro al_to_hex
{
    cmp al, 10
	sbb al, 0x69
	das
}
