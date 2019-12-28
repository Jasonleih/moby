.code16

.global _bootstart

.equ BOOTSEG, 0x07c0

ljmp $BOOTSEG, $_bootstart

_bootstart:
	jmp _bootstart

.= 510

signature:
	.word 0xaa55 

