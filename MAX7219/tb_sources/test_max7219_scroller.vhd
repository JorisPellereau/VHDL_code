-------------------------------------------------------------------------------
-- Title      : TB Test MAX7219 SCROLLER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_type.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-04-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-18  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity test_max7219_scroller is

end entity test_max7219_scroller;

architecture behv of test_max7219_scroller is

  -- TDPRAM single CLOCK
  component tdpram_sclk is

    generic (
      G_ADDR_WIDTH : integer := 8;      -- ADDR WIDTH
      G_DATA_WIDTH : integer := 8);     -- DATA WIDTH

    port (
      clk       : in  std_logic;        -- Clock
      i_me_a    : in  std_logic;        -- Memory Enable port A
      i_we_a    : in  std_logic;        -- Memory Write/Read access port A
      i_addr_a  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port A
      i_wdata_a : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port A
      o_rdata_a : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RDATA port A

      i_me_b    : in  std_logic;        -- Memory Enable port B
      i_we_b    : in  std_logic;        -- Memory Write/Read access port B
      i_addr_b  : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR port B
      i_wdata_b : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA port B
      o_rdata_b : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)  -- RDATA port B
      );

  end component tdpram_sclk;


  component max7219_matrix_emul is
    generic (
      G_MATRIX_NB : integer                      := 2;
      G_VERBOSE   : std_logic_vector(7 downto 0) := x"FF");
    port (
      clk            : in std_logic;
      rst_n          : in std_logic;
      i_max7219_clk  : in std_logic;
      i_max7219_din  : in std_logic;
      i_max7219_load : in std_logic);

  end component max7219_matrix_emul;


  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;  -- HALF PERIOD of clk

  constant C_RAM_ADDR_WIDTH : integer := 8;
  constant C_RAM_DATA_WIDTH : integer := 16;

  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous reset

  -- INTERNAL SIGNALS
  signal s_me_a    : std_logic;
  signal s_me_b    : std_logic;
  signal s_we_a    : std_logic;
  signal s_we_b    : std_logic;
  signal s_addr_a  : std_logic_vector(C_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_addr_b  : std_logic_vector(C_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_wdata_a : std_logic_vector(C_RAM_DATA_WIDTH - 1 downto 0);
  signal s_wdata_b : std_logic_vector(C_RAM_DATA_WIDTH - 1 downto 0);
  signal s_rdata_a : std_logic_vector(C_RAM_DATA_WIDTH - 1 downto 0);
  signal s_rdata_b : std_logic_vector(C_RAM_DATA_WIDTH - 1 downto 0);


  signal s_start        : std_logic;
  signal s_en_load      : std_logic;
  signal s_data         : std_logic_vector(15 downto 0);
  signal s_done         : std_logic;
  signal s_start_scroll : std_logic;

  signal s_max7219_load : std_logic;
  signal s_max7219_data : std_logic;
  signal s_max7219_clk  : std_logic;

begin  -- architecture behv

  -- purpose: this process generate the input clock
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clk <= not clk;
    wait for C_CLK_HALF_PERIOD;
  end process p_clk_gen;

                                        -- STIMULIS
  p_stimulis : process is
  begin  -- process p_stimuli

    -- SIGNALS INIT
    s_me_a         <= '0';
    s_we_a         <= '0';
    s_addr_a       <= (others => '0');
    s_wdata_a      <= (others => '0');
    s_start_scroll <= '0';

    wait for 10*C_CLK_HALF_PERIOD;
    rst_n <= '0';
    wait for 10*C_CLK_HALF_PERIOD;
    rst_n <= '1';

    wait for 10*C_CLK_HALF_PERIOD;

    -- INIT RAM
    s_wdata_a <= x"0001";
    s_addr_a  <= (others => '0');
    s_we_a    <= '1';
    wait until falling_edge(clk);
    s_me_a    <= '1';
    wait until falling_edge(clk);
    s_me_a    <= '0';


    s_wdata_a <= x"007E";
    s_addr_a  <= x"01";
    wait until falling_edge(clk);
    s_me_a    <= '1';
    wait until falling_edge(clk);
    s_me_a    <= '0';


    wait for 10*C_CLK_HALF_PERIOD;

    wait until falling_edge(clk);
    s_start_scroll <= '1';
    wait until falling_edge(clk);
    s_start_scroll <= '0';

    wait for 200 us;

    assert false report "end of simulation" severity failure;

  end process p_stimulis;






  -- INST
  max7219_scroller_inst_0 : max7219_scroller
    generic map(
      G_RAM_ADDR_WIDTH => C_RAM_ADDR_WIDTH,
      G_RAM_DATA_WIDTH => C_RAM_DATA_WIDTH,
      G_DIGITS_NB      => 8)
    port map (
      clk   => clk,
      rst_n => rst_n,

                                        -- COMMANDS
      i_start_scroll => s_start_scroll,

                                        -- MEMORY I/F
      o_me    => s_me_b,
      o_we    => s_we_b,
      o_addr  => s_addr_b,
      i_rdata => s_rdata_b,

                                        -- MAX7219 I/F
      o_start   => s_start,
      o_en_load => s_en_load,
      o_data    => s_data,
      i_done    => s_done);

                                        -- TDPRAM INST
  tdpram_inst_0 : tdpram_sclk
    generic map (
      G_ADDR_WIDTH => C_RAM_ADDR_WIDTH,
      G_DATA_WIDTH => C_RAM_DATA_WIDTH
      )
    port map(
      clk       => clk,
      i_me_a    => s_me_a,
      i_we_a    => s_we_a,
      i_addr_a  => s_addr_a,
      i_wdata_a => s_wdata_a,
      o_rdata_a => s_rdata_a,

      i_me_b    => s_me_b,
      i_we_b    => s_we_b,
      i_addr_b  => s_addr_b,
      i_wdata_b => s_wdata_b,
      o_rdata_b => s_rdata_b
      );


                                        -- MAX7219 I/F
  max7219_if_inst_0 : max7219_if
    generic map (
      G_MAX_HALF_PERIOD => 50,
      G_LOAD_DURATION   => 4
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

                                        -- Input commands
      i_start   => s_start,
      i_en_load => s_en_load,
      i_data    => s_data,

                                        -- MAX7219 I/F
      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk,

                                        -- Transaction Done
      o_done => s_done);


                                        -- MAX7219 MATRIX DISPLAY EMUL
  max7219_matrix_emul_inst : max7219_matrix_emul
    generic map (
      G_MATRIX_NB => 8,
      G_VERBOSE   => x"FF")
    port map (
      clk            => clk,
      rst_n          => rst_n,
      i_max7219_clk  => s_max7219_clk,
      i_max7219_din  => s_max7219_data,
      i_max7219_load => s_max7219_load);


end architecture behv;
