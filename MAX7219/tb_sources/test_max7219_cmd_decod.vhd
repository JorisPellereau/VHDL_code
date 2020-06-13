-------------------------------------------------------------------------------
-- Title      : TEST for MAX7219_CMD_DECO
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_max7219_cmd_decod.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-13
-- Last update: 2020-06-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-13  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity test_max7219_cmd_decod is

end entity test_max7219_cmd_decod;

architecture behv of test_max7219_cmd_decod is

  -- COMPONENTS
  component max7219_emul is
    generic(
          G_MATRIX_I : integer := 0);
    port (
      clk            : in  std_logic;
      rst_n          : in  std_logic;
      i_max7219_clk  : in  std_logic;
      i_max7219_din  : in  std_logic;
      i_max7219_load : in  std_logic;
      o_max7219_dout : out std_logic);

  end component max7219_emul;



  -- INTERNAL SIGNALS
  signal clk   : std_logic := '0';
  signal rst_n : std_logic := '1';

  signal s_max7219_load : std_logic;
  signal s_max7219_clk  : std_logic;
  signal s_max7219_data : std_logic;

  signal s_me    : std_logic;
  signal s_we    : std_logic;
  signal s_addr  : std_logic_vector(7 downto 0);
  signal s_wdata : std_logic_vector(15 downto 0);
  signal s_rdata : std_logic_vector(15 downto 0);
  signal s_en    : std_logic;

  signal s_start_ptr    : std_logic_vector(7 downto 0);
  signal s_last_ptr     : std_logic_vector(7 downto 0);
  signal s_ptr_val      : std_logic;
  signal s_loop         : std_logic;
  signal s_ptr_equality : std_logic;

  signal s_max7219_dout : std_logic;

