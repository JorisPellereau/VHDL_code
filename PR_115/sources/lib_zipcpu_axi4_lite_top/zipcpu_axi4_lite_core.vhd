-------------------------------------------------------------------------------
-- Title      : Core of JTAG AXI4 Lite
-- Project    : 
-------------------------------------------------------------------------------
-- File       : jtag_axi4_lite_core.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-18
-- Last update: 2023-09-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
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
use lib_axi4_lite.pkg_axi4_lite_interco_cutom.all;
use lib_axi4_lite.pkg_axi4_lite_interco.all;

library lib_axi4_lite_7seg;
library lib_axi4_lite_lcd;
library lib_jtag_axi4_lite_top;

entity jtag_axi4_lite_core is
  generic (
    G_AXI_DATA_WIDTH      : integer range 32 to 64 := 32;    -- AXI DATA WIDTH
    G_AXI_ADDR_WIDTH      : integer range 8 to 64  := 16;    -- AXI ADDR WIDTH
    G_SLAVE_NB            : integer range 2 to 16  := 2;     -- Number of AXI4 Lite Slave
    G_CLK_PERIOD_NS       : integer                := 20;    -- Clock Period in ns
    G_BIDIR_POLARITY_READ : std_logic              := '0';   -- BIDIR SEL Polarity
    G_FIFO_ADDR_WIDTH     : integer                := 10;    -- FIFO ADDR WIDTH
    G_SIMULATION          : boolean                := false  -- Simulation Purpose
    );
  port (
    clk_sys   : in std_logic;                                -- Clock System
    rst_n_sys : in std_logic;                                -- Asynchronous Reset

    -- 7 Segments
    o_seg0 : out std_logic_vector(6 downto 0);  -- SEG 0
    o_seg1 : out std_logic_vector(6 downto 0);  -- SEG 1
    o_seg2 : out std_logic_vector(6 downto 0);  -- SEG 2
    o_seg3 : out std_logic_vector(6 downto 0);  -- SEG 3
    o_seg4 : out std_logic_vector(6 downto 0);  -- SEG 4
    o_seg5 : out std_logic_vector(6 downto 0);  -- SEG 5
    o_seg6 : out std_logic_vector(6 downto 0);  -- SEG 6
    o_seg7 : out std_logic_vector(6 downto 0);  -- SEG 7

    -- LCD I/F
    i_lcd_data  : in  std_logic_vector(7 downto 0);  -- Data from LCD
    o_lcd_wdata : out std_logic_vector(7 downto 0);  -- LCD WData    
    o_lcd_rw    : out std_logic;                     -- R/W command
    o_lcd_en    : out std_logic;                     -- LCD Enable
    o_lcd_rs    : out std_logic;                     -- LCD RS
    o_lcd_on    : out std_logic;                     -- LCD ON Management
    o_bidir_sel : out std_logic;                     -- Bidir Selector

    -- RED LEDS
    ledr : out std_logic_vector(17 downto 0);  -- RED LEDS

    -- GREEN LEDS
    ledg : out std_logic_vector(8 downto 0)  -- GREEN LEDS
    );

end entity jtag_axi4_lite_core;

