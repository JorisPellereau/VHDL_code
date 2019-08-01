-------------------------------------------------------------------------------
-- Title      : Unitary test of the MAX7219 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_max7219_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-22
-- Last update: 2019-08-01
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
use ieee.numeric_std.all;

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
  signal en_load_i     : std_logic;     -- Enable load_o
  signal load_o        : std_logic;     -- Load output
  signal data_o        : std_logic;     -- data to transmit to the component
  signal clk_o         : std_logic;     -- SPI CLK
  signal frame_done_o  : std_logic;     -- Frame terminated

  -- MAX7219_controller signals  
  signal frame_done_i        : std_logic;  -- Frame done from the MAX7219 interface
  signal test_display_i      : std_logic;  -- Test the display
  signal update_display_i    : std_logic;  -- Update the display(new pattern)
  signal pattern_available_i : std_logic;  -- Pattern available

  -- Matri sel
  signal matrix_sel_i : std_logic_vector(C_MATRIX_SEL_SIZE - 1 downto 0);

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
  signal display_on_o       : std_logic_vector(C_MATRIX_NB - 1 downto 0);  -- State of the display
  signal display_test_o     : std_logic_vector(C_MATRIX_NB - 1 downto 0);  -- 1 : Display in test mode
  signal update_done_o      : std_logic;  -- Display upadte terminated
  signal wdata_o            : std_logic_vector(15 downto 0);  -- Data bus                                        
  signal start_frame_o      : std_logic;  -- Start a frame
  signal en_load_o          : std_logic;  -- Enable the LOAD output

  -- PATTERN_SELECTOR signals
  signal en_i                : std_logic;  -- Enable pattern selector
  signal sel_i               : std_logic_vector(15 downto 0);  -- Selector
  signal digit_0_o           : std_logic_vector(7 downto 0);  -- Digit 0 pattern
  signal digit_1_o           : std_logic_vector(7 downto 0);  -- Digit 1 pattern
  signal digit_2_o           : std_logic_vector(7 downto 0);  -- Digit 2 pattern
  signal digit_3_o           : std_logic_vector(7 downto 0);  -- Digit 3 pattern
  signal digit_4_o           : std_logic_vector(7 downto 0);  -- Digit 4 pattern
  signal digit_5_o           : std_logic_vector(7 downto 0);  -- Digit 5 pattern
  signal digit_6_o           : std_logic_vector(7 downto 0);  -- Digit 6 pattern
  signal digit_7_o           : std_logic_vector(7 downto 0);  -- Digit 7 pattern
  signal pattern_available_o : std_logic;  -- Pattern avaiable

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

    update_display_i   <= '0';
    decode_mode_i      <= (others => '0');
    intensity_format_i <= (others => '0');
    scan_limit_i       <= (others => '0');
    en_i               <= '0';
    sel_i              <= (others => '0');
    matrix_sel_i       <= (others => '0');


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
    en_i               <= '1';
    sel_i              <= x"0001";


    for i in 0 to 7 loop

      matrix_sel_i   <= std_logic_vector(to_unsigned(i, matrix_sel_i'length));
      wait for 5 us;
      report "Start the config ";
      start_config_i <= '1';
      wait for 0.5 us;
      start_config_i <= '0';
      wait until falling_edge(config_done_o) for 10 ms;

    end loop;

    wait for 50 us;

    for i in 0 to 7 loop
      matrix_sel_i   <= std_logic_vector(to_unsigned(i, matrix_sel_i'length));
      wait for 5 us;
      test_display_i <= '1';
      wait until (display_test_o(i) = '1') for 10 ms;
      wait for 10 us;
      test_display_i <= '0';
      wait until (display_test_o(i) = '0') for 10 ms;

    end loop;

    wait for 25 us;

    -- pour test
    wait;

    report "SET DISPLAY !!!";
    update_display_i <= '1';

    wait for 40 us;
    update_display_i <= '0';

    wait until rising_edge(update_done_o) for 10 ms;


    report"Set 0 on the display";
    sel_i            <= x"0000";
    wait for 11 us;
    update_display_i <= '1', '0' after 1 us;

    wait until rising_edge(update_done_o) for 10 ms;


    report"Set 9 on the display";
    sel_i            <= x"0009";
    wait for 11 us;
    update_display_i <= '1', '0' after 1 us;

    wait until rising_edge(update_done_o) for 10 ms;


    decode_mode_i      <= "11";
    intensity_format_i <= x"E";
    scan_limit_i       <= "010";


    wait for 5 us;

    report "Start the config";
    start_config_i <= '1';
    wait for 0.5 us;
    start_config_i <= '0';

    wait until falling_edge(config_done_o) for 10 ms;



    report integer'image(C_MATRIX_SEL_SIZE);


    report "end of test !!!";
    wait;

  end process p_stimuli_mng;

  -- pattern_selector inst
  pattern_selector_inst : pattern_selector
    port map (
      clock_i             => clock_i,
      reset_n_i           => reset_n_i,
      en_i                => en_i,
      sel_i               => sel_i,
      digit_0_o           => digit_0_o,
      digit_1_o           => digit_1_o,
      digit_2_o           => digit_2_o,
      digit_3_o           => digit_3_o,
      digit_4_o           => digit_4_o,
      digit_5_o           => digit_5_o,
      digit_6_o           => digit_6_o,
      digit_7_o           => digit_7_o,
      pattern_available_o => pattern_available_o);

  digit_0_i <= digit_0_o;
  digit_1_i <= digit_1_o;
  digit_2_i <= digit_2_o;
  digit_3_i <= digit_3_o;
  digit_4_i <= digit_4_o;
  digit_5_i <= digit_5_o;
  digit_6_i <= digit_6_o;
  digit_7_i <= digit_7_o;


  -- MAX7219_controller inst
  max7219_controller_inst : max7219_controller
    port map (
      clock_i             => clock_i,
      reset_n_i           => reset_n_i,
      frame_done_i        => frame_done_i,
      test_display_i      => test_display_i,
      update_display_i    => update_display_i,
      pattern_available_i => pattern_available_i,
      matrix_sel_i        => matrix_sel_i,
      start_config_i      => start_config_i,
      decode_mode_i       => decode_mode_i,
      intensity_format_i  => intensity_format_i,
      scan_limit_i        => scan_limit_i,
      digit_0_i           => digit_0_i,
      digit_1_i           => digit_1_i,
      digit_2_i           => digit_2_i,
      digit_3_i           => digit_3_i,
      digit_4_i           => digit_4_i,
      digit_5_i           => digit_5_i,
      digit_6_i           => digit_6_i,
      digit_7_i           => digit_7_i,
      config_done_o       => config_done_o,
      display_on_o        => display_on_o,
      display_test_o      => display_test_o,
      update_done_o       => update_done_o,
      wdata_o             => wdata_o,
      start_frame_o       => start_frame_o,
      en_load_o           => en_load_o);

  wdata_i             <= wdata_o;
  start_frame_i       <= start_frame_o;
  frame_done_i        <= frame_done_o;
  pattern_available_i <= pattern_available_o;
  en_load_i           <= en_load_o;

  -- max7219_interface inst
  max_7219_interface_inst : max7219_interface
    port map(
      clock_i       => clock_i,
      reset_n_i     => reset_n_i,
      wdata_i       => wdata_i,
      start_frame_i => start_frame_i,
      en_load_i     => en_load_i,
      load_o        => load_o,
      data_o        => data_o,
      clk_o         => clk_o,
      frame_done_o  => frame_done_o);


end architecture arch_test_max7219_controller;
