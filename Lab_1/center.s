	.text
	.global _start 
	

_start:
		LDR R1, =ADD_RESULT
		LDR R2, =AVG_RESULT
		LDR R8, =DIV_COUNTER
		LDR R3, [R1, #4] //Counter ie N  
		ADD R4, R1, #8   //R4 points to the first number 
		LDR R5, [R4]   	//R5 holds the first number in the list
		
LOOP: 	
		SUBS R3, R3, #1
		BEQ CALC_AVG
		ADD R4, R4, #4
		ADD R6, R6, R4
		STR R6, [R1]
		B LOOP

CALC_AVG:	
		SUBS R7, R1, #7
		ADD R8, R8, #1
		BGE	CALC_AVG

SUB_LOOP: 
		SUBS R9, R9, R8
		STR R5,[R9]
		BEQ END
		ADD R4, R4, #4
		LDR R9, [R4]
		B SUB_LOOP

END: B END

AVG_RESULT:	.word	4
ADD_RESULT:	.word   0
N:			.word	7			//number of entries in the list 
NUMBERS:	.word	4, 5, 3, 6	//the list data 
			.word	1, 8, 2
DIV_COUNTER: .word 0

.end
