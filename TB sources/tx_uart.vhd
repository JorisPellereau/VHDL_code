--=======================================
--	
--	filename 	: tx_uart.vhd
--	Created		: 01/02/2019
--	Description	: TX UART emulation
	
--	Author 		: Joris Pellereau
--	Contact		: 
--=======================================


-- == LIBRARY ==
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- == PACKAGES ==
use work.pkg_uart.all;

entity tx_uart is
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
end tx_uart;

architecture behv of tx_uart is

constant t_bit 		: real := 1000000.0/baud_rate;		-- 1 bit duration * 10e6
constant us_time 	: time := 1 us;
signal fsm 			: fsm_tx_uart := idle;
signal data_s 		: std_logic_vector(nb_data - 1 downto 0) := (others => '0');
signal tx_laser_s 	: std_logic := '0';
signal start_tx_s	: std_logic := '0';
signal d_transmit	: std_logic_vector( (nb_data + nb_stop_bit) downto 0) := ((nb_data + nb_stop_bit) => '1' ,  others => '0');	-- ( (nb_data + nb_stop_bit ) => '0', 0 => '1', others => '0');		--  (nb_data + nb_stop_bit - 1) downto 1 => '0'
constant cpt_max	: integer := nb_data + nb_stop_bit + 1;
signal cpt_data		: integer range 0 to cpt_max := 0;

begin



	-- == FSM manage ==
	fsm_p :	process
			begin
					case(fsm) is
						when idle =>								
								if(start_tx_s = '1') then
									fsm <= d_latch;
								else
									tx_done <= '0';
									data_s 	<= (others => '0');									
								end if;
						when d_latch =>
								data_s 							<= data;
								d_transmit(nb_data downto 1) 	<= data;		-- because LSB first
								fsm 							<= tx_send;
						when tx_send =>
								if(cpt_data = cpt_max) then
									tx_done <= '1';
									fsm 	<= stop;									
								end if;
						when stop =>
								tx_done <= '0';
								fsm 	<= idle;
						when others => NULL;
					end case;
					wait for 1 ns;
			end process;

	-- == start latch ==
	st_latch_p :	process
					begin
						if(en = '1' and fsm = idle) then
							wait until start_tx = '1' and start_tx'event;				-- start_tx rising_edge
							start_tx_s <= '1', '0' after 1 us;
						else
							start_tx_s <= '0';
						end if;
						wait for 1 ns;							
					end process;
	
	-- == TX generation ==
	tx_gen_p :	process
					variable i : integer := 0; --nb_data + nb_stop_bit;
				begin
					if(fsm = tx_send) then
						while(i <= cpt_max - 1) loop 
							tx_laser_s 	<= d_transmit(i);								-- LSB first							
							wait for t_bit*us_time;										-- Wait
							if(i /= cpt_max) then
								i 			:= i + 1;
								cpt_data 	<= cpt_data + 1;
							end if;
							
						end loop;
					else
						tx_laser_s 	<= '1';
						cpt_data 	<= 0;
						i 			:= 0 ;--;nb_data + nb_stop_bit;
					end if;
					wait for 1 ns;
				end process;
				TX_laser <= tx_laser_s;
end behv;