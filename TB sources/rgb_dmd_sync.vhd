--=======================================
--	PIXIUM-VISION
--	filename 	: rgb_dmd_sync.vhd
--	Created		: 01/02/2019
--	Description	: RGB_SYNC - DMD_SYNCH emulation
	
--	Author 		: Joris Pellereau - Elsys Design
--	Contact		: joris.pellereau@elsys-design.com
--=======================================

-- == LIBRARY ==
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- == PACKAGES ==

entity rgb_dmd_sync is
	port (
		en		: in std_logic;		-- Enabled outputs
		rgb_sync	: out std_logic;
		dmd_sync	: out std_logic
	);
end rgb_dmd_sync;

architecture behv of rgb_dmd_sync is


-- == CONSTANTS ==
constant ta : time := 16.66 ms;
constant tb : time := 50 us;
constant tc : time := 160 us;
constant td : time := 350 us;
constant te : time := 660 us;
constant tf : time := 10 us;

-- == SIGNALS ==
signal rgb_sync_s : std_logic := '0';
signal dmd_sync_s : std_logic := '0';

begin

	-- == RGB_synch generation ==
	rgb_gen_p :	process
			begin
				if(en = '1') then
					rgb_sync_s <= '1';
					wait for tb;
					rgb_sync_s <= '0';
					wait for (ta - tb);
				else
					rgb_sync_s <= '0';
				end if;
				wait for 1 ns;
			end process;

	rgb_sync <= rgb_sync_s;
	
	-- == DMD_synch generation ==
	dmd_gen_p :	process
				variable i	: integer range 0 to 24 - 1 := 0;		-- index
			begin
				wait until rgb_sync_s'event and rgb_sync_s = '1';	-- Wait for rising_edge(rgb_sync_s)
				dmd_sync_s <= '0';
				wait for td;
				for i in 0 to 24 - 1 loop
					dmd_sync_s <= '1';
					wait for te;
					dmd_sync_s <= '0';
					wait for tf;
				end loop;				
			end process;
	
	dmd_sync <= dmd_sync_s;
end behv;
