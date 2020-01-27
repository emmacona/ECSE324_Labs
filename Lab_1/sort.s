.text
.global _start

_start:
	LDR R1, =N //counter for outer loop
	LDR R9, =N // counter for inner loop
	LDR R2, =SORTED
	LDR R3, =NOTSORTED
	ADD R4, R1, #12 //R4 points to the first element in the list
	LDR R5, [R4] //R5 holds the first element in the list
	LDR R10, [R4] //R10 holds the first element in the list (second copy)

OUTER_LOOP: 
	SUBS R1, R1, #1 // decrement counter
	BEQ END
	LDR R5, [R5, #4]! // point to next element in list
	BGE INNER_LOOP


INNER_LOOP:
	SUBS R9, R9, #1 // decrement counter
	BEQ RESET 	// when counter done, go to RESET list copy
	ADD R6, R10, #4 // point to next element in the list
	LDR R7, [R6] // hold the next element
	CMP R10, R7 // check if R5 is greater than R7
	BGE INNER_LOOP //bigger --> dont swap
	MOV R8, R7 // else (R7 < R5) --> swap
	MOV R7, R5
	MOV R10, R8
	B INNER_LOOP

RESET:
	ADD R4, R1, #12 //R4 points to the first element in the list
	LDR R10, [R4] //R10 holds the first element in the list (second copy)
	B OUTER_LOOP


END: B END // infinite loop



N:			.word	7			//number of entries in the list 
SORTED:		.word	0			//Sorted
NOTOSRTED:	.word	1			//Not sorted
NUMBERS:	.word	4, 5, 3, 6	//the list data 
			.word	1, 8, 2