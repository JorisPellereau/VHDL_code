-------------------------------------------------------------------------------
-- Title      : MAX7219 DECOD CMD INIT RAM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_init_ram.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-14
-- Last update: 2020-04-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This block Initializes the MAX7219_cmd_decod block - DEBUG purpose
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-14  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_init_ram is

  generic (
    G_ADDR_WIDTH : integer                       := 8;   -- RAM ADDR WIDTH
    G_DATA_WIDTH : integer                       := 16;  -- RAM DATA WIDTH
    G_LAST_PTR   : std_logic_vector(31 downto 0) := x"0000000A");

  port (
    clk        : in  std_logic;         -- Clock
    rst_n      : in  std_logic;         -- Asynchronous reset
    o_me       : out std_logic;         -- Memory Enable
    o_we       : out std_logic;         -- Memory Command
    o_addr     : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    o_wdata    : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
    o_en       : out std_logic;         -- Enable the MAX7219 CMD DECOD
    o_last_ptr : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0));  -- LAST ADDR PTR

end entity max7219_init_ram;

architecture behv of max7219_init_ram is

  -- INTERNAL SIGNALS
  signal s_ram_init_done : std_logic;   -- RAM INIT done
  signal s_en            : std_logic;   -- ENABLE
  signal s_me            : std_logic;   -- ME
  signal s_me_p          : std_logic;   -- s_me pipe
  signal s_we            : std_logic;   -- WE


  signal s_wdata    : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- WDATA
  signal s_addr     : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR ptr
  signal s_addr_p   : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- ADDR ptr
  signal s_last_ptr : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- LAST PTR
begin  -- architecture behv


  -- purpose: INIT the RAM
  p_init_ram : process (clk, rst_n) is
  begin  -- process p_init_ram
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_ram_init_done <= '0';
      s_me            <= '0';
      s_we            <= '0';

      --s_wdata         <= C_RAM_INIT_0(0);
      s_wdata <= C_RAM_INIT_1(0);

      s_addr   <= (others => '0');
      s_addr_p <= (others => '0');
      s_me_p   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_addr_p <= s_addr;
      s_me_p   <= s_me;
      if(s_ram_init_done = '0') then

        if(s_addr < x"FF") then
          s_me <= '1';
          s_we <= '1';

          --s_wdata <= C_RAM_INIT_0(conv_integer(unsigned(s_addr)));
          s_wdata <= C_RAM_INIT_1(conv_integer(unsigned(s_addr)));
          if(s_me = '1') then
            s_addr <= unsigned(s_addr) + 1;  -- INC ADDR
          --s_wdata <= C_RAM_INIT_0(conv_integer(unsigned(s_addr)));
          end if;
        else
          s_ram_init_done <= '1';
          s_me            <= '0';
          s_we            <= '0';
          s_wdata         <= (others => '0');
          s_addr          <= (others => '0');
        end if;
      end if;
    end if;
  end process p_init_ram;

  -- p_addr_mngt : process (clk, rst_n) is
  -- begin  -- process p_addr_mngt
  --   if rst_n = '0' then                    -- asynchronous reset (active low)
  --     s_addr <= (others => '0');
  --   --s_wdata <= (others => '0');
  --   elsif clk'event and clk = '1' then     -- rising clock edge
  --     if(s_me = '1') then
  --       if(s_addr < x"FF") then
  --         s_addr <= unsigned(s_addr) + 1;  -- INC ADDR
  --       --s_wdata <= C_RAM_INIT_0(conv_integer(unsigned(s_addr)));
  --       else
  --         s_addr <= (others => '0');
  --       --s_wdata <= (others => '0');
  --       end if;
  --     end if;
  --   end if;
  -- end process p_addr_mngt;

  -- purpose: Start the CMD DECOD after the initialization of the RAM
  p_start_ram_decod : process (clk, rst_n) is
  begin  -- process p_start_ram_decod
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en       <= '0';
      s_last_ptr <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_ram_init_done = '1') then
        s_en       <= '1';
        s_last_ptr <= G_LAST_PTR(G_ADDR_WIDTH - 1 downto 0);
      end if;
    end if;
  end process p_start_ram_decod;

  -- OUTPUT affectation
  o_en       <= s_en;
  o_last_ptr <= s_last_ptr;
  o_me       <= s_me;
  o_we       <= s_we;
  o_addr     <= s_addr_p;
  o_wdata    <= s_wdata;

end architecture behv;
