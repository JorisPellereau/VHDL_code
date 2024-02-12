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
	.equ segments_base_addr, 0x0000 		; Segments Base ADDR
	.equ LCD_base_addr, 0x1000 			; LCD Base Addr
	.equ zipcpu_periph_base_addr, 0x2000 		; ZIPCPU Peripherals Base Addr
	.equ max7219_base_addr, 0x3000	     		; MAX7219 BASE addr
	.equ zipuart_base_addr, 0x4000	     		; ZIPUART BASE addr
	.equ spi_master_base_addr, 0x5000    		; SPI MASTER Base Addr
	.equ spi_slave_base_addr, 0x6000     		; SPI SLAVE Base Addr
	.equ i2c_master_eeprom_base_addr, 0x7000	; I2C MASTER EEPROM Addr
	
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
	CMP C_INIT_DONE, R4			; Compare R4 with the constant of INitialization done
	BGE idle_task				; Init R4 == C_INIT_DINE -> Goto IDLE Task
	jsr clr_reg				; Clear All registers expect r13 r14 r15
	jsr init_7segs				; INIT 7Segments Slave
	jsr init_spi_master			; INIT SPI MASTER
	jsr init_spi_slave			; INIT SPI SLAVE	
	jsr init_i2c_master_eeprom 		; INIT I2C MASTER EEPROM
	jsr init_done
	jsr i2c_master_eeprom_write_access
	WAIT
	
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

;;; INIT I2C MASTER EEPROM
init_i2c_master_eeprom:
	LDI 1, r2
	SW r2, i2c_master_eeprom_base_addr + 4
	LDI 0x55, r2
	SW r2, i2c_master_eeprom_base_addr + 4
	RETN

;;; INIT_DONE Flag - Write into R4 1 == Initialization already done
init_done:
	MOV C_INIT_DONE, R4
	RETN


;;; SEND I2C MASTER Data
i2c_master_eeprom_write_access:
	LDI 0x00010A01,r2
	SW r2, i2c_master_eeprom_base_addr
	RETN
