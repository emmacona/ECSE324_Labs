// Fibonacci program with recursive subroutine

.text
.global _start


// Registers - Tracker:
// R0: Result
// R1: n to be computed --> fib(n)
// R2: n - 1
// R3: n - 2

_start:
	LDR R1, N // value of n	
	PUSH {R1, LR} // store n and lr 
	BL FIB
	STR R0, RESULT
	POP {R1, R2, R3, LR} // restore original register values
	B END
	

FIB: 
	PUSH {LR}	

	CMP R1, #2			// compare R1 (n) to 2
	BLT LESS_2 		// if n < 2 branch to last step
	
	SUB R2, R1, #1 	// else store n - 1 into R2
	SUB R3, R1, #2 	// store n-2 into R3
	PUSH {R3} 		// push n-2 on stack for later
	MOV R1, R2
	BL FIB 			// call fib (n - 1)

	POP {R3} // n-1
	PUSH {R1} // push f(n-1)
	MOV R1, R3 // Change R1 to be n-2
	BL FIB //cal fib(n-2)

	MOV R3, R1 // R3 holds n-2
	POP {R2} //pop fib(n-1)
	
	ADD R0, R2, R3 // resutl stored in R0, return value
	POP {LR}
	BX LR


LESS_2: 
	MOV R1, #1		// if n < 2, then R1 = 1
	POP {LR}
	BX LR 			//back to start

END: B END //infinite loop


RESULT: .word 0 // fib result
N: .word 4 // value we want to compute (fact(n))
