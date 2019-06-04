-------------------------------------------------------------------------------
-- Title      : ADC128s02 test
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_adc128s.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-29
-- Last update: 2019-06-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the test of the ADC128 module
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-29  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test2_adc128s is

end entity test2_adc128s;


architecture arch_test2_adc128s of test2_adc128s is

  -- CONSTANTS
  constant max_T        : time := 20 ns;    -- Clock Period duration
  constant C_T_adc_sclk : time := 0.32 us;  -- Fsclk = 3.125MHz T=0.32us

  -- Component
  component adc128s022_ctrl is
    port (
      clock       : in  std_logic;      -- Input system clock
      reset_n     : in  std_logic;      -- Active low asynchronous reset
      adc_sdat    : in  std_logic;      -- ADC serial data
      channel_sel : in  std_logic_vector(2 downto 0);  -- ADC channel selector   
      en          : in  std_logic;      -- Enable - Start conversion
      adc_cs_n    : out std_logic;      -- ADC Chip select
      adc_sclk    : out std_logic;      -- ADC Serial Clock
      adc_saddr   : out std_logic;      -- ADC d_in controller
      adc_data    : out std_logic_vector(11 downto 0);  -- ADC data
      adc_channel : out std_logic_vector(2 downto 0);  -- Current ADC channel
      data_valid  : out std_logic);     -- Data and Current channel available
  end component;



  -- ADC signals
  signal clock       : std_logic                    := '0';  -- Input system clock
  signal reset_n     : std_logic;       -- Active low asynchronous reset
  signal adc_sdat    : std_logic                    := '1';  -- ADC serial data
  signal channel_sel : std_logic_vector(2 downto 0) := (others => '0');  -- ADC channel selector
  signal conv_mode   : std_logic_vector(1 downto 0);  -- Conversion mode
  signal en          : std_logic;       -- Enable - Start conversion
  signal adc_cs_n    : std_logic;       -- ADC Chip select
  signal adc_sclk    : std_logic;       -- ADC Serial Clock
  signal adc_saddr   : std_logic;       -- ADC d_in controller
  signal adc_data    : std_logic_vector(11 downto 0);        -- ADC data
  signal adc_channel : std_logic_vector(2 downto 0);  -- Current ADC channel
  signal data_valid  : std_logic;       -- Data and Current channel available

begin

  -- purpose: This process generates the clock
  p_clock_gen : process
  begin
    clock <= not clock;
    wait for max_T/2;
  end process p_clock_gen;

  p_stimuli_test : process
  begin
    -- INITS inputs    
    conv_mode   <= (others => '0');
    en          <= '0';
    adc_sdat    <= '0';
    reset_n     <= '1';
    channel_sel <= (others => '0');

    wait for 10 ns;

    -- Gen reset
    reset_n <= '0';
    wait for 10 us;
    reset_n <= '1';

    channel_sel <= "101";

    wait for 10 us;

    report "Start a conversion";
    en <= '1';
    wait for 50*C_T_adc_sclk;
    en <= '0';

    channel_sel <= "110";

    wait for 10 us;

    report "Start a conversion";
    en <= '1';
    wait for 10*C_T_adc_sclk;
    en <= '0';

    report "end of test !!!!";
    wait;
  end process p_stimuli_test;







-- ADC inst
  adc128s_ctrl_inst : adc128s022_ctrl
    port map(clock       => clock,
             reset_n     => reset_n,
             adc_sdat    => adc_sdat,
             channel_sel => channel_sel,
             en          => en,
             adc_cs_n    => adc_cs_n,
             adc_sclk    => adc_sclk,
             adc_saddr   => adc_saddr,
             adc_data    => adc_data,
             adc_channel => adc_channel,
             data_valid  => data_valid);

end architecture arch_test2_adc128s;
