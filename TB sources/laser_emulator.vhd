--=======================================
--	PIXIUM-VISION
--	filename 	: laser_emulator.vhd
--	Created		: 01/02/2019
--	Description	: Laser com. UART emulation
	
--	Author 		: Joris Pellereau - Elsys Design
--	Contact		: joris.pellereau@elsys-design.com
--=======================================


-- == LIBRARY ==
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- == PACKAGES ==

entity laser_emulator is
	port (
		RX_laser	: in std_logic;		-- RX UART
		TX_laser	: out std_logic		-- TX UART
		
	);
end laser_emulator;

