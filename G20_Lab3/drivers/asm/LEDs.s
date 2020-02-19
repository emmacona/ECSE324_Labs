.text
.equ LED_BASE, 0xFF200040
.global read_LEDs_ASM
.global write_LEDs_ASM

read_LEDs_ASM:
	PUSH {R1}
	PUSH {LR}
	LDR R1, =LED_BASE
	LDR R0, [R1]
	BX LR

write_LEDs_ASM:
	PUSH {R1}
	PUSH {LR}
	LDR R1, =LED_BASE
	STR R0, =LED_BASE
	POP{LR}
	POP{R1}
	BX LR

.end