-------------------------------------------------------------------------------
-- Title      : Unitary test of the reg_controller module
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_reg_ctrl.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-08-23
-- Last update: 2019-08-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Unitary test
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-08-23  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_rs232;
use lib_rs232.pkg_rs232.all;

entity test_reg_ctrl is

end entity test_reg_ctrl;

architecture arch_test_reg_ctrl of test_reg_ctrl is


  -- Component
  component reg_ctrl is

    generic (
      data_size : integer range 5 to 9 := 8);  -- Size of the data

    port (
      reset_n : in std_logic;           -- Active Low Asynchronous Reset
      clock_i : in std_logic;           -- System clock

      -- Addr Reg to RW from the UART command
      rcvd_addr_reg_i : in  std_logic_vector(data_size - 1 downto 0);
      -- Write data for the Write command
      wdata_reg_i     : in  std_logic_vector(data_size - 1 downto 0);
      -- RW command
      rw_reg_i        : in  std_logic;
      -- Start the RW command
      start_rw_i      : in  std_logic;
      -- Data valid
      data_valid_o    : out std_logic;
      -- Reg addr present in the list
      reg_addr_ok_o   : out std_logic;
      -- Read data from the correct Addr reg
      rdata_reg_o     : out std_logic_vector(data_size - 1 downto 0));
  end component;

  -- CONSTANTS
  constant C_data_size : integer := 8;
  constant C_CLOCK_T   : time    := 20 ns;  -- Clock period

  -- REG_ctrl SIGNALS
  signal reset_n : std_logic := '1';
  signal clock   : std_logic := '0';

  signal rcvd_addr_reg_i : std_logic_vector(C_data_size - 1 downto 0);
  signal wdata_reg_i     : std_logic_vector(C_data_size - 1 downto 0);
  signal rw_reg_i        : std_logic;
  signal start_rw_i      : std_logic;
  signal data_valid_o    : std_logic;
  signal reg_addr_ok_o   : std_logic;
  signal rdata_reg_o     : std_logic_vector(data_size - 1 downto 0));

begin  -- architecture arch_test_reg_ctrl

  p_clk_gen : process is
  begin  -- process p_clk_gen
    clock <= not clock;
    wait for 10 ns;                     -- 50MHz 
  end process p_clk_gen;

  p_stimulis : process is
  begin  -- process p_stimulis

    -- INIT SIGNALS
    rcvd_addr_reg_i <= (others => '0');
    wdata_reg_i     <= (others => '0');
    rw_reg_i        <= '0';
    start_rw_i      <= '0';

    wait for 10*C_CLOCK_T;
    reset_n <= '0';
    wait for 10*C_CLOCK_T;
    reset_n <= '1';

    -- Write REG@0x00 : 0x11
    rcvd_addr_reg_i <= x"00";
    wdata_reg_i     <= x"11";
    rw_reg_i        <= '0';
    wait for 2*C_CLOCK_T;
    start_rw_i      <= '1', '0' after 3*C_CLOCK_T;
    wait until rising_edge(data_valid_o) for 100 us;

    -- Read REG@0x00
    rcvd_addr_reg_i <= x"00";
    wdata_reg_i     <= x"00";
    rw_reg_i        <= '1';
    wait for 2*C_CLOCK_T;
    start_rw_i      <= '1', '0' after 3*C_CLOCK_T;
    wait until rising_edge(data_valid_o) for 100 us;

    if(rdata_reg_o = x"11") then
      report "Data read : 0x11 => OK !!!";
    else
      report "Erreur RDATA_REG !";
    end if;

    report "end of test !!!";
    wait;
  end process p_stimulis;

  -- REG STRL inst
  reg_ctrl_inst : reg_ctrl
    generic map(
      data_size => C_data_size)
    port map (
      reset_n         => reset_n,
      clock_i         => clock_i,
      rcvd_addr_reg_i => rcvd_addr_reg_i,
      wdata_reg_i     => wdata_reg_i,
      rw_reg_i        => rw_reg_i,
      start_rw_i      => start_rw_i,
      data_valid_o    => data_valid_o,
      reg_addr_ok_o   => reg_addr_ok_o,
      rdata_reg_o     => rdata_reg_o);


end architecture arch_test_reg_ctrl;
