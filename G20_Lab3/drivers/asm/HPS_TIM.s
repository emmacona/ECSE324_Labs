.text

.equ HPS_TIM_1, 0xFFC08000 // 100 MHz
.equ HPS_TIM_2, 0xFFC09000 // 100 MHz
.equ HPS_TIM_3, 0xFFD00000 // 25 MHz
.equ HPS_TIM_4, 0xFFD01000 // 25 MHz


.global HPS_TIM_config_ASM
.global HPS_TIM_read_INT_ASM
.global HPS_TIM_clear_INT_ASM


///////////////////////
// CONFIG SUBROUTINE //
///////////////////////

HPS_TIM_config_ASM:
	LDR R1, [R0] // Timer passed through R0
	// check timers locations
	TST R1, #1 // Check if timer 1 is started
	LDRNE R2, =HPS_TIM_1 // If not, set the address to timer 1
	TST R1, #2 // Check for second timer
	LDRNE R2, =HPS_TIM_2 // If not, set the address to timer 2
	TST R1, #4 // Check for third timer
	LDRNE R2, =HPS_TIM_3 // If not, set the address to timer 3
	TST R1, #8 // One hot encoding check for fourth timer
	LDRNE R2, =HPS_TIM_4 // If not, set the address to timer 4

	MOV R3, #0 // R3 = enable register
	STR R3, [R2, #8] // Set the enable to timer value
	
	// config timeout
	LDREQ R1, [R0, #4] // Load the timout field from timer struct
	CMP R1, #1 // if enable is one
	MOV R10, #10
	MUL R1, R1, R10
	STR R1, [R2]

	// config LD_en
	LDR R1, [R0, #8] // Load the LD_en from the timer struct
	ORREQ R3, #0b00000000000000000000000000000010 // if it is one, set the enable register to 1
	ANDNE R3, #0b11111111111111111111111111111101 // else set the enable register to 0
	STR R3, [R2, #8]

	// config INT_en
	LDR R1, [R0, #12] // Load the INT_en field from timer struct
	CMP R1, #1
	ORREQ R3, #0b00000000000000000000000000000100 // if it is one, set the enable register to 1
	ANDNE R3, #0b11111111111111111111111111111011 // else set the enable register to 0
	STR R3, [R2, #8] 

	// config enable from struct
	LDR R1, [R0, #16] // Load the enable field from timer struct
	CMP R1, #1
	LDR R3, [R2, #8]
	ORREQ R3, #0b00000000000000000000000000000001 // if it is one, set the enable register to 1
	STR R3, [R2, #8]
	
	BX LR

/////////////////////
// READ SUBROUTINE //
/////////////////////

HPS_TIM_read_INT_ASM:
		// READ DISPLAY 1
		TST R0, #1 
		LDRNE R1, =HPS_TIM_1
		LDRNE R3, [R1, #8] // R3 is the control register
		ANDNE R3, R3, #0b11111111111111111111111111111011 // We set 8 to 0
		STRNE R3, [R1, #8] // Set I bit in Control register to 1 or 0
		LDRNE R2, [R1, #16]

		// READ DISPLAY 2
		TST R0, #2 
		LDRNE R1, =HPS_TIM_2
		LDRNE R3, [R1, #8]
		ANDNE R3, R3, #0b11111111111111111111111111111011 // We set 8 to 0
		STRNE R3, [R1, #8] // Update control register
		LDRNE R2, [R1, #16]

		// READ DISPLAY 3
		TST R0, #4 
		LDRNE R1, =HPS_TIM_3
		LDRNE R3, [R1, #8]
		ANDNE R3, R3, #0b11111111111111111111111111111011 // We set 8 to 0
		STRNE R3, [R1, #8] // Update control register
		LDRNE R2, [R1, #16]

		// READ DISPLAY 4
		TST R0, #8 // var passed through R0
		LDRNE R1, =HPS_TIM_4
		LDRNE R3, [R1, #8]
		ANDNE R3, R3, #0b11111111111111111111111111111011 // We set 8 to 0
		STRNE R3, [R1, #8] // Update control register
		LDRNE R2, [R1, #16]

		// Return value
		AND R3, R2, #0x1
		MOV R4, #0
		EOR R0, R4, R3 // return R0

		BX LR

//////////////////////
// CLEAR SUBROUTINE //
//////////////////////

HPS_TIM_clear_INT_ASM:
	// Clear tim 1
	TST R0, #1
	LDRNE R1, =HPS_TIM_1
	LDRNE R2, [R1, #12]

	// Clear tim 2
	TST R0, #2
	LDRNE R1, =HPS_TIM_2
	LDRNE R2, [R1, #12]	

	// Clear tim 3
	TST R0, #4
	LDRNE R1, =HPS_TIM_3
	LDRNE R2, [R1, #12]

	// Clear tim 4
	TST R0, #8
	LDRNE R1, =HPS_TIM_4
	LDRNE R2, [R1, #12]

	BX LR
	
.end