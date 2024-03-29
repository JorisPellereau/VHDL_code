-------------------------------------------------------------------------------
-- Title      : MAX7219 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-22
-- Last update: 2024-01-24
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is a controller for the MAX7219 component
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

entity max7219_controller is

  port (
    clock_i   : in std_logic;           -- System clock
    reset_n_i : in std_logic;           -- Asynchonous Active Low

    -- From MAX7219 interface
    frame_done_i : in std_logic;  -- Frame done from the MAX7219 interface

    test_display_i      : in std_logic;  -- Test the display
    update_display_i    : in std_logic;  -- Update the display
    pattern_available_i : in std_logic;  -- Pattern available

    -- Matrix selector
    matrix_sel_i : in std_logic_vector(C_MATRIX_SEL_SIZE - 1 downto 0);


    -- Config inputs
    start_config_i     : in std_logic;  -- Start the config of the MAX7219
    decode_mode_i      : in std_logic_vector(1 downto 0);  -- Decode mode (0x0 - 0x1 - 0x2 - 0x3)
    intensity_format_i : in std_logic_vector(3 downto 0);  -- Intensity format
    scan_limit_i       : in std_logic_vector(2 downto 0);  -- Scan limit config

    -- Config Digits
    digit_0_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
    digit_1_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
    digit_2_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
    digit_3_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
    digit_4_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
    digit_5_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
    digit_6_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
    digit_7_i : in std_logic_vector(7 downto 0);  -- Digit 0 data

    -- Flags 
    config_done_o  : out std_logic;     -- Config is done
    display_on_o   : out std_logic;     -- State of the display 1 : on 0 : off
    display_test_o : out std_logic;     -- 1 : Display in test mode
    update_done_o  : out std_logic;     -- Display Update terminated

    -- To MAX7219 interface
    wdata_o       : out std_logic_vector(15 downto 0);  -- Data bus                                        
    start_frame_o : out std_logic;      -- Start a frame
    en_load_o     : out std_logic);     -- Enable the LOAD generation

end entity max7219_controller;


architecture arch_max7219_controller of max7219_controller is

  -- INTERNAL SIGNALS

  -- FSM States
  signal state_max7219_ctrl : t_max7219_ctrl_fsm;  -- State of the controller

  -- Config. SIGNAL
  signal decode_mode_s      : std_logic_vector(7 downto 0);  -- Data for Decode mode register
  signal intensity_format_s : std_logic_vector(7 downto 0);  -- Data for the intensity register
  signal scan_limit_s       : std_logic_vector(7 downto 0);  -- Data for the scan limit register

  -- atrix sel signal
  signal matrix_sel_i_s        : std_logic_vector(C_MATRIX_SEL_SIZE - 1 downto 0);
  signal cnt_matrix_sel_s      : integer range 0 to C_MATRIX_NB - 1;  -- Counts the frame to send to the matrix
  signal cnt_matrix_sel_done_s : std_logic;  -- Counter reach

  signal config_busy_s       : std_logic;  -- Config. ongoing
  signal start_config_i_s    : std_logic;  -- Old start_config_i
  signal start_config_r_edge : std_logic;  -- Rising edge of start config

  signal frame_done_i_s    : std_logic;  -- Old frame_done_i
  signal frame_done_r_edge : std_logic;  -- Rising edge of frame_done_i

  signal pattern_available_i_s    : std_logic;  -- Old pattern available
  signal pattern_available_r_edge : std_logic;  -- RE of pattern available

  signal update_display_i_s    : std_logic;  -- Old update_display_i
  signal update_display_r_edge : std_logic;  -- Rising edge of update_display

  -- outputs SIGNALS
  signal wdata_s        : std_logic_vector(15 downto 0);  -- Data to write on the bus
  signal start_frame_s  : std_logic;    -- Start a frame
  signal start_frame_ss : std_logic;    -- Start a frame
  signal config_done_s  : std_logic;    -- Configuration done
  signal display_on_s   : std_logic;    -- Stat of the display
  signal display_test_s : std_logic;    -- Display in mode test
  signal en_load_s      : std_logic;    -- Enable LOAD output

  signal en_start_frame_s : std_logic;  -- Send a frame when = '1'
  signal cnt_config_s     : integer range 0 to C_CFG_NB - 1;  -- Counts the frame to transmit for the config

  -- DIGITS
  signal digit_0_s : std_logic_vector(7 downto 0);  -- Digit 0 data
  signal digit_1_s : std_logic_vector(7 downto 0);  -- Digit 0 data
  signal digit_2_s : std_logic_vector(7 downto 0);  -- Digit 0 data
  signal digit_3_s : std_logic_vector(7 downto 0);  -- Digit 0 data
  signal digit_4_s : std_logic_vector(7 downto 0);  -- Digit 0 data
  signal digit_5_s : std_logic_vector(7 downto 0);  -- Digit 0 data
  signal digit_6_s : std_logic_vector(7 downto 0);  -- Digit 0 data
  signal digit_7_s : std_logic_vector(7 downto 0);  -- Digit 0 data

  signal cnt_digit_s   : integer range 0 to C_DIGIT_NB - 1;  -- Counts the digit to passed
  signal update_done_s : std_logic;     -- Display update terminated

