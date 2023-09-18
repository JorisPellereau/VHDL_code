-------------------------------------------------------------------------------
-- Title      : FIFO SP_RAM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : fifo_sp_ram.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-14
-- Last update: 2023-09-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: FIFO for a SP_RAM.
-- Read and Write access can be simulteneous
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-14  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_sp_ram is
  generic (
    G_DATA_WIDTH : integer := 8;        -- DATA Width
    G_ADDR_WIDTH : integer := 10
    );
  port (
    clk   : in std_logic;               -- Clock System
    rst_n : in std_logic;               -- Asynchronous Reset

    -- FIFO CTRL
    wr_en     : in  std_logic;          -- Write Enable
    rd_en     : in  std_logic;          -- Read Enable
    wdata     : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA to Write
    rdata     : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA From RAM
    rdata_val : out std_logic;          -- RDATA Valid

    -- RAM ITF
    wdata_out : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to write to the RAM
    we        : out std_logic;          -- SP RAM Write Enable
    wr_addr   : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Write Addr
    rd_addr   : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Read Addr
    rdata_in  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to read from the RAM

    -- FIFO Status
    fifo_empty : out std_logic;         -- Fifo Empty Flag
    fifo_full  : out std_logic);        -- Fifo Full Flag

end entity fifo_sp_ram;

architecture rtl of fifo_sp_ram is

  -- == INTERNAL Signals ==
  signal write_ptr : unsigned(G_ADDR_WIDTH - 1 downto 0);  -- Write Pointer
  signal read_ptr  : unsigned(G_ADDR_WIDTH - 1 downto 0);  -- Read Pointer

  signal fifo_full_int  : std_logic;    -- Fifo FULL Flag internal
  signal fifo_empty_int : std_logic;    -- Fifo EMPTY Flag internal

  signal rd_en_p  : std_logic;          -- RD Enable Piped one time
  signal we_int   : std_logic;          -- Internal Write Enable

begin  -- architecture rtl

  -- purpose: FIFO Write Access
  -- Perform a FIFO Write Access on a write enable
  p_fifo_wr_access : process (clk, rst_n) is
  begin  -- process p_fifo_wr_access
    if rst_n = '0' then          -- asynchronous reset (active low)      
      we_int <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Enable the write access if the FIFO is not full
      if(wr_en = '1' and fifo_full_int = '0') then
        we_int <= '1';

      -- Otherwise do not perform a write access
      else
        we_int <= '0';
      end if;

    end if;
  end process p_fifo_wr_access;

  -- purpose: Write Pointer Management
  p_fifo_wr_ptr_mngt : process (clk, rst_n) is
  begin  -- process p_fifo_wr_ptr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      write_ptr <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      if(we_int = '1' and fifo_full_int = '0') then
        write_ptr <= write_ptr + 1;     -- Inc the ptr
      end if;

    end if;
  end process p_fifo_wr_ptr_mngt;

  -- purpose: FIFO Read Access
  -- Perform a FIFO Read Access on Read Enable
  p_fifo_rd_access : process (clk, rst_n) is
  begin  -- process p_fifo_rd_access
    if rst_n = '0' then                 -- asynchronous reset (active low)
      read_ptr <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Enable the Read access if the FIFO is not empty
      if(rd_en_p = '1' and fifo_empty_int = '0') then
        read_ptr <= read_ptr + 1;       -- Inc the ptr
      end if;

    end if;
  end process p_fifo_rd_access;

  -- purpose: Read Enable Piped one time on read access
  p_rd_en_p_mngt : process (clk, rst_n) is
  begin  -- process p_rd_en_p_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      rd_en_p <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Enable the Read access if the FIFO is not empty
      if(rd_en = '1' and fifo_empty_int = '0') then
        rd_en_p <= '1';
      else
        rd_en_p <= '0';
      end if;
    end if;
  end process p_rd_en_p_mngt;

  -- purpose: DATA Out Management
  p_data_out_mngt : process (clk, rst_n) is
  begin  -- process p_data_out_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      rdata     <= (others => '0');
      rdata_val <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      if(rd_en_p = '1') then
        rdata     <= rdata_in;
        rdata_val <= '1';
      else
        rdata     <= (others => '0');
        rdata_val <= '0';
      end if;

    end if;
  end process p_data_out_mngt;

  -- purpose: Write data out management
  -- set wdata_out when a write access is allowed
  p_wdata_out_mngt : process (clk, rst_n) is
  begin  -- process p_wdata_out_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      wdata_out <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Enable to set wdata_out if the FIFO is not full
      if(wr_en = '1' and fifo_full_int = '0') then
        wdata_out <= wdata;
      end if;

    end if;
  end process p_wdata_out_mngt;


  -- FIFO Flag computation
  fifo_empty_int <= '1' when (unsigned(write_ptr) - unsigned(read_ptr)) = to_unsigned(0, G_ADDR_WIDTH)                     else '0';
  fifo_full_int  <= '1' when (unsigned(write_ptr) - unsigned(read_ptr)) = to_unsigned((2**G_ADDR_WIDTH) - 1, G_ADDR_WIDTH) else '0';

  -- == Outputs Affectation ==
  fifo_full  <= fifo_full_int;
  fifo_empty <= fifo_empty_int;
  wr_addr    <= std_logic_vector(write_ptr);
  rd_addr    <= std_logic_vector(read_ptr);
  we         <= we_int;

end architecture rtl;
