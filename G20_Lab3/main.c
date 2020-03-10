#include <stdio.h>

#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"

#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/address_map_arm.h"
#include "./drivers/inc/ISRs.h"

#include "./drivers/inc/HPS_TIM.h"




int main(){


// PART 1
/*while (1){
	write_LEDs_ASM(read_slider_switches_ASM());
	}
	return 0;
*/
// PART 2

/*while(1){
	write_LEDs_ASM(read_slider_switches_ASM());
	if(read_slider_switches_ASM() & 0b1000000000){
		HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);		
	}
	else{
		HEX_flood_ASM(HEX4 | HEX5);
		char value = (read_slider_switches_ASM());
		int pushbutton = (read_PB_data_ASM());
		HEX_write_ASM(pushbutton, value);
	}
	
}
*/
// PART 3
	
/*
int count10ms = 0, count100ms = 0, count1s = 0, count10s = 0, count1min = 0, count10min = 0;
	int run = 0;
	HPS_TIM_config_t hps_tim_watch;
	hps_tim_watch.tim = TIM0;
	hps_tim_watch.timeout = 100000;
	hps_tim_watch.LD_en = 1;	//M
	hps_tim_watch.INT_en = 1;	//I
	hps_tim_watch.enable = 1;	//E
	HPS_TIM_config_ASM (&hps_tim_watch);
	HPS_TIM_config_t hps_tim_poll;
	hps_tim_poll.tim = TIM1;
	hps_tim_poll.timeout = 5000;
	hps_tim_poll.LD_en = 1;
	hps_tim_poll.INT_en = 1;
	hps_tim_poll.enable = 1;
	HPS_TIM_config_ASM (&hps_tim_poll);
	while(1){
		if (run){
			if(HPS_TIM_read_INT_ASM(TIM0)) {
				HPS_TIM_clear_INT_ASM(TIM0);
				if(++count10ms == 10){
					count10ms = 0;
					if(++count100ms == 10){
						count100ms = 0;
						if(++count1s == 10){
							count1s = 0;
							if(++count10s == 6){
								count10s = 0;
								if(++count1min == 10){
									count1min = 0;
									if(++count10min == 6){
										count10min = 0;
									}
									HEX_write_ASM(HEX5, count10min);
								}
								HEX_write_ASM(HEX4, count1min);
							}
							HEX_write_ASM(HEX3, count10s);
						}
						HEX_write_ASM(HEX2, count1s);
					}
					HEX_write_ASM(HEX1, count100ms);
				}
				HEX_write_ASM(HEX0, count10ms);
			}
		}
		if(HPS_TIM_read_INT_ASM(TIM1)) {
			HPS_TIM_clear_INT_ASM(TIM1);
			if(PB_edgecap_is_pressed_ASM(PB0)){		//PB0 = start
				run = 1;
				PB_clear_edgecap_ASM(PB0);
			}
			if(PB_edgecap_is_pressed_ASM(PB1)){		//PB1 = stop
				run = 0;
				PB_clear_edgecap_ASM(PB1);
			}
			if(PB_edgecap_is_pressed_ASM(PB2)){		//PB2 = reset
				HPS_TIM_clear_INT_ASM(TIM0);
				HEX_clear_ASM(HEX0|HEX1|HEX2|HEX3|HEX4|HEX5);
				count10ms = 0, count100ms = 0, count1s = 0, count10s = 0, count1min = 0, count10min = 0;
				PB_clear_edgecap_ASM(PB2);
			}
		}
	} */
// _____________________________________________________
//	int count0 = 0, count1 = 0, count2 = 0, count3 = 0;

/*	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0|TIM1|TIM2|TIM3;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	HPS_TIM_config_ASM(&hps_tim);
	while(1){
		if(HPS_TIM_read_INT_ASM(TIM0)){
			HPS_TIM_clear_INT_ASM(TIM0);
			if (++count0 == 16)
				count0 = 0;
			HEX_write_ASM(HEX0, count0);
		}
		if(HPS_TIM_read_INT_ASM(TIM1)){
			HPS_TIM_clear_INT_ASM(TIM1);
			if (++count1 == 16)
				count1 = 0;
			HEX_write_ASM(HEX1, count1);
		}
		if(HPS_TIM_read_INT_ASM(TIM2)){
			HPS_TIM_clear_INT_ASM(TIM2);
			if (++count2 == 16)
				count2 = 0;
			HEX_write_ASM(HEX2, count2);
		}
		if(HPS_TIM_read_INT_ASM(TIM3)){
			HPS_TIM_clear_INT_ASM(TIM3);
			if (++count3 == 16)
				count3 = 0;
			HEX_write_ASM(HEX3, count3);
		}
}*/


// PART 4 
	/*int_setup(1, (int[]){199});
	
	int count = 0;
	HPS_TIM_config_t hps_tim;
	
	hps_tim.tim = TIM0;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 0;
	hps_tim.enable = 1;
	HPS_TIM_config_ASM(&hps_tim);
	
	while(1){
	if (hps_tim0_int_flag){
		hps_tim0_int_flag = 0;
		if (++count == 15)
			count = 0;
		HEX_write_ASM(HEX0, count);
		}
	}*/

	int_setup(2, (int[]){73,199});

	int count10ms = 0, count100ms = 0, count1s = 0, count10s = 0, count1min = 0, count10min = 0;
	int run = 0;

	HPS_TIM_config_t hps_tim_watch;
	hps_tim_watch.tim = TIM0;
	hps_tim_watch.timeout = 100000;
	hps_tim_watch.LD_en = 1;	//M
	hps_tim_watch.INT_en = 0;	//I
	hps_tim_watch.enable = 1;	//E
	HPS_TIM_config_ASM (&hps_tim_watch);

	enable_PB_INT_ASM(PB0|PB1|PB2);
//	run = 1;
	while(1){
		if (run){
			if(hps_tim0_int_flag) {
				hps_tim0_int_flag = 0;
				if(++count10ms == 10){
					count10ms = 0;
					if(++count100ms == 10){
						count100ms = 0;
						if(++count1s == 10){
							count1s = 0;
							if(++count10s == 6){
								count10s = 0;
								if(++count1min == 10){
									count1min = 0;
									if(++count10min == 6){
										count10min = 0;
									}
									HEX_write_ASM(HEX5, count10min);
								}
								HEX_write_ASM(HEX4, count1min);
							}
							HEX_write_ASM(HEX3, count10s);
						}
						HEX_write_ASM(HEX2, count1s);
					}
					HEX_write_ASM(HEX1, count100ms);
				}
				HEX_write_ASM(HEX0, count10ms);
			}
		}

		if (pb_int_flag != 0){
			if(pb_int_flag == 1){		//PB0 = start
				run = 1;

			}
	
			else if(pb_int_flag == 2){		//PB1 = stop
				run = 0;

			}
	
			else if(pb_int_flag == 4){		//PB2 = reset
				//HPS_TIM_clear_INT_ASM(TIM0);
				run = 0;
				HEX_clear_ASM(HEX0|HEX1|HEX2|HEX3|HEX4|HEX5);
				count10ms = 0, count100ms = 0, count1s = 0, count10s = 0, count1min = 0, count10min = 0;

			}
			pb_int_flag = 0;
		}
	}


return 0;
}