		.text
		.equ L_BASE, 0xFF200000 //Defines data register adress of LEDS
		.global read_LEDs_ASM  //external
		.global write_LEDs_ASM  //external

read_LEDs_ASM:
		LDR R1, =L_BASE //loads a pointer adress of LED data register 
		LDR R0, [R1]
		BX LR

write_LEDs_ASM:
		LDR R1, =L_BASE //loads a pointer adress of LED data register 
		STR R0, [R1]	//stores RO into contents of R1
		BX LR
		.end
