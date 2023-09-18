-------------------------------------------------------------------------------
-- Title      : Update Display Management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_update_display.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-24
-- Last update: 2023-09-17
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Update display management block. Update one character or the
-- entire display
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-12-24  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_fifo_wrapper;

entity lcd_cfah_update_display is
  generic (
    G_DATA_WIDTH : integer := 8;        -- DATA Width
    G_ADDR_WIDTH : integer := 10
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Commands
    i_update_all_lcd  : in std_logic;   -- Update the entire LCD Command
    i_update_one_char : in std_logic;   -- One char update
    i_char_position   : in std_logic_vector(4 downto 0);  -- Character position selection [0:31]

    -- LCD Commands
    o_set_ddram_addr     : out std_logic;  -- SET DDRAM ADDR Command
    o_wr_data            : out std_logic;  -- Write data to RAM command
    o_ddram_data_or_addr : out std_logic_vector(7 downto 0);  -- Data or Addr bus
    o_start              : out std_logic;  -- Start command

    -- Command Done
    i_poll_done : in std_logic;         -- Command done from polling block

    -- FIFO CTRL 
    wr_en : in std_logic;                                    -- Write Enable
    wdata : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA to Write

    -- LCD Update done flag
    o_update_done : out std_logic;      -- LCD Update Done

    -- FIFO Status
    fifo_empty : out std_logic;         -- Fifo Empty Flag
    fifo_full  : out std_logic          -- Fifo Full Flag
    );

end entity lcd_cfah_update_display;

architecture rtl of lcd_cfah_update_display is

  -- == INTERNAL Signals ==
  signal fifo_full_int  : std_logic;    -- FIFO FULL FLAG
  signal fifo_empty_int : std_logic;    -- FIFO EMPTY FLAG
  signal rd_en          : std_logic;    -- Read Enable
  signal rdata          : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Read Data from RAM
  signal rdata_val      : std_logic;    -- Valid signal of rdata

begin  -- architecture rtl

  -- Instanciation of the FSM
  i_lcd_cfah_update_display_fsm_0 : lcd_cfah_update_display_fsm
    generic map (
      G_DATA_WIDTH => G_DATA_WIDTH,
      G_ADDR_WIDTH => G_ADDR_WIDTH
      )
    port map(
      clk   => clk,
      rst_n => rst_n,

      -- Commands
      i_update_all_lcd  => i_update_all_lcd,
      i_update_one_char => i_update_one_char,
      i_char_position   => i_char_position,

      -- LCD Commands
      o_set_ddram_addr     => o_set_ddram_addr,
      o_wr_data            => o_wr_data,
      o_ddram_data_or_addr => o_ddram_data_or_addr,
      o_start              => o_start,

      -- Polling block ready
      i_poll_done => i_poll_done,

      -- Update Done flag
      o_update_done => o_update_done,

      -- FIFO CTRL 
      rd_en     => rd_en,
      rdata     => rdata,
      rdata_val => rdata_val
      );

  -- Instanciation of the FIFO WRAPPER SP_RAM
  i_fifo_sp_ram_wrapper_0 : entity lib_fifo_wrapper.fifo_sp_ram_wrapper
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

      -- FIFO Status
      fifo_empty => fifo_empty_int,
      fifo_full  => fifo_full_int
      );

  -- == OUTPUTS Affectation ==
  fifo_full  <= fifo_full_int;
  fifo_empty <= fifo_empty_int;

end architecture rtl;
