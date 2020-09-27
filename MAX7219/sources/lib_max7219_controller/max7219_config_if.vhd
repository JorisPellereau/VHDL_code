-------------------------------------------------------------------------------
-- Title      : MAX7219 Configuration Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_config_if.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-09-26
-- Last update: 2020-09-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 Configuration I/F
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-09-26  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity max7219_config_if is

  generic(
    G_MAXTRIX_NB : integer := 8
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous clock

    -- MATRIX CONFIG.
    i_decod_mode     : in  std_logic_vector(7 downto 0);  -- DECOD MODE
    i_intensity      : in  std_logic_vector(7 downto 0);  -- INTENSITY
    i_scan_limit     : in  std_logic_vector(7 downto 0);  -- SCAN LIMIT
    i_shutdown       : in  std_logic_vector(7 downto 0);  -- SHUTDOWN MODE
    i_display_test   : in  std_logic;   -- DISPLAY TEST Config
    i_new_config_val : in  std_logic;   -- CONFIG. VALID
    o_config_done    : out std_logic;   -- CONFIG. DONE

    -- MAX7219 I/F
    i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
    o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
    o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
    o_max7219_if_data    : out std_logic_vector(15 downto 0));  -- MAX7219 I/F Data

end entity max7219_config_if;

architecture behv of max7219_config_if is

  -- INTERNAL SIGNALS

  signal s_init_config           : std_logic;  -- Init Configuration
  signal s_new_config_val        : std_logic;
  signal s_new_config_val_r_edge : std_logic;  -- Rising Edge of New Config. Val

  signal s_config_done : std_logic;     -- Config Done

  signal s_cnt_5      : std_logic_vector(2 downto 0);  -- Counter to 5
  signal s_cnt_5_done : std_logic;                     -- Coutner to 5 reach

  signal s_cnt_matrix      : std_logic_vector(3 downto 0);
  signal s_cnt_matrix_done : std_logic;

  signal s_max7219_if_start   : std_logic;
  signal s_max7219_if_en_load : std_logic;
  signal s_max7219_if_data    : std_logic_vector(15 downto 0);

begin  -- architecture behv


  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_new_config_val <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_new_config_val <= i_new_config_val;
    end if;
  end process p_latch_inputs;

  -- Rising Edge management
  s_new_config_val_r_edge <= i_new_config_val and not s_new_config_val;

  -- purpose: Configuration Done management
  p_config_done_mngt : process (clk, rst_n) is
  begin  -- process p_config_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_config_done <= '0';

    elsif clk'event and clk = '1' then  -- rising clock edge

    end if;
  end process p_config_done_mngt;


  p_config_mngt : process (clk, rst_n) is
  begin  -- process p_config_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_init_config <= '1';
      s_cnt_5       <= (others => '0');
      s_cnt_5_done  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Config On Initialization
      if(s_init_config = '1') then
        if(i_max7219_if_done = '1') then

          case s_cnt_5 is
            when "000" =>

            when others => null;
          end case;

        end if;
      end if;

    end if;
  end process p_config_mngt;


end architecture behv;
