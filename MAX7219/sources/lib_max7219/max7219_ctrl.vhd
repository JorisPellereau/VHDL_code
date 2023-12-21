-------------------------------------------------------------------------------
-- Title      : MAX7219 Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_ctrl.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-12-07
-- Last update: 2023-12-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 Controller
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-12-07  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_max7219_interface;
library lib_max7219;
library lib_fifo_wrapper;

entity max7219_ctrl is

  generic (
    G_MATRIX_NB : integer range 1 to 8 := 4);  -- Number of Matrix

  port (
    clk_sys   : in std_logic;           -- Clock System
    rst_n_sys : in std_logic;           -- Asynchronous Reset

    -- Control Signals
    enable     : in std_logic;                                        -- Enable the MAX7219 Generation
    cmd_start  : in std_logic;                                        -- Command Start
    cmd        : in std_logic_vector(13 downto 0);                    -- Possible Commands
    cmd_data   : in std_logic_vector(7 downto 0);                     -- Data Command
    matrix_idx : in std_logic_vector(log2(G_MATRIX_NB) -1 downto 0);  -- Number of Matrix

    ctrl_done   : out std_logic;        -- Write access done
    ctrl_status : out std_logic;        -- Controller Status 0 : No Error - 1 : Error

    -- Status
    fifo_full  : out std_logic;         -- FIFO Full
    fifo_empty : out std_logic;         -- FIFO Empty Status

    -- MAX7219 I/F
    o_max7219_load : out std_logic;     -- LOAD command
    o_max7219_data : out std_logic;     -- DATA to send
    o_max7219_clk  : out std_logic      -- CLK
    );

end entity max7219_ctrl;

architecture rtl of max7219_ctrl is

  -- == INTERNAL Signals ==
  signal wr_en           : std_logic;                      -- FIFO Write Enable
  signal rd_en           : std_logic;                      -- Read Enable Signal to FIFO
  signal wdata           : std_logic_vector(16 downto 0);  -- Write Data to FIFO
  signal rdata           : std_logic_vector(16 downto 0);  -- Read Data From FIFO
  signal rdata_val       : std_logic;                      -- Read Data valid from FIFO
  signal fifo_full_int   : std_logic;                      -- FIFO FULL
  signal fifo_empty_int  : std_logic;                      -- FIFO Empty
  signal max7219_if_done : std_logic;                      -- MAX7219 Interface Done

begin  -- architecture rtl


  -- Instanciation of wr_fifo_mngt
  i_wr_fifo_mngt_0 : entity lib_max7219.wr_fifo_mngt
    generic map (
      G_MATRIX_NB => G_MATRIX_NB
      )
    port map(
      clk_sys    => clk_sys,
      rst_n_sys  => rst_n_sys,
      cmd_start  => cmd_start,
      cmd        => cmd,
      cmd_data   => cmd_data,
      matrix_idx => matrix_idx,
      wr_en      => wr_en,
      wdata      => wdata,
      fifo_full  => fifo_full_int,
      fifo_empty => fifo_empty_int,
      done       => ctrl_done,
      status     => ctrl_status
      );


  -- Instanciation of the FIFO Wrapper
  i_fifo_sp_ram_wrapper_0 : entity lib_fifo_wrapper.fifo_sp_ram_wrapper
    generic map (
      G_DATA_WIDTH => 17,
      G_ADDR_WIDTH => 10                -- 2^10
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

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


  -- Instanciation of the Start MAX7219 interface block
  i_start_max7219_if_0 : entity lib_max7219.start_max7219_if
    port map (
      clk_sys    => clk_sys,
      rst_n_sys  => rst_n_sys,
      fifo_empty => fifo_empty_int,
      enable     => enable,
      rd_en      => rd_en,
      done       => max7219_if_done
      );


  -- Instanciation of MAX7219 Interface
  i_max7219_if_0 : entity lib_max7219_interface.max7219_if
    generic map (
      G_MAX_HALF_PERIOD => 4,           -- 4 => 6.25MHz with 50MHz input
      G_LOAD_DURATION   => 4            -- LOAD DURATION in clk_in period
      )
    port map (
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Input commands
      i_start   => rdata_val,           -- Start from FIFO (Read Value)
      i_en_load => rdata(16),           -- The bit 16 is the en_load information
      i_data    => rdata(15 downto 0),  -- Read data from FIFO

      -- MAX7219 I/F
      o_max7219_load => o_max7219_load,
      o_max7219_data => o_max7219_data,
      o_max7219_clk  => o_max7219_clk,

      -- Transaction Done
      o_done => max7219_if_done
      );


  -- == OUTPUTS Affectation ==
  fifo_full  <= fifo_full_int;
  fifo_empty <= fifo_empty_int;

end architecture rtl;
