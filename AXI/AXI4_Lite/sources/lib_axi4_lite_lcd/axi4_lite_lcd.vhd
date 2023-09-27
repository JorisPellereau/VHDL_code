-------------------------------------------------------------------------------
-- Title      : AXI4 Lite LCD Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_lcd.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-17
-- Last update: 2023-09-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite LCD Controller - 32 Bits Data with 8 bits registers
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-17  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_axi4_lite;
library lib_axi4_lite_lcd;
library lib_CFAH1602_v2;

entity axi4_lite_lcd is
  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 10 to 64 := 10;   -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;   -- AXI4 Lite DATA WIDTH
    G_CLK_PERIOD_NS        : integer                := 20;   -- Clock Period in ns
    G_BIDIR_POLARITY_READ  : std_logic              := '0';  -- BIDIR SEL Polarity
    G_FIFO_ADDR_WIDTH      : integer                := 10    -- FIFO ADDR WIDTH
    );
  port (
    clk_sys   : in std_logic;                                -- System Clock
    rst_n_sys : in std_logic;                                -- Asynchronous Reset

    -- Write Address Channel signals
    awvalid : in  std_logic;                                              -- Address Write Valid
    awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : in  std_logic_vector(2 downto 0);                           -- Adress Write Prot
    awready : out std_logic;                                              -- Address Write Ready

    -- Write Data Channel
    wvalid : in  std_logic;                                                    -- Write Data Valid
    wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);        -- Write Data
    wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
    wready : out std_logic;                                                    -- Write data Ready

    -- Write Response Channel
    bready : in  std_logic;                     -- Write Channel Response
    bvalid : out std_logic;                     -- Write Response Channel Valid
    bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid : in  std_logic;                                              -- Read Channel Valid
    araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : in  std_logic_vector(2 downto 0);                           --  Read Address channel Ready Prot
    arready : out std_logic;                                              -- Read Address Channel Ready

    -- Read Data Channel
    rready : in  std_logic;                                              -- Read Data Channel Ready
    rvalid : out std_logic;                                              -- Read Data Channel Valid
    rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : out std_logic_vector(1 downto 0);                           -- Read Data Channel Response


    -- LCD I/F
    i_lcd_data  : in  std_logic_vector(7 downto 0);  -- Data from LCD
    o_lcd_wdata : out std_logic_vector(7 downto 0);  -- LCD WData    
    o_lcd_rw    : out std_logic;                     -- R/W command
    o_lcd_en    : out std_logic;                     -- LCD Enable
    o_lcd_rs    : out std_logic;                     -- LCD RS
    o_lcd_on    : out std_logic;                     -- LCD ON Management
    o_bidir_sel : out std_logic                      -- Bidir Selector
    );

end entity axi4_lite_lcd;

architecture rtl of axi4_lite_lcd is

  -- == INTERNAL Signals ==
  signal slv_start  : std_logic;                                                  -- Start the access
  signal slv_rw     : std_logic;                                                  -- Read or Write Access
  signal slv_addr   : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);      -- ADDR to reach
  signal slv_wdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Write Data
  signal slv_strobe : std_logic_vector((G_AXI4_LITE_DATA_WIDTH/8) - 1 downto 0);  -- Write Strobe
  signal slv_done   : std_logic;                                                  -- Access done
  signal slv_rdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Slave read data
  signal slv_status : std_logic_vector(1 downto 0);                               -- Slave status

  signal lcd_on              : std_logic;                     -- LCD ON
  signal func_set            : std_logic;                     -- Function Set Command
  signal cursor_disp_shift   : std_logic;                     -- Cursor or Display shift Command
  signal disp_on_off_ctrl    : std_logic;                     -- Display ON OFF Control
  signal entry_mode_set      : std_logic;                     -- Entry Mode Set command
  signal return_home         : std_logic;                     -- Return Home Command
  signal clear_disp          : std_logic;                     -- Clear Display Command
  signal update_all_lcd      : std_logic;                     -- UPDATE LCD Command
  signal update_one_char     : std_logic;                     -- UPDATE Once Char command
  signal char_position       : std_logic_vector(4 downto 0);  -- Char Position
  signal wr_en_fifo_display  : std_logic;                     -- Write Enable Data fifo display
  signal wdata_fifo_display  : std_logic_vector(7 downto 0);  -- Write Data FIFO Display
  signal dl_n_f              : std_logic_vector(2 downto 0);  -- DL N F Configuration
  signal dcb                 : std_logic_vector(2 downto 0);  -- DCB Configuration
  signal sc_rl               : std_logic_vector(1 downto 0);  -- SC RL Condifuration
  signal id_sh               : std_logic_vector(1 downto 0);  -- ID SH Configuration
  signal fifo_full_display   : std_logic;                     -- FIFO Full Display flag
  signal fifo_empty_display  : std_logic;                     -- FIFO Empty Display flag
  signal init_ongoing        : std_logic;                     -- Init ongoing flag
  signal single_cmd_ongoing  : std_logic;                     -- SINGLE Command ongoing
  signal update_disp_ongoing : std_logic;                     -- Update display ongoing

