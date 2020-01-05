-------------------------------------------------------------------------------
-- Title      : Unitary test of the max7219_interface component
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_max7219_interface.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-19
-- Last update: 2020-01-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is a unitary test of the MAx7219 interface
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-19  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;


entity test_max7219_interface is

end entity test_max7219_interface;

architecture arch_test_max7219_interface of test_max7219_interface is


  -- MAX7219_interface signals
  signal clock_i       : std_logic := '0';               -- System Clock
  signal reset_n_i     : std_logic := '1';               -- ARESET
  signal wdata_i       : std_logic_vector(15 downto 0);  -- Data to transmit
  signal start_frame_i : std_logic;     -- Start SPI frame
  signal load_o        : std_logic;     -- Load output
  signal data_o        : std_logic;     -- data to transmit to the component
  signal clk_o         : std_logic;     -- SPI CLK
  signal frame_done_o  : std_logic;     -- Frame terminated
  signal s_en_load     : std_logic;     -- Enable load
begin  -- architecture arch_test_max7219_interface

  -- purpose: this process generate the input clock
  -- 50MHz : 20 ns
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clock_i <= not clock_i;
    wait for 10 ns;
  end process p_clk_gen;


  -- purpose: This process generates stimuli for the component 
  p_stimuli_mng : process is
  begin  -- process p_stimuli_mng
    wdata_i       <= (others => '0');
    start_frame_i <= '0';
    s_en_load     <= '0';

    wait for 5 us;
    reset_n_i <= '0';
    wait for 5 us;
    reset_n_i <= '1';

    report "Reset n done !!!";


    wdata_i       <= x"EAA2";
    wait until falling_edge(clock_i);
    start_frame_i <= '1';
    wait for 1 us;
    start_frame_i <= '0';
    wait until rising_edge(frame_done_o) for 10 ms;

    wait for 5 us;

    wdata_i       <= x"FFFE";
    wait until falling_edge(clock_i);
    s_en_load     <= '1';
    start_frame_i <= '1';
    wait for 1 us;
    start_frame_i <= '0';

    wait until rising_edge(frame_done_o) for 10 ms;

    wait for 5 us;


    wdata_i       <= x"5555";
    wait until falling_edge(clock_i);
    s_en_load     <= '1', '0' after 10 us;
    start_frame_i <= '1', '0' after 10 us;
    wait for 1 us;
    start_frame_i <= '0';


    wait until rising_edge(frame_done_o) for 10 ms;

    wait for 5 us;

    wdata_i       <= x"AAAA";
    wait until falling_edge(clock_i);
    s_en_load     <= '0', '0' after 10 us;
    start_frame_i <= '1', '0' after 10 us;
    wait for 1 us;
    start_frame_i <= '0';


    wait until rising_edge(frame_done_o) for 10 ms;

    wait for 5 us;


    wdata_i       <= x"BDEF";
    wait until falling_edge(clock_i);
    s_en_load     <= '1', '0' after 1 us;
    start_frame_i <= '1', '0' after 1 us;
    wait for 1 us;
    start_frame_i <= '0';


    wait until rising_edge(frame_done_o) for 10 ms;

    wait for 5 us;

    wdata_i       <= x"5698";
    wait until falling_edge(clock_i);
    s_en_load     <= '1', '0' after 1 us;
    start_frame_i <= '1', '0' after 1 us;
    wait for 1 us;
    start_frame_i <= '0';


    wait until rising_edge(frame_done_o) for 10 ms;

    wait for 5 us;


    report "end of test !!!";
    wait;


  end process p_stimuli_mng;

  -- max7219_interface inst
  max_7219_interface_inst : max7219_interface
    port map(
      clk            => clock_i,
      rst_n          => reset_n_i,
      i_max7219_data => wdata_i,
      i_start        => start_frame_i,
      i_en_load      => s_en_load,
      o_load_max7219 => load_o,
      o_data_max7219 => data_o,
      o_clk_max7219  => clk_o,
      o_max7219_done => frame_done_o);



end architecture arch_test_max7219_interface;
