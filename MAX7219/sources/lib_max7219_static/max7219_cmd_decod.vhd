-------------------------------------------------------------------------------
-- Title      : COMMAND Decoder for MAX7219 Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_cmd_decod.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-13
-- Last update: 2022-01-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Cammdn Decoder for MAX7219 I/F
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-13  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219_static;
use lib_max7219_static.pkg_max7219_static.all;

entity max7219_cmd_decod is

  generic (
    G_RAM_ADDR_WIDTH    : integer                       := 8;  -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH    : integer                       := 16;  -- RAM DATA WIDTH
    G_DECOD_MAX_CNT_32B : std_logic_vector(31 downto 0) := x"02FAF080");
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous reset
    i_en  : in std_logic;               -- Enable the Function

    -- RAM I/F
    i_me    : in  std_logic;            -- Memory Enable
    i_we    : in  std_logic;            -- W/R command
    i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
    o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

    -- RAM INFO.
    i_start_ptr    : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- ST PTR
    i_last_ptr     : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR
    i_ptr_val      : in  std_logic;     -- PTRS VALIDS
    i_loop         : in  std_logic;     -- LOOP CONFIG.
    o_ptr_equality : out std_logic;     -- ADDR = LAST PTR
    o_discard      : out std_logic;     -- Start of pattern discard

    -- MAX7219 I/F
    i_max7219_if_done    : in  std_logic;  -- MAX7219 IF Done
    o_max7219_if_start   : out std_logic;
    o_max7219_if_en_load : out std_logic;
    o_max7219_if_data    : out std_logic_vector(15 downto 0));

end entity max7219_cmd_decod;

architecture behv of max7219_cmd_decod is

  -- COMPONENT

  -- TDPRAM single CLOCK
  -- component tdpram_sclk is

  --   generic (
  --     G_ADDR_WIDTH : integer := 8;      -- ADDR WIDTH
  --     G_DATA_WIDTH : integer := 8);     -- DATA WIDTH

  --   port (
  --     clk       : in  std_logic;        -- Clock
  --     i_me_a    : in  std_logic;        -- Memory Enable port A
  --     i_we_a    : in  std_logic;        -- Memory Write/Read access port A
  --     i_addr_a  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port A
  --     i_wdata_a : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port A
  --     o_rdata_a : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RDATA port A

  --     i_me_b    : in  std_logic;        -- Memory Enable port B
  --     i_we_b    : in  std_logic;        -- Memory Write/Read access port B
  --     i_addr_b  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port B
  --     i_wdata_b : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port B
  --     o_rdata_b : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)  -- RDATA port B
  --     );

  -- end component tdpram_sclk;

  -- INTERNAL SIGNALS
  signal s_me_decod    : std_logic;
  signal s_we_decod    : std_logic;
  signal s_addr_decod  : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_wdata_decod : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
  signal s_rdata_decod : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);

begin  -- architecture behv

  s_wdata_decod <= (others => '0');

  -- TDPRAM INST
  tdpram_inst_0 : tdpram_sclk
    generic map (
      G_ADDR_WIDTH => G_RAM_ADDR_WIDTH,
      G_DATA_WIDTH => G_RAM_DATA_WIDTH
      )
    port map(
      clk       => clk,
      i_me_a    => i_me,
      i_we_a    => i_we,
      i_addr_a  => i_addr,
      i_wdata_a => i_wdata,
      o_rdata_a => o_rdata,

      i_me_b    => s_me_decod,
      i_we_b    => s_we_decod,
      i_addr_b  => s_addr_decod,
      i_wdata_b => s_wdata_decod,
      o_rdata_b => s_rdata_decod
      );

  -- MAX7219 RAM DECOD INST
  max7219_ram_decod_inst_0 : max7219_ram_decod
    generic map (
      G_RAM_ADDR_WIDTH => G_RAM_ADDR_WIDTH,
      G_RAM_DATA_WIDTH => G_RAM_DATA_WIDTH,
      G_MAX_CNT_32B    => G_DECOD_MAX_CNT_32B
      )
    port map (
      clk     => clk,
      rst_n   => rst_n,
      i_en    => i_en,
      o_me    => s_me_decod,
      o_we    => s_we_decod,
      o_addr  => s_addr_decod,
      i_rdata => s_rdata_decod,


      i_start_ptr    => i_start_ptr,
      i_last_ptr     => i_last_ptr,
      i_ptr_val      => i_ptr_val,
      i_loop         => i_loop,
      o_ptr_equality => o_ptr_equality,
      o_discard      => o_discard,

      o_start   => o_max7219_if_start,
      o_en_load => o_max7219_if_en_load,
      o_data    => o_max7219_if_data,
      i_done    => i_max7219_if_done);


end architecture behv;
