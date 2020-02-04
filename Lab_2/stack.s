// Re-write stack program

.text
.global _start


// Registers - Tracker :
// R0 : Return value (convention)

// R2: Pointer -- Number of elements in the list
// R3: List of elements (points to 1st element)
// R4: Value -- Number of elements in the list
// R5 : Fake stack pointer

_start:
	LDR R5, FAKE_SP
	LDR R2, N
	LDR R3, =NUMBERS
	LDR R4, [R3]


PUSH: // Re-write PUSH { R0 }
	LDR R0, [R3] // Load first element
	STR R0, [R5, #-4]! // push R0 into TOS
	ADD R3, R3, #4 // point to next element in the list
	SUBS R2, R2, #1 // decrement counter
	BEQ POP // if all elements pushed, go to pop
	B PUSH // else push again


POP: // Re-write POP { R0 - R2 }
	LDR R0, [R5], #4 // pop first element into R0 and point to next element
	LDR R1, [R5], #4 // pop second element into R1
	LDR R2, [R5], #4 // pop third element into R2

END: 		B END	// infinite loop

RETURN_VAL: .word 0
FAKE_SP: .word 0
NUMBERS: .word 1, 2, 3  // list data
N: .word 3 // number of elements in the list
