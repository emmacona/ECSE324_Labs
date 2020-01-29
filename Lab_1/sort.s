.text
		.global _start

_start:
			LDR R1, =N
			LDR R1, [R1]	//R1 holds length of the list
			MOV R10, #0		//sorted = false

OUT_LOOP:	CMP R10, #1		//Check if sorted
			BEQ END
			MOV R2, #1		//R2 holds i (counter)
			LDR R3, =LIST	//R3 points to first element
			ADD R4, R3, #4	//R4 points to second element
			MOV R10, #1

SWAP_LOOP:	CMP R2, R1		//Check if i = N
			BEQ OUT_LOOP
			LDR R5, [R3]	//R5 holds value of current element
			LDR R6, [R4]	//R5 holds value of next element		
			ADD R2, R2, #1	//increment i
			ADD R7, R3, #0		//Copy address of R3
			ADD R8, R4, #0		//copy address of R4
			ADD R3, R3, #4	//Move current pointer one position
			ADD R4, R4, #4	//Move next pointer 1 position
			CMP R6, R5		//Check if [i] < [i-1]
			BGE	SWAP_LOOP	//If bigger or equals, no swap
			STR R6, [R7]
			STR R5, [R8]	//Swapped the 2 elements
			MOV R10, #0		//We swapped, so sorted=false
			B SWAP_LOOP					

END:		B END

N:			.word	8	//length of list
LIST:		.word	7, 8, 1, 2, 3, 5, 4, 6