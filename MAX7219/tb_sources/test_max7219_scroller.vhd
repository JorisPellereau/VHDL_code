-------------------------------------------------------------------------------
-- Title      : TB Test MAX7219 SCROLLER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_type.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-09-20
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

  -- TYPE
  type t_message_array is array (0 to 100) of std_logic_vector(7 downto 0);



  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;  -- HALF PERIOD of clk

  constant C_RAM_ADDR_WIDTH : integer := 8;
  constant C_RAM_DATA_WIDTH : integer := 16;

  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous reset

  signal s_message_array : t_message_array;  -- MEssage array

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

  signal s_ram_start_ptr : std_logic_vector(C_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_msg_length    : std_logic_vector(C_RAM_DATA_WIDTH - 1 downto 0);

  signal s_max_tempo_cnt : std_logic_vector(31 downto 0);
  signal s_busy          : std_logic;

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

    variable v_i : integer := 0;
  begin  -- process p_stimuli

    -- SIGNALS INIT
    s_me_a          <= '0';
    s_we_a          <= '0';
    s_addr_a        <= (others => '0');
    s_wdata_a       <= (others => '0');
    s_start_scroll  <= '0';
    s_ram_start_ptr <= (others => '0');
    s_msg_length    <= (others => '0');

    s_max_tempo_cnt <= x"000000FF";

    -- s_message_array <= (others => (others => '1'));
    s_message_array    <= (others => (others => '0'));
    s_message_array(0) <= x"C0";
    s_message_array(1) <= x"C2";
    s_message_array(2) <= x"C1";
    s_message_array(3) <= x"FF";
    s_message_array(4) <= x"FE";
    s_message_array(5) <= x"C0";
    s_message_array(6) <= x"C0";
    s_message_array(7) <= x"C0";


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


    --
    s_msg_length    <= x"02";
    s_ram_start_ptr <= (others => '0');
    wait until falling_edge(clk);
    s_start_scroll  <= '1';
    wait until falling_edge(clk);
    s_start_scroll  <= '0';

    wait for 1 ms;

    assert false report "end of simulation" severity failure;
    wait;

  end process p_stimulis;


  -- INST
  max7219_scroller_ctrl_inst_0 : max7219_scroller_ctrl
    generic map (
      G_MATRIX_NB      => 8,
      G_RAM_ADDR_WIDTH => C_RAM_DATA_WIDTH,
      G_RAM_DATA_WIDTH => C_RAM_DATA_WIDTH)
    port map(
      clk   => clk,
      rst_n => rst_n,

      -- RAM I/F
      i_me    => s_me_a,
      i_we    => s_we_a,
      i_addr  => s_addr_a,
      i_wdata => s_wdata_a,
      o_rdata => s_rdata_a,

      -- RAM Commands
      i_ram_start_ptr => s_ram_start_ptr,
      i_msg_length    => s_msg_length,
      i_start_scroll  => s_start_scroll,

      -- MAX7219 I/F
      i_max7219_if_done    => s_done,
      o_max7219_if_start   => s_start,
      o_max7219_if_en_load => s_en_load,
      o_max7219_if_data    => s_data,

      o_busy => s_busy);                -- Scroller Controller Busy


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
      i_start        => s_start,
      i_en_load      => s_en_load,
      i_data         => s_data,
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
      G_VERBOSE   => x"00")
    port map (
      clk            => clk,
      rst_n          => rst_n,
      i_max7219_clk  => s_max7219_clk,
      i_max7219_din  => s_max7219_data,
      i_max7219_load => s_max7219_load);


end architecture behv;
