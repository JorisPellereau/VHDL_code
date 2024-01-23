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
	.equ segments_base_addr, 0x0000 	; Segments Base ADDR
	.equ LCD_base_addr, 0x1000 		; LCD Base Addr
	.equ zipcpu_periph_base_addr, 0x2000 	; ZIPCPU Peripherals Base Addr
	.equ max7219_base_addr, 0x3000	     	; MAX7219 BASE addr
	.equ zipuart_base_addr, 0x4000	     	; ZIPUART BASE addr
	.equ spi_master_base_addr, 0x5000    	; SPI MASTER Base Addr
	.equ spi_slave_base_addr, 0x6000     	; SPI SLAVE Base Addr
	
	;; INITIAL Values
	.equ segment_init_value, 0x00000000	   ; Segment Initial Value

	;; CONSTANTS
	;; External_IT[0] => IT_0
	;; External_IT[1] => IT_6 (Generic EXTERNAL_INTERRUPTS > 1)
	.equ C_EN_IT_0, 0x80018001   	; Enable IT 0 - Clear bit 0  status (IT 0 status)
	.equ C_EN_IT_6, 0x80408040	; Enable IT 6 - Clear bit 6  status (IT 6 status)
	.equ C_EN_IT,   0x80418041	; Enable IT 0 and 6
	.equ C_INIT_DONE, 0x0000D043  	; Initialisation done code
	.equ C_MASK_IT_0, 0x00000001	; Mask for IT 0
	.equ C_MASK_IT_6, 0x00000040	; Mask for IT 6
	.equ C_RST_IT_0, 0x00000001	; Mask for reseting IT 0
	.equ C_RST_IT_6, 0x00000040	; Mask for reseting IT 6
	
;;; Register Utilization :
;;; R2 : Data to send through SPI MASTER
;;; R3 : Temporary register
;;; R4 : Inform if an initialization was already performed - 
;;; R5 : Temporary zone for IT check
	
;; Perform after a reset of the CPU (cpu_reset, bus error etc)
_start:
	NOOP
	CMP C_INIT_DONE, R4	; Compare R4 with the constant of INitialization done
	BGE idle_task		; Init R4 == C_INIT_DINE -> Goto IDLE Task
	jsr clr_reg		; Clear All registers expect r13 r14 r15
	jsr init_7segs		; INIT 7Segments Slave
	jsr init_spi_master	; INIT SPI MASTER
	jsr init_spi_slave	; INIT SPI SLAVE	
	jsr init_it		; INIT Interruption
	jsr init_done
	RTU 				; Return to User Mode
	MOV resolves_it(PC), sPC 	; Load the sPC to resolves IT subroutine
	jsr idle_task			; Go to IDLE TASK
	
;;; == SUBROUTINES ==

	
;;; CLEAR REGISTERS
clr_reg:	
	clr r1				; RESET Register
	clr r2				; RESET Register
	clr r3				; RESET Register
	clr r4				; RESET Register
	clr r5				; RESET Register
	clr r6				; RESET Register
	clr r7				; RESET Register
	clr r8				; RESET Register
	clr r9				; Data for DBG
	clr r10				; R10 Is used for Error Counter
	clr r11				; R11 is used for the result of the test
	clr r12
	clr CC 				; Initialized the status register (not mandatory but cleaner)
	MOV idle_task(PC), uPC	; Initialized the Uer Program Counter to the
	MOV r12, uCC
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
;;; Clear Interrut and enable it
init_it:
	LDI C_EN_IT, r3
	SW r3, zipcpu_periph_base_addr
	RETN

;;; INIT_DONE Flag - Write into R4 1 == Initialization already done
init_done:
	MOV C_INIT_DONE, R4
	RETN

