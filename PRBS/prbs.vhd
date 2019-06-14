-------------------------------------------------------------------------------
-- Title      : PRBS
-- Project    : 
-------------------------------------------------------------------------------
-- File       : prbs.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-03
-- Last update: 2019-06-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Pseudo Random Binary Sequence
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-03  1.0      JorisPC Created
-------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;

library lib_prbs;
use lib_prbs.pkg_prbs.all;

entity prbs is
  generic(
    prbs_i : integer range 2 to 32 := 3  -- PRBS index 2 => 32
    );
  port(
    -- == INPUTS ==
    lfsr_preload : in  std_logic_vector(prbs_cst(prbs_i).lfsr_size - 1 downto 0);  -- Preload of the LFSR
    clk          : in  std_logic;       -- Clock
    rst_n        : in  std_logic;       -- Asynchron RESET
    start        : in  std_logic;       -- Start the sequence
    -- == OUTPUTS ==
    lfsr         : out std_logic_vector(prbs_cst(prbs_i).lfsr_size - 1 downto 0);  -- LFSR output
    d_out        : out std_logic        -- Serial output
    );
end entity;

architecture behv of prbs is

  -- signal lfsr_s  : std_logic_vector(prbs_cst(prbs_i).lfsr_size - 1 downto 0);  -- Linear Feedback Shift register
  -- signal res_xor : std_logic;


  -- Modif
  signal lfsr_reg : std_logic_vector(prbs_i - 1 downto 0);  -- LFSR register
  signal lfsr_fbk : std_logic;                              -- LFSR feedback

begin



  -- preload_gen_p : process(clk, rst_n)
  -- begin
  --   if(rst_n = '0') then
  --     lfsr_s <= (others => '0');
  --     lfsr_s <= lfsr_preload;
  --   elsif(rising_edge(clk)) then
  --     if(start = '0') then
  --       lfsr_s <= lfsr_preload;
  --     else
  --       lfsr_s(prbs_cst(prbs_i).lfsr_size - 2 downto 0) <= lfsr_s(prbs_cst(prbs_i).lfsr_size - 1 downto 1);  -- Shift
  --       lfsr_s(prbs_cst(prbs_i).lfsr_size - 1)          <= res_xor;  -- Feedback on MSB
  --     end if;
  --   end if;
  -- end process;

  -- == XOR mng ==
  -- res_xor <= lfsr_s(prbs_cst(prbs_i).fbk_position(0)) xor lfsr_s(prbs_cst(prbs_i).fbk_position(1)) when (prbs_cst(prbs_i).fbk_number = 2) else
  --            lfsr_s(prbs_cst(prbs_i).fbk_position(0)) xor lfsr_s(prbs_cst(prbs_i).fbk_position(1)) xor lfsr_s(prbs_cst(prbs_i).fbk_position(2)) xor lfsr_s(prbs_cst(prbs_i).fbk_position(3)) when (prbs_cst(prbs_i).fbk_number = 4) else
  --            '0';


  -- == d_out mng == 
  -- d_out <= lfsr_s(0);                   -- output generation on LSB
  -- lfsr  <= lfsr_s;



  -- purpose: this process manages the prbs 
  p_prbs_gen : process (clk, rst_n) is
  begin  -- process p_prbs_gen
    if rst_n = '0' then                 -- asynchronous reset (active low)
      lfsr_reg <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(start = '0') then
        lfsr_reg <= lfsr_preload;
      else
        lfsr_reg <= lfsr_fbk & lfsr_reg(prbs_i - 2 downto 0) :
      end if;
    end if;
  end process p_prbs_gen;


  d_out <= lfsr_reg(0) when start = '1' else '0';
  lfsr  <= lfsr_reg;

  -- With generate
  g_lfsr_2 : if(prbs_i = 2) generate
    lfsr_fbk <= lfsr_reg(2) xor lfsr_reg(1);
  end generate;



end behv;
