-------------------------------------------------------------------------------
-- Title      : TX UART in the RAM management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tx_msg_ram_if.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-02-23
-- Last update: 2020-02-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: this block mamanges the message stored in the TX RAM
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-02-23  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tx_msg_ram_if is

  generic (
    G_ADDR_WIDTH : integer := 8;        -- ADDR WIDTH
    G_DATA_WIDTH : integer := 8);       -- DATA WIDTH

  port (
    clk            : in  std_logic;     -- Clock
    rst_n          : in  std_logic;     -- Asynchronous reset
    o_me           : out std_logic;     -- Memory Enable
    o_we           : out std_logic;     -- W/R command
    o_addr         : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR
    o_wdata        : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA
    i_rdata        : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RDATA
    i_busy         : in  std_logic;     -- TX Transaction ongoing
    o_en_transfert : out std_logic;     -- Start the transfert
    i_init_ram     : in  std_logic);    -- Init the RAM

end entity tx_msg_ram_if;

architecture behv of tx_msg_ram_if is

  -- INTERNAL SIGNALS
  signal s_init_ram        : std_logic;  -- Latch i_init_ram
  signal s_init_ram_r_edge : std_logic;  -- R EDGE of i_init_ram

  signal s_run_init_ram : std_logic;    -- INIT RAM

  signal s_me    : std_logic;           -- memory enable
  signal s_we    : std_logic;           -- W/R command
  signal s_addr  : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);
  signal s_wdata : std_logic_vector(G_DATA_WIDTH - 1 downto 0);

  signal s_en_transfert : std_logic;    -- Enable the transfert

  --signal s_addr_ptr : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR ptr

begin  -- architecture behv

  -- purpose: Latch inputs
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_init_ram <= '0';

    elsif clk'event and clk = '1' then  -- rising clock edge
      s_init_ram <= i_init_ram;
    end if;
  end process p_latch_inputs;

  -- R EDGE detection
  s_init_ram_r_edge <= i_init_ram and not s_init_ram;


  -- purpose: Write to the RAM
  p_ram_access : process (clk, rst_n) is
  begin  -- process p_ram_access
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_me           <= '0';
      s_we           <= '0';
      s_wdata        <= (others => '0');
      s_addr         <= (others => '0');
      s_run_init_ram <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge


      if(s_init_ram_r_edge = '1') then
        s_run_init_ram <= '1';
        s_me           <= '1';
        s_we           <= '1';
        s_wdata        <= (others => '0');
      end if;

      if(s_run_init_ram = '1')then

        if(unsigned(s_addr) < 2**G_ADDR_WIDTH - 1) then
          s_addr <= unsigned(s_addr) + 1;  -- INC ADDR
        else
          s_run_init_ram <= '0';
          s_me           <= '0';
          s_we           <= '0';
          s_addr         <= (others => '0');
        end if;
      end if;
    end if;
  end process p_ram_access;

  -- Start the transfert
  p_en_en_transfert_mngt : process (clk, rst_n) is
  begin  -- process p_en_en_transfert_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en_transfert <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

    end if;
  end process p_en_en_transfert_mngt;

  -- OUTPUTS AFFECTATIONS
  o_me           <= s_me;
  o_we           <= s_we;
  o_wdata        <= s_wdata;
  o_addr         <= s_addr;
  o_en_transfert <= s_en_transfert;

end architecture behv;
