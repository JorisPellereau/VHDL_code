-------------------------------------------------------------------------------
-- Title      : Package of lib_max7219_static blocks
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_max7219_static.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-09-26
-- Last update: 2020-09-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Package of lib_max7219_static blocks
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

package pkg_max7219_static is

  -- MAX7219 RAM DECOD
  -- RAM DECOD for MAX7219 inputs commands
  component max7219_ram_decod is
    generic (
      G_RAM_ADDR_WIDTH : integer                       := 8;  -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH : integer                       := 16;  -- RAM DATA WIDTH
      G_MAX_CNT_32B    : std_logic_vector(31 downto 0) := x"02FAF080");  -- MAX CNT
    port (
      --# {{clocks|Clock and Reset}}
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous reset

      --# {{Enable}}
      i_en : in std_logic;              -- Enable the function

      --# {{RAM I/F}}
      o_me    : out std_logic;          -- MEMORY ENABLE
      o_we    : out std_logic;          -- W/R COMMAND
      o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
      i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

      --# {{Control signals}}
      i_start_ptr    : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- ST ADDR
      i_last_ptr     : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR
      i_ptr_val      : in  std_logic;   -- PTRS VALIDS
      i_loop         : in  std_logic;   -- LOOP CONFIG.
      o_ptr_equality : out std_logic;   -- ADDR = LAST PTR

      --# {{MAX7219_if I/F}}
      o_start   : out std_logic;                      -- MAX7219 START
      o_en_load : out std_logic;                      -- MAX7219 EN LOAD
      o_data    : out std_logic_vector(15 downto 0);  -- MAX7219 DATA
      i_done    : in  std_logic);                     -- MAX7219 DONE
  end component;


  -- MAX7219 COMMAND DECOD
  -- TOP Block for decoding command for MAX7219 I/F
component max7219_cmd_decod is
  generic (
    G_RAM_ADDR_WIDTH    : integer                       := 8;  -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH    : integer                       := 16;  -- RAM DATA WIDTH
    G_DECOD_MAX_CNT_32B : std_logic_vector(31 downto 0) := x"02FAF080");
  port (
    --# {{clocks|Clock and Reset}}    
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous reset

    --# {{Enable}}
    i_en  : in std_logic;               -- Enable the Function

    --# {{RAM I/F}}
    i_me    : in  std_logic;            -- Memory Enable
    i_we    : in  std_logic;            -- W/R command
    i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
    o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

    --# {{Control Signals}}
    i_start_ptr    : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- ST PTR
    i_last_ptr     : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR
    i_ptr_val      : in  std_logic;     -- PTRS VALIDS
    i_loop         : in  std_logic;     -- LOOP CONFIG.
    o_ptr_equality : out std_logic;     -- ADDR = LAST PTR

    --# {{MAX7219_if I/F}}
    i_max7219_if_done    : in  std_logic;  -- MAX7219 IF Done
    o_max7219_if_start   : out std_logic;
    o_max7219_if_en_load : out std_logic;
    o_max7219_if_data    : out std_logic_vector(15 downto 0));
end component;




end package pkg_max7219_static;
