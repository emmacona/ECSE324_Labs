.text

.equ HPS_TIM_1, 0xFFC08000 // 100 MHz
.equ HPS_TIM_2, 0xFFC09000 // 100 MHz
.equ HPS_TIM_3, 0xFFD00000 // 25 MHz
.equ HPS_TIM_4, 0xFFD01000 // 25 MHz


.global HPS_TIM_config_ASM
.global HPS_TIM_read_INT_ASM
.global HPS_TIM_clear_INT_ASM



HPS_TIM_config_ASM:
	LDR R1, [R0] // load timer one-hot from struct

	TST R1, #1 // One hot encoding check for first timer
	LDRNE R2, =HPS_TIM_1 // Address of timer

	TST R1, #2 // One hot encoding check for second timer
	LDRNE R2, =HPS_TIM_2 // Address of timer

	TST R1, #4 // One hot encoding check for third timer
	LDRNE R2, =HPS_TIM_3 // Address of timer

	TST R1, #8 // One hot encoding check for fourth timer
	LDRNE R2, =HPS_TIM_4 // Address of timer

	//LDR R1, [R0, #16] // load 'enable' from struct
	//CMP R1, #1
	//ANDNE R3, #0b11111111111111111111111111111110 // set bit to 0 (configuration mode)
	MOV R3, #0
	STR R3, [R2, #8] // Set enable bit E in Control register to 1 or 0

	
	LDR R1, [R0, #8] // load 'LD_en' from struct (Load Enable)
	CMP R1, #1
	ORREQ R3, #0b00000000000000000000000000000010 // set bit to 1
	ANDNE R3, #0b11111111111111111111111111111101 // set bit to 0
	STR R3, [R2, #8] // Set M bit in Control register to 1 or 0
	LDREQ R1, [R0, #4] // get the 'timeout' int from struct (microseconds)
	MOV R10, #10
	MUL R1, R1, R10
	STR R1, [R2] // Set the load value in the load register to 'timeout'

	LDR R1, [R0, #12] // load 'INT_en' from struct
	CMP R1, #1
	ORREQ R3, #0b00000000000000000000000000000100 // set bit to 1
	ANDNE R3, #0b11111111111111111111111111111011 // set bit to 0
	STR R3, [R2, #8] // Set I bit in Control register to 1 or 0

	LDR R1, [R0, #16] // load 'enable' from struct
	CMP R1, #1
	LDR R3, [R2, #8]
	ORREQ R3, #0b00000000000000000000000000000001 // set bit to 1 (non configuration mode/start timer)
	STR R3, [R2, #8]
	
	BX LR
HPS_TIM_read_INT_ASM:
		


		TST R0, #8 
		LDRNE R1, =HPS_TIM_4
		LDRNE R3, [R1, #8]
		ANDNE R3, R3, #0b11111111111111111111111111111011 // set bit to 0
		STRNE R3, [R1, #8] // Set I bit in Control register to 1 or 0
		LDRNE R2, [R1, #16]
		

		TST R0, #4 
		LDRNE R1, =HPS_TIM_3
		LDRNE R3, [R1, #8]
		ANDNE R3, R3, #0b11111111111111111111111111111011 // set bit to 0
		STRNE R3, [R1, #8] // Set I bit in Control register to 1 or 0
		LDRNE R2, [R1, #16]
		

		TST R0, #2 
		LDRNE R1, =HPS_TIM_2
		LDRNE R3, [R1, #8]
		ANDNE R3, R3, #0b11111111111111111111111111111011 // set bit to 0
		STRNE R3, [R1, #8] // Set I bit in Control register to 1 or 0
		LDRNE R2, [R1, #16]
		

		TST R0, #1 
		LDRNE R1, =HPS_TIM_1
		LDRNE R3, [R1, #8]
		ANDNE R3, R3, #0b11111111111111111111111111111011 // set bit to 0
		STRNE R3, [R1, #8] // Set I bit in Control register to 1 or 0
		LDRNE R2, [R1, #16]

		AND R3, R2, #0x1 // Will move the S-bit of the last-checked timer into R3
		MOV R4, #0
		EOR R0, R4, R3
		
		
		BX LR

HPS_TIM_clear_INT_ASM:
	
	TST R0, #8
	LDRNE R1, =HPS_TIM_4
	LDRNE R2, [R1, #12]
	

	TST R0, #4
	LDRNE R1, =HPS_TIM_3
	LDRNE R2, [R1, #12]
	

	TST R0, #2
	LDRNE R1, =HPS_TIM_2
	LDRNE R2, [R1, #12]	

	TST R0, #1
	LDRNE R1, =HPS_TIM_1
	LDRNE R2, [R1, #12]

	BX LR
.end