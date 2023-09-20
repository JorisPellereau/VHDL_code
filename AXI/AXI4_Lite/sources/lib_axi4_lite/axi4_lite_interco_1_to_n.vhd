-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Interconnect 1 Master to N Slaves
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_interco_1_to_n.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-18
-- Last update: 2023-09-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite Interconnect 1 Master to N Slaves
-- The interconnect privides entire address (no filter of base addr. is performed)
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-18  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_axi4_lite;
use lib_axi4_lite.pkg_axi4_lite_interco.all;
use lib_axi4_lite.pkg_axi4_lite_interco_cutom.all;

entity axi4_lite_interco_1_to_n is

  generic (
    G_AXI_DATA_WIDTH : integer range 32 to 64 := 32;  -- AXI DATA WIDTH
    G_AXI_ADDR_WIDTH : integer range 8 to 32  := 16;  -- AXI ADDR WIDTH
    G_SLAVE_NB       : integer range 2 to 16  := 2);  -- Number of AXI4 Lite Slave
  port (
    clk_sys   : in std_logic;                         -- Clock system
    rst_n_sys : in std_logic;                         -- Asynchronous reset

    -- SLAVE INTERFACE

    -- Write Address Channel signals
    awvalid_s : in  std_logic;                                        -- Address Write Valid
    awaddr_s  : in  std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot_s  : in  std_logic_vector(2 downto 0);                     -- Adress Write Prot
    awready_s : out std_logic;                                        -- Address Write Ready

    -- Write Data Channel
    wvalid_s : in  std_logic;                                              -- Write Data Valid
    wdata_s  : in  std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
    wstrb_s  : in  std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
    wready_s : out std_logic;                                              -- Write data Ready

    -- Write Response Channel
    bready_s : in  std_logic;                     -- Write Channel Response
    bvalid_s : out std_logic;                     -- Write Response Channel Valid
    bresp_s  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid_s : in  std_logic;                                        -- Read Channel Valid
    araddr_s  : in  std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot_s  : in  std_logic_vector(2 downto 0);                     -- Read Address channel Ready Prot
    arready_s : out std_logic;                                        -- Read Address Channel Ready

    -- Read Data Channel
    rready_s : in  std_logic;                                        -- Read Data Channel Ready
    rvalid_s : out std_logic;                                        -- Read Data Channel Valid
    rdata_s  : out std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp_s  : out std_logic_vector(1 downto 0);                     -- Read Data Channel Response


    -- MASTERS Interface
    awvalid_m : out std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Address Write Valid
    awaddr_m  : out t_addr_array(0 to G_SLAVE_NB - 1);          -- Address Write    
    awprot_m  : out t_prot_array(0 to G_SLAVE_NB - 1);          -- Adress Write Prot
    awready_m : in  std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Address Write Ready

    wvalid_m : out std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Data Valid
    wdata_m  : out t_data_array(0 to G_SLAVE_NB - 1);          -- Write Data
    wstrb_m  : out t_wstrb_array(0 to G_SLAVE_NB - 1);
    wready_m : in  std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write data Ready

    bready_m : out std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Channel Response
    bvalid_m : in  std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Response Channel Valid
    bresp_m  : in  t_resp_array(0 to G_SLAVE_NB - 1);          -- Write Response Channel resp

    arvalid_m : out std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Channel Valid
    araddr_m  : out t_addr_array(0 to G_SLAVE_NB - 1);          -- Read Address channel Ready
    arprot_m  : out t_prot_array(0 to G_SLAVE_NB - 1);          -- Read Address channel Ready Prot
    arready_m : in  std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Address Channel Ready

    rready_m : out std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Data Channel Ready
    rvalid_m : in  std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Data Channel Valid
    rdata_m  : in  t_data_array(0 to G_SLAVE_NB - 1);          -- Read Data Channel rdata
    rresp_m  : in  t_resp_array(0 to G_SLAVE_NB - 1)           -- Read Data Channel Resp
    );

end entity axi4_lite_interco_1_to_n;

architecture rtl of axi4_lite_interco_1_to_n is

  -- == INTERNAL Signals ==
  --Slave signals
  signal slv_start  : std_logic;                                              -- Slave Start
  signal slv_rw     : std_logic;                                              -- Slave Read or Write Access
  signal slv_addr   : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);        -- Slave Addr
  signal slv_wdata  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- SLave Write Data
  signal slv_strobe : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Slave Strobe
  signal slv_done   : std_logic;                                              -- Slave Done
  signal slv_rdata  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Slave Read Data
  signal slv_status : std_logic_vector(1 downto 0);                           -- Status

  -- Decoder signals
  signal sel_idx_comb       : unsigned(3 downto 0);  -- Slave Index Selection combinatory
  signal sel_idx_latch      : unsigned(3 downto 0);  -- Slave Index Selection combinatory
  signal sel_idx_comb_valid : std_logic;             -- A flag that indicates if the idx selection is valid

  -- Masters signals
  signal start_master         : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Start Master Pulse
  signal addr_master          : t_addr_array(0 to G_SLAVE_NB - 1);          -- Master Addr array
  signal rnw_master           : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- RNW Masters
  signal strobe_master        : t_wstrb_array(0 to G_SLAVE_NB - 1);         -- Strobe Master array
  signal wdata_master         : t_data_array(0 to G_SLAVE_NB - 1);          -- Write Data Master Array
  signal done_master          : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Done MAster
  signal rdata_master         : t_data_array(0 to G_SLAVE_NB - 1);          -- MAster RDATA
  signal access_status_master : t_resp_array(0 to G_SLAVE_NB - 1);          -- Master Resp Array

