.text

.global VGA_clear_charbuff_ASM
.global VGA_clear_pixelbuff_ASM
.global VGA_write_char_ASM
.global VGA_write_byte_ASM
.global VGA_draw_point

.equ VGA_PIXEL_BUF_BASE, 0xC8000000
.equ VGA_CHAR_BUF_BASE, 0xC9000000
.equ X_offset, 0x00000001
.equ Y_offset, 0x00000080
.equ Y_offset_pixel, 0x00000400
.equ pixel_end_Y, 0xC803BE7E
.equ pixel_end_X, 0x0000013F
.equ char_end_Y, 0xC9001DCF
.equ char_end_X, 0x0000004F

////////////////////////////
// subroutines VGA driver //
////////////////////////////

VGA_clear_charbuff_ASM:


VGA_clear_pixelbuff_ASM:


VGA_write_char_ASM:


VGA_write_byte_ASM:


VGA_draw_point:




.end