architecture rtl of jtag_axi4_lite_core is

  -- == COMPONENTS ==

  -- Component Altera VJTAG with 6 IR length
  component altera_vjtag is
    port (
      tdi                : out std_logic;                                        -- tdi
      tdo                : in  std_logic                    := 'X';              -- tdo
      ir_in              : out std_logic_vector(7 downto 0);                     -- ir_in
      ir_out             : in  std_logic_vector(7 downto 0) := (others => 'X');  -- ir_out
      virtual_state_cdr  : out std_logic;                                        -- virtual_state_cdr
      virtual_state_sdr  : out std_logic;                                        -- virtual_state_sdr
      virtual_state_e1dr : out std_logic;                                        -- virtual_state_e1dr
      virtual_state_pdr  : out std_logic;                                        -- virtual_state_pdr
      virtual_state_e2dr : out std_logic;                                        -- virtual_state_e2dr
      virtual_state_udr  : out std_logic;                                        -- virtual_state_udr
      virtual_state_cir  : out std_logic;                                        -- virtual_state_cir
      virtual_state_uir  : out std_logic;                                        -- virtual_state_uir
      tck                : out std_logic                                         -- clk
      );
  end component altera_vjtag;

  component vjtag_intf is

    generic (
      G_DATA_WIDTH : integer range 1 to 32 := 32;  -- DAta Width
      G_ADDR_WIDTH : integer range 8 to 32 := 32;
      G_IR_WIDTH   : integer range 8 to 24 := 8);  -- VJTAG IR Width
    port (
      clk_jtag   : in std_logic;                   -- JTAG Clock
      rst_n_jtag : in std_logic;                   -- Asynchronous Reset

      tdi   : in  std_logic;                                  -- TDI Data from Virtual JTAG
      tdo   : out std_logic;                                  -- TDO Data to Virtual JTAG
      ir_in : in  std_logic_vector(G_IR_WIDTH - 1 downto 0);  -- IR IN Vector
      sdr   : in  std_logic;                                  -- SDR state from Virtual JTAG
      udr   : in  std_logic;                                  -- UDR state from Virtual JTAG
      cdr   : in  std_logic;                                  -- CDR statue from Virtual JTAG

      addr          : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);      -- Addr
      data_out      : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);      -- Data out
      data_in       : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);      -- DATA IN to read
      data_in_val   : in  std_logic;                                        -- Data in Valid
      access_status : in  std_logic_vector(1 downto 0);                     -- Access status
      rnw           : out std_logic;                                        -- Read not Write signal
      strobe        : out std_logic_vector((G_DATA_WIDTH/8) - 1 downto 0);  -- Strobe signal
      start         : out std_logic);

  end component vjtag_intf;

  -- component axi4_lite_master is

  --   generic (
  --     G_DATA_WIDTH : integer range 8 to 32 := 32;   -- DATA WIDTH
  --     G_ADDR_WIDTH : integer range 8 to 32 := 32);  -- ADDR WIDTH

  --   port(

  --     clk   : in std_logic;             -- Clock system
  --     rst_n : in std_logic;             -- Asynchronous Reset

  --     start         : in  std_logic;                                          -- Start the access
  --     addr          : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);        -- Addr of the access
  --     rnw           : in  std_logic;                                          -- Read ('1') or Write ('0') access
  --     strobe        : in  std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe
  --     master_wdata  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- Write Data
  --     done          : out std_logic;                                          -- Access done
  --     master_rdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- Read Data
  --     access_status : out std_logic_vector(1 downto 0);                       -- Access Status

  --     awvalid : out std_logic;                                    -- Address Write Valid
  --     awaddr  : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Address Write    
  --     awprot  : out std_logic_vector(2 downto 0);                 -- Adress Write Prot
  --     awready : in  std_logic;                                    -- Address Write Ready

  --     wvalid : out std_logic;                                    -- Write Data Valid
  --     wdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Write Data
  --     wstrb  : out std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);
  --     wready : in  std_logic;                                    -- Write data Ready

  --     bready : out std_logic;                     -- Write Channel Response
  --     bvalid : in  std_logic;                     -- Write Response Channel Valid
  --     bresp  : in  std_logic_vector(1 downto 0);  -- Write Response Channel resp

  --     arvalid : out std_logic;                                    -- Read Channel Valid
  --     araddr  : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  --     arprot  : out std_logic_vector(2 downto 0);                 --  Read Address channel Ready Prot
  --     arready : in  std_logic;                                    -- Read Address Channel Ready

  --     rready : out std_logic;                                    -- Read Data Channel Ready
  --     rvalid : in  std_logic;                                    -- Read Data Channel Valid
  --     rdata  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  --     rresp  : in  std_logic_vector(1 downto 0)                  -- Read Data Channel Resp
  --     );
  -- end component axi4_lite_master;

  -- component axi4_lite_slave_itf is

  --   generic (
  --     G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
  --     G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32   -- AXI4 Lite DATA WIDTH
  --     );
  --   port (
  --     clk   : in std_logic;                                   -- Clock
  --     rst_n : in std_logic;                                   -- Asynchronous Reset

  --     -- Write Address Channel signals
  --     awvalid : in  std_logic;                                              -- Address Write Valid
  --     awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
  --     awprot  : in  std_logic_vector(2 downto 0);                           -- Adress Write Prot
  --     awready : out std_logic;                                              -- Address Write Ready

  --     -- Write Data Channel
  --     wvalid : in  std_logic;                                                    -- Write Data Valid
  --     wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);        -- Write Data
  --     wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  --     wready : out std_logic;                                                    -- Write data Ready

  --     -- Write Response Channel
  --     bready : in  std_logic;                     -- Write Channel Response
  --     bvalid : out std_logic;                     -- Write Response Channel Valid
  --     bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

  --     -- Read Address Channel
  --     arvalid : in  std_logic;                                              -- Read Channel Valid
  --     araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  --     arprot  : in  std_logic_vector(2 downto 0);                           --  Read Address channel Ready Prot
  --     arready : out std_logic;                                              -- Read Address Channel Ready

  --     -- Read Data Channel
  --     rready : in  std_logic;                                              -- Read Data Channel Ready
  --     rvalid : out std_logic;                                              -- Read Data Channel Valid
  --     rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  --     rresp  : out std_logic_vector(1 downto 0);                           -- Read Data Channel Response

  --     -- Slave Registers Interface
  --     slv_start  : out std_logic;                                                    -- Start the access
  --     slv_rw     : out std_logic;                                                    -- Read or write access
  --     slv_addr   : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);        -- Slave Addr
  --     slv_wdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);        -- Slave Write Data
  --     slv_strobe : out std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

  --     slv_done   : in std_logic;                                              -- Slave access done
  --     slv_rdata  : in std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
  --     slv_status : in std_logic_vector(1 downto 0)                            -- Slave status        
  --     );

  -- end component axi4_lite_slave_itf;

  -- component axi4_lite_7segs is
  --   generic (
  --     G_AXI4_LITE_ADDR_WIDTH : integer range 8 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
  --     G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32   -- AXI4 Lite DATA WIDTH
  --     );
  --   port (
  --     clk   : in std_logic;                                   -- Clock
  --     rst_n : in std_logic;                                   -- Asynchronous Reset

  --     -- Write Address Channel signals
  --     awvalid : in  std_logic;                                              -- Address Write Valid
  --     awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
  --     awprot  : in  std_logic_vector(2 downto 0);                           -- Adress Write Prot
  --     awready : out std_logic;                                              -- Address Write Ready

  --     -- Write Data Channel
  --     wvalid : in  std_logic;                                                    -- Write Data Valid
  --     wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);        -- Write Data
  --     wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  --     wready : out std_logic;                                                    -- Write data Ready

  --     -- Write Response Channel
  --     bready : in  std_logic;                     -- Write Channel Response
  --     bvalid : out std_logic;                     -- Write Response Channel Valid
  --     bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

  --     -- Read Address Channel
  --     arvalid : in  std_logic;                                              -- Read Channel Valid
  --     araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  --     arprot  : in  std_logic_vector(2 downto 0);                           --  Read Address channel Ready Prot
  --     arready : out std_logic;                                              -- Read Address Channel Ready

  --     -- Read Data Channel
  --     rready : in  std_logic;                                              -- Read Data Channel Ready
  --     rvalid : out std_logic;                                              -- Read Data Channel Valid
  --     rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  --     rresp  : out std_logic_vector(1 downto 0);                           -- Read Data Channel Response

  --     -- 7 Segments
  --     o_seg0 : out std_logic_vector(6 downto 0);  -- SEG 0
  --     o_seg1 : out std_logic_vector(6 downto 0);  -- SEG 1
  --     o_seg2 : out std_logic_vector(6 downto 0);  -- SEG 2
  --     o_seg3 : out std_logic_vector(6 downto 0);  -- SEG 3
  --     o_seg4 : out std_logic_vector(6 downto 0);  -- SEG 4
  --     o_seg5 : out std_logic_vector(6 downto 0);  -- SEG 5
  --     o_seg6 : out std_logic_vector(6 downto 0);  -- SEG 6
  --     o_seg7 : out std_logic_vector(6 downto 0)   -- SEG 7
  --     );

  -- end component axi4_lite_7segs;

  component bit_extender is
    generic (
      G_PULSE_WIDTH : positive := 10);  -- Extended Pulse Width
    port (
      clk_sys   : in  std_logic;        -- Clock system
      rst_n     : in  std_logic;        -- Asynchronous Reset
      pulse_in  : in  std_logic;        -- Input pulse to extend
      pulse_out : out std_logic);       -- Output Extended Pulse
  end component bit_extender;


  -- == INTERNAL Signals ==
  --Signals and registers declared for VJI instance
  signal tck   : std_logic;
  signal tdi   : std_logic;
  signal tdo   : std_logic;
  signal cdr   : std_logic;
  signal e1dr  : std_logic;
  signal e2dr  : std_logic;
  signal pdr   : std_logic;
  signal sdr   : std_logic;
  signal udr   : std_logic;
  signal uir   : std_logic;
  signal cir   : std_logic;
  signal ir_in : std_logic_vector(7 downto 0);

