// Re-write stack program

.text
.global _start


// Registers - Tracker :
// R0 : Return value (convention)
// R1 : Fake stack pointer
// R2: Pointer -- Number of elements in the list
// R3: List of elements (points to 1st element)
// R4: Value -- Number of elements in the list
//

_start:
	LDR, R0, =RETURN_VAL // Return value for functions
	LDR, R1, =FAKE_SP
	LDR, R2, =N
	LDR, R3, =NUMBERS
	LDR, R4, [R3]


PUSH: // Re-write PUSH { R0 }
	LDR R0, [R3] // Load first element
	STR R0, [R1, #-4] // push R0 into TOS
	ADD R3, R3, #4 // point to next element in the list
	SUBS R4, R4, #1 // decrement counter
	BEQ POP // if all elements pushed, go to pop
	B PUSH // else push again


POP: // Re-write POP { R0 - R2 }
	LDMIA R1!, {R1, R0-R2} // pop into R0, R1, R2 + Post-index mode (increment R1 after pop)

END: 		B END	// infinite loop

RETURN_VAL: .word 0
FAKE_SP: .word 0
NUMBERS: .word 1, 2, 3, 4 // list data
N: .word 4 // number of elements in the list