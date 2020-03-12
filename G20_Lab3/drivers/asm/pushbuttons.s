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
	LDR R1, =KEY_3_TO_0 // Load pointer to address of keys 3 to 0
	LDR R0, [R1] // Load content of keys 3 to 0
	BX LR

PB_data_ispressed_ASM: 
	LDR R1, =KEY_3_TO_0 // Load pointer to address of keys 3 to 0
	LDR R2, [R1] // Load content of keys 3 to 0
	AND R2, R2, R0 
	CMP R2, R0 // Compare to PB value that is passed 
	MOVEQ R0, #1 // if the same, set boolean to true (i.e. return 1)
	MOVNE R0, #0 // else, set boolean to false (i.e. return 0)
	BX LR

///////////////////////////	
// EDGECAP SUBROUTINES ////
///////////////////////////

read_PB_edgecap_ASM:
<<<<<<< HEAD
	LDR R1, =EDGECAPTURE
	LDR R0, [R1]
	AND R0, R0, #0xFFFFFFFF //Bitwise AND to see 
=======
	LDR R1, =EDGECAPTURE // Load pointer to address of edgecap
	LDR R0, [R1] // Load content of edgecap
	AND R0, R0, #0xFFFFFFFF 
>>>>>>> 9203b6faf6ee087b989e79f19a31777195fcaa3b
	BXEQ LR	


PB_edgecap_is_pressed_ASM:	
	LDR R1, =EDGECAPTURE // Load pointer to address of edgecap
	LDR R2, [R1] // Load content of edgecap
	AND R2, R2, R0
	CMP R2, R0  // Compare to edgecap value that is passed 
	MOVEQ R0, #1 // if the same, set boolean to true (i.e. return 1)
	MOVNE R0, #0 // else, set boolean to false (i.e. return 0)
	BX LR

PB_clear_edgecap_ASM:
	LDR R1, =EDGECAPTURE // Load pointer to address of edgecap
	MOV R2, R0 
	STR R2, [R1] // Set all to zero
	BX LR

////////////////////////////////////////////////
// ENABLE AND DISABLE PUSHBUTTON SUBROUTINES ///
////////////////////////////////////////////////

enable_PB_INT_ASM:
	LDR R1, =INTERRUPT // Load pointer to address of INTERRUPT
	AND R2, R0, #0xFFFFFFFF // set to 1 (i.e. enable)
	STR R2, [R1] // Write 
	BX LR

disable_PB_INT_ASM:
	LDR R1, =INTERRUPT // Load pointer to address of INTERRUPT
	LDR R2, [R1] 
	BIC R2, R2, R0 // set to 0 (i.e. disable)
	STR R2, [R1] // Write
	BX LR


.end