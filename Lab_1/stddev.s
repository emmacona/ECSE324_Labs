	.text
	.global _start


_start: 
		LDR R4, =MAX  //R4 points to the max location
		LDR R5, =MIN	//R5 points to the min location
		LDR R10, =STD_RSLT //
		LDR R2, [R4, #4] //R2 holds the number of elements in the list 
		ADD R3, R4, #8   //R3 points to the first number 
		LDR R0, [R3]   	//R0 holds the first number in the list
		LDR R8, [R3] 	//R8 holds the first number in the list	

		//potenial sharing for the min, but we need another result location for the min 

LOOP_MAX:	SUBS R2, R2, #1		//decrement the loop counter 
			BEQ DONE_MAX		//end loop if counter has reached 0
			ADD R3, R3, #4		//R3 points to the next number in the list
			LDR R1, [R3]		//R1 points to the next number in the list 
			CMP R0, R1 			// check if it is greater than the maximum
			BGE LOOP_MAX		//if no, branch back to the loop 
			MOV R0, R1			// Movw R1 into R0 as it represents the new max value 
			B LOOP_MAX			//branch back to loop

 
LOOP_MIN:	SUBS R2, R2, #1		//decrement the loop counter 
			BEQ DONE_MIN		//end loop if counter has reached 0
			ADD R3, R3, #4		//R3 points to the next number in the list
			LDR R1, [R3]					//R1 points to the next number in the list 
			CMP R8, R1 			// check if it is greater than the maximum
			BLE LOOP_MIN		//if no, branch back to the loop 
			MOV R8, R1			// if yes, update the current max 
			B LOOP_MIN			//branch back to loop 

DONE_MAX: 	STR R0, [R4]		//store the max to the memory location 
			LDR R2, [R5, #8] //R2 holds the number of elements in the list 
			ADD R3, R4, #8   //R3 points to the first number 			
			B LOOP_MIN		//branhes to LOOP_MIN

DONE_MIN: 	STR R8, [R5]    //store the min to the memory location 
			B DEVIDE

DEVIDE:		SUBS R6, R4, R5
			LSR R7, R6, #2 
			STR R7, [R10] 	

END: 	B END 				//infinite loop!

MIN: 		.word	0 
MAX: 		.word 	0	//memoery assigned for result 
N:			.word	7			//number of entries in the list 
NUMBERS:	.word	4, 5, 3, 6	//the list data 
			.word	1, 8, 2
STD_RSLT:	.word	4				 

			.end 
