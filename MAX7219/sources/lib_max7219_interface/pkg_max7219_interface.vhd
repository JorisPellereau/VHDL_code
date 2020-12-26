-------------------------------------------------------------------------------
-- Title      : MAX7219 Interface Package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_max7219_interface.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-12-26
-- Last update: 2020-12-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package pkg_max7219_interface is

  -- MAX7219 Interface
  -- Physical interface with MAX7219 Matrix Component
  component max7219_if is
    generic (
      G_MAX_HALF_PERIOD : integer := 4;  -- 4 => 6.25MHz with 50MHz input
      G_LOAD_DURATION   : integer := 4   -- LOAD DURATION in clk_in period
      );
    port (
      --# {{clocks|Clock and Reset}}
      clk   : in std_logic;              -- System clock
      rst_n : in std_logic;              -- Asynchronous active low reset

      -- Input commands
      --# {{Control signals}}
      i_start   : in std_logic;         -- Start the transaction
      i_en_load : in std_logic;         -- Enable the generation of o_load
      i_data    : in std_logic_vector(15 downto 0);  -- Data to send te the Max7219

      -- MAX7219 I/F
      --# {{MAX7219 Interface}}
      o_max7219_load : out std_logic;   -- LOAD command
      o_max7219_data : out std_logic;   -- DATA to send
      o_max7219_clk  : out std_logic;   -- CLK

      -- Transaction Done
      --# {{Status signal}}
      o_done : out std_logic);          -- Frame done
  end component;

end package pkg_max7219_interface;
