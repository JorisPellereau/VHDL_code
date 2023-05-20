-------------------------------------------------------------------------------
-- Title      : Wrapper of the AXI4Lite Manager block of OSVVM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : osvvm_axi4lite_manager_wrapper.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-04
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
-- 2023-03-04  1.0      linux-jp        Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;
use ieee.math_real.all;

library osvvm_common;
use osvvm_common.AddressBusTransactionPkg.all;

library tb_lib_osvvm_axi4lite;
use tb_lib_osvvm_axi4lite.Axi4OptionsPkg.all;
use tb_lib_osvvm_axi4lite.Axi4ModelPkg.all;
use tb_lib_osvvm_axi4lite.Axi4InterfaceCommonPkg.all;
use tb_lib_osvvm_axi4lite.Axi4LiteInterfacePkg.all;
use tb_lib_osvvm_axi4lite.Axi4CommonPkg.all;

-- library osvvm;
--   context osvvm.OsvvmContext;
--   use osvvm.ScoreboardPkg_slv.all;

-- library osvvm_common;
-- context osvvm_common.OsvvmCommonContext;




entity osvvm_axi4lite_manager_wrapper is
  generic(
    MODEL_ID_NAME          : string                 := "MASTER_AXI4_Lite_";
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;
    tperiod_Clk            : time                   := 10 ns;
    DEFAULT_DELAY          : time                   := 1 ns;
    tpd_Clk_AWAddr         : time                   := 1 ns;
    tpd_Clk_AWProt         : time                   := 1 ns;
    tpd_Clk_AWValid        : time                   := 1 ns;
    tpd_Clk_WValid         : time                   := 1 ns;
    tpd_Clk_WData          : time                   := 1 ns;
    tpd_Clk_WStrb          : time                   := 1 ns;
    tpd_Clk_BReady         : time                   := 1 ns;
    tpd_Clk_ARValid        : time                   := 1 ns;
    tpd_Clk_ARProt         : time                   := 1 ns;
    tpd_Clk_ARAddr         : time                   := 1 ns;
    tpd_Clk_RReady         : time                   := 1 ns
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Write Address Channel signals
    awvalid : out std_logic;            -- Address Write Valid
    awaddr  : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : out std_logic_vector(2 downto 0);  -- Adress Write Prot
    awready : in  std_logic;            -- Address Write Ready

    -- Write Data Channel
    wvalid : out std_logic;             -- Write Data Valid
    wdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
    wstrb  : out std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);
    wready : in  std_logic;             -- Write data Ready

    -- Write Response Channel
    bready : out std_logic;                     -- Write Channel Response
    bvalid : in  std_logic;                     -- Write Response Channel Valid
    bresp  : in  std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid : out std_logic;            -- Read Channel Valid
    araddr  : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : out std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
    arready : in  std_logic;            -- Read Address Channel Ready

    -- Read Data Channel
    rready : out std_logic;             -- Read Data Channel Ready
    rvalid : in  std_logic;             -- Read Data Channel Valid
    rdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : in  std_logic_vector(1 downto 0)  -- Read Data Channel Response

    );
end entity osvvm_axi4lite_manager_wrapper;

architecture rtl of osvvm_axi4lite_manager_wrapper is
--tb_lib_osvvm_axi4lite.Axi4LiteInterfacePkg.
  -- == INTERNALS Signals ==
  signal axibus : Axi4LiteRecType (
    WriteAddress(Addr (G_AXI4_LITE_ADDR_WIDTH-1 downto 0)),
    WriteData (Data (G_AXI4_LITE_DATA_WIDTH-1 downto 0),
               Strb((G_AXI4_LITE_DATA_WIDTH/8)-1 downto 0)),
--               WriteResponse (((G_AXI4_LITE_DATA_WIDTH/8)-1 downto 0)),
    ReadAddress (Addr (G_AXI4_LITE_ADDR_WIDTH-1 downto 0)),
    ReadData (Data (G_AXI4_LITE_DATA_WIDTH-1 downto 0))
    );

  signal transrec : AddressBusRecType (
    Address (G_AXI4_LITE_ADDR_WIDTH-1 downto 0),
    DataToModel (G_AXI4_LITE_DATA_WIDTH-1 downto 0),
    DataFromModel(G_AXI4_LITE_DATA_WIDTH-1 downto 0)
    );


  -- Interface with Tesbench Module
  signal wr_req : std_logic := '0';
  signal rd_req : std_logic := '0';

  -- MASTER AXI4 Configuration
  signal start_config      : std_logic := '0';
  signal config_done       : std_logic := '0';
  signal config_param_int  : integer   := 0;
  signal config_param_bool : boolean   := false;
  signal config_nb         : integer   := 0;  -- Configuration number
  -- 0 : WRITE_ADDRESS_VALID_DELAY_CYCLES    - Value type : integer
  -- 1 : WRITE_DATA_VALID_DELAY_CYCLES       - Value type : integer
  -- 2 : WRITE_DATA_VALID_BURST_DELAY_CYCLES - Value type : integer
  -- 3 : READ_ADDRESS_VALID_DELAY_CYCLES     - Value type : integer
  -- 4 : WRITE_RESPONSE_READY_BEFORE_VALID   - Value type : boolean
  -- 5 : READ_DATA_READY_BEFORE_VALID        - Value type : boolean
  -- 6 : WRITE_RESPONSE_READY_DELAY_CYCLES   - Value type : integer
  -- 7 : READ_DATA_READY_DELAY_CYCLES        - Value type : integer
  -- 8 : WRITE_ADDRESS_READY_TIME_OUT        - Value type : integer
  -- 9 : WRITE_DATA_READY_TIME_OUT           - Value type : integer
  -- 10 : READ_ADDRESS_READY_TIME_OUT        - Value type : integer
  -- 11 : WRITE_RESPONSE_VALID_TIME_OUT      - Value type : integer
  -- 12 : READ_DATA_VALID_TIME_OUT           - Value type : integer

  signal axi_data : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0) := (others => '0');
  signal axi_addr : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0) := (others => '0');

