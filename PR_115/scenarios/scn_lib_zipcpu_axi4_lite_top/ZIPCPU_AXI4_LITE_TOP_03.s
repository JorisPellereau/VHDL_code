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

	;; INITIAL Values
	.equ segment_init_value, 0x00000000	   ; Segment Initial Value

	;; CONSTANTS
	.equ C_EN_IT, 0x80108010   ; Enable IT
	.equ C_TEST_OK, 0x000DEA15 ; DEALS  == OK
	.equ C_TEST_KO, 0x00FA11ED ; FAILED == KO


	;; Main program
_main:
	NOP
	clr r0			; LR (for subroutines)
	clr r1			; Data from segments
	clr r2			; Data from LCD
	clr r9			; Data for DBG
	clr r10			; R10 Is used for Error Counter
	clr r11			; R11 is used for the result of the test
	clr CC
	jsr periph_it_init 	; Peripherals IT Initialization
	jsr idle_task
	jsr check_test		; Check the result of the test


;;; Interuption Initial Configuration
periph_it_init:
	LDI 	C_EN_IT, r2		     		; Enable the interrupt 4 in the PIC (From TIMER_A)
	SW	r2, zipcpu_periph_base_addr		; Write it into register 0 (PIC)
	LDI 	0x800002FF, r2				; Set the data to write in timer A
	SW	r2, zipcpu_periph_base_addr + 0x10	; AUTO RELOAD TIMER A
	;; OR 0x0000000020, CC ; ;;;;;;SET sCC GIE bit to 1 and enable interruption	 x
	RETN

idle_task:
				; Wait for the next interrupt, then switch to supervisor task
	WAIT
	JSR inc_r9
	
				; When WAIT completes, the CPU will switch to supervisor mode.
				; If the supervisor then re-enables this task, it will be because
				; the supervisor wishes to wait for an interrupt again. For
				; this reason, we loop back to the top.
	BRA idle_task

inc_r9:
	LW zipcpu_periph_base_addr, r2 	; Store the value of the PIC IT into R2
	AND 0xFFFF7FEF,r2	       	; Reset the bit 4 (timer_a interrupt)
	SW  r2, zipcpu_periph_base_addr	; Clear the interrupt 4 in the PIC (From TIMER_A)
	LDI 	C_EN_IT, r2		     		; Enable the interrupt 4 in the PIC (From TIMER_A)
	SW	r2, zipcpu_periph_base_addr		; Write it into register 0 (PIC)
	add $1, r9
	RTU
	jsr idle_task
	

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
