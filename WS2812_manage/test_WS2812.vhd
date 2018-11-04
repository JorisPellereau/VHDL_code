--
--	Fichier de test du WS2812
--
--


library ieee;
use ieee.std_logic_1164.all;

library work;
use work.pkg_ws2812.all;


Entity test_WS2812 is			
end test_WS2812;




Architecture arch_test_WS2812 of test_WS2812 is


--			CONSTANTES
constant T_clk 				: time := 20ns/2.0;
constant t_reset_n 			: time := 100ns;

signal clk 			: std_logic := '0';
signal rst_n		: std_logic := '0';
signal start		: std_logic := '0';
signal led_config : std_logic_vector(23 downto 0);
signal trame_done	: std_logic := '0';
signal d_out		: std_logic := '0';
Begin 

	
		clk <= not clk after T_clk;				-- Generation de clk
		rst_n <= '0', '1' after  t_reset_n;		-- Reset_n
		
		
		simu_p : process
					begin
							wait for 55us;
							start	<= '1', '0' after 100ns;
							led_config <= x"800001";
							
							wait for 55us;
							start	<= '1', '0' after 100ns;
							led_config <= x"000000";
							
							wait for 55us;
							start	<= '1', '0' after 100ns;
							led_config <= x"7EEAAA";
							
							wait for 55us;
							start	<= '1', '0' after 100ns;
							led_config <= x"FFFFFF";
							
							wait for 55us;
							start	<= '1', '0' after 100ns;
							led_config <= x"123456";
							
							wait for 55us;
							start	<= '1', '0' after 100ns;
							led_config <= x"987654";
							
							wait for 55us;
							start	<= '1', '0' after 100ns;
							led_config <= x"DEDEDE";
							
							wait for 55us;
							start	<= '1', '0' after 100ns;
							led_config <= x"B0B0B5";
					
					end process;
					
					
					
		-- Instance
			WS2812_mng_inst : entity work.WS2812_mng
									generic map(T0H  => 18, T1H => 35 )
									port map(
												clk 			=> clk,
												rst_n 		=> rst_n,
												start			=> start,
												led_config	=> led_config,
												trame_done	=> trame_done,
												d_out			=> d_out									
									);
		
end arch_test_WS2812 ;