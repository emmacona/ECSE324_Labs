#include <stdio.h>

#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/address_map_arm.h"
#include "./drivers/inc/int_setup.h"

int main() {

///////////////////
/// BASIC I/O /////
///////////////////

/*
	while(1){
		// display switches
		write_LEDs_ASM(read_slider_switches_ASM());

		// If 10th switch is pushed, clear display
		if(read_slider_switches_ASM() & 0x200){ 
			HEX_clear_ASM(HEX0);
			HEX_clear_ASM(HEX1);
			HEX_clear_ASM(HEX2);
			HEX_clear_ASM(HEX3);
			HEX_clear_ASM(HEX4);
			HEX_clear_ASM(HEX5);
		}
		else{
			HEX_flood_ASM(HEX4); // flood last 2 hex displays
			HEX_flood_ASM(HEX5); `
			int push_btn = (0b1111 & read_PB_data_ASM()); // Find what PB has been pressed
			char isEnabled = push_btn + 0x30; // convert to ASCII
			HEX_write_ASM(push_btn, isEnabled); // Display on board
		}
	}
*/


////////////////////
// Timer example ///
////////////////////

/*	
	int count0 = 0, count1 = 0, count2 = 0, count3 = 0;
	
	HPS_TIM_config_t hps_tim; // Declare timer struct
	hps_tim.tim = TIM0|TIM1|TIM2|TIM3;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	
	HPS_TIM_config_ASM(&hps_tim); // call subroutine to configurate timer
	
	while (1) {
		write_LEDs_ASM(read_slider_switches_ASM());
		if (HPS_TIM_read_INT_ASM(TIM0)) {
			HPS_TIM_clear_INT_ASM(TIM0);
			if (++count0 == 16)
				count0 = 0;
		HEX_write_ASM(HEX0, (count0+48));
		}
		if (HPS_TIM_read_INT_ASM(TIM1)) {
			HPS_TIM_clear_INT_ASM(TIM1);
			if (++count1 == 16)
				count1 = 0;
			HEX_write_ASM(HEX1, (count1+48));
		}
		if (HPS_TIM_read_INT_ASM(TIM2)) {
			HPS_TIM_clear_INT_ASM(TIM2);
			if (++count2 == 16)
				count2 = 0;
		HEX_write_ASM(HEX2, (count2+48));
		}
		if (HPS_TIM_read_INT_ASM(TIM3)) {
			HPS_TIM_clear_INT_ASM(TIM3);
			if (++count3 == 16)
				count3 = 0;
			HEX_write_ASM(HEX3, (count3+48));
		}
	}
	*/
/*

///////////////////////////
//// POLLING: TIMERS //////
///////////////////////////
	
	// Timer 1: "real" timer
	HPS_TIM_config_t hps_tim; // declare timer
	hps_tim.tim = TIM0;
	hps_tim.timeout = 10000; // 10ms
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	
	HPS_TIM_config_ASM(&hps_tim); // Call subroutine
	

	// Timer 2: inner timer for polling

	HPS_TIM_config_t hps_tim_pb;
	hps_tim_pb.tim = TIM1;
	hps_tim_pb.timeout = 5000;
	hps_tim_pb.LD_en = 1;
	hps_tim_pb.INT_en = 1;
	hps_tim_pb.enable = 1;

	HPS_TIM_config_ASM(&hps_tim_pb); // call subroutine
	
	// Initialize ms, s, min to zero
	int micros = 0;
	int seconds = 0;
	int minutes = 0;

	// Don't start the timer yet
	int start_clock = 0;
	
	while (1) {
		// If the clock is started and timer for seconds is done
		if (start_clock && HPS_TIM_read_INT_ASM(TIM0)) {
			HPS_TIM_clear_INT_ASM(TIM0); // call clear init subroutine
			micros += 10; // add 10ms to ms counter

			// Now, update the ms, s, min variables
			// When ms reached 1000 ==> 1 s
			if (micros >= 1000) {
				micros -= 1000;
				seconds++;
				// When s reaches 60 ==> 1 min
				if (seconds >= 60) {
					seconds -= 60;
					minutes++;
				}
			}

			// Once all values are updated, call subroutine to display
			// +48 to convert to ASCII
			HEX_write_ASM(HEX0, ((micros % 100) / 10) + 48);
			HEX_write_ASM(HEX1, (micros / 100) + 48);
			HEX_write_ASM(HEX2, (seconds % 10) + 48);
			HEX_write_ASM(HEX3, (seconds / 10) + 48);
			HEX_write_ASM(HEX4, (minutes % 10) + 48);
			HEX_write_ASM(HEX5, (minutes / 10) + 48);
		}

		// If PB is pressed
		if (HPS_TIM_read_INT_ASM(TIM1)) {
			
			// clear PB 
			HPS_TIM_clear_INT_ASM(TIM1);
			
			int push_btn = 0xFFFFFFF & read_PB_data_ASM(); // check which PB has been pressed

			// Stop the timer #1
			if if ((push_btn & 2) && (start_clock)) {
				start_clock = 0;
			}
			// Start the timer #1
			else ((push_btn & 1) && (!start_clock)) {
				start_clock = 1;
			}
			// Reset the timer #1
			else if (push_btn & 4) {
				micros = 0;
				seconds = 0;
				minutes = 0;
				start_clock = 0;

				// Reset all display values to zero
				HEX_write_ASM(HEX0, 48);
				HEX_write_ASM(HEX1, 48);
				HEX_write_ASM(HEX2, 48);
				HEX_write_ASM(HEX3, 48);
				HEX_write_ASM(HEX4, 48);
				HEX_write_ASM(HEX5, 48);
			}
		}
	}
	*/
	
	//Example for interrupt count to 15 ************************************************************
	//enable the pb interrupts
	int_setup(2, (int[]) {73, 199 });
	enable_PB_INT_ASM(PB0 | PB1 | PB2);
	
	int count = 0;
	HPS_TIM_config_t hps_tim;
	//only need one timer
	hps_tim.tim = TIM0;
	hps_tim.timeout = 10000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);
	int start_clock=0;
	int micros = 0;
	int seconds = 0;
	int minutes = 0;
	
	while (1) {
		//each 10 ms, we increment, we only go when the subroutine flag is active
		if (hps_tim0_int_flag && start_clock) {
			hps_tim0_int_flag = 0;
			micros += 10; 

			//increment ms until we reach 1000, then +1 second then reset
			if (micros >= 1000) {
				micros -= 1000;
				seconds++;
				//increment seconds, until we reach 60, then +1 minute then reset
				if (seconds >= 60) {
					seconds -= 60;
					minutes++;
					//reset minutes since we have no hours
					if (minutes >= 60) {
						minutes = 0;
					}
				}
			}

			//write on the proper hex display
			HEX_write_ASM(HEX0, ((micros % 100) / 10) + 48);
			HEX_write_ASM(HEX1, (micros / 100) + 48);
			HEX_write_ASM(HEX2, (seconds % 10) + 48);
			HEX_write_ASM(HEX3, (seconds / 10) + 48);
			HEX_write_ASM(HEX4, (minutes % 10) + 48);
			HEX_write_ASM(HEX5, (minutes / 10) + 48);
		}
		//if pushbutton flag active, the ISR is active, we do something according to which button pressed
		if (pb_int_flag != 0){
			if(pb_int_flag == 1)
				start_clock=1;
			else if(pb_int_flag == 2)
				start_clock = 0;
			else if(pb_int_flag == 4 & start_clock==0){
				micros = 0;
				seconds = 0;
				minutes = 0;
				HEX_write_ASM(HEX0, 48);
				HEX_write_ASM(HEX1, 48);
				HEX_write_ASM(HEX2, 48);
				HEX_write_ASM(HEX3, 48);
				HEX_write_ASM(HEX4, 48);
				HEX_write_ASM(HEX5, 48);
			}
			pb_int_flag = 0;
		}
	}
	
	return 0;
}