begin  -- architecture rtl


  -- Instancation of the AXI4 Lite Slave interface
  i_axi4_lite_slave_itf_0 : entity lib_axi4_lite.axi4_lite_slave_itf
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_s,
      awaddr  => awaddr_s,
      awprot  => awprot_s,
      awready => awready_s,

      -- Write Data Channel
      wvalid => wvalid_s,
      wdata  => wdata_s,
      wstrb  => wstrb_s,
      wready => wready_s,

      -- Write Response Channel
      bready => bready_s,
      bvalid => bvalid_s,
      bresp  => bresp_s,

      -- Read Address Channel
      arvalid => arvalid_s,
      araddr  => araddr_s,
      arprot  => arprot_s,
      arready => arready_s,

      -- Read Data Channel
      rready => rready_s,
      rvalid => rvalid_s,
      rdata  => rdata_s,
      rresp  => rresp_s,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status
      );



  -- purpose: Address Decoder
  -- Generate an unsigned value in function of the slv_addr
  p_addr_decoder : process (slv_addr) is
  begin  -- process p_addr_decoder

    for i in 0 to G_SLAVE_NB - 1 loop

      -- Selection of the Slave Index in function of the slv_addr
      if(unsigned(slv_addr) >= unsigned(C_SLV_ADDR_MIN_ARRAY(i)) and unsigned(slv_addr) < unsigned(C_SLV_ADDR_MAX_ARRAY(i))) then
        sel_idx_comb <= to_unsigned(i, sel_idx_comb'length);
      end if;

    end loop;

  end process p_addr_decoder;

  -- purpose: Check if the address range is valid
  -- If the slv_addr is greater than C_SLV_ADDR_MAX_ARRAY(G_SLAVE_NB-1), the valid signal is not set
  p_addr_decoder_valid : process (slv_addr) is
  begin  -- process p_addr_decoder_valid

    if(unsigned(slv_addr) >= unsigned(C_SLV_ADDR_MIN_ARRAY(0)) and unsigned(slv_addr) < unsigned(C_SLV_ADDR_MAX_ARRAY(G_SLAVE_NB-1))) then
      sel_idx_comb_valid <= '1';
    else
      sel_idx_comb_valid <= '0';
    end if;

  end process p_addr_decoder_valid;



  -- purpose: 
  p_route_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_route_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      start_master  <= (others => '0');
      addr_master   <= (others => (others => '0'));
      rnw_master    <= (others => '0');
      wdata_master  <= (others => (others => '0'));
      strobe_master <= (others => (others => '0'));
      sel_idx_latch <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On the Slave start and if the selection of the Slave is correct
      if(slv_start = '1' and sel_idx_comb_valid = '1') then

        start_master(to_integer(sel_idx_comb))  <= '1';
        addr_master(to_integer(sel_idx_comb))   <= slv_addr;
        rnw_master(to_integer(sel_idx_comb))    <= slv_rw;
        wdata_master(to_integer(sel_idx_comb))  <= slv_wdata;
        strobe_master(to_integer(sel_idx_comb)) <= slv_strobe;

        -- Latch the selected index
        sel_idx_latch <= sel_idx_comb;

      -- On the slave start and if the selecion is not correct
      -- Do not performed access to a master and drive response
      else

        start_master  <= (others => '0');
        addr_master   <= (others => (others => '0'));
        rnw_master    <= (others => '0');
        wdata_master  <= (others => (others => '0'));
        strobe_master <= (others => (others => '0'));
      end if;

    end if;
  end process p_route_mngt;


  -- Route master responses to slave

  -- purpose: Route Master Signals
  p_route_masters_signals : process (clk_sys, rst_n_sys) is
  begin  -- process p_route_masters_signals
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      slv_done   <= '0';
      slv_rdata  <= (others => '0');
      slv_status <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Check if the selected addr is uncorrect
      -- If it is -> Force the response and return DECERR
      if(slv_start = '1' and sel_idx_comb_valid = '0') then
        slv_done   <= '1';
        slv_rdata  <= (others => '0');
        slv_status <= "11";             -- RETURN DECERR
      else
        slv_done   <= done_master(to_integer(sel_idx_latch));
        slv_rdata  <= rdata_master(to_integer(sel_idx_latch));
        slv_status <= access_status_master(to_integer(sel_idx_latch));
      end if;

    end if;
  end process p_route_masters_signals;


  -- Instanciation of AXI4-Lite Masters
  -- There is one master per SLave Number
  g_axi4_lite_masters : for i in 0 to G_SLAVE_NB -1 generate

    i_axi4_lite_master_0 : entity lib_axi4_lite.axi4_lite_master
      generic map(
        G_DATA_WIDTH => G_AXI_DATA_WIDTH,
        G_ADDR_WIDTH => G_AXI_ADDR_WIDTH
        )
      port map(
        clk   => clk_sys,
        rst_n => rst_n_sys,

        start         => start_master(i),
        addr          => addr_master(i),
        rnw           => rnw_master(i),
        strobe        => strobe_master(i),
        master_wdata  => wdata_master(i),
        done          => done_master(i),
        master_rdata  => rdata_master(i),
        access_status => access_status_master(i),

        awvalid => awvalid_m(i),
        awaddr  => awaddr_m(i),
        awprot  => awprot_m(i),
        awready => awready_m(i),

        wvalid => wvalid_m(i),
        wdata  => wdata_m(i),
        wstrb  => wstrb_m(i),
        wready => wready_m(i),

        bready => bready_m(i),
        bvalid => bvalid_m(i),
        bresp  => bresp_m(i),

        arvalid => arvalid_m(i),
        araddr  => araddr_m(i),
        arprot  => arprot_m(i),
        arready => arready_m(i),

        rready => rready_m(i),
        rvalid => rvalid_m(i),
        rdata  => rdata_m(i),
        rresp  => rresp_m(i)
        );
  end generate;


end architecture rtl;
