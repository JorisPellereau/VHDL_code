	--=======================================
--	
--	filename 	: pkg_uart.vhd
--	Created		: 23/03/2019
--	Description	:
	
--	Author 		: Joris Pellereau
--	Contact		: 
--=======================================

-- == LIBRARY ==
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package pkg_uart is


type baud_rate is (b9600, b57600);

-- Compute the duration of a bit, according to the baud_rate and the clock frequencer in MHz
-- return an integer : number of clock period to generate a bit
function baud_2_bit_duration(baud : baud_rate, clk_frequency : integer)
return integer;



end pkg_uart;

package body pkg_uart is

-- Compute the duration of a bit, according to the baud_rate and the clock frequencer in MHz
-- return an integer : number of clock period to generate a bit
function baud_2_bit_duration(baud : baud_rate, clk_frequency : integer)
return integer is
        variable bit_duration : integer;
        variable time_real: real;
begin
        case baud is
                when b9600 =>
                        time_real := 1/9600.0;
                when b57600 =>
                        time_real := 1/57600.0;
                when others => NULL;
        end case;
        


end baud_2_bit_duration;

end package body;