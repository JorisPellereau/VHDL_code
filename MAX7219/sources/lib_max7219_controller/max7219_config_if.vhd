-------------------------------------------------------------------------------
-- Title      : MAX7219 Configuration Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_config_if.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-09-26
-- Last update: 2020-09-26
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
  signal s_config_done : std_logic;     -- Config Done

begin  -- architecture behv



  -- purpose: Configuration Done management
  p_config_done_mngt : process (clk, rst_n) is
  begin  -- process p_config_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_config_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

    end if;
  end process p_config_done_mngt;


end architecture behv;