begin  -- architecture rtl

  -- Instanciation of AXI4 Lite Slave interface
  i_axi4_lite_slave_itf_0 : entity lib_axi4_lite.axi4_lite_slave_itf

    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid,
      awaddr  => awaddr,
      awprot  => awprot,
      awready => awready,

      -- Write Data Channel
      wvalid => wvalid,
      wdata  => wdata,
      wstrb  => wstrb,
      wready => wready,

      -- Write Response Channel
      bready => bready,
      bvalid => bvalid,
      bresp  => bresp,

      -- Read Address Channel
      arvalid => arvalid,
      araddr  => araddr,
      arprot  => arprot,
      arready => arready,

      -- Read Data Channel
      rready => rready,
      rvalid => rvalid,
      rdata  => rdata,
      rresp  => rresp,

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


  -- Instanciation of LCD REGISTERS
  i_axi4_lite_lcd_registers_0 : entity lib_axi4_lite_lcd.axi4_lite_lcd_registers
    generic map(
      G_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status,

      -- Registers Interface
      lcd_on            => lcd_on,
      update_all_lcd    => update_all_lcd,
      update_one_char   => update_one_char,
      func_set          => func_set,
      cursor_disp_shift => cursor_disp_shift,
      disp_on_off_ctrl  => disp_on_off_ctrl,
      entry_mode_set    => entry_mode_set,
      return_home       => return_home,
      clear_disp        => clear_disp,


      char_position       => char_position,
      wr_en_fifo_display  => wr_en_fifo_display,
      wdata_fifo_display  => wdata_fifo_display,
      dl_n_f              => dl_n_f,
      dcb                 => dcb,
      sc_rl               => sc_rl,
      id_sh               => id_sh,
      fifo_full_display   => fifo_full_display,
      fifo_empty_display  => fifo_empty_display,
      init_ongoing        => init_ongoing,
      single_cmd_ongoing  => single_cmd_ongoing,
      update_disp_ongoing => update_disp_ongoing
      );

  -- Instanciation of LCDCFAH TOP
  i_lcd_cfah_top_0 : entity lib_CFAH1602_v2.lcd_cfah_top
    generic map (
      G_CLK_PERIOD_NS       => G_CLK_PERIOD_NS,
      G_BIDIR_POLARITY_READ => G_BIDIR_POLARITY_READ,
      G_DATA_WIDTH          => 8,
      G_FIFO_ADDR_WIDTH     => G_FIFO_ADDR_WIDTH
      )
    port map (
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- LCD DISPLAY CTRL
      i_func_set           => func_set,
      i_cursor_disp_shift  => cursor_disp_shift,
      i_disp_on_off_ctrl   => disp_on_off_ctrl,
      i_entry_mode_set     => entry_mode_set,
      i_return_home        => return_home,
      i_clear_disp         => clear_disp,
      i_update_all_lcd     => update_all_lcd,
      i_update_one_char    => update_one_char,
      i_char_position      => char_position,
      i_wr_en_fifo_display => wr_en_fifo_display,
      i_wdata_fifo_display => wdata_fifo_display,

      -- LCD Config Bus
      i_dl_n_f => dl_n_f,
      i_dcb    => dcb,
      i_sc_rl  => sc_rl,
      i_id_sh  => id_sh,

      -- LCD Commands and Controls
      i_lcd_on => lcd_on,

      -- STATUS
      fifo_full_display   => fifo_full_display,
      fifo_empty_display  => fifo_empty_display,
      init_ongoing        => init_ongoing,
      single_cmd_ongoing  => single_cmd_ongoing,
      update_disp_ongoing => update_disp_ongoing,

      -- LCD I/F
      i_lcd_data  => i_lcd_data,
      o_lcd_wdata => o_lcd_wdata,
      o_lcd_rw    => o_lcd_rw,
      o_lcd_en    => o_lcd_en,
      o_lcd_rs    => o_lcd_rs,
      o_lcd_on    => o_lcd_on,
      o_bidir_sel => o_bidir_sel
      );

end architecture rtl;