begin  -- architecture rtl


  i_Axi4LiteManager_0 : entity tb_lib_osvvm_axi4lite.Axi4LiteManager
    generic map (
      MODEL_ID_NAME   => MODEL_ID_NAME,
      tperiod_Clk     => tperiod_Clk,
      DEFAULT_DELAY   => DEFAULT_DELAY,
      tpd_Clk_AWAddr  => tpd_Clk_AWAddr,
      tpd_Clk_AWProt  => tpd_Clk_AWProt,
      tpd_Clk_AWValid => tpd_Clk_AWValid,
      tpd_Clk_WValid  => tpd_Clk_WValid,
      tpd_Clk_WData   => tpd_Clk_WData,
      tpd_Clk_WStrb   => tpd_Clk_WStrb,
      tpd_Clk_BReady  => tpd_Clk_BReady,
      tpd_Clk_ARValid => tpd_Clk_ARValid,
      tpd_Clk_ARProt  => tpd_Clk_ARProt,
      tpd_Clk_ARAddr  => tpd_Clk_ARAddr,
      tpd_Clk_RReady  => tpd_Clk_RReady
      )
    port map (
      Clk    => clk,
      nReset => rst_n,

      -- AXI Manager Functional Interface
      AxiBus => axibus,

      -- Testbench Transaction Interface
      TransRec => transrec
      );


  -- AXIBUS to AXI IN/OUT
  -- Write Address Channel
  awvalid                   <= axibus.WriteAddress.Valid;
  awaddr                    <= axibus.WriteAddress.Addr;
  awprot                    <= axibus.WriteAddress.Prot;
  axibus.WriteAddress.Ready <= awready;

  -- Write Data Channel
  wvalid                 <= axibus.WriteData.Valid;
  wdata                  <= axibus.WriteData.Data;
  wstrb                  <= axibus.WriteData.Strb;
  axibus.WriteData.Ready <= wready;

  -- Write Response Channel
  bready                     <= axibus.WriteResponse.Ready;
  axibus.WriteResponse.Valid <= bvalid;
  axibus.WriteResponse.Resp  <= bresp;

  -- Read Address Channel
  arvalid                  <= axibus.ReadAddress.Valid;
  araddr                   <= axibus.ReadAddress.Addr;
  arprot                   <= axibus.ReadAddress.Prot;
  axibus.ReadAddress.Ready <= arready;

  -- Read Data Channel
  rready                <= axibus.ReadData.Ready;
  axibus.ReadData.Valid <= rvalid;
  axibus.ReadData.Data  <= rdata;
  axibus.ReadData.Resp  <= rresp;

  -- == AXI4Lite Procedure Control =


  -- purpose: Set the configuration of AXI4 Manager
  p_axi4_config : process is
  begin  -- process p_axi4_config

    wait until rising_edge(start_config);

    case config_nb is

      when 0 =>
        SetAxi4Options(transrec, WRITE_ADDRESS_VALID_DELAY_CYCLES, config_param_int);

      when 1 =>
        SetAxi4Options(transrec, WRITE_DATA_VALID_DELAY_CYCLES, config_param_int);

      when 2 =>
        SetAxi4Options(transrec, WRITE_DATA_VALID_BURST_DELAY_CYCLES, config_param_int);

      when 3 =>
        SetAxi4Options(transrec, READ_ADDRESS_VALID_DELAY_CYCLES, config_param_int);

      when 4 =>
        SetAxi4Options(transrec, WRITE_RESPONSE_READY_BEFORE_VALID, config_param_bool);

      when 5 =>
        SetAxi4Options(transrec, READ_DATA_READY_BEFORE_VALID, config_param_bool);

      when 6 =>
        SetAxi4Options(transrec, WRITE_RESPONSE_READY_DELAY_CYCLES, config_param_int);

      when 7 =>
        SetAxi4Options(transrec, READ_DATA_READY_DELAY_CYCLES, config_param_int);

      when 8 =>
        SetAxi4Options(transrec, WRITE_ADDRESS_READY_TIME_OUT, config_param_int);

      when 9 =>
        SetAxi4Options(transrec, WRITE_DATA_READY_TIME_OUT, config_param_int);

      when 10 =>
        SetAxi4Options(transrec, READ_ADDRESS_READY_TIME_OUT, config_param_int);

      when 11 =>
        SetAxi4Options(transrec, WRITE_RESPONSE_VALID_TIME_OUT, config_param_int);

      when 12 =>
        SetAxi4Options(transrec, READ_DATA_VALID_TIME_OUT, config_param_int);


      when others => null;
    end case;
    config_done <= not config_done;
    
  end process p_axi4_config;

  p_axi4_write : process is
  begin  -- process p_axi4_write
    wait until rising_edge(wr_req);
    if(wr_req = '1') then
      Write(transrec, axi_addr, axi_data);
    end if;

  end process p_axi4_write;

  p_axi4_read : process is
  begin  -- process p_axi4_read
    wait until rising_edge(rd_req);
    if(rd_req = '1') then
      ReadCheck(transrec, axi_addr, axi_data);
    end if;
  end process p_axi4_read;


end architecture rtl;
