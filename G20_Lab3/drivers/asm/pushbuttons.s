.text
.equ KEY_3_TO_0, 0xFF200050
.equ INTERRUPT, 0xFF200058
.equ EDGECAPTURE, 0xFF20005C


.global read_PB_data_ASM
.global PB_data_ispressed_ASM
.global read_PB_edgecap_ASM
.global PB_edgecap_is_pressed_ASM
.global PB_clear_edgecap_ASM
.global enable_PB_INT_ASM
.global disable_PB_INT_ASM

///////////////////////////////
// PUSH BUTTON SUBROUTINES ////
///////////////////////////////

read_PB_data_ASM:
	LDR R1, =KEY_3_TO_0
	LDR R0, [R1]
	BX LR

PB_data_ispressed_ASM:
	LDR R1, =KEY_3_TO_0
	LDR R2, [R1]
	AND R2, R2, R0
	CMP R2, R0
	MOVEQ R0, #1
	MOVNE R0, #0
	BX LR

///////////////////////////	
// EDGECAP SUBROUTINES ////
///////////////////////////

read_PB_edgecap_ASM:
	LDR R1, =EDGECAPTURE
	LDR R0, [R1]
	AND R0, R0, #0xFFFFFFFF
	BXEQ LR	


PB_edgecap_is_pressed_ASM:	
	LDR R1, =EDGECAPTURE
	LDR R2, [R1]
	AND R2, R2, R0
	CMP R2, R0
	MOVEQ R0, #1
	MOVNE R0, #0
	BX LR

PB_clear_edgecap_ASM:
	LDR R1, =EDGECAPTURE
	MOV R2, R0
	STR R2, [R1] // Performing a write operation sets all bits in register to 0
	BX LR

////////////////////////////////////////////////
// ENABLE AND DISABLE PUSHBUTTON SUBROUTINES ///
////////////////////////////////////////////////

enable_PB_INT_ASM:
	LDR R1, =INTERRUPT
	AND R2, R0, #0xFFFFFFFF // Set IR bit of PB input to 1
	STR R2, [R1]
	BX LR

disable_PB_INT_ASM:
	LDR R1, =INTERRUPT
	LDR R2, [R1] 
	BIC R2, R2, R0 // Set IR bit of PB input to 0
	STR R2, [R1] // Write to IR
	BX LR


.end