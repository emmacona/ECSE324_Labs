// Fibonacci program with recursive subroutine

.text
.global _start


// Registers - Tracker:
// R0: n
// R1:
// R2:
// R3: Holds the current value of n

_start:
	LDR R0, =N // points to value of n



FIB: 
	CMP R0, #2			// compare R0 (n) to 2
	MOVLT R0, #1		// if n < 2, then R0 = 1
	MOVLT PC, LR		// and go to LR (aka "MUL R0, R3, R0")
	STDB SP!, {LR} 		// push LR
	MOV R3, R0 			// Move n into R3
	SUB R0, R0, #1 		// R0 = n -1
	BL FIB 				// call fib(n-1)
	
	ADD R0, R3, R0 		// R0 <- fib(n-2) + fib(n-1)
	LDMIA SP!, {PC} 	// pop PC


N: .word 5 // value we want to compute (fact(n))