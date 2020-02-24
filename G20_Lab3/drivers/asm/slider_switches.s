		.text
		.equ SW_BASE, 0xFF200040 //Defines Base Register for LEDs 
		.global read_slider_switches_ASM //External call 

read_slider_switches_ASM:
		LDR R1, =SW_BASE //Loads pointer to adress of first switch into R1
		LDR R0, [R1] //Loads contents of R1 into R0
		BX LR
		.end


		