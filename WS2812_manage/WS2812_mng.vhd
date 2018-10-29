library ieee;
use ieee.std_logic_1164.all;

-----Entite-----------

Entity WS2812_mng is
			Port( 	clk, rst_n 		: in std_logic;										-- Clock, reset
						start				: in std_logic;										-- Démarrage trame
						led_config		: in std_logic_vector(23 downto 0);				-- Configuration de la trame RGB
						trame_done		: out std_logic;
						d_out				: out std_logic										-- Sortie PWM, génère un 1 ou 0 suivant le WS2812
					);
end WS2812_mng;


-------Achitecture--------

Architecture WS2812_mng of WS2812_mng is

-- Compteurs => T_clk = 20ns
constant T0H 			: integer := 18;
constant T1H 			: integer := 35;
constant max_T 		: integer := 63;
constant T_reset 		: integer := 2500;			-- 50µs
signal cpt_H 			: integer range 0 to max_T;
signal cpt_reset 		: integer range 0 to T_reset;
signal cpt_bits 		: integer range 0 to 23;

type mode is (mode_0, mode_1, reset);
signal mode_led : mode;

signal run, run_flag, done 	: std_logic;
signal start_s 					: std_logic;
Begin 

	-- start_mng_p
	--	gestion du démarrage de l'envoi d'une trame
	--
	start_mng_p : 	process(clk, rst_n)
						begin
								if(rst_n = '0') then
										start_s 		<= '0';
										trame_done	<= '0';
								elsif(rising_edge(clk)) then
										if(start = '1') then
												start_s 		<= '1';
												trame_done	<= '0';
										elsif(cpt_bits = 0) then
												start_s 		<= '0';
												trame_done	<= '1';
										end if;
								end if;
						end process;
	
	-- modes_gen_p
	-- Sélectionne le mode : 0 ou 1 à écirre en sortie en fonction
	-- du vecteur d'entrée led_config
	--	
	modes_gen_p: process(clk, rst_n)
						begin
								if(rst_n = '0') then
										cpt_bits <= 23;
										run <= '0';
										mode_led <= mode_0;
								elsif(rising_edge(clk)) then
								
									
											if(start_s = '1') then
												if(done = '1') then										
														if(led_config(cpt_bits) = '1') then
																	mode_led <= mode_1;
														else
																	mode_led <= mode_0;
														end if;
												
												
														if(cpt_bits > 0) then
																cpt_bits <= cpt_bits - 1;
														else
																cpt_bits <= 23;
														end if;	
												elsif(done = '0') then
														run <= '1';
												end if;
											else
														run <= '0';
											end if;
										
										
								end if;
						end process;
					
					
	--	d_out_p
	--	Génératon de la sortie d_out (0 ou 1) suivant le WS2812
	--
	--	
	d_out_p :		process(clk, rst_n)
	
						variable d_out_var : std_logic;
	
						begin
					
							if(rst_n = '0') then
									cpt_H <= 0;
									run_flag <= '0';
									done <= '0';
									d_out_var := '0';
							elsif(rising_edge(clk)) then
							
									if(run = '1') then
											run_flag <= '1';											
									end if;
									
									if(run_flag = '1') then
													--
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
									elsif(run_flag = '0') then
										done <= '0';									
									end if;
							
							end if;
					
					end process;
					

end WS2812_mng ;