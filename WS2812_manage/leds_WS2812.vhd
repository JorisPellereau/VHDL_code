library ieee;
use ieee.std_logic_1164.all;

-----Entite-----------

Entity leds_WS2812 is

			generic(nb_leds : integer := 3);
			Port( 	clk, rst_n 					: in std_logic;										-- Clock, reset
						start							: out std_logic;										-- Démarrage trame
						red, green, blue 			: in std_logic_vector(7 downto 0);				-- Bytes Color
						led_config					: out std_logic_vector(23 downto 0);				-- Configuration de la trame RGB
						trame_done					: in std_logic						
					);
end leds_WS2812;


-------Achitecture--------

Architecture Arch_leds_WS2812 of leds_WS2812 is


Begin 

	

	
	led_config <= green & red & blue;					-- Concatenation de la config
					

end arch_leds_WS2812 ;