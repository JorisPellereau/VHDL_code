-------------------------------------------------------------------------------
-- Title      : Unitary test of the max7219_interface component
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_max7219_interface.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-19
-- Last update: 2019-07-19
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

    wait for 5 us;
    reset_n_i <= '0';
    wait for 5 us;
    reset_n_i <= '1';

    report "Reset n done !!!";


    wdata_i       <= x"EAA2";
    start_frame_i <= '1';
    wait for 1 us;

    report "end of test !!!";
    wait;


  end process p_stimuli_mng;

  -- max7219_interface inst
  max_7219_interface_inst : max7219_interface
    port map(
      clock_i       => clock_i,
      reset_n_i     => reset_n_i,
      wdata_i       => wdata_i,
      start_frame_i => start_frame_i,
      load_o        => load_o,
      data_o        => data_o,
      clk_o         => clk_o,
      frame_done_o  => frame_done_o);



end architecture arch_test_max7219_interface;
