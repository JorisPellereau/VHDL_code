;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Filename:	simuart.s
;; {{{
;; Project:	Zip CPU -- a small, lightweight, RISC CPU soft core
;;
;; Purpose:	Initialized and used interrupt
;;
;;
;; Creator:	Dan Gisselquist, Ph.D.
;;		Gisselquist Technology, LLC
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; }}}
;; Copyright (C) 2015-2022, Gisselquist Technology, LLC
;; {{{
;; This program is free software (firmware): you can redistribute it and/or
;; modify it under the terms of  the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;; }}}
;; License:	GPL, v3, as defined and found on www.gnu.org,
;; {{{
;;		http://www.gnu.org/licenses/gpl.html
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; }}}

	.section .start,"ax",@progbits
	.global	_main
	
	;; Base Addr
	.equ segments_base_addr, 0x0000 ; Segments Base ADDR
	.equ LCD_base_addr, 0x1000 ; LCD Base Addr
	.equ zipcpu_periph_base_addr, 0x2000 ; ZIPCPU Peripherals Base Addr
	.equ max7219_base_addr, 0x3000	     ; MAX7219 BASE addr
	.equ zipuart_base_addr, 0x4000	     ; ZIPUART BASEA addr
	
	;; INITIAL Values
	.equ segment_init_value, 0x00000000	   ; Segment Initial Value

	;; CONSTANTS
	.equ C_EN_IT, 0x80108010   ; Enable IT
	.equ C_TEST_OK, 0x000DEA15 ; DEALS  == OK
	.equ C_TEST_KO, 0x00FA11ED ; FAILED == KO


	;; Main program
_main:

	;; Clr register
;;;	NOP
;;;	clr r0			; LR (for subroutines)
;;;	clr r1			; Data from segments
;;;	clr r2			; Data from LCD
;;;	clr r9			; Data for DBG
;;;	clr r10			; R10 Is used for Error Counter
;;;	clr r11			; R11 is used for the result of the test
;;;	clr CC
	LW zipuart_base_addr, r2 	; Store the value into R2
	LW zipuart_base_addr + 0x4, r2 	; Store the value into R2
	LW zipuart_base_addr + 0x8, r2 	; Store the value into R2
	LW zipuart_base_addr + 0xC, r2 	; Store the value into R2
	LDI 0x00AA, r2
	SW r2, zipuart_base_addr + 0xC  ; -- Load the value in TX Transmitter register
	ADD 1, r2
	SW r2, zipuart_base_addr + 0xC  ; -- Load the value in TX Transmitter register
	WAIT
	
;;;	jsr clr_reg		; Clear registers
;;;	jsr rd_zipuart_reg	; Read UART REG
;;;	jsr check_test		; Check the test at the end

;;; CLEAR REGISTERS
clr_reg:	
	clr r0			; LR (for subroutines)
	clr r1			; RESET Register
	clr r2			; RESET Register
	clr r3			; RESET Register
	clr r4			; RESET Register
	clr r5			; RESET Register
	clr r6			; RESET Register
	clr r7			; RESET Register
	clr r8			; RESET Register
	clr r9			; Data for DBG
	clr r10			; R10 Is used for Error Counter
	clr r11			; R11 is used for the result of the test
	RETN

rd_zipuart_reg:
	LW zipuart_base_addr, r2 	; Store the value into R2
	NOP
	RETN
	
;;; == CHECK TEST SECTION ==
;; This function increments Error if the previous comparison is wrong
;; Error register is R10
inc_error:	
	add $1, r10
	RETN

;;; This function Check the result of the test
check_test:
	cmp 0, r10
	BZ success_test 	; If ok goto success_test subroutines
	LDI C_TEST_KO, r11 	; Else write KO
	BUSY

;;; Success : Write value 1 in r11
success_test:
	LDI C_TEST_OK, r11
	BUSY
;;; ========================
