.text
	
	.global A9_PRIV_TIM_ISR
	.global HPS_GPIO1_ISR
	.global HPS_TIM0_ISR
	.global HPS_TIM1_ISR
	.global HPS_TIM2_ISR
	.global HPS_TIM3_ISR
	.global FPGA_INTERVAL_TIM_ISR
	.global FPGA_PB_KEYS_ISR
	.global FPGA_Audio_ISR
	.global FPGA_PS2_ISR
	.global FPGA_JTAG_ISR
	.global FPGA_IrDA_ISR
	.global FPGA_JP1_ISR
	.global FPGA_JP2_ISR
	.global FPGA_PS2_DUAL_ISR

	//flags to be updated by their corresponding ISR
	.global hps_tim0_int_flag
	.global pb_int_flag



hps_tim0_int_flag: // set timer flag to 0
	.word 0x0

pb_int_flag: //set pb flag to 0
	.word 0x0

PB_KEY0_int_flag: //set pb0 flag to 0
	.word 0x0

PB_KEY1_int_flag: //set pb1 flag to 0
	.word 0x0

PB_KEY2_int_flag: //set pb2 flag to 0 
	.word 0x0

PB_KEY3_int_flag: //set pb3 flag to 0
	.word 0x0

A9_PRIV_TIM_ISR: //Convention
	BX LR
	
HPS_GPIO1_ISR: //Convention
	BX LR
	
HPS_TIM0_ISR:		//clear interrupt status and assert interrupt flag
	PUSH {LR}		//Push LR to the stack
	MOV R0, #0x1
	BL HPS_TIM_clear_INT_ASM	//clears the edgecap register and also clears all associated interrupts

	LDR R0, =hps_tim0_int_flag
	MOV R1, #1
	STR R1, [R0]				//set interrupt flag to 1
	
	POP {LR}
	BX LR
	
HPS_TIM1_ISR: //Convention
	BX LR
	
HPS_TIM2_ISR: //Convention
	BX LR
	
HPS_TIM3_ISR: //Convention
	BX LR
	
FPGA_INTERVAL_TIM_ISR: //Convention
	BX LR
	
FPGA_PB_KEYS_ISR:
	PUSH {LR}
	BL read_PB_edgecap_ASM //Get the specific pushbutton that was pressed it is in R0
	
	LDR R1, =pb_int_flag  //get the pb flag 
	STR R0, [R1]         //Set the flag to the value of the pb 
	BL PB_clear_edgecap_ASM //clear the edgecap register to reset the interupt 
	
	POP {LR}         //pop the LR from the stack
	BX LR
	
FPGA_Audio_ISR: //Convention
	BX LR
	
FPGA_PS2_ISR: //Convention
	BX LR
	
FPGA_JTAG_ISR: //Convention
	BX LR
	
FPGA_IrDA_ISR: //Convention
	BX LR
	
FPGA_JP1_ISR: //Convention
	BX LR
	
FPGA_JP2_ISR: //Convention
	BX LR
	
FPGA_PS2_DUAL_ISR: //Convention
	BX LR
	
	.end