begin  -- architecture behv

  -- purpose: this process generate the input clock
  -- 50MHz : 20 ns
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clk <= not clk;
    wait for 10 ns;
  end process p_clk_gen;


  p_stimulis : process is
  begin  -- process p_stimulis
    s_en        <= '0';
    s_me        <= '0';
    s_we        <= '0';
    s_addr      <= (others => '0');
    s_wdata     <= (others => '0');
    s_start_ptr <= (others => '0');
    s_last_ptr  <= (others => '0');
    s_ptr_val   <= '0';
    s_loop      <= '0';

    wait for 1 us;
    rst_n <= '0';
    wait for 1 us;
    rst_n <= '1';

    wait for 10 us;
    -- INIT RAM
    -- SET DECODE MODE to 0x00
    s_addr  <= x"00";
    s_wdata <= x"1900";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET INTENSITY to 0x00
    s_addr  <= x"01";
    s_wdata <= x"1A00";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET SCAN LIMIT to 0x07 : display all digits
    s_addr  <= x"02";
    s_wdata <= x"1B07";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET SHUTDOWN to 0x01 : Normal Mode
    s_addr  <= x"03";
    s_wdata <= x"1C01";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';


    -- == DISPLAY 1 symbol ==
    -- SET DIGIT_0 to 0x00
    s_addr  <= x"04";
    s_wdata <= x"1100";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET DIGIT_1 to 0x01
    s_addr  <= x"05";
    s_wdata <= x"1201";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET DIGIT_2 to 0x7F
    s_addr  <= x"06";
    s_wdata <= x"137F";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET DIGIT_3 to 0x21
    s_addr  <= x"07";
    s_wdata <= x"1421";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET DIGIT_4 to 0x00
    s_addr  <= x"08";
    s_wdata <= x"1500";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET DIGIT_5 to 0x00
    s_addr  <= x"09";
    s_wdata <= x"1600";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET DIGIT_6 to 0x00
    s_addr  <= x"0A";
    s_wdata <= x"1700";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';

    -- SET DIGIT_7 to 0x00
    s_addr  <= x"0B";
    s_wdata <= x"1800";
    wait until falling_edge(clk);
    s_me    <= '1';
    s_we    <= '1';
    wait until falling_edge(clk);
    s_me    <= '0';
    s_we    <= '0';
    
    
    s_start_ptr <= x"00";
    s_last_ptr  <= x"0C";
    wait until falling_edge(clk);
    s_ptr_val   <= '1';
    s_en        <= '1';
    wait until falling_edge(clk);
    s_ptr_val   <= '0';


    wait for 100 us;





    wait;

    -- Old test
    for i in 0 to 255 loop

      s_addr      <= std_logic_vector(to_unsigned(i, s_addr'length));
      s_wdata     <= std_logic_vector(to_unsigned(i, s_wdata'length));
      s_wdata(12) <= '1';
      wait until falling_edge(clk);
      s_me        <= '1';
      s_we        <= '1';
      wait until falling_edge(clk);
      s_me        <= '0';
      s_we        <= '0';
    end loop;  -- i

    wait for 10 us;

    s_start_ptr <= x"00";
    s_last_ptr  <= x"05";
    wait until falling_edge(clk);
    s_ptr_val   <= '1';
    s_en        <= '1';
    wait until falling_edge(clk);
    s_ptr_val   <= '0';


    wait until s_ptr_equality = '1';
    wait for 100 us;

    s_start_ptr <= x"0A";
    s_last_ptr  <= x"0F";
    wait until falling_edge(clk);
    s_ptr_val   <= '1';
    s_en        <= '1';
    wait until falling_edge(clk);
    s_ptr_val   <= '0';

    wait until s_ptr_equality = '1';
    wait for 100 us;

    s_start_ptr <= x"F0";
    s_last_ptr  <= x"02";
    wait until falling_edge(clk);
    s_ptr_val   <= '1';
    s_en        <= '1';
    wait until falling_edge(clk);
    s_ptr_val   <= '0';


    wait until s_ptr_equality = '1';
    wait for 100 us;

    s_start_ptr <= x"03";
    s_last_ptr  <= x"06";
    wait until falling_edge(clk);
    s_ptr_val   <= '1';
    s_en        <= '0';
    wait until falling_edge(clk);
    s_ptr_val   <= '0';

    wait for 200 us;
    s_en <= '1';

    wait until s_ptr_equality = '1';
    wait for 100 us;

    s_start_ptr <= x"20";
    s_last_ptr  <= x"25";
    wait until falling_edge(clk);
    s_ptr_val   <= '1';
    s_en        <= '1';
    s_loop      <= '1';
    wait until falling_edge(clk);
    s_ptr_val   <= '0';


    wait for 400 us;
    s_loop <= '0';

    wait for 200 us;
    report "end of simu !!";
    wait;
  end process p_stimulis;


  -- MAX7219 CMD DECOD INST
  max7219_cmd_decod_inst : max7219_cmd_decod
    generic map (
      G_RAM_ADDR_WIDTH             => 8,  -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH             => 16,  -- RAM DATA WIDTH
      G_MAX7219_IF_MAX_HALF_PERIOD => 50,  -- MAX HALF PERIOD for MAX729 CLK generation
      G_MAX7219_LOAD_DUR           => 4)  -- MAX7219 LOAD duration in period of clk

    port map (
      clk   => clk,
      rst_n => rst_n,
      i_en  => s_en,

      -- RAM I/F
      i_me    => s_me,
      i_we    => s_we,
      i_addr  => s_addr,
      i_wdata => s_wdata,
      o_rdata => s_rdata,

      -- RAM INFO.
      i_start_ptr    => s_start_ptr,
      i_last_ptr     => s_last_ptr,
      i_ptr_val      => s_ptr_val,
      i_loop         => s_loop,
      o_ptr_equality => s_ptr_equality,

      -- MAX7219 I/F
      o_max7219_load => s_max7219_load,
      o_max7219_data => s_max7219_data,
      o_max7219_clk  => s_max7219_clk);  -- MAX7219 CLK



  -- MAX7219 MODULE EMUL - Checker
  max7219_emul_inst : max7219_emul
    generic map(
      G_MATRIX_I => 0
    )
    port map (
      clk            => clk,
      rst_n          => rst_n,
      i_max7219_clk  => s_max7219_clk,
      i_max7219_din  => s_max7219_data,
      i_max7219_load => s_max7219_load,
      o_max7219_dout => s_max7219_dout
      );

end architecture behv;