begin  -- architecture arch_max7219_controller


  -- This process manages the start_config - frame_done inputs
  p_inputs_re_mng : process (clock_i, reset_n_i) is
  begin  -- process p_start_config_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      start_config_i_s         <= '0';
      frame_done_i_s           <= '0';
      start_config_r_edge      <= '0';
      frame_done_r_edge        <= '0';
      pattern_available_i_s    <= '0';
      pattern_available_r_edge <= '0';
      update_display_i_s       <= '0';
      update_display_r_edge    <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      start_config_i_s         <= start_config_i;
      frame_done_i_s           <= frame_done_i;
      pattern_available_i_s    <= pattern_available_i;
      update_display_i_s       <= update_display_i;
      start_config_r_edge      <= start_config_i and not start_config_i_s;
      frame_done_r_edge        <= frame_done_i and not frame_done_i_s;
      pattern_available_r_edge <= pattern_available_i and not pattern_available_i_s;
      update_display_r_edge    <= update_display_i and not update_display_i_s;
    end if;
  end process p_inputs_re_mng;
  -- start_config_r_edge <= start_config_i and not start_config_i_s;
  -- frame_done_r_edge   <= frame_done_i and not frame_done_i_s;


  -- This process manages the config 
  p_config_mng : process (clock_i, reset_n_i) is
  begin  -- process p_config_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      config_busy_s      <= '0';
      intensity_format_s <= (others => '0');
      scan_limit_s       <= (others => '0');
      decode_mode_s      <= (others => '0');

    elsif clock_i'event and clock_i = '1' then            -- rising clock edge
      if(start_config_r_edge = '1' and config_busy_s = '0' and state_max7219_ctrl = IDLE) then
        -- Latch inputs
        intensity_format_s <= x"0" & intensity_format_i;  -- Intensity format data  
        scan_limit_s       <= b"00000" & scan_limit_i;    -- Scnal limit data

        case decode_mode_i is           -- Decode mode data
          when "00" =>
            decode_mode_s <= x"00";
          when "01" =>
            decode_mode_s <= x"01";
          when "10" =>
            decode_mode_s <= x"0F";
          when "11" =>
            decode_mode_s <= x"FF";
          when others => null;
        end case;

        config_busy_s <= '1';           -- Config on going
      elsif(config_done_s = '1') then
        config_busy_s <= '0';
      end if;
    end if;
  end process p_config_mng;

  -- This process manages the digits input 
  p_digit_in_mng : process (clock_i, reset_n_i) is
  begin  -- process p_digit_in_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      digit_0_s <= (others => '0');
      digit_1_s <= (others => '0');
      digit_2_s <= (others => '0');
      digit_3_s <= (others => '0');
      digit_4_s <= (others => '0');
      digit_5_s <= (others => '0');
      digit_6_s <= (others => '0');
      digit_7_s <= (others => '0');
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(update_display_r_edge = '1') then
        digit_0_s <= digit_0_i;
        digit_1_s <= digit_1_i;
        digit_2_s <= digit_2_i;
        digit_3_s <= digit_3_i;
        digit_4_s <= digit_4_i;
        digit_5_s <= digit_5_i;
        digit_6_s <= digit_6_i;
        digit_7_s <= digit_7_i;
      end if;
    end if;
  end process p_digit_in_mng;

  -- purpose: This process lach  matrix_sel_i_s 
  p_matrix_sel_in_mng : process (clock_i, reset_n_i) is
  begin  -- process p_matrix_sel_in_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      matrix_sel_i_s <= (others => '0');
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      if(start_config_r_edge = '1') then
        matrix_sel_i_s <= matrix_sel_i;
      end if;
    end if;
  end process p_matrix_sel_in_mng;

  -- purpose: This process manages the state of the controller
  p_state_mng : process (clock_i, reset_n_i) is
  begin  -- process p_state_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      state_max7219_ctrl <= IDLE;
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      case state_max7219_ctrl is
        when IDLE =>
          if(config_busy_s = '1') then
            state_max7219_ctrl <= SET_CFG;
          elsif(test_display_i = '1') then
            state_max7219_ctrl <= TEST_DISPLAY_ON;
          elsif(update_display_r_edge = '1' and pattern_available_i = '1' and display_on_s = '1') then
            state_max7219_ctrl <= SET_DISPLAY;
          end if;

        when SET_CFG =>
          if(config_done_s = '1') then  -- or cfg_busy = '0' ?
            state_max7219_ctrl <= DISPLAY_ON;
          end if;

        when DISPLAY_ON =>
          if(display_on_s = '1') then
            state_max7219_ctrl <= IDLE;
          end if;

        when TEST_DISPLAY_ON =>
          if(display_test_s = '1') then
            state_max7219_ctrl <= TEST_DISPLAY_OFF;
          end if;

        when TEST_DISPLAY_OFF =>
          if(display_test_s = '0') then
            state_max7219_ctrl <= IDLE;
          end if;

        when SET_DISPLAY =>
          if(update_done_s = '1') then
            state_max7219_ctrl <= IDLE;
          end if;

        when others => null;
      end case;
    end if;
  end process p_state_mng;

  -- purpose: This process manages the outputs of the controller 
  p_outputs_mng : process (clock_i, reset_n_i) is
  begin  -- process p_outputs_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      wdata_s               <= (others => '0');
      start_frame_s         <= '0';
      start_frame_ss        <= '0';
      cnt_config_s          <= 0;
      config_done_s         <= '0';
      en_start_frame_s      <= '0';
      display_on_s          <= '0';
      display_test_s        <= '0';
      update_done_s         <= '0';
      en_load_s             <= '0';
      cnt_matrix_sel_s      <= 0;
      cnt_matrix_sel_done_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      case state_max7219_ctrl is
        when IDLE =>
          wdata_s          <= (others => '0');
          start_frame_s    <= '0';
          start_frame_ss   <= '0';
          config_done_s    <= '0';
          en_start_frame_s <= '1';
          update_done_s    <= '0';
        when SET_CFG =>

          -- if(frame_done_r_edge = '1') then
          --   if(cnt_matrix_sel_s < unsigned(matrix_sel_i_s)) then
          --     cnt_matrix_sel_s      <= cnt_matrix_sel_s + 1;
          --     cnt_matrix_sel_done_s <= '0';
          --   else
          --     cnt_matrix_sel_s      <= 0;  -- RAZ 
          --     cnt_matrix_sel_done_s <= '1';
          --   end if;
          -- end if;

          -- Counts the frame acconding to frame_done

          if(frame_done_r_edge = '1') then
            if(cnt_config_s < C_CFG_NB - 1) then
              cnt_config_s     <= cnt_config_s + 1;
              config_done_s    <= '0';
              en_start_frame_s <= '1';
            else
              config_done_s    <= '1';
              cnt_config_s     <= 0;
              en_start_frame_s <= '1';          -- ???
            end if;
          end if;

          -- Gestion des trames a envoyer
          if(cnt_config_s = 0 and en_start_frame_s = '1') then -- and cnt_matrix_sel_s = 0) then
            wdata_s        <= C_DECODE_MODE_ADDR & decode_mode_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_config_s = 1 and en_start_frame_s = '1') then -- and cnt_matrix_sel_s = 0) then
            wdata_s        <= C_INTENSITY_ADDR & intensity_format_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_config_s = 2 and en_start_frame_s = '1') then -- and cnt_matrix_sel_s = 0) then
            wdata_s        <= C_SCAN_LIMIT_ADDR & scan_limit_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          -- Send no op
          -- elsif(en_start_frame_s = '1' and cnt_matrix_sel_s /= 0) then
          --   wdata_s        <= C_NO_OP_ADDR & scan_limit_s;
          --   start_frame_s  <= '1';
          --   start_frame_ss <= start_frame_s;
          elsif(en_start_frame_s = '0') then
            start_frame_s  <= '0';
            start_frame_ss <= '0';
          end if;

          if(start_frame_ss = '1') then
            en_start_frame_s <= '0';
          end if;

        when DISPLAY_ON =>

          if(frame_done_r_edge = '1') then
            display_on_s <= '1';
          end if;

          if(en_start_frame_s = '1') then
            wdata_s        <= C_SHUTDOWN_ADDR & x"01";  -- Normal Operation
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;
          else
            start_frame_s  <= '0';
            start_frame_ss <= '0';
          end if;

          if(start_frame_ss = '1') then
            en_start_frame_s <= '0';
          end if;

        when TEST_DISPLAY_ON =>

          if(frame_done_r_edge = '1') then
            display_test_s   <= '1';
            en_start_frame_s <= '1';
          end if;

          if(en_start_frame_s = '1') then
            wdata_s        <= C_DISPLAY_TEST_ADDR & x"01";  -- Display test mode
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;
          else
            start_frame_s  <= '0';
            start_frame_ss <= '0';
          end if;

          if(start_frame_ss = '1') then
            en_start_frame_s <= '0';
          end if;

        when TEST_DISPLAY_OFF =>
          -- Need to wait for the release of the test_display_i input
          if(test_display_i = '0') then

            if(frame_done_r_edge = '1') then
              display_test_s <= '0';
            end if;

            if(en_start_frame_s = '1') then
              wdata_s        <= C_DISPLAY_TEST_ADDR & x"01";  -- Display test mode
              start_frame_s  <= '1';
              start_frame_ss <= start_frame_s;
            else
              start_frame_s  <= '0';
              start_frame_ss <= '0';
            end if;

            if(start_frame_ss = '1') then
              en_start_frame_s <= '0';
            end if;

          end if;

        when SET_DISPLAY =>
          -- Counts the frame acconding to frame_done
          if(frame_done_r_edge = '1') then
            if(cnt_digit_s < C_DIGIT_NB - 1) then
              cnt_digit_s      <= cnt_digit_s + 1;
              en_start_frame_s <= '1';
            else
              cnt_digit_s      <= 0;
              update_done_s    <= '1';
              en_start_frame_s <= '1';  -- ???
            end if;
          end if;

          if(cnt_digit_s = 0 and en_start_frame_s = '1') then
            wdata_s        <= C_DIGIT_0_ADDR & digit_0_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_digit_s = 1 and en_start_frame_s = '1') then
            wdata_s        <= C_DIGIT_1_ADDR & digit_1_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_digit_s = 2 and en_start_frame_s = '1') then
            wdata_s        <= C_DIGIT_2_ADDR & digit_2_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_digit_s = 3 and en_start_frame_s = '1') then
            wdata_s        <= C_DIGIT_3_ADDR & digit_3_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_digit_s = 4 and en_start_frame_s = '1') then
            wdata_s        <= C_DIGIT_4_ADDR & digit_4_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_digit_s = 5 and en_start_frame_s = '1') then
            wdata_s        <= C_DIGIT_5_ADDR & digit_5_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_digit_s = 6 and en_start_frame_s = '1') then
            wdata_s        <= C_DIGIT_6_ADDR & digit_6_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_digit_s = 7 and en_start_frame_s = '1') then
            wdata_s        <= C_DIGIT_7_ADDR & digit_7_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;


          elsif(en_start_frame_s = '0') then
            start_frame_s  <= '0';
            start_frame_ss <= '0';
          end if;

          if(start_frame_ss = '1') then
            en_start_frame_s <= '0';
          end if;


        when others => null;
      end case;
    end if;
  end process p_outputs_mng;

-- OUTPUTS affectation
  wdata_o        <= wdata_s;
  start_frame_o  <= start_frame_ss;
  config_done_o  <= config_done_s;
  display_on_o   <= display_on_s;
  display_test_o <= display_test_s;
  update_done_o  <= update_done_s;
  en_load_o      <= en_load_s;

end architecture arch_max7219_controller;
