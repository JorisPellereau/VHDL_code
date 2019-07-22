-------------------------------------------------------------------------------
-- Title      : MAX7219 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_controller.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-22
-- Last update: 2019-07-22
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

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_controller is

  port (
    clock_i   : in std_logic;           -- System clock
    reset_n_i : in std_logic;           -- Asynchonous Active Low

    -- From MAX7219 interface
    frame_done_i : in std_logic;  -- Frame done from the MAX7219 interface

    -- Config inputs
    start_config_i     : in std_logic;  -- Start the config of the MAX7219
    decode_mode_i      : in std_logic_vector(1 downto 0);  -- Decode mode (0x0 - 0x1 - 0x2 - 0x3)
    intensity_format_i : in std_logic_vector(3 downto 0);  -- Intensity format
    scan_limit_i       : in std_logic_vector(2 downto 0);  -- Scan limit config

    -- Flags 
    config_done_o : out std_logic;      -- Config is done
    display_on_o  : out std_logic;      -- State of the display 1 : on 0 : off

    -- To MAX7219 interface
    wdata_o       : out std_logic_vector(15 downto 0);  -- Data bus                                        
    start_frame_o : out std_logic);     -- Start a frame

end entity max7219_controller;


architecture arch_max7219_controller of max7219_controller is

  -- INTERNAL SIGNALS

  -- FSM States
  signal state_max7219_ctrl : t_max7219_ctrl_fsm;  -- State of the controller

  -- Config. SIGNAL
  signal decode_mode_s      : std_logic_vector(7 downto 0);  -- Data for Decode mode register
  signal intensity_format_s : std_logic_vector(7 downto 0);  -- Data for the intensity register
  signal scan_limit_s       : std_logic_vector(7 downto 0);  -- Data for the scan limit register

  signal config_busy_s       : std_logic;  -- Config. ongoing
  signal start_config_i_s    : std_logic;  -- Old start_config_i
  signal start_config_r_edge : std_logic;  -- Rising edge of start config

  signal frame_done_i_s    : std_logic;  -- Old frame_done_i
  signal frame_done_r_edge : std_logic;  -- Rising edge of frame_done_i

  -- outputs SIGNALS
  signal wdata_s        : std_logic_vector(15 downto 0);  -- Data to write on the bus
  signal start_frame_s  : std_logic;    -- Start a frame
  signal start_frame_ss : std_logic;    -- Start a frame
  signal config_done_s  : std_logic;    -- Configuration done
  signal display_on_s   : std_logic;    -- Stat of the display

  signal en_start_frame_s : std_logic;  -- Send a frame when = '1'
  signal cnt_config_s     : integer range 0 to 2;  -- Counts the frame to transmit for the config

begin  -- architecture arch_max7219_controller


  -- This process manages the start_config - frame_done inputs
  p_inputs_re_mng : process (clock_i, reset_n_i) is
  begin  -- process p_start_config_mng
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      start_config_i_s    <= '0';
      frame_done_i_s      <= '0';
      start_config_r_edge <= '0';
      frame_done_r_edge   <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      start_config_i_s    <= start_config_i;
      frame_done_i_s      <= frame_done_i;
      start_config_r_edge <= start_config_i and not start_config_i_s;
      frame_done_r_edge   <= frame_done_i and not frame_done_i_s;
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
          end if;

        when SET_CFG =>
          if(config_done_s = '1') then  -- or cfg_busy = '0' ?
            state_max7219_ctrl <= DISPLAY_ON;
          end if;

        when DISPLAY_ON =>
          if(display_on_s = '1') then
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
      wdata_s          <= (others => '0');
      start_frame_s    <= '0';
      start_frame_ss   <= '0';
      config_done_s    <= '0';
      en_start_frame_s <= '0';
      display_on_s     <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      case state_max7219_ctrl is
        when IDLE =>
          wdata_s          <= (others => '0');
          start_frame_s    <= '0';
          start_frame_ss   <= '0';
          -- config_done_s    <= '0';
          en_start_frame_s <= '1';

        when SET_CFG =>

          -- Counts the frame acconding to frame_done
          if(frame_done_r_edge = '1') then
            if(cnt_config_s < C_CFG_NB - 1) then
              cnt_config_s     <= cnt_config_s + 1;
              config_done_s    <= '0';
              en_start_frame_s <= '1';
            else
              config_done_s    <= '1';
              cnt_config_s     <= 0;
              en_start_frame_s <= '1';  -- ???
            end if;
          end if;

          if(cnt_config_s = 0 and en_start_frame_s = '1') then
            wdata_s        <= C_DECODE_MODE_ADDR & decode_mode_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_config_s = 1 and en_start_frame_s = '1') then
            wdata_s        <= C_INTENSITY_ADDR & intensity_format_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;

          elsif(cnt_config_s = 2 and en_start_frame_s = '1') then
            wdata_s        <= C_SCAN_LIMIT_ADDR & scan_limit_s;
            start_frame_s  <= '1';
            start_frame_ss <= start_frame_s;
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

        when others => null;
      end case;
    end if;
  end process p_outputs_mng;

  -- OUTPUTS affectation
  wdata_o       <= wdata_s;
  start_frame_o <= start_frame_ss;
  config_done_o <= config_done_s;
  display_on_o  <= display_on_s;

end architecture arch_max7219_controller;
