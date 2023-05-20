-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Slave Registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_slave_reg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-05
-- Last update: 2023-05-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-05  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_axi4_lite;
use lib_axi4_lite.pkg_reg.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity axi4_lite_slave_reg is

  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite DATA WIDTH
    G_REG_CONFIG           : t_reg_config_array;      -- Register Configuration
    G_REG_IN_NB            : integer range 1 to 4096;  -- Number of Inputs registers
    G_REG_OUT_NB           : integer range 1 to 4096  -- Number of Outputs registers
    );

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Slave Registers Interface
    slv_start  : in std_logic;          -- Start the access
    slv_rw     : in std_logic;          -- Read or write access
    slv_addr   : in std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Addr
    slv_wdata  : in std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave Write Data
    slv_strobe : in std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

    slv_done   : out std_logic;         -- Slave access done
    slv_rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_status : out std_logic;         -- Slave status

    -- Registers Interface
    registers_in  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH*G_REG_IN_NB - 1 downto 0);  -- Registers In
    registers_out : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH*G_REG_OUT_NB - 1 downto 0)  -- Registers out
    );

end entity axi4_lite_slave_reg;

architecture rtl of axi4_lite_slave_reg is

  -- == TYPES ==
  type t_registers_array is array (0 to G_REG_CONFIG'length - 1) of std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Array of registers

  -- == INTERNAL Signals ==
  signal reg_wr_sel       : std_logic_vector(G_REG_CONFIG'length - 1 downto 0);  -- Register selection (1 bit per register)
  signal reg_wr_sel_error : std_logic;  -- Wrong selected registers
  signal reg_rd_sel       : unsigned(log2(G_REG_CONFIG'length) downto 0);  -- Register Read selection
  signal reg_rd_sel_error : std_logic;  -- Wrong select read addr

  -- Registers
  signal register_i : t_registers_array;  -- Register i

  signal rdata_register : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Selected rdata from register

begin  -- architecture rtl

  -- == Register Decoding ==
  g_register_sel : for i in 0 to G_REG_CONFIG'length - 1 generate
    -- Register selection from slv_addr
    -- Check registers addr until G_REG_NB
    p_register_sel : process (slv_addr) is
    begin  -- process p_register_sel

      -- Set the corresponding bit to '1' if the address correspond to an
      -- exsisting address from the number of possible address      
      if(unsigned(slv_addr) = to_unsigned((i*G_AXI4_LITE_DATA_WIDTH)/8, slv_addr'length)) then
        reg_wr_sel(i) <= '1';
      else
        reg_wr_sel(i) <= '0';
      end if;

    end process p_register_sel;
  end generate;

  -- reg_wr_sel_error generation
  reg_wr_sel_error <= '1' when reg_wr_sel = std_logic_vector(to_unsigned(0, reg_wr_sel'length)) else '0';


  reg_rd_sel <= unsigned(slv_addr(G_AXI4_LITE_ADDR_WIDTH - 1 downto ((G_AXI4_LITE_DATA_WIDTH/8)/2)));
  -- =======================


  -- == Register Write Access ==
  -- Customized it for the application
  -- One Process per writtable registers
  g_register_wr_mngt : for i in 0 to G_REG_CONFIG'length - 1 generate

    -- purpose: Register 1 Write Access Management
    p_register_i_wr_mngt : process (clk, rst_n) is
    begin  -- process p_register_i_wr_mngt
      if rst_n = '0' then               -- asynchronous reset (active low)
        register_i(i) <= std_logic_vector(to_unsigned(G_REG_CONFIG(i).reg_init_value, register_i(i)'length));
      elsif rising_edge(clk) then       -- rising clock edge

        -- On the Write Access and on the selected allowed the write to the register
        if(slv_start = '1' and slv_rw = '0' and reg_wr_sel(i) = '1' and (G_REG_CONFIG(i).reg_wr_en = '1')) then

          -- Loop on Each possible Strobe
          for i in 0 to (G_AXI4_LITE_DATA_WIDTH / 8) - 1 loop
            register_i(i)(8*(i + 1) - 1 downto i*8) <= slv_wdata(8*(i + 1) - 1 downto i*8);
          end loop;

        end if;

      end if;
    end process p_register_i_wr_mngt;

  end generate;
  -- ===========================

  -- == Register Read Access ==

  -- purpose: Rdata register selection
  p_rdata_register : process (slv_start, slv_rw, reg_rd_sel) is
  begin  -- process p_rdata_register

    -- Register 1 selected for a read access
    if(slv_start = '1' and slv_rw = '0' and G_REG_CONFIG(to_integer(reg_rd_sel)).reg_rd_en = '1') then
      rdata_register   <= register_i(to_integer(reg_rd_sel));
      reg_rd_sel_error <= '0';
    else
      rdata_register   <= (others => '0');
      reg_rd_sel_error <= '1';
    end if;

  end process p_rdata_register;


  -- ==========================

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
      slv_status <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '0') then
        slv_status <= reg_wr_sel_error;

      -- Ack for a read access into a regular register
      elsif(slv_start = '1' and slv_rw = '1') then
        slv_status <= reg_rd_sel_error;

      else
        slv_status <= '0';
      end if;

    end if;
  end process p_slv_status_mngt;

  -- purpose: Slave RDATA management  
  p_slv_rdata_mngt : process (clk, rst_n) is
  begin  -- process p_slv_rdata_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_rdata <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '1') then
        slv_rdata <= rdata_register;
      else
        slv_rdata <= (others => '0');
      end if;

    end if;
  end process p_slv_rdata_mngt;

  -- ==========================


  -- == REGISTERS Mapping ==
  g_reg_mapping : for i in 0 to G_REG_CONFIG'length - 1 generate

    -- Connect register to outputs port
    g_reg_to_output : if(G_REG_CONFIG(i).reg_wr_en = '1' and G_REG_CONFIG(i).external = '1') generate
      registers_out((G_REG_CONFIG(i).position+1)*G_AXI4_LITE_DATA_WIDTH - 1 downto G_REG_CONFIG(i).position*G_AXI4_LITE_DATA_WIDTH) <= register_i(i);
    end generate;

    -- Connect register to inputs port
    g_reg_to_input : if(G_REG_CONFIG(i).reg_wr_en = '0' and G_REG_CONFIG(i).reg_rd_en = '1' and G_REG_CONFIG(i).external = '1') generate
      register_i(i) <= registers_in((G_REG_CONFIG(i).position+1)*G_AXI4_LITE_DATA_WIDTH - 1 downto G_REG_CONFIG(i).position*G_AXI4_LITE_DATA_WIDTH);
    end generate;

  end generate;
  -- =======================

end architecture rtl;