--  signal rst_n_synch : std_logic;


  -- VJTAG Signals
  signal start_clk_jtag     : std_logic;
  signal addr_vjtag         : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);
  signal rnw                : std_logic;
  signal strobe             : std_logic_vector((G_AXI_DATA_WIDTH/8) - 1 downto 0);
  signal master_wdata_vjtag : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);
  signal master_rdata       : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);
  signal access_status      : std_logic_vector(1 downto 0);
  signal master_wdata       : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);
  signal start_master       : std_logic;  -- Start Master
  signal addr_master        : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);
  signal rnw_master         : std_logic;
  signal strobe_master      : std_logic_vector((G_AXI_DATA_WIDTH/8) - 1 downto 0);

  -- # AXI4 Lite MASTER signals --
  -- Write Address Channel signals
  signal awvalid_master : std_logic;                                        -- Address Write Valid
  signal awaddr_master  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_master  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_master : std_logic;                                        -- Address Write Ready

  -- Write Data Channel
  signal wvalid_master : std_logic;                                              -- Write Data Valid
  signal wdata_master  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_master  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_master : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_master : std_logic;                     -- Write Channel Response
  signal bvalid_master : std_logic;                     -- Write Response Channel Valid
  signal bresp_master  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_master : std_logic;                                        -- Read Channel Valid
  signal araddr_master  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_master  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_master : std_logic;                                        -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_master : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_master : std_logic;                                        -- Read Data Channel Valid
  signal rdata_master  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_master  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------


  -- # AXI4 Lite LCD signals --
  -- Write Address Channel signals
  signal awvalid_lcd : std_logic;                                        -- Address Write Valid
  signal awaddr_lcd  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_lcd  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_lcd : std_logic;                                        -- Address Write Ready

  -- Write Data Channel
  signal wvalid_lcd : std_logic;                                              -- Write Data Valid
  signal wdata_lcd  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_lcd  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_lcd : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_lcd : std_logic;                     -- Write Channel Response
  signal bvalid_lcd : std_logic;                     -- Write Response Channel Valid
  signal bresp_lcd  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_lcd : std_logic;                                        -- Read Channel Valid
  signal araddr_lcd  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_lcd  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_lcd : std_logic;                                        -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_lcd : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_lcd : std_logic;                                        -- Read Data Channel Valid
  signal rdata_lcd  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_lcd  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

  -- # AXI4 Lite 7 SEGS signals --
  -- Write Address Channel signals
  signal awvalid_7segs : std_logic;                                        -- Address Write Valid
  signal awaddr_7segs  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_7segs  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_7segs : std_logic;                                        -- Address Write Ready

  -- Write Data Channel
  signal wvalid_7segs : std_logic;                                              -- Write Data Valid
  signal wdata_7segs  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_7segs  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_7segs : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_7segs : std_logic;                     -- Write Channel Response
  signal bvalid_7segs : std_logic;                     -- Write Response Channel Valid
  signal bresp_7segs  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_7segs : std_logic;                                        -- Read Channel Valid
  signal araddr_7segs  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_7segs  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_7segs : std_logic;                                        -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_7segs : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_7segs : std_logic;                                        -- Read Data Channel Valid
  signal rdata_7segs  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_7segs  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

  -- # AXI4 Lite Interconnect Masters signals
  signal awvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Address Write Valid
  signal awaddr_interco_m  : t_addr_array(0 to G_SLAVE_NB - 1);          -- Address Write    
  signal awprot_interco_m  : t_prot_array(0 to G_SLAVE_NB - 1);          -- Adress Write Prot
  signal awready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Address Write Ready

  signal wvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Data Valid
  signal wdata_interco_m  : t_data_array(0 to G_SLAVE_NB - 1);          -- Write Data
  signal wstrb_interco_m  : t_wstrb_array(0 to G_SLAVE_NB - 1);
  signal wready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write data Ready

  signal bready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Channel Response
  signal bvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Response Channel Valid
  signal bresp_interco_m  : t_resp_array(0 to G_SLAVE_NB - 1);          -- Write Response Channel resp

  signal arvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Channel Valid
  signal araddr_interco_m  : t_addr_array(0 to G_SLAVE_NB - 1);          -- Read Address channel Ready
  signal arprot_interco_m  : t_prot_array(0 to G_SLAVE_NB - 1);          -- Read Address channel Ready Prot
  signal arready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Address Channel Ready

  signal rready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Data Channel Ready
  signal rvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Data Channel Valid
  signal rdata_interco_m  : t_data_array(0 to G_SLAVE_NB - 1);          -- Read Data Channel rdata
  signal rresp_interco_m  : t_resp_array(0 to G_SLAVE_NB - 1);          -- Read Data Channel Resp
  -- # ----------------------


  signal start_clk    : std_logic;      -- Start in CLK clock domain
  signal start_clk_p1 : std_logic;      -- Start in CLK clock domain
  signal start_clk_p2 : std_logic;      -- Start in CLK clock domain

  signal start_clk_r_edge : std_logic;  -- Rising Edge of start

  signal done_master   : std_logic;     -- Done signal in clk clock domain
  signal done_extended : std_logic;     -- Done signal extended in clk clock domain


  signal done_extended_clk_jtag_p1     : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag_p2     : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag        : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag_r_edge : std_logic;  -- rising edge

  signal ledr_int   : std_logic_vector(17 downto 0);  -- RED LEDS
  signal shift_reg  : std_logic_vector(31 downto 0);  -- Get TDI data
  signal lcd_on_int : std_logic;                      -- Internal LCD ON

