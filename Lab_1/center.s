	.text
	.global _start 

// Registers:
// R3: Counter (starts at N, the nb of elements in list)
// R4: List of numbers
// R5: First element in the list (value)
// R6: Result of the average
// R9: Content of current element when subracting
// R11: Content of the current element when calculating the sum

_start:
		MOV R6, #0
		LDR R3, =N // Counter
		LDR R4, =NUMBERS  // R4 points to the first number 
		LDR R5, [R4]   	//R5 holds the first number in the list
		
SUM_LOOP: 	
		SUBS R3, R3, #1 // counter starts at N, decrement by 1 every time
		BEQ CALC_AVG // if done, go to division for average
		ADD R4, R4, #4 // else point to the next element
		LDR R11, [R4] // store next element in R11
		ADD R6, R6, R11 // add the element to R6
		B SUM_LOOP // loop again until counter reaches 0

CALC_AVG:	
		LSR R6, #3 // 8 elements so to divide by 8 shift by 3 (i.e. 2^3)
		LDR R3, =N // Reset counter to N  
		LDR R4, =NUMBERS  // Reset R4 to first number in list

SUB_LOOP: 
		SUBS R3, R3, #1 // decrement counter by 1
		BEQ END 		// if counter reaches 0 then we are done
		LDR R9, [R4]	// else store content of current element in R9
		SUB R9, R9, R6 // Subtract the average (R6) to the current element
		STR R9, [R4] // Replace R4 (current element) with the new subracted value (R9)
		ADD R4, R4, #4 // point to next element
		B SUB_LOOP // loop again until all elements have been subracted with the average

END: B END

N:			.word	8			//number of entries in the list 
NUMBERS:	.word	-4, 5, -3, 6	//the list data 
			.word	1, -8, 2, 7

.end



