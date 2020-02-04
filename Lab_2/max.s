// Assembly code which computes the max of an array using an assembly subroutine 

	.text
	.global _start

// Registers - Traker :
// R0: Arg 1, and return value
// R1: Arg 2
// R2: Arg 3
// R3: Arg 4
// R4: Pointer to N
// R5: Value of N
// R6: List of numbers
// R7: Next number in the list
// R8: Result value
// R9: TOS

_start: 
	LDR R6, =NUMBERS // points to the list
	LDR R0, [R6] // R0 holds the first element
	LDR R1, [R6, #4] // R1 holds the second element
	LDR R2, [R6, #8] // R2 holds the third element
	LDR R3, [R6, #12] // R3 holds the fourth element
	LDR R4, =N // points to N
	LDR R5, [R4] // number of elements in the list
	LDR R8, =RESULT // holds the result

CALLER:	
	BL MAX
	STR R0, [R8]
	B END

MAX:
	SUBS R5, R5, #1		// decrement the loop counter 
	BEQ DONE			// end loop if counter has reached 0
	PUSH {R1-R3} 		// push R1 to R3
	LDR R9, [SP], #4 // pop TOS
	CMP R0, R9 // compare R0 to the next element (R9)
	BGE MAX // If R0 > R9 move on to next
	MOV R0, R9 // If R9 > R0 replace R0 with R9
	B MAX

DONE: BX LR

END: 	B END 				// infinite loop!


RESULT: .word 0 // memory assigned for result
N:	.word	4	// number of entries in the list 
NUMBERS:	.word	1, 2, 3, 4	// the list data 

