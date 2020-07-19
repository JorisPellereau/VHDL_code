-------------------------------------------------------------------------------
-- Title      : MAX7219 DISPLAY MANAGER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_display_manager.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-09
-- Last update: 2020-07-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 DISPLAY MANAGER
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-09  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_display_manager is
  generic (
    G_DIGITS_NB      : integer range 2 to 8 := 8;  -- DIGIT NB on the MATRIX DISPLAY
    G_RAM_ADDR_WIDTH : integer              := 8);  -- RAM ADDR WIDTH

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- NEW CONFIG.
    i_config_val        : in std_logic;  -- New Config Available
    i_config_start_addr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    i_config_last_addr  : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

    i_score_val        : in std_logic;  -- New SCORE available
    i_score_start_addr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    i_score_last_addr  : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

    i_msg_val        : in std_logic;    -- New Message available
    i_msg_start_addr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    i_msg_last_addr  : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

    -- MAX7219 RAM DECOD I/F
    i_ptr_equality : in  std_logic;     -- PTR EQUALITY
    o_start_ptr    : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- START PTR
    o_last_ptr     : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST PTR
    o_ptr_val      : out std_logic;     -- PTR VALID
    o_loop         : out std_logic;     -- LOOP MODE
    o_en           : out std_logic      -- ENABLE CMD DECOD BLOCK
    );

end entity max7219_display_manager;

architecture behv of max7219_display_manager is

  -- TYPES
  type t_display_manager_states is (IDLE, WAIT_CMD, SET_CONFIG, SET_SCORE, SET_MSG, WAIT_EQU);  -- STATES

  -- INTERNAL SIGNALS
  signal s_curr_state : t_display_manager_states;  -- Current State
  signal s_next_state : t_display_manager_states;  -- Next State

  signal s_start_ptr : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_last_ptr  : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_ptr_val   : std_logic;
  signal s_en        : std_logic;

begin  -- architecture behv

  p_next_state_mngt : process (clk, rst_n) is
  begin  -- process p_next_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_curr_state <= IDLE;
      s_next_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_curr_state <= s_next_state;

      case s_curr_state is
        when IDLE =>
          s_next_state <= WAIT_CMD;

        when WAIT_CMD =>
          if(i_config_val = '1') then
            s_next_state <= SET_CONFIG;
          elsif(i_score_val = '1') then
            s_next_state <= SET_SCORE;
          elsif(i_msg_val = '1') then
            s_next_state <= SET_MSG;
          end if;

        when SET_CONFIG =>
          if(s_ptr_val = '1') then
            s_next_state <= WAIT_EQU;
          end if;

        when SET_SCORE =>
          if(s_ptr_val = '1') then
            s_next_state <= WAIT_EQU;
          end if;

        when SET_MSG =>
          if(s_ptr_val = '1') then
            s_next_state <= WAIT_EQU;
          end if;

        when WAIT_EQU =>
          if(i_ptr_equality = '1') then
            s_next_state <= WAIT_CMD;
          end if;

        when others => null;
      end case;
    end if;
  end process p_next_state_mngt;

  p_command_mngt : process (clk, rst_n) is
  begin  -- process p_command_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en        <= '0';
      s_ptr_val   <= '0';
      s_start_ptr <= (others => '0');
      s_last_ptr  <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_ptr_val <= '0';                 -- PULSE
      case s_curr_state is
        when WAIT_CMD =>
          s_en <= '1';
          if(i_config_val = '1') then
            s_start_ptr <= i_config_start_addr;
            s_last_ptr  <= i_config_last_addr;
          elsif(i_score_val = '1') then
            s_start_ptr <= i_score_start_addr;
            s_last_ptr  <= i_score_last_addr;
          elsif(i_msg_val = '1') then
            s_start_ptr <= i_msg_start_addr;
            s_last_ptr  <= i_msg_last_addr;
          end if;

        when SET_CONFIG =>
          s_ptr_val <= '1';

        when SET_SCORE =>
          s_ptr_val <= '1';

        when SET_MSG =>
          s_ptr_val <= '1';

        when others => null;
      end case;
    end if;
  end process p_command_mngt;


  -- OUTPUTS AFFECTATION
  o_start_ptr <= s_start_ptr;
  o_last_ptr  <= s_last_ptr;
  o_ptr_val   <= s_ptr_val;
  o_en        <= s_en;

end architecture behv;
