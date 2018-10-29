library ieee;
use ieee.std_logic_1164.all;

-----Entite-----------

Entity leds_WS2812 is

			generic(	nb_leds : integer := 3
						);
			Port( 	clk, rst_n 					: in std_logic;										-- Clock, reset
						start							: in std_logic;
						start_trame					: out std_logic;										-- Démarrage trame
						red, green, blue 			: in std_logic_vector(7 downto 0);				-- Bytes Color
						led_config					: out std_logic_vector(23 downto 0);				-- Configuration de la trame RGB
						trame_done					: in std_logic						
					);
end leds_WS2812;


-------Achitecture--------

Architecture Arch_leds_WS2812 of leds_WS2812 is


signal  start_s : std_logic;
signal cpt_leds : integer range 0 to nb_leds;


Begin 
	--	start_gen_p
	-- gestion de l'alummage des leds
	--
	start_gen_p : 	process(clk, rst_n) 
						begin
								if(rst_n = '0') then
											start_s <= '0';
									elsif(rising_edge(clk)) then
											if(start = '1') then
													start_s <= not start_s;
											end if;
									end if;
						end process;


	
	trames_start_p : 	process(clk, rst_n)
							begin
									if(rst_n = '0') then
											start_trame <= '0';
									elsif(rising_edge(clk)) then
											if(start_s = '1') then
												if(trame_done = '1') then
														start_trame <= '1';
														if(cpt_leds < nb_leds) then
																	cpt_leds <= cpt_leds + 1;
														else
																	cpt_leds <= 0;
														end if;
												else
														start_trame <= '0';
												end if;
											end if;
									end if;
							
							end process;

	
							led_config <= green & red & blue;					-- Concatenation de la config
					

end arch_leds_WS2812 ;