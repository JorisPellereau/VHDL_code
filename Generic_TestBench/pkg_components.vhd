--=======================================
--	
--	filename 	: pkg_components.vhd
--	Author 		: Joris Pellereau
--	Created		: 03/12/2018
--=======================================
library ieee;
use ieee.std_logic_1164.all;

library tb_generic_lib;				-- Generic TB library
use tb_generic_lib.pkg_constants.all;

package pkg_components is


-- == SEQUENCER ==
component sequencer_generic is
	port(
		clk 		: in std_logic;
		status		: in std_logic_vector(nb_status - 1 downto 0);
		cmd_pulses 	: out std_logic_vector(nb_cmd_pulses - 1 downto 0);
		resets		: out std_logic_vector(nb_reset - 1 downto 0);
		stdl_out	: out std_logic_vector(nb_stdl - 1 downto 0)
	);
end component;
-- ===============

end pkg_components;
