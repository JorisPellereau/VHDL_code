-------------------------------------------------------------------------------
-- Title      : Unitary test of the MAX7219 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_max7219_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-22
-- Last update: 2019-07-22
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the unitary test of the MAX7219 Controller
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-22  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity test_max7219_controller is

end entity test_max7219_controller;

architecture arch_test_max7219_controller of test_max7219_controller is

  signal clock_i   : std_logic := '0';  -- System Clock
  signal reset_n_i : std_logic := '1';  -- ARESET

  -- MAX7219_interface
  signal wdata_i       : std_logic_vector(15 downto 0);  -- Data to transmit
  signal start_frame_i : std_logic;     -- Start SPI frame
  signal load_o        : std_logic;     -- Load output
  signal data_o        : std_logic;     -- data to transmit to the component
  signal clk_o         : std_logic;     -- SPI CLK
  signal frame_done_o  : std_logic;     -- Frame terminated

  -- MAX7219_controller signals  
  signal frame_done_i       : std_logic;  -- Frame done from the MAX7219 interface
  signal test_display_i     : std_logic;  -- Test the display
  signal start_config_i     : std_logic;  -- Start the config of the MAX7219
  signal decode_mode_i      : std_logic_vector(1 downto 0);  -- Decode mode (0x0 - 0x1 - 0x2 - 0x3)
  signal intensity_format_i : std_logic_vector(3 downto 0);  -- Intensity format
  signal scan_limit_i       : std_logic_vector(2 downto 0);  -- Scan limit config
  signal digit_0_i          : std_logic_vector(7 downto 0);  -- for digit 0
  signal digit_1_i          : std_logic_vector(7 downto 0);  -- for digit 1
  signal digit_2_i          : std_logic_vector(7 downto 0);  -- for digit 2
  signal digit_3_i          : std_logic_vector(7 downto 0);  -- for digit 3
  signal digit_4_i          : std_logic_vector(7 downto 0);  -- for digit 4
  signal digit_5_i          : std_logic_vector(7 downto 0);  -- for digit 5
  signal digit_6_i          : std_logic_vector(7 downto 0);  -- for digit 6
  signal digit_7_i          : std_logic_vector(7 downto 0);  -- for digit 7
  signal config_done_o      : std_logic;  -- Config is done
  signal display_on_o       : std_logic;  -- State of the display
  signal display_test_o     : std_logic;  -- 1 : Display in test mode
  signal wdata_o            : std_logic_vector(15 downto 0);  -- Data bus                                        
  signal start_frame_o      : std_logic;  -- Start a frame

begin  -- architecture arch_test_max7219_controller

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

    decode_mode_i      <= (others => '0');
    intensity_format_i <= (others => '0');
    scan_limit_i       <= (others => '0');
    digit_0_i          <= (others => '0');
    digit_1_i          <= (others => '0');
    digit_2_i          <= (others => '0');
    digit_3_i          <= (others => '0');
    digit_4_i          <= (others => '0');
    digit_5_i          <= (others => '0');
    digit_6_i          <= (others => '0');
    digit_7_i          <= (others => '0');

    start_config_i <= '0';
    test_display_i <= '0';

    wait for 5 us;
    reset_n_i <= '0';
    wait for 5 us;
    reset_n_i <= '1';

    report "Reset n done !!!";

    decode_mode_i      <= "11";
    intensity_format_i <= x"E";
    scan_limit_i       <= "010";

    wait for 5 us;

    report "Start the config";
    start_config_i <= '1';
    wait for 0.5 us;
    start_config_i <= '0';
    -- wait for 20 us;

    wait until falling_edge(config_done_o) for 10 ms;
    test_display_i <= '1';
    wait for 20 us;

    -- if(config_done_o = '1' and display_on_o = '1') then
    --   test_display_i <= '1';
    --   wait for 20 us;
    -- end if;

    report "end of test !!!";
    wait;

  end process p_stimuli_mng;

  -- MAX7219_controller inst
  max7219_controller_inst : max7219_controller
    port map (
      clock_i            => clock_i,
      reset_n_i          => reset_n_i,
      frame_done_i       => frame_done_i,
      test_display_i     => test_display_i,
      start_config_i     => start_config_i,
      decode_mode_i      => decode_mode_i,
      intensity_format_i => intensity_format_i,
      scan_limit_i       => scan_limit_i,
      digit_0_i          => digit_0_i,
      digit_1_i          => digit_1_i,
      digit_2_i          => digit_2_i,
      digit_3_i          => digit_3_i,
      digit_4_i          => digit_4_i,
      digit_5_i          => digit_5_i,
      digit_6_i          => digit_6_i,
      digit_7_i          => digit_7_i,
      config_done_o      => config_done_o,
      display_on_o       => display_on_o,
      display_test_o     => display_test_o,
      wdata_o            => wdata_o,
      start_frame_o      => start_frame_o);

  wdata_i       <= wdata_o;
  start_frame_i <= start_frame_o;
  frame_done_i  <= frame_done_o;

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


end architecture arch_test_max7219_controller;
