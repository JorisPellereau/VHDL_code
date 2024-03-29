-------------------------------------------------------------------------------
-- Title      : AXI4 Lite I2C Masters Registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_i2c_master_registers.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-31
-- Last update: 2024-03-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-31  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_axi4_lite_i2c_master;
use lib_axi4_lite_i2c_master.axi4_lite_i2c_master_pkg.all;

entity axi4_lite_i2c_master_registers is
  generic (
    G_ADDR_WIDTH      : integer range 4 to 16  := 4;    -- USEFULL ADDR WIDTH
    G_DATA_WIDTH      : integer range 32 to 64 := 32;   -- AXI4 Lite DATA WIDTH
    G_NB_DATA         : integer                := 256;  -- NB DATA WIDTH
    G_FIFO_DATA_WIDTH : integer                := 8;    -- FIFO DATA WIDTH
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

    -- I2C Control
    start_i2c : out std_logic;                                   -- START I2C Transaction
    rw        : out std_logic;                                   -- R/W acces
    chip_addr : out std_logic_vector(6 downto 0);                -- Chip addr to request
    nb_data   : out std_logic_vector(log2(G_NB_DATA) downto 0);  -- Number of Bytes to Read or Write

    -- FIFO ITF
    wr_en_fifo_tx : out std_logic;                     -- Write Enable to the FIFO TX
    wdata_fifo_tx : out std_logic_vector(7 downto 0);  -- Write DAta FIFO TX

    rd_en_fifo_rx : out std_logic;                     -- Read Enable to the FIFO RX
    rdata_fifo_rx : in  std_logic_vector(7 downto 0);  -- Read Data FIFO RX

    -- Status
    fifo_tx_empty : in std_logic;       -- FIFO TX Empty Flag
    fifo_tx_full  : in std_logic;       -- FIFO TX Full Flag
    fifo_rx_empty : in std_logic;       -- FIFO RX Empty Flag
    fifo_rx_full  : in std_logic;       -- FIFO RX Full Flag
    sack_error    : in std_logic;       -- SACK Error Flag
    i2c_busy      : in std_logic        -- SPI BUSY Flag
    );

end entity axi4_lite_i2c_master_registers;

