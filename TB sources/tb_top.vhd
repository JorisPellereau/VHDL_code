--=======================================
--	PIXIUM-VISION
--	filename 	: tb_top.vhd
--	Created		: 01/02/2019
--	Description	: tb_top
	
--	Author 		: Joris Pellereau - Elsys Design
--	Contact		: joris.pellereau@elsys-design.com
--=======================================


-- == LIBRARY ==
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- == PACKAGES ==
use work.pkg_uart.all;

entity tb_top is
end tb_top;

architecture behv of tb_top is


component tx_uart is
generic(
		baud_rate	: real := 57600.0;
		nb_data 	: integer := 8;
		nb_stop_bit : integer := 1;
		parity		: uart_parity := none
	);
	port (
		en			: in std_logic;		-- Enable
		start_tx	: in std_logic;
		data		: in std_logic_vector(nb_data - 1 downto 0);
		tx_done		: out std_logic;
		TX_laser	: out std_logic		-- TX UART		
	);
end component;

-- == signals ==
constant nb_data 	: integer := 8;
signal en 			: std_logic := '0';
signal start_tx 	: std_logic := '0';
signal data			:  std_logic_vector(nb_data - 1 downto 0);
signal tx_done 		: std_logic := '0';
signal TX_laser 	: std_logic := '0';

begin
	-- == TX INST ==
	tx_uart_inst : tx_uart generic map(
								baud_rate => 57600.0 , nb_data => 8 , nb_stop_bit => 1, parity => none
							)
							port map(
								en => en,
								start_tx => start_tx,
								data => data,
								tx_done => tx_done,
								TX_laser => TX_laser
							);
							
	-- == TB ==
		test_p : 	process
					begin
						data 		<= x"7F";
						en 			<= '0';
						start_tx 	<= '0';
						wait for 10 us;
						en <= '1', '0' after 20 us;
						start_tx <= '1', '0' after 10 us;
						wait for 400 us;
						wait for 1 ns;
					end process;
							

end behv;