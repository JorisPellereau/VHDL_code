-------------------------------------------------------------------------------
-- Title      : MAX7219 package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_max7219.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-19
-- Last update: 2019-07-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the package for the Max7219 component
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-19  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pkg_max7219 is

  -- SYSTEM clock : 50MHz : 20 ns
  -- CLK frequency : 5MHz (10MHz max)

  -- CONSTANTS
  constant C_T_CLK    : integer := 10;      -- 50MHz/5MHz = 10
  constant C_T_2_sclk : integer := 10 / 2;  -- Half Period of CLK


  -- COMPONENTS
  component max7219_interface
    port (
      clock_i       : in  std_logic;    -- System clock
      reset_n_i     : in  std_logic;    -- Asynchronous active low reset
      wdata_i       : in  std_logic_vector(15 downto 0);  -- Data to send te the Max7219
      start_frame_i : in  std_logic;    -- Start the transaction
      load_o        : out std_logic;    -- LOAD command
      data_o        : out std_logic;    -- DATA to send th
      clk_o         : out std_logic;    -- CLK
      frame_done_o  : out std_logic);   -- Frame done
  end component;

end package pkg_max7219;
