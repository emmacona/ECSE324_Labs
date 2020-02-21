// Fibonacci program with recursive subroutine

.text
.global _start


// Registers - Tracker:
// R0: starts at N, then used as argument
// R2: n - 1
// R3: n - 2

_start:
	LDR R0, N // value of n	
	PUSH {R0, LR} // store n and lr 
	BL FIB
	STR R0, RESULT
	POP {R0, R2, R3, LR} // restore original register values
	B END
	

FIB: 
	PUSH {LR}	// everytime, push back the instruction after BL

	CMP R0, #2			// compare R0 (n) to 2
	BLT LESS_2 		// if n < 2 branch to last step
	
	SUB R2, R0, #1 	// else store n - 1 into R2
	SUB R3, R0, #2 	// store n-2 into R3
	PUSH {R3} 		// push n-2 on stack for later
	MOV R0, R2
	BL FIB 			// call fib (n - 1)

	POP {R3} // n-1
	PUSH {R0} // push f(n-1)
	MOV R0, R3 // Change R1 to be n-2
	BL FIB //cal fib(n-2)

	MOV R3, R0 // R3 holds n-2
	POP {R2} //pop fib(n-1)
	
	ADD R0, R2, R3 // resutl stored in R0, return value
	POP {LR}
	BX LR


LESS_2: 
	MOV R0, #1		// if n < 2, then R0 = 1
	POP {LR}
	BX LR 			//back to fib function

END: B END //infinite loop


RESULT: .word 0 // fib result
N: .word 4 // value we want to compute (fact(n))
