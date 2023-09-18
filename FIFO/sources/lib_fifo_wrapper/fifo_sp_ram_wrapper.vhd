-------------------------------------------------------------------------------
-- Title      : FIFO SP RAM Wrapper
-- Project    : 
-------------------------------------------------------------------------------
-- File       : fifo_sp_ram_wrapper.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-15
-- Last update: 2023-09-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Wrapper on the FIFO for SP_RAM and the SP_RAM
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-15  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_fifo;
library lib_ram_intel;

use ieee.numeric_std.all;

entity fifo_sp_ram_wrapper is
  generic (
    G_DATA_WIDTH : integer := 8;        -- DATA Width
    G_ADDR_WIDTH : integer := 10
    );
  port (
    clk   : in std_logic;               -- Clock System
    rst_n : in std_logic;               -- Asynchronous Reset

    -- FIFO CTRL
    wr_en     : in  std_logic;          -- Write Enable
    rd_en     : in  std_logic;          -- Read Enable
    wdata     : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA to Write
    rdata     : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA From RAM
    rdata_val : out std_logic;          -- RDATA Valid

    -- FIFO Status
    fifo_empty : out std_logic;         -- Fifo Empty Flag
    fifo_full  : out std_logic);        -- Fifo Full Flag
end entity fifo_sp_ram_wrapper;

architecture rtl of fifo_sp_ram_wrapper is

  -- == INTERNAL Signals ==

  signal ram_data_in  : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RAM DATA In
  signal ram_we       : std_logic;      -- RAM Write Enable
  signal wr_addr      : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Write ADDR
  signal rd_addr      : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Read ADDR
  signal ram_data_out : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RAM DATA Out

begin  -- architecture rtl

  -- FIFO SP RAM Instanciation
  i_fifo_sp_ram_0 : entity lib_fifo.fifo_sp_ram
    generic map (
      G_DATA_WIDTH => G_DATA_WIDTH,
      G_ADDR_WIDTH => G_ADDR_WIDTH
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- FIFO CTRL
      wr_en     => wr_en,
      rd_en     => rd_en,
      wdata     => wdata,
      rdata     => rdata,
      rdata_val => rdata_val,

      -- RAM ITF
      wdata_out => ram_data_in,
      we        => ram_we,
      wr_addr   => wr_addr,
      rd_addr   => rd_addr,
      rdata_in  => ram_data_out,

      -- FIFO Status
      fifo_empty => fifo_empty,
      fifo_full  => fifo_full
      );

  -- Instanciation of the SP RAM
  i_sp_ram_0 : entity lib_ram_intel.sp_ram
    generic map (
      G_ADDR_WIDTH => G_ADDR_WIDTH,
      G_DATA_WIDTH => G_DATA_WIDTH
      )
    port map (
      clk      => clk,
      data_in  => ram_data_in,
      wr_addr  => wr_addr,
      rd_addr  => rd_addr,
      we       => ram_we,
      data_out => ram_data_out
      );

end architecture rtl;
