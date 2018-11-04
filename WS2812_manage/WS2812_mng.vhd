library ieee;
use ieee.std_logic_1164.all;

library work;
use work.pkg_ws2812.all;


Entity WS2812_mng is
			generic(T0H : integer := 18;
						T1H : integer := 35);
			Port( 	clk, rst_n 		: in std_logic;										-- Clock, reset
						start				: in std_logic;										-- Démarrage trame
						led_config		: in std_logic_vector(23 downto 0);				-- Configuration de la trame RGB
						trame_done		: out std_logic;										-- Info' trame envoyée
						d_out				: out std_logic										-- Sortie PWM, génère un 1 ou 0 suivant le WS2812
					);
end WS2812_mng;


-------Achitecture--------

Architecture arch_WS2812_mng of WS2812_mng is

-- Compteurs => T_clk = 20ns
--constant T0H 			: integer := 18;
--constant T1H 			: integer := 35;
constant max_T 		: integer := 63;
constant T_reset 		: integer := 2500;			-- 50µs
signal cpt_H 			: integer range 0 to max_T;
signal cpt_reset 		: integer range 0 to T_reset;
signal cpt_bits , cpt		: integer range 0 to 24;


signal mode_led : mode;

signal run, run_flag, done 	: std_logic;
signal start_s 					: std_logic;

signal start_dout : std_logic;
signal bit_send : std_logic;
Begin 

	-- start_mng_p
	--	gestion du démarrage de l'envoi d'une trame
	--
	start_mng_p : 	process(clk, rst_n)
						begin
								if(rst_n = '0') then
										start_s 		<= '0';
										trame_done	<= '1';
								elsif(rising_edge(clk)) then
										if(start = '1') then
												start_s 		<= '1';
												trame_done		<= '0';
										elsif(cpt = 24) then
												start_s 		<= '0';
												trame_done		<= '1';
										end if;
								end if;
						end process;
	
	start_gen_p : 	process(clk, rst_n)
					begin
					
							if(rst_n = '0') then
									start_dout <= '0';
							elsif(rising_edge(clk)) then
								
									if(start_s = '1') then
										if(cpt_bits = 24) then			-- 1er start
												start_dout <= '1';
										elsif(done = '1' ) then
												start_dout <= '0';
										elsif(done = '0' or cpt_bits = 0) then
												start_dout <= '1';
										end if;
									end if;
							end if;
					
					end process;
	
	
	mode_gen_p: process(done, rst_n, start)
				begin
						if(rst_n = '0') then							
								cpt_bits <= 24;
								cpt <= 0;
						elsif(start = '1') then
								cpt_bits <= 23;
								cpt <= 0;
								mode_led <= mode_sel(led_config(23));							
						elsif(rising_edge(done)) then								
										
										if(cpt_bits > 0) then
												cpt_bits <= cpt_bits - 1;
												mode_led <= mode_sel(led_config(cpt_bits - 1));
										else--if(cpt_bits = 0) then
												mode_led <= mode_sel(led_config(0));
												cpt_bits <= 24;
										end if;
										
										if(cpt < 24) then
												cpt <= cpt + 1;
										else
											cpt <= 0;
										end if;
										
						end if;
				end process;
			
					
	d_out_gen_p : 	process(clk, rst_n)
						variable d_out_var : std_logic;
						begin
					
					
					
						if(rst_n = '0') then
								done <= '0';
						elsif(rising_edge(clk)) then
						
									if( (start_dout = '1' and done = '0')) then
											   if(mode_led = mode_0) then					-- Generation du 0 logique
															if(cpt_H < T0H) then											
																	d_out_var := '1';												
															else
																	d_out_var := '0';												
															end if;
															
															if(cpt_H < max_T) then
																cpt_H <= cpt_H + 1;
															elsif(cpt_H = max_T) then
																	cpt_H <= 0;
																	run_flag <= '0';			-- Raz Flag
																	done <= '1';				-- Génération terminée
															end if;
												elsif(mode_led = mode_1) then				-- Generation du 1 logique
												
															if(cpt_H < T1H) then											
																	d_out_var := '1';												
															else
																	d_out_var := '0';												
															end if;
															
															if(cpt_H < max_T) then
																cpt_H <= cpt_H + 1;
															elsif(cpt_H = max_T) then
																	cpt_H <= 0;
																	run_flag <= '0';			-- Raz Flag
																	done <= '1';				-- Generation terminée
															end if;
												end if;
												d_out <= d_out_var;
									elsif(start_dout = '0') then
												done <= '0';
									end if;
						end if;
					
					
					end process;
					

end arch_WS2812_mng ;