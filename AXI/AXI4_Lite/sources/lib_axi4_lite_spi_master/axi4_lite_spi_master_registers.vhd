-------------------------------------------------------------------------------
-- Title      : AXI 4 Lite SPI MASTER Registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_spi_master_registers.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2024-01-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: SPI MASTER REGISTERS - 32 bits access
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-08-29  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_axi4_lite_spi_master;
use lib_axi4_lite_spi_master.axi4_lite_spi_master_pkg.all;

entity axi4_lite_spi_master_registers is
  generic (
    G_ADDR_WIDTH      : integer range 4 to 16  := 5;    -- USEFULL ADDR WIDTH
    G_DATA_WIDTH      : integer range 32 to 64 := 32;   -- AXI4 Lite DATA WIDTH
    G_SPI_DATA_WIDTH  : integer                := 8;    -- SPI DATA WIDTH
    G_FIFO_DATA_WIDTH : integer range 8 to 32  := 8;    -- FIFO DATA WIDTH
    G_FIFO_DEPTH      : integer                := 1024  -- FIFO DEPTH
    );
  port (
    clk   : in std_logic;                               -- Clock
    rst_n : in std_logic;                               -- Asynchronous Reset

    -- Slave Registers Interface
    slv_start  : in std_logic;                                          -- Start the access
    slv_rw     : in std_logic;                                          -- Read or write access
    slv_addr   : in std_logic_vector(G_ADDR_WIDTH - 1 downto 0);        -- Slave Addr
    slv_wdata  : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- Slave Write Data
    slv_strobe : in std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

    slv_done   : out std_logic;                                    -- Slave access done
    slv_rdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_status : out std_logic_vector(1 downto 0);                 -- Slave status

    -- Registers Interface
    start_spi         : out std_logic;                                          -- Start SPI Transaction
    cpha              : out std_logic;                                          -- CPHA Configuration
    cpol              : out std_logic;                                          -- CPOL Configuration
    full_duplex       : out std_logic;                                          -- Full Duplex Configuration
    clk_div           : out std_logic_vector(7 downto 0);                       -- Clock Division Configuration
    nb_wr             : out std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of Write to perform
    nb_rd             : out std_logic_vector(log2(G_FIFO_DEPTH) - 1 downto 0);  -- Number of Read to perform
    wdata_fifo_tx     : out std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);   -- FIFO TX Data
    wr_en_fifo_tx     : out std_logic;                                          -- FIFO TX Write Enable    
    rdata_fifo_rx     : in  std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);   -- FIFO RX Data
    rdata_fifo_rx_val : in  std_logic;                                          -- FIFO RX Data Valid
    rd_en_fifo_rx     : out std_logic;                                          -- FIFO RX Read Enable
    fifo_tx_empty     : in  std_logic;                                          -- FIFO TX Empty Flag
    fifo_tx_full      : in  std_logic;                                          -- FIFO TX Full Flag
    fifo_rx_empty     : in  std_logic;                                          -- FIFO RX Empty Flag
    fifo_rx_full      : in  std_logic;                                          -- FIFO RX Full Flag
    spi_busy          : in  std_logic                                           -- SPI BUSY Flag
    );

end entity axi4_lite_spi_master_registers;

architecture rtl of axi4_lite_spi_master_registers is

  -- == INTERNAL Signals ==
  signal reg_wr_sel       : std_logic_vector(C_NB_REG - 1 downto 0);  -- Write register selection
  signal reg_wr_sel_error : std_logic;                                -- Reg Write Selection error

  -- Internal Registers
  signal ctrl0_register      : std_logic_vector(C_CTRL0_WIDTH - 1 downto 0);    -- CTRL0 Register
  signal ctrl1_register      : std_logic_vector(C_CTRL1_WIDTH - 1 downto 0);    -- CTRL1 Register
  signal fifo_tx_register    : std_logic_vector(C_FIFO_TX_WIDTH - 1 downto 0);  -- FIFO TX Register
  signal fifo_rx_register    : std_logic_vector(C_FIFO_RX_WIDTH - 1 downto 0);  -- FIFO RX Register
  signal status_register     : std_logic_vector(C_STATUS_WIDTH - 1 downto 0);   -- STATUS Register
  signal slv_wr_access_error : std_logic;                                       -- Slave Write Access Error

  signal wr_en_fifo_tx_int : std_logic;  -- Write FIFO TX Enable

