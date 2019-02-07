--=======================================
--	
--	filename 	: pkg_uart.vhd
--	Created		: 01/02/2019
--	Description	: package UART
	
--	Author 		: Joris Pellereau
--	Contact		: 
--=======================================


-- == LIBRARY ==
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- == PACKAGES ==

package pkg_uart is
	
	type uart_parity is (none, even, odd);
	type uart_bauds is (b9600, b57600);
	type fsm_tx_uart is (idle, d_latch, tx_send, stop);
end pkg_uart;

