;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Filename:	simuart.s
;; {{{
;; Project:	Zip CPU -- a small, lightweight, RISC CPU soft core
;;
;; Purpose:	Test of single write access on I2C MASTER EEPROM
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
	.equ C_I2C_MASTER_EEPROM_STS_MSK, 0x00020000
	.equ C_MAX_LOOP_IDX, 256
	
;;; Register Utilization :
;;; R2 : Temporary register for AXI4 access
;;; R3 : Temporary register
;;; R4 : Inform if an initialization was already performed - 
;;; R5 : Counter index
	
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
;;; Load data into the FIFO TX Data 0 to 255
init_i2c_master_eeprom:
	MOV r5, r2					; Copy r5 to R2
	SW r2, i2c_master_eeprom_base_addr + 4 		; Load the data to the TX FIFO
	ADD $1, R5					; Inc the Counter
	CMP C_MAX_LOOP_IDX, R5					; Compare R5 with C_MAX_LOOP_IDX
	BLT init_i2c_master_eeprom			; Return to init_i2c_master_eeprom if not equals the 255
	MOV 0, R5					; Re init the counter to 0
	RETN

;;; INIT_DONE Flag - Write into R4 1 == Initialization already done
init_done:
	MOV C_INIT_DONE, R4
	RETN

;;; Polling I2C Master busy
polling_i2c_master_busy:
	LW i2c_master_eeprom_base_addr + 12, r2		; Load Status data into R2
	AND C_I2C_MASTER_EEPROM_STS_MSK, r2		; Mask bit 17
	CMP $0, r2					; Test if R2 == 0x00000000
	BZ  i2c_master_eeprom_write_access		; If Equal to 0x00000000 -> I2C not busy anymore, so go to write access
	BRA polling_i2c_master_busy			; otherwise return polling

;;; SEND I2C MASTER Data
i2c_master_eeprom_write_access:
	LDI 0x00010A01,r2				; Send a write access on the I2C MASTER EEPROM with 1 data
	SW r2, i2c_master_eeprom_base_addr
	ADD $1, R5					; Add 1 to R5
	CMP C_MAX_LOOP_IDX, R5					; Compare if R5 Equals to MAX idx
	BLT polling_i2c_master_busy			; If less than MAX idx -> Return to polling
	BUSY


