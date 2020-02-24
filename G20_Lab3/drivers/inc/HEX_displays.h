#ifndef __HEX_DISPLAYS
#define __HEX_DISPLAYS
	
	//new type HEX_t is defined to be able to write to multiple diplays in a single fucntion call
	typedef enum {
		HEX0 = 0x00000001,
		HEX1 = 0x00000002,
		HEX2 = 0x00000004,
		HEX3 = 0x00000008,
		HEX4 = 0x00000010,
		HEX5 = 0x00000020   //2^5 in hex 
	} HEX_t;

	extern void HEX_clear_ASM(HEX_t hex);
	extern void HEX_flood_ASM(HEX_t hex);
	extern void HEX_write_ASM(HEX_t hex, char val);

#endif