;;; READ Data from SPI Slave and update 7 segments
;;; Enter in this subroutine on interrution
;;; Supervisor Task
read_spi_slave_to_7_segs:

	;; Clear the status of the IT
	MOV C_RST_IT_0,r3	       	; Reset the bit 0 (SPI SLAVE interrupt)
	SW R3, zipcpu_periph_base_addr	; Clear the interrupt 0 in the PIC

	;; Re enable the IT
	;; LDI C_EN_IT, r3		; Write the Enable value in R3
	;; SW R3, zipcpu_periph_base_addr	; Load the content of R3 to ZIPPERIPH (enable IT 0)

	;; Read the value from SPI SLAVE
	LW spi_slave_base_addr, R3 	; STORE Data from SPI Slave into r3
	SW R3, segments_base_addr  	; Update segments data

	RTU 				; Return to User Mode and enable IT
	MOV resolves_it(PC), sPC 	; Load the sPC to resolves IT subroutine
	jsr idle_task			; Go to IDLE Task
	

; force -freeze sim:/tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_spi_slave_0/i_spi_slave_0/i_spi_slave_itf_0/spi_slave_it 1 0 -cancel 20ns
; force -freeze sim:/tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_spi_slave_0/rresp 0 0
; force -freeze sim:/tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_zipaxil_0/core/i_reset 0 0
; force -freeze sim:/tb_top/i_dut/key_1_a 0 0 -cancel 100ns

;;; SEND SPI DATA
send_spi_data:

	;; Clear the status of the IT
	MOV C_RST_IT_6,r3	       	; Reset the bit 6 (KEY 6 interrupt)
	SW R3, zipcpu_periph_base_addr	; Clear the interrupt 6 in the PIC

	;; Re enable the IT
	LDI C_EN_IT, r3		; Write the Enable value in R3
	SW R3, zipcpu_periph_base_addr	; Load the content of R3 to ZIPPERIPH (enable IT 6)
	
	;; Send Data through SPI MASTER
	SW r2, spi_master_base_addr + 0x8 ; Write the data into R2 to the FIFO WRITE Data
	LDI 0x00000101, r3		  ; Prepare the register R3 for the SPI Start access
	SW r3, spi_master_base_addr	  ; PErform a SPI Start and keep the clk_div at 1

	;; ADD +1 to R2
	ADD $1, R2		 		; Add +1 to R2
	
	;; Return in IDLE STATE
	RTU				  	; Go to USER Mode
	MOV resolves_it(PC), sPC 		; Load the sPC to resolves IT subroutine
	jsr idle_task			      	; Go to IDLE Task

;;; This subroutine check the source of the IT and resolve IT
;;; Task resoled in SUPERVISOR MODE
resolves_it:
	AND 0xFFFFFFDF, sCC 		; Disable GIE
	LW zipcpu_periph_base_addr, r3 	; Store the value of the PIC IT into R3 -> We get the current status of interruption
	
	;; Check the status of IT 0
	MOV R3, R5			; Copy R3 into R5
	AND C_MASK_IT_0, R5		; Mask IT 0 and check if active
	CMP C_MASK_IT_0, R5		; Compare R5 with the C_MASk_IT_0
	BGE read_spi_slave_to_7_segs	; Jump the read_spi_slave if equals

	;; Check the status of IT 1
	MOV R3, R5			; Re init R5 with the content of R3
	AND C_MASK_IT_6, R5		; Mask IT 1 and check if active
	CMP C_MASK_IT_6, R5		; Compare R5 with the C_MASk_IT_1
	BGE send_spi_data		; Jump to send SPI Data

	;; Otherwise : an other IT was generated but we don't care
	RTU 				; Return to User Mode and enable IT
	MOV resolves_it(PC), sPC 	; Load the sPC to resolves IT subroutine
	jsr idle_task
	
;;; Wait for the interruption of SPI SLAVE
;;; We entered in this task when we are in USER MODE
idle_task:
	; Wait for the next interrupt, then switch to supervisor task
	WAIT
	
        ; When WAIT completes, the CPU will switch to supervisor mode.
        ; If the supervisor then re-enables this task, it will be because
        ; the supervisor wishes to wait for an interrupt again. For
        ; this reason, we loop back to the top.
	BRA idle_task