begin  -- architecture rtl

  -- Instanciation of VIRTUAL JTAG Controller
  -- Generated from Quartus II
  i_altera_vjtag_0 : altera_vjtag
    port map (
      tdo                => tdo,
      tck                => tck,
      tdi                => tdi,
      ir_in              => ir_in(7 downto 0),
      ir_out             => open,
      virtual_state_cdr  => cdr,
      virtual_state_e1dr => e1dr,
      virtual_state_e2dr => e2dr,
      virtual_state_pdr  => pdr,
      virtual_state_sdr  => sdr,
      virtual_state_udr  => udr,
      virtual_state_uir  => uir,
      virtual_state_cir  => cir
      );



-- Instanciation of VRITUAL JTAG Interface
-- TCK JTAG has a maximal frequency of 10MHz and may vary
  i_vjtag_intf_0 : vjtag_intf
    generic map (
      G_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
      G_IR_WIDTH   => 8
      )
    port map(
      clk_jtag   => tck,
      rst_n_jtag => rst_n_sys,          --'1',                -- TBD pas de reset ..

      tdi   => tdi,
      tdo   => tdo,
      ir_in => ir_in(7 downto 0),
      sdr   => sdr,
      udr   => udr,
      cdr   => cdr,

      addr          => addr_vjtag,
      data_out      => master_wdata_vjtag,
      data_in       => master_rdata,
      data_in_val   => done_extended_clk_jtag_r_edge,
      access_status => access_status,   -- not resynchronized in clk_jtag clock domain /!\
      rnw           => rnw,             -- not resynchronized in clk_jtag clock domain /!\
      strobe        => strobe,          -- not resynchronized in clk_jtag clock domain /!\
      start         => start_clk_jtag
      );