begin  -- architecture rtl


  -- == Register Decoding ==
  -- Register decoding for Write Access or Read Access
  -- 
  g_register_sel : for i in 0 to C_NB_REG - 1 generate

    -- Register selection from slv_addr
    -- Check registers addr until G_REG_NB
    p_register_sel : process (slv_addr) is
    begin  -- process p_register_sel

      -- Set the corresponding bit to '1' if the address correspond to an
      -- exsisting address from the number of possible address
      -- check addr modulo 4 (0-4-8-C)
      if(unsigned(slv_addr(C_USEFUL_LSBITS - 1 downto 0)) = to_unsigned((i*G_DATA_WIDTH)/8, C_USEFUL_LSBITS)) then

        -- If lower or equals than REG2 ADDR -> Write access is authorized
        -- otherwise it is forbidden ('0')
        if(unsigned(slv_addr(C_USEFUL_LSBITS - 1 downto 0)) <= unsigned(C_REG2_ADDR)) then
          reg_wr_sel(i) <= '1';
        else
          reg_wr_sel(i) <= '0';
        end if;

      else
        reg_wr_sel(i) <= '0';
      end if;

    end process p_register_sel;

  end generate;
  -- ==========================

  -- == SELECTION ERROR Management ==
  -- reg_wr_sel_error generation if reg_wr_sel is set to (others => '0')
  reg_wr_sel_error <= '1' when reg_wr_sel = std_logic_vector(to_unsigned(0, reg_wr_sel'length)) else '0';
  -- ================================


  -- == Register Write Access ==
  -- purpose: Write Management of the REG0 Register
  -- Write in :
  -- CTRL

  p_reg0_wr_mngt : process (clk, rst_n) is
  begin  -- process p_reg0_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      ctrl0_register <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Write in CTRL0 Register
      if(reg_wr_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '0') then
        ctrl0_register <= slv_wdata(C_CTRL0_WIDTH - 1 downto 0);
      else
        ctrl0_register(0) <= '0';       -- Cleared on Write Bit
      end if;

    end if;
  end process p_reg0_wr_mngt;


  -- purpose: REG1 Write Management
  -- Write in register :
  -- command register
  p_reg1_wr_mngt : process (clk, rst_n) is
  begin  -- process p_reg1_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      ctrl1_register <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Write in CTRL1 Register
      if(reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0') then
        ctrl1_register <= slv_wdata(C_CTRL1_WIDTH - 1 downto 0);
      end if;

    end if;
  end process p_reg1_wr_mngt;


  -- purpose: Write Management
  p_reg2_wr_mngt : process (clk, rst_n) is
  begin  -- process p_reg2_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      fifo_rx_register  <= (others => '0');
      wr_en_fifo_tx_int <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Write in FIFO TX Register
      if(reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0') then
        fifo_tx_register  <= slv_wdata(C_FIFO_TX_WIDTH - 1 downto 0);
        wr_en_fifo_tx_int <= '1';
      else
        fifo_rx_register  <= (others => '0');
        wr_en_fifo_tx_int <= '0';       -- Pulse 
      end if;

    end if;
  end process p_reg2_wr_mngt;

  -- ===========================



  -- Slave WRite Access error :
  -- Wrong Write selection
  slv_wr_access_error <= reg_wr_sel_error;


  -- == Slave ACK Management ==

  -- purpose: Slave Done Management
  p_slv_done_mngt : process (clk, rst_n) is
  begin  -- process p_slv_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_done <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '0') then
        slv_done <= '1';

      -- Ack for a read access into a regular register
      elsif(slv_start = '1' and slv_rw = '1') then
        slv_done <= '1';

      else
        slv_done <= '0';
      end if;

    end if;
  end process p_slv_done_mngt;

  -- purpose: Slave Statue management
  p_slv_status_mngt : process (clk, rst_n) is
  begin  -- process p_slv_status_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_status <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '0') then
        slv_status <= slv_wr_access_error & '0';

      -- Ack for a read access into a regular register
      -- Generates an error if the addr is greater than the last accessible addr C_REG2_ADDR
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) > C_REG4_ADDR) then
        slv_status <= "10";

      -- No Error generated
      else
        slv_status <= "00";
      end if;

    end if;
  end process p_slv_status_mngt;

  -- purpose: Slave RDATA management  
  p_slv_rdata_mngt : process (clk, rst_n) is
  begin  -- process p_slv_rdata_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_rdata <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- RDATA for Regular registers
      -- Set RDATA when reading REG0
      if(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG0_ADDR) then
        slv_rdata <= x"0000" & ctrl0_register;

      -- Set RDATA when reading REG1
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG1_ADDR) then
        slv_rdata <= ctrl1_register;

      -- Set RDATA when reading REG2
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG2_ADDR) then
        slv_rdata <= fifo_tx_register;

      -- Set RDATA when reading REG3 -- TBD FIFO ...
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG3_ADDR) then
        slv_rdata <= fifo_rx_register;

      -- Set RDATA when reading REG4
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG4_ADDR) then
        slv_rdata <= x"000" & "000" & status_register;

      -- Otherwise REturn (others => '0');
      else
        slv_rdata <= (others => '0');
      end if;

    end if;
  end process p_slv_rdata_mngt;

  -- ==========================

  -- Inputs
  status_register <= spi_busy & x"0" & "00" & fifo_rx_full & fifo_rx_empty & x"0" & "00" & fifo_tx_full & fifo_tx_empty;  -- FIFO A ajouter

  -- == OUTPUTS Affectation ==
  start_spi     <= ctrl0_register(0);                                      -- Start SPI Bit
  cpha          <= ctrl0_register(1);                                      -- CPHA Configuration
  cpol          <= ctrl0_register(2);                                      -- CPOL Configuration
  full_duplex   <= ctrl0_register(3);                                      -- FULL DUPLEX Configuration
  clk_div       <= ctrl0_register(15 downto 8);                            -- Clock Div Configuration
  nb_wr         <= ctrl1_register(log2(G_FIFO_DEPTH) - 1 downto 0);        -- nb_wr Configuration
  nb_rd         <= ctrl1_register(16 + log2(G_FIFO_DEPTH) - 1 downto 16);  -- nb_wr Configuration
  wdata_fifo_tx <= fifo_tx_register(G_FIFO_DATA_WIDTH - 1 downto 0);       -- FIFO TX DATA TO Write
  wr_en_fifo_tx <= wr_en_fifo_tx_int;                                      -- FIFO TX DATA Write Enable
  rd_en_fifo_rx <= '0';                                                    -- TBD a connecter

end architecture rtl;
