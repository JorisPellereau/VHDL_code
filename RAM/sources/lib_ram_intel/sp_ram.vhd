-------------------------------------------------------------------------------
-- Title      : Single PORT RAM for INTAL Ram inference
-- Project    : 
-------------------------------------------------------------------------------
-- File       : sp_ram.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-14
-- Last update: 2023-09-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Single PORT RAM
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-14  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sp_ram is

  generic (
    G_ADDR_WIDTH : integer := 10;       -- ADDR WIDTH
    G_DATA_WIDTH : integer := 8         -- DATA WIDTH
    );
  port (
    clk      : in  std_logic;           -- RAM Clock
    data_in  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA IN
    wr_addr  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Write Addr Width
    rd_addr  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Read Addr Width
    we       : in  std_logic;           -- Write Enable
    data_out : out std_logic_vector(G_DATA_WIDTH - 1 downto 0));  -- DATA out

end entity sp_ram;

architecture rtl of sp_ram is

  -- == TYPES ==
  type t_mem is array (0 to 2**G_ADDR_WIDTH-1) of std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Memory Type

  -- == Internal Signals ==
  signal mem : t_mem;                   -- Memory

begin  -- architecture rtl

  -- Management of the write and read access to the RAM
  p_mem : process (clk)
  begin

    if(rising_edge(clk)) then

      -- Write to the memory when we is set
      if(we = '1') then
        mem(to_integer(unsigned(wr_addr))) <= data_in;
      end if;

      -- Read the data from the ram. A data is available every clock cycle
      -- It depends on rd_addr
      data_out <= mem(to_integer(unsigned(rd_addr)));

    end if;
  end process;

end architecture rtl;
