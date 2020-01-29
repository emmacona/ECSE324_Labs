	.text
	.global _start 
	

_start:
		LDR R1, =ADD_RESULT
		LDR R2, =AVG_RESULT
		LDR R8, =DIV_COUNTER
		MOV R6, #0
		LDR R3, [R1, #4] //Counter ie N  
		ADD R4, R1, #8   //R4 points to the first number 
		LDR R5, [R4]   	//R5 holds the first number in the list
		
LOOP: 	
		SUBS R3, R3, #1
		BEQ CALC_AVG
		ADD R4, R4, #4
		LDR R11, [R4]
		ADD R6, R6, R11
		B LOOP

CALC_AVG:	
		LSR R6, #3
		LDR R3, [R1, #4] //Counter ie N  
		ADD R4, R1, #8   //R4 points to the first number 

SUB_LOOP: 
		SUBS R3, R3, #1
		BEQ END
		LDR R9, [R4]
		SUB R9, R9, R6
		STR R9, [R4]
		ADD R4, R4, #4
		B SUB_LOOP

END: B END

AVG_RESULT:	.word	4
ADD_RESULT:	.word   0
N:			.word	8			//number of entries in the list 
NUMBERS:	.word	-4, 5, -3, 6	//the list data 
			.word	1, -8, 2, 7
DIV_COUNTER: .word 0

.end



