;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Filename:	simuart.s
;; {{{
;; Project:	Zip CPU -- a small, lightweight, RISC CPU soft core
;;
;; Purpose:	SPI MIRROR Function
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
	.global	_start
	
	;; Base Addr
	.equ segments_base_addr, 0x0000 ; Segments Base ADDR
	.equ LCD_base_addr, 0x1000 ; LCD Base Addr
	.equ zipcpu_periph_base_addr, 0x2000 ; ZIPCPU Peripherals Base Addr
	.equ max7219_base_addr, 0x3000	     ; MAX7219 BASE addr
	.equ zipuart_base_addr, 0x4000	     ; ZIPUART BASE addr
	.equ spi_master_base_addr, 0x5000    ; SPI MASTER Base Addr
	.equ spi_slave_base_addr, 0x6000     ; SPI SLAVE Base Addr
	
	;; INITIAL Values
	.equ segment_init_value, 0x00000000	   ; Segment Initial Value

	;; CONSTANTS
	.equ C_EN_IT_0, 0x80018001   ; Enable IT 0 - Clear bit 0 status (IT 0 status)
	.equ C_TEST_OK, 0x000DEA15 ; DEALS  == OK
	.equ C_TEST_KO, 0x00FA11ED ; FAILED == KO

;;; Register Utilization :
;;; R2 : Data to send through SPI MASTER
;;; R3 : Temporary register

	;; Main program
_start:
	NOOP
	jsr clr_reg		; Clear All registers expect r13 r14 r15
	jsr init_7segs		; INIT 7Segments Slave
	jsr init_spi_master	; INIT SPI MASTER
	jsr init_spi_slave	; INIT SPI SLAVE	
	jsr init_it		; INIT Interruption
	jsr idle_task 		; JUMP to IDLE Task
	WAIT

;;; == SUBROUTINES ==
	
;;; CLEAR REGISTERS
clr_reg:	
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
	clr r12
	clr CC 			; Initialized the status register (not mandatory but cleaner)
	RETN


;;; INIT Segments Slave
init_7segs:
	LDI 0, r3
	SW r3, segments_base_addr
	RETN

;;; INIT SPI MASTER
init_spi_master:
	LDI 1, r2		; R2 is used to store the data to send through SPI MASTER
	LDI 0x00000001, r3
	SW r3, spi_master_base_addr + 0x4 ; Write int CTRL1 REgister - INit only one Write
	RETN

;;; INIT SPI SLAVE
init_spi_slave:
	NOOP
	RETN

;;; INIT Interruption Manager
;;; Clear the interrupt 0 and enable it
init_it:
	LDI C_EN_IT_0, r3
	SW r3, zipcpu_periph_base_addr
	RETN

;;; READ Data from SPI Slave and update 7 segments
;;; Enter in this subroutine on interrution
read_spi_slave_to_7_segs:
	LW zipcpu_periph_base_addr, r3 	; Store the value of the PIC IT into R3
	AND 0xFFFF7FFE,r3	       	; Reset the bit 0 (SPI SLAVE interrupt)
	SW r3, zipcpu_periph_base_addr	; Clear the interrupt 1 in the PIC
	LDI C_EN_IT_0, r3		; Write the Enable value in R3
	SW r3, zipcpu_periph_base_addr	; Load the content of R3 to ZIPPERIPH (enable IT 0)
	LW spi_slave_base_addr, r3 	; STORE Data from SPI Slave into r3
	SW r3, segments_base_addr  	; Update segments data
	add $1, r2			; Add 1 into R2
	RTU	
	jsr idle_task

	;; force -freeze sim:/tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_spi_slave_0/i_spi_slave_0/i_spi_slave_itf_0/spi_slave_it 1 0 -cancel 20ns
	
;;; Task that send a SPI Frame on the SPI MASTER and wait for the interruption of SPI SLAVE
idle_task:
	;; Send Data through SPI MASTER
	SW r2, spi_master_base_addr + 0x8 ; Write the data into R2 to the FIFO WRITE Data
	LDI 0x00000101, r3		  ; Prepare the register R3 for the SPI Start access
	SW r3, spi_master_base_addr	  ; PErform a SPI Start and keep the clk_div at 1
	
	; Wait for the next interrupt, then switch to supervisor task
	WAIT
	JSR read_spi_slave_to_7_segs
	
        ; When WAIT completes, the CPU will switch to supervisor mode.
        ; If the supervisor then re-enables this task, it will be because
        ; the supervisor wishes to wait for an interrupt again. For
        ; this reason, we loop back to the top.
	BRA idle_task
	
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