-- purpose: LEDR Update
  p_ledr_mngt : process (tck, rst_n_sys) is
  begin  -- process p_ledr_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      ledr_int <= (others => '0');
    elsif rising_edge(tck) then         -- rising clock edge

      if(udr = '1') then
        ledr_int <= shift_reg(17 downto 0);
      end if;

    end if;
  end process p_ledr_mngt;

  -- purpose: Shift REG
  p_shift_reg : process (tck, rst_n_sys) is
  begin  -- process p_shift_reg
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      shift_reg <= (others => '0');
    elsif rising_edge(tck) then         -- rising clock edge
      if(sdr = '1') then
        --shift_reg <= shift_reg(31 - 1 downto 0) & tdi;
        shift_reg <= tdi & shift_reg(31 downto 1);
      end if;

    end if;
  end process p_shift_reg;

  -- purpose: LEDG Mngt
  p_ledg_mngt : process (tck, rst_n_sys) is
  begin  -- process p_ledg_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      ledg(7 downto 0) <= (others => '0');
    elsif rising_edge(tck) then         -- rising clock edge
      ledg(7 downto 0) <= ir_in(7 downto 0);
    end if;
  end process p_ledg_mngt;

  -- purpose: Double resynchronization of start_clk_jtag in clk clock domain
  p_resynch_start : process (clk_sys, rst_n_sys) is
  begin  -- process p_resynch_start
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      start_clk_p1 <= '0';
      start_clk_p2 <= '0';
      start_clk    <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      start_clk_p1 <= start_clk_jtag;
      start_clk_p2 <= start_clk_p1;
      start_clk    <= start_clk_p2;
    end if;
  end process p_resynch_start;

  -- Rising edge detection of start
  start_clk_r_edge <= start_clk_p2 and not start_clk;

  --strobe <= (others => '0');            -- Not Used


  -- purpose: Resynchronization in tck clock domain of the signal done_extended
  p_ressynch_done_extended : process (tck, rst_n_sys) is
  begin  -- process p_ressynch_done_extended
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      done_extended_clk_jtag_p1 <= '0';
      done_extended_clk_jtag_p2 <= '0';
      done_extended_clk_jtag    <= '0';
    elsif rising_edge(tck) then         -- rising clock edge
      done_extended_clk_jtag_p1 <= done_extended;
      done_extended_clk_jtag_p2 <= done_extended_clk_jtag_p1;
      done_extended_clk_jtag    <= done_extended_clk_jtag_p2;
    end if;
  end process p_ressynch_done_extended;


  done_extended_clk_jtag_r_edge <= done_extended_clk_jtag_p2 and not done_extended_clk_jtag;


  -- Instanciation of bit extender
  -- Extender the pulse done_master in x width in order to be detected in the
  -- slower clock domain clk_jtag
  i_bit_extender_0 : bit_extender
    generic map(
      G_PULSE_WIDTH => 2*5
      )
    port map (
      clk_sys   => clk_sys,
      rst_n     => rst_n_sys,
      pulse_in  => done_master,
      pulse_out => done_extended
      );

  -- Bypass
  -- Force to '0' inputs of AXI4 Lite Master
  -- Theses inputs will be drived by the testbench
  g_bypass_altera_vjtag : if(G_SIMULATION = true) generate

  end generate;

  -- NO BYPASS
  -- Connect Signals from vjtag to AXI4 Lite Master
  g_no_bypass_altera_vjtag : if(G_SIMULATION = false) generate
    start_master  <= start_clk_r_edge;
    addr_master   <= addr_vjtag;
    rnw_master    <= rnw;
    strobe_master <= strobe;
    master_wdata  <= master_wdata_vjtag;
  end generate;

  -- Instanciation of AXI4 LITE MASTER
  i_axi4_lite_master_0 : entity lib_axi4_lite.axi4_lite_master
    generic map(
      G_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_ADDR_WIDTH => G_AXI_ADDR_WIDTH
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      start         => start_master,
      addr          => addr_master,
      rnw           => rnw_master,
      strobe        => strobe_master,
      master_wdata  => master_wdata,
      done          => done_master,
      master_rdata  => master_rdata,
      access_status => access_status,

      awvalid => awvalid_master,
      awaddr  => awaddr_master,
      awprot  => awprot_master,
      awready => awready_master,

      wvalid => wvalid_master,
      wdata  => wdata_master,
      wstrb  => wstrb_master,
      wready => wready_master,

      bready => bready_master,
      bvalid => bvalid_master,
      bresp  => bresp_master,

      arvalid => arvalid_master,
      araddr  => araddr_master,
      arprot  => arprot_master,
      arready => arready_master,

      rready => rready_master,
      rvalid => rvalid_master,
      rdata  => rdata_master,
      rresp  => rresp_master
      );

  -- AXI4 Lite Interconnect
  i_axi4_lite_interco_1_to_n : entity lib_axi4_lite.axi4_lite_interco_1_to_n
    generic map (
      G_AXI_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_AXI_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
      G_SLAVE_NB       => G_SLAVE_NB
      )
    port map (
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- SLAVE INTERFACE

      -- Write Address Channel signals
      awvalid_s => awvalid_master,
      awaddr_s  => awaddr_master,
      awprot_s  => awprot_master,
      awready_s => awready_master,

      -- Write Data Channel
      wvalid_s => wvalid_master,
      wdata_s  => wdata_master,
      wstrb_s  => wstrb_master,
      wready_s => wready_master,

      -- Write Response Channel
      bready_s => bready_master,
      bvalid_s => bvalid_master,
      bresp_s  => bresp_master,

      -- Read Address Channel
      arvalid_s => arvalid_master,
      araddr_s  => araddr_master,
      arprot_s  => arprot_master,
      arready_s => arready_master,

      -- Read Data Channel
      rready_s => rready_master,
      rvalid_s => rvalid_master,
      rdata_s  => rdata_master,
      rresp_s  => rresp_master,


      -- MASTERS Interface
      awvalid_m => awvalid_interco_m,
      awaddr_m  => awaddr_interco_m,
      awprot_m  => awprot_interco_m,
      awready_m => awready_interco_m,

      wvalid_m => wvalid_interco_m,
      wdata_m  => wdata_interco_m,
      wstrb_m  => wstrb_interco_m,
      wready_m => wready_interco_m,

      bready_m => bready_interco_m,
      bvalid_m => bvalid_interco_m,
      bresp_m  => bresp_interco_m,

      arvalid_m => arvalid_interco_m,
      araddr_m  => araddr_interco_m,
      arprot_m  => arprot_interco_m,
      arready_m => arready_interco_m,

      rready_m => rready_interco_m,
      rvalid_m => rvalid_interco_m,
      rdata_m  => rdata_interco_m,
      rresp_m  => rresp_interco_m
      );


  -- Interconnect Master's connected to AXI4 Lite Slave
  -- Index 0 -> AXI4 Lite 7SEGMENTS
  -- Index 1 -> AXI4 Lite LCD

  -- # - SEGMENTS Interconnexion
