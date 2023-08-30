-------------------------------------------------------------------------------
-- Title      : Top for JTAG debug
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_jtag.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2023-08-29
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-08-29  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity top_jtag is

  port (
    clock : in  std_logic;                    -- Clock
    rst_n : in  std_logic;                    -- Asynchronous Reset
    leds  : out std_logic_vector(7 downto 0)  -- LEDS
    );

end entity top_jtag;

architecture rtl of top_jtag is

  -- == COMPONENTS ==
  component my_vji is
    port (
      tdi                : out std_logic;  -- tdi
      tdo                : in  std_logic                    := 'X';  -- tdo
      ir_in              : out std_logic_vector(5 downto 0);         -- ir_in
      ir_out             : in  std_logic_vector(5 downto 0) := (others => 'X');  -- ir_out
      virtual_state_cdr  : out std_logic;  -- virtual_state_cdr
      virtual_state_sdr  : out std_logic;  -- virtual_state_sdr
      virtual_state_e1dr : out std_logic;  -- virtual_state_e1dr
      virtual_state_pdr  : out std_logic;  -- virtual_state_pdr
      virtual_state_e2dr : out std_logic;  -- virtual_state_e2dr
      virtual_state_udr  : out std_logic;  -- virtual_state_udr
      virtual_state_cir  : out std_logic;  -- virtual_state_cir
      virtual_state_uir  : out std_logic;  -- virtual_state_uir
      tck                : out std_logic   -- clk
      );
  end component my_vji;

  -- == INTERNAL Signals ==
  --Signals and registers declared for VJI instance
  signal tck   : std_logic;
  signal tdi   : std_logic;
  signal tdo   : std_logic;
  signal cdr   : std_logic;
  signal e1dr  : std_logic;
  signal e2dr  : std_logic;
  signal pdr   : std_logic;
  signal sdr   : std_logic;
  signal udr   : std_logic;
  signal uir   : std_logic;
  signal cir   : std_logic;
  signal ir_in : std_logic_vector(5 downto 0);

  signal rst_n_synch : std_logic;

begin  -- architecture rtl


  -- Instanciation of Reset generation
  i_reset_egn_0 : entity work.reset_gen

    port map (
      clk     => clock,
      arst_n  => rst_n,
      o_rst_n => rst_n_synch
      );


  --Instantiation of VJI
  i_vji_inst : my_vji
    port map(
      tdo                => tdo,
      tck                => tck,
      tdi                => tdi,
      --tms => ,
      ir_in              => ir_in,
      ir_out             => (others => '0'),
      virtual_state_cdr  => cdr,
      virtual_state_e1dr => e1dr,
      virtual_state_e2dr => e2dr,
      virtual_state_pdr  => pdr,
      virtual_state_sdr  => sdr,
      virtual_state_udr  => udr,
      virtual_state_uir  => uir,
      virtual_state_cir  => cir
      );


  -- Instanciation of Virtual JTAG Interface
  i_vjtag_intf_0 : entity work.vjtag_intf

    generic map(
      G_DATA_WIDTH => 32,
      G_ADDR_WIDTH => 32,
      G_IR_WIDTH   => 6)
    port map(
      clk_jtag   => tck,
      rst_n_jtag => rst_n_synch,

      tdi   => tdi,
      tdo   => tdo,
      ir_in => ir_in,
      sdr   => sdr,
      udr   => udr,

      addr        => open,
      data_out    => open,
      data_in     => x"DEADD0D0",
      data_in_val => '0',
      rnw         => open,
      start       => open
      );


  leds(5 downto 0) <= ir_in;
  leds(7) <= '1';
  leds(6) <= '1';
end architecture rtl;