architecture rtl of axi4_lite_i2c_master_registers is

  -- == INTERNAL Signals ==
  signal reg_sel              : std_logic_vector(C_NB_REG - 1 downto 0);  -- Register selection
  signal reg_sel_error        : std_logic;                                -- Reg Selection error
  signal slv_wr_access_error  : std_logic;                                -- Slave Write Access Error
  signal wr_en_fifo_tx_int    : std_logic;                                -- Write FIFO TX Enable
  signal rd_en_fifo_rx_int    : std_logic;                                -- Read FIFO RX Enable
  signal fifo_rx_register_val : std_logic;                                -- FIFO RX Register valid
  signal regular_reg_sel      : std_logic;                                -- Regular Register selected

  -- Internal Registers
  signal ctrl0_register          : std_logic_vector(C_CTRL0_WIDTH - 1 downto 0);    -- CTRL0 Register
  signal fifo_tx_register        : std_logic_vector(C_FIFO_TX_WIDTH - 1 downto 0);  -- FIFO TX Register
  signal fifo_rx_register        : std_logic_vector(C_FIFO_RX_WIDTH - 1 downto 0);  -- FIFO RX Register
  signal status_register         : std_logic_vector(C_STATUS_WIDTH - 1 downto 0);   -- STATUS Register
  signal fifo_rx_rd_access_error : std_logic;                                       -- FIFO RX Read access Error FLAG
  signal rdata_fifo_rx_val       : std_logic;                                       -- Read Data FIFO RX Valid - internal piped

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

        -- If lower or equals than REG3 ADDR -> Write access is authorized
        -- otherwise it is forbidden ('0')
        if(unsigned(slv_addr(C_USEFUL_LSBITS - 1 downto 0)) <= unsigned(C_REG3_ADDR)) then
          reg_sel(i) <= '1';
        else
          reg_sel(i) <= '0';
        end if;

      else
        reg_sel(i) <= '0';
      end if;

    end process p_register_sel;

  end generate;
  -- ==========================

  -- == SELECTION ERROR Management ==
  -- reg_sel_error generation if reg_sel is set to (others => '0')
  reg_sel_error <= '1' when reg_sel = std_logic_vector(to_unsigned(0, reg_sel'length)) else '0';
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
      if(reg_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '0') then
        ctrl0_register <= slv_wdata(C_CTRL0_WIDTH - 1 downto 0);
      else
        ctrl0_register(0) <= '0';       -- Cleared on Write Bit
      end if;

    end if;
  end process p_reg0_wr_mngt;

  -- purpose: Write Management
  p_reg1_wr_mngt : process (clk, rst_n) is
  begin  -- process p_reg1_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      fifo_tx_register  <= (others => '0');
      wr_en_fifo_tx_int <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Write in FIFO TX Register
      if(reg_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0') then
        fifo_tx_register  <= slv_wdata(C_FIFO_TX_WIDTH - 1 downto 0);
        wr_en_fifo_tx_int <= '1';
      else
        fifo_tx_register  <= (others => '0');
        wr_en_fifo_tx_int <= '0';       -- Pulse 
      end if;

    end if;
  end process p_reg1_wr_mngt;

  -- purpose: Register 2 - FIFO RX update 
  p_reg2_update : process (clk, rst_n) is
  begin  -- process p_reg0_update
    if rst_n = '0' then                 -- asynchronous reset (active low)
      fifo_rx_register     <= (others => '0');
      fifo_rx_register_val <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- On the valid signal, update fifo_rx_register
      -- This signal is set to one only if rd_fifo_rx_en was set previously AND if the FIFO is not empty
      if(rdata_fifo_rx_val = '1') then
        fifo_rx_register     <= x"000000" & rdata_fifo_rx;  -- Update FIFO RX register
        fifo_rx_register_val <= '1';
      else
        fifo_rx_register_val <= '0';                        -- Reset the flag
      end if;

    end if;
  end process p_reg2_update;

  -- ===========================



  -- Slave WRite Access error :
  -- Wrong Write selection
  slv_wr_access_error <= reg_sel_error;

  -- purpose: FIFO RX Read Enable bit management
  p_fifo_rx_en_mngt : process (clk, rst_n) is
  begin  -- process p_fifo_rx_en_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      rd_en_fifo_rx_int <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Generates the enable bit only during a read_access (slv_rw = '1') and if the correct
      -- register (REG2) is selected. Otherwise no generation of the bit
      -- Perform a read access only if the FIFO RX is not empty
      if(reg_sel(C_REG2_IDX) = '1' and slv_start = '1' and slv_rw = '1' and fifo_rx_empty = '0') then
        rd_en_fifo_rx_int <= '1';
      else
        rd_en_fifo_rx_int <= '0';
      end if;

    end if;
  end process p_fifo_rx_en_mngt;

  -- purpose: FIFO RX Read access error because of empty FIFO
  p_fifo_rx_read_access_error : process (clk, rst_n) is
  begin  -- process p_fifo_rx_read_access_error
    if rst_n = '0' then                 -- asynchronous reset (active low)
      fifo_rx_rd_access_error <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- If a read access if perform on the REG2 and if the fifo is EMPTY -> abort the access and generate an error flag
      if(reg_sel(C_REG2_IDX) = '1' and slv_start = '1' and slv_rw = '1' and fifo_rx_empty = '1') then
        fifo_rx_rd_access_error <= '1';
      else
        fifo_rx_rd_access_error <= '0';
      end if;

    end if;
  end process p_fifo_rx_read_access_error;

  -- purpose: Pipe one time FIFO RX Valid and internaly generate rdata_fifo_rx_val
  p_pipe_fifo_rx_valid : process (clk, rst_n) is
  begin  -- process p_pipe_fifo_rx_valid
    if rst_n = '0' then                        -- asynchronous reset (active low)
      rdata_fifo_rx_val <= '0';
    elsif rising_edge(clk) then                -- rising clock edge
      rdata_fifo_rx_val <= rd_en_fifo_rx_int;  -- Internal signal rdata_fifo_rx_val gets rd_en_fifo_rx_int
    end if;
  end process p_pipe_fifo_rx_valid;


  -- Regular register is selected : REg 0-1 and 3 are regular register
  regular_reg_sel <= '1' when reg_sel(C_REG0_IDX) = '1' else
                     '1' when reg_sel(C_REG1_IDX) = '1' else
                     '1' when reg_sel(C_REG3_IDX) = '1' else
                     '0';

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
      -- or
      -- Ack for a read access of the FIFO RX register or a read access to the FIFO RX during an empty status
      elsif((slv_start = '1' and slv_rw = '1' and regular_reg_sel = '1') or
            (fifo_rx_register_val = '1' or fifo_rx_rd_access_error = '1')) then
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
      elsif((slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) > C_REG3_ADDR) or
            fifo_rx_rd_access_error = '1'
            ) then
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
        slv_rdata <= ctrl0_register;

      -- Set RDATA when reading REG1
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG1_ADDR) then
        slv_rdata <= fifo_tx_register;

      -- Set RDATA when reading REG2 - Update slv_rdata on fifo_rx_register_val
      elsif(fifo_rx_register_val = '1') then
        slv_rdata <= fifo_rx_register;

      -- Set RDATA when reading REG3
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG3_ADDR) then
        slv_rdata <= x"000" & "00" & status_register;

      -- Otherwise REturn (others => '0');
      else
        slv_rdata <= (others => '0');
      end if;

    end if;
  end process p_slv_rdata_mngt;

  -- ==========================

  -- Inputs
  status_register <= i2c_busy & sack_error & x"0" & "00" & fifo_rx_full & fifo_rx_empty & x"0" & "00" & fifo_tx_full & fifo_tx_empty;  -- FIFO A ajouter

  -- == OUTPUTS Affectation ==
  start_i2c     <= ctrl0_register(0);                                 -- Start I2C Transaction
  rw            <= ctrl0_register(1);                                 -- Read or Write I2C Access
  chip_addr     <= ctrl0_register(14 downto 8);                       -- Chip Addr
  nb_data       <= ctrl0_register(16 + log2(G_NB_DATA) downto 16);    -- Number of data parameter
  wdata_fifo_tx <= fifo_tx_register(G_FIFO_DATA_WIDTH - 1 downto 0);  -- FIFO TX DATA TO Write
  wr_en_fifo_tx <= wr_en_fifo_tx_int;                                 -- FIFO TX DATA Write Enable
  rd_en_fifo_rx <= rd_en_fifo_rx_int;                                 -- FIFO RX Read Enable

end architecture rtl;
