;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Filename:	simuart.s
;; {{{
;; Project:	Zip CPU -- a small, lightweight, RISC CPU soft core
;;
;; Purpose:	Read not mapped registers
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
	.equ segment_init_value, 0x00000000	   ; Segment Initial Value

	;; CONSTANTS
	.equ C_TEST_OK, 0x000DEA15 ; DEAL == OK
	.equ C_TEST_KO, 0x00FA11ED ; FAILED == KO


	;; Main program
_main:
	NOP
	clr r0			; LR (for subroutines)
	clr r1			; Data from segments
	clr r2			; Data from LCD
	clr r10			; R10 Is used for Error Counter
	clr r11			; R11 is used for the result of the test
	clr CC
	jsr read_not_mapped_segments_reg 	; Read not mapped segments registers	
	jsr check_test		; Check the result of the test

;;; Read Initial values of Segments registers
read_not_mapped_segments_reg:
	MOV CC, r5		      ; Copie the content of the status register CC into r2
	MOV uCC, r6		      ; Copie the content of the status register CC into r2
	LW segments_base_addr + 4, r1 ; Get the value store in segment register from SEGMENT slave and store it into R1
	NOP
	BNZ inc_error 		; Branch if not zero (initial value if 0)
	RETN


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


