.code16

.global _bootstart

.equ BOOTSEG, 0x07c0
.equ INITSEG, 0x9000
.equ DEMOSEG, 0x1000
.text
ljmp $BOOTSEG, $_bootstart

_bootstart:
	mov $0x03, %ah
	int $0x10
	mov $BOOTSEG,%ax
	mov %ax,%es
	mov $_str,%bp
	mov $0x1301,%ax
	mov $0x0007,%bx
	mov $16,%cx
	int $0x10

_load_demo:
	mov $0x0000,%dx
	mov $0x0002,%cx
	mov $DEMOSEG,%ax
	mov %ax,%es
	mov $0x0200,%bx
	mov $0x02,%ah
	mov $4,%al
	int $0x13
	jnc demo_load_ok
	jmp _load_demo

demo_load_ok:
	mov $DEMOSEG,%ax
	mov %ax,%ds
	ljmp $0x1020,$0

_str:
	.ascii "hello world!"
	.byte 13,10,13,10

.= 510

signature:
	.word 0xaa55 