-- Write Addr Channel
  awvalid_7segs        <= awvalid_interco_m(0);
  awaddr_7segs         <= awaddr_interco_m(0);
  awprot_7segs         <= awprot_interco_m(0);
  awready_interco_m(0) <= awready_7segs;

  -- Write Data Channel
  wvalid_7segs        <= wvalid_interco_m(0);
  wdata_7segs         <= wdata_interco_m(0);
  wstrb_7segs         <= wstrb_interco_m(0);
  wready_interco_m(0) <= wready_7segs;

  -- Write Response Channem
  bready_7segs        <= bready_interco_m(0);
  bvalid_interco_m(0) <= bvalid_7segs;
  bresp_interco_m(0)  <= bresp_7segs;

  -- Read Addr Channel
  arvalid_7segs        <= arvalid_interco_m(0);
  araddr_7segs         <= araddr_interco_m(0);
  arprot_7segs         <= arprot_interco_m(0);
  arready_interco_m(0) <= arready_7segs;

  -- Read DAta Channel
  rready_7segs        <= rready_interco_m(0);
  rvalid_interco_m(0) <= rvalid_7segs;
  rdata_interco_m(0)  <= rdata_7segs;
  rresp_interco_m(0)  <= rresp_7segs;


  -- # - LCD Interconnexion
  -- Write Addr Channel
  awvalid_lcd          <= awvalid_interco_m(1);
  awaddr_lcd           <= awaddr_interco_m(1);
  awprot_lcd           <= awprot_interco_m(1);
  awready_interco_m(1) <= awready_lcd;

  -- Write Data Channel
  wvalid_lcd          <= wvalid_interco_m(1);
  wdata_lcd           <= wdata_interco_m(1);
  wstrb_lcd           <= wstrb_interco_m(1);
  wready_interco_m(1) <= wready_lcd;

  -- Write Response Channem
  bready_lcd          <= bready_interco_m(1);
  bvalid_interco_m(1) <= bvalid_lcd;
  bresp_interco_m(1)  <= bresp_lcd;

  -- Read Addr Channel
  arvalid_lcd          <= arvalid_interco_m(1);
  araddr_lcd           <= araddr_interco_m(1);
  arprot_lcd           <= arprot_interco_m(1);
  arready_interco_m(1) <= arready_lcd;

  -- Read DAta Channel
  rready_lcd          <= rready_interco_m(1);
  rvalid_interco_m(1) <= rvalid_lcd;
  rdata_interco_m(1)  <= rdata_lcd;
  rresp_interco_m(1)  <= rresp_lcd;


  -- Instanciation of AXI4 LITE 7 SEGMENT Controller
  i_axi4_lite_7segs_0 : entity lib_axi4_lite_7seg.axi4_lite_7segs
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH
      )
    port map (
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_7segs,
      awaddr  => awaddr_7segs,
      awprot  => awprot_7segs,
      awready => awready_7segs,

      -- Write Data Channel
      wvalid => wvalid_7segs,
      wdata  => wdata_7segs,
      wstrb  => wstrb_7segs,
      wready => wready_7segs,

      -- Write Response Channel
      bready => bready_7segs,
      bvalid => bvalid_7segs,
      bresp  => bresp_7segs,

      -- Read Address Channel
      arvalid => arvalid_7segs,
      araddr  => araddr_7segs,
      arprot  => arprot_7segs,
      arready => arready_7segs,

      -- Read Data Channel
      rready => rready_7segs,
      rvalid => rvalid_7segs,
      rdata  => rdata_7segs,
      rresp  => rresp_7segs,

      -- 7 Segments
      o_seg0 => o_seg0,
      o_seg1 => o_seg1,
      o_seg2 => o_seg2,
      o_seg3 => o_seg3,
      o_seg4 => o_seg4,
      o_seg5 => o_seg5,
      o_seg6 => o_seg6,
      o_seg7 => o_seg7
      );

  -- Instanciation of AXI4 Lite LCD
  i_axi4_lite_lcd_0 : entity lib_axi4_lite_lcd.axi4_lite_lcd
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_CLK_PERIOD_NS        => G_CLK_PERIOD_NS,
      G_BIDIR_POLARITY_READ  => G_BIDIR_POLARITY_READ,
      G_FIFO_ADDR_WIDTH      => G_FIFO_ADDR_WIDTH
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_lcd,
      awaddr  => awaddr_lcd,
      awprot  => awprot_lcd,
      awready => awready_lcd,

      -- Write Data Channel
      wvalid => wvalid_lcd,
      wdata  => wdata_lcd,
      wstrb  => wstrb_lcd,
      wready => wready_lcd,

      -- Write Response Channel
      bready => bready_lcd,
      bvalid => bvalid_lcd,
      bresp  => bresp_lcd,

      -- Read Address Channel
      arvalid => arvalid_lcd,
      araddr  => araddr_lcd,
      arprot  => arprot_lcd,
      arready => arready_lcd,

      -- Read Data Channel
      rready => rready_lcd,
      rvalid => rvalid_lcd,
      rdata  => rdata_lcd,
      rresp  => rresp_lcd,

      -- LCD I/F
      i_lcd_data  => i_lcd_data,
      o_lcd_wdata => o_lcd_wdata,
      o_lcd_rw    => o_lcd_rw,
      o_lcd_en    => o_lcd_en,
      o_lcd_rs    => o_lcd_rs,
      o_lcd_on    => lcd_on_int,
      o_bidir_sel => o_bidir_sel
      );


  -- Outputs
  ledr     <= ledr_int;
  o_lcd_on <= lcd_on_int;
  ledg(8)  <= lcd_on_int;

end architecture rtl;




