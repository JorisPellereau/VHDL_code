;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Filename:	simuart.s
;; {{{
;; Project:	Zip CPU -- a small, lightweight, RISC CPU soft core
;;
;; Purpose:	Read initial Value of AXI4 Lite Slave registers and check it
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
	.equ	segments_base_addr, 0x0000 ; Segments Base ADDR
	.equ    LCD_base_addr,      0x1000 ; LCD Base Addr

	;; INITIAL Values
	.equ segment_init_value, 0x0000	   ; Segment Initial Value

	;; CONSTANTS
	.equ LCD_CHAR, 0xCAFEDECA


	;; Main program
_main:
	NOP
	clr r0			; LR (for subroutines)
	clr r1			; Data from segments
	clr r2			; Data from LCD
	clr r10			; R10 Is used for Error Counter
	clr r11			; R11 is used for the result of the test (0 == KO - 1 == OK)
	jsr read_init_segments 	; Read Initial Value of segments slave and check it
	jsr read_init_lcd 	; Read Initial Value of LCD slave and check it
	jsr check_test		; Check the result of the test

;;; Read Initial values of Segments registers
read_init_segments:
	LW (segments_base_addr), r1 ; Get the value store in segment register from SEGMENT slave and store it into R1
	cmp 0, r1
	BZ inc_error
	RETN

;;; Read initial Values of LCD registers
read_init_lcd:
	LW (LCD_base_addr), r2
	cmp 0, r2
	BZ inc_error
	LW.Z LCD_base_addr + 4, r2 ; Get Initial Value of reg1
	cmp 0, r2
	BZ inc_error
	LW LCD_base_addr + 8, r2 ; Get Initial Value of reg2
	cmp 2, r2
	BZ inc_error
	RETN

;; This function increments Error if the previous comparison is wrong
;; Error register is R10
inc_error:	
	add $1, r10
	RETN

;;; This function Check the result of the test
check_test:
	BUSY
	
;; for_loop:
;; 	add	$1,r1
;; 	;; add 	$1,r0
;; 	JSR 	inc_segment
;; 	cmp	$10,r1
;; 	blt	for_loop
;; 	BRA 	infinite_loop
	
	;; Read the value the segments, increment it by one and update the segment
;; inc_segment:
;; 	NOP
;; 	;; SUB 	$4,SP		; PUSH
;; 	;; SW 	R0,(SP)		; PUSH
;; 	;; SUB 	$4,SP
;; 	;; SW 	R1,$(SP)
;; 	LW (segments_base_addr), r2 ; Get the value store in segment register from SEGMENT slave and store it into R2
;; 	ADD 1,r2		  ; Inc by one the value into R2
;; 	SW r2, segments_base_addr ; Write the Update value into segment
;; 	;; LW (SP),R0		  ; POP
;; 	;; ADD $4,SP		  ; POP
;; 	;; LW $(SP),R1
;; 	;; ADD $4,SP
;; 	;; LW $(SP),R0
;; 	;; ADD $4,SP
;; 	RETN


	
;; infinite_loop:
;; 	BUSY
	;; LW.Z segments_base_addr, r2 ;Get Initial Value from segments and check if it is equals to (others => '0')
	;; LW.Z LCD_base_addr, r2 ; Get Initial Value of reg0
	;; LW.Z LCD_base_addr + 4, r2 ; Get Initial Value of reg1
	;; LW LCD_base_addr + 8, r2 ; Get Initial Value of reg2
	;; BUSY
;; next_char:
;; 	LB	(r2),R4
;; 	TST	R4
;; 	BZ	all_done
;; keep_waiting:
;; 	LW	12(r3),R5
;; 	TST	1,R5
;; 	BNZ	keep_waiting
;; 	SW	r4,12(r3)
;; 	ADD	1,r2
;; 	BRA	next_char
	
;; all_done:
;; 	SEXIT	0
;; 	HALT
;; string:
;; 	.string	"H"


