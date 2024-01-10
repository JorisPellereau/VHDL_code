-------------------------------------------------------------------------------
-- Title      : SPI Mirror TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : spi_mirror_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-09
-- Last update: 2024-01-10
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: DE0 NANO Use as a single SPI MIRROR TOP function
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-09  1.0      linux-jp        Created
-------------------------------------------------------------------------------

  library ieee;
use ieee.std_logic_1164.all;

entity spi_mirror_top is
  generic(
    G_SPI_SIZE : integer := 4
    );
  port (
    clk_spi     : in  std_logic;                                   -- Clock SPI from PR_115 BOARD    
    rst_n       : in  std_logic;                                   -- Asynchronous Reset
    clk_spi_out : out std_logic;                                   -- Clock SPI return passthrough
    spi_cs_n    : in  std_logic;                                   -- SPI Chip Select
    spi_di      : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);   -- SPI Data In
    spi_do      : out std_logic_vector(G_SPI_SIZE - 1 downto 0));  -- SPI Data Out

end entity spi_mirror_top;

architecture rtl of spi_mirror_top is

begin  -- architecture rtl


  clk_spi_out <= clk_spi;               -- Only passthrough


  g_spi_do : if(G_SPI_SIZE = 4) generate

    g_for : for i in 0 to G_SPI_SIZE - 1 generate
      -- purpose: Drive SPI Data Out - Only resynchronized input data
      -- The Clock SPI is used as clock
      p_spi_do : process (clk_spi, rst_n) is
      begin  -- process p_spi_do
        if rst_n = '0' then              -- asynchronous reset (active low)
          spi_do(i) <= '0';
        elsif rising_edge(clk_spi) then  -- rising clock edge
          if(spi_cs_n = '0') then
            spi_do(i) <= spi_di(i);
          else
            spi_do(i) <= '0';
          end if;
        end if;

      end process p_spi_do;
    end generate;
  end generate;

end architecture rtl;
