.text
		.global _start

// Registers:
// R1: Number of elements
// R2: Boolean
// R3: counter
// R4: List of numbers
// R5: Next element
// R6: Current element
// R7: Next element
// R8: Temp data of current (used to swap)
// R9: Temp data of next (used to swap)


_start:
			LDR R1, =N 		// Point to the number of elements in the list
			LDR R1, [R1]	// R1 has the content of address of N i.e. the number of elements
			MOV R2, #0		// Boolean for sorting status (0 = false)

OUTER_LOOP:	CMP R2, #1		// Compare the boolean sorting status to 1
			BEQ END			// If sorted (R2 == 0), then go to END infinite loop
			MOV R3, #1		// Outer loop counter // start at 1
			LDR R4, =NUMBERS	// Points to the list of numbers
			ADD R5, R4, #4	// R5 points to second element
			MOV R2, #1

INNER_LOOP:	CMP R3, R1		//Compare counter to number of elements in list
			BEQ OUTER_LOOP 	// if went through all elements, go back to outer while loop
			LDR R6, [R4]	// R6 is the current element
			LDR R7, [R5]	// R7 is the next element in the list we will compare
			ADD R3, R3, #1	// counter++
			ADD R8, R4, #0		// Store current element (temp_current)
			ADD R9, R5, #0		// Store next element (temp_next)
			ADD R4, R4, #4	// Make current point to next element
			ADD R5, R5, #4	// Make next element point to the next element after it
			CMP R6, R7		// Check if next element is smaller than current
			BGE	INNER_LOOP	// If R7 >= R6 --> loop again
			B SWAP // Else swap the elements

SWAP: 		STR R7, [R8] // next becomes current
			STR R6, [R9] // current becomes next
			MOV R2, #0	// Set sorted to false so "while" executes again
			B INNER_LOOP		// Go back to inner loop

END:		B END

N:			.word	8	// Number of entries in the list 
NUMBERS:		.word	7, 8, 1, 2, 3, 5, 4, 6  // The list data 