-------------------------------------------------------------------------------
-- Title      : AXI 4 Lite LCD Registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_7segs_registers.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2023-09-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: LCD REGISTERS - 32 bits access. Each bytes on registers are selected by the wstr signals
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

library lib_axi4_lite_lcd;
use lib_axi4_lite_lcd.axi4_lite_lcd_pkg.all;

entity axi4_lite_lcd_registers is
  generic (
    G_ADDR_WIDTH : integer range 4 to 16  := 4;  -- USEFULL ADDR WIDTH
    G_DATA_WIDTH : integer range 32 to 64 := 32  -- AXI4 Lite DATA WIDTH
    );
  port (
    clk   : in std_logic;                        -- Clock
    rst_n : in std_logic;                        -- Asynchronous Reset

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
    lcd_on              : out std_logic;                     -- LCD ON
    update_all_lcd      : out std_logic;                     -- UPDATE LCD Command
    update_one_char     : out std_logic;                     -- UPDATE Once Char command
    func_set            : out std_logic;                     -- Function Set command
    cursor_disp_shift   : out std_logic;                     -- Cursor Or display shift
    disp_on_off_ctrl    : out std_logic;                     -- Displau ON/OFF Control command
    entry_mode_set      : out std_logic;                     -- Entry Mode Set command
    return_home         : out std_logic;                     -- Return Home Command
    clear_disp          : out std_logic;                     -- Clear Display Command
    char_position       : out std_logic_vector(4 downto 0);  -- Char Position
    wr_en_fifo_display  : out std_logic;                     -- Write Enable Data fifo display
    wdata_fifo_display  : out std_logic_vector(7 downto 0);  -- Write Data FIFO Display
    dl_n_f              : out std_logic_vector(2 downto 0);  -- DL N F Configuration
    dcb                 : out std_logic_vector(2 downto 0);  -- DCB Configuration
    sc_rl               : out std_logic_vector(1 downto 0);  -- SC RL Condifuration
    id_sh               : out std_logic_vector(1 downto 0);  -- ID SH Configuration
    fifo_full_display   : in  std_logic;                     -- FIFO Full Display flag
    fifo_empty_display  : in  std_logic;                     -- FIFO Empty Display flag
    init_ongoing        : in  std_logic;                     -- Initialization of the LCD ongoing
    single_cmd_ongoing  : in  std_logic;                     -- SINGLE Command ongoing
    update_disp_ongoing : in  std_logic                      -- Uate Display ongoing
    );

end entity axi4_lite_lcd_registers;

architecture rtl of axi4_lite_lcd_registers is

  -- == INTERNAL Signals ==
  signal reg_wr_sel       : std_logic_vector(C_NB_REG - 1 downto 0);  -- Write register selection
  signal reg_wr_sel_error : std_logic;                                -- Reg Write Selection error

  -- Internal Registers
  signal ctrl_register                  : std_logic_vector(C_CTRL_WIDTH - 1 downto 0);                   -- CTRL Register
  signal entry_mode_set_config_register : std_logic_vector(C_ENTRY_MODE_SET_CONFIG_WIDTH - 1 downto 0);  -- ENTRY MODE SET Condig Register
  signal disp_on_off_config_register    : std_logic_vector(C_DISP_ON_OFF_CONFIG_WIDTH - 1 downto 0);     -- DISP ON OFF Config register
  signal cursor_disp_config_register    : std_logic_vector(C_CURSOR_DISP_CONFIG_WIDTH - 1 downto 0);     -- CURSOR DISP Config register
  signal func_set_config_register       : std_logic_vector(C_FUNC_SET_CONFIG_WIDTH - 1 downto 0);        -- FUNCTION SET Config register
  signal wdata_display_register         : std_logic_vector(C_WDATA_DISPLAY_WIDTH - 1 downto 0);          -- WDATA DISPLAY register
  signal char_position_register         : std_logic_vector(C_CHAR_POSITION_WIDTH - 1 downto 0);          -- CHAR Postion register
  signal lcd_cmds_0_register            : std_logic_vector(C_LCD_CMDS_0_WIDTH - 1 downto 0);             -- LCD Commands register
  signal lcd_status_register            : std_logic_vector(C_LCD_STATUS_WIDTH - 1 downto 0);             -- LCD Status register

  signal wr_en_fifo_display_int : std_logic;  -- WR EN Fifo Display
  signal wdata_display_wr_error : std_logic;  -- Write Error in WDATA_DISLAY register
  signal slv_wr_access_error    : std_logic;  -- SLave Write Access Error
  signal en_wr_cmds_0           : std_logic;  -- Enable to write in lcd_cmds_0 register if set

  signal lcd_cmd_ongoing : std_logic; -- LCD Command ongoing
  
  -- Alias
  alias a_wdata_cmds_0_field : std_logic_vector(C_LCD_CMDS_0_WIDTH - 1 downto 0) is slv_wdata(C_LCD_CMDS_0_WIDTH - 1 + 3*8 downto 0 + 3*8);
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

        -- If different from REG2 ADDR -> Write access is authorized
        -- otherwise it is forbidden ('0')
        if(unsigned(slv_addr(C_USEFUL_LSBITS - 1 downto 0)) /= unsigned(C_REG2_ADDR)) then  --, slv_addr'length)) then
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
  -- ENTRY_MODE_SET_CONFIG
  -- DISP_ON_OFF_CONFIG
  -- CURSOR_DISP_CONFIG
  -- Register in function of the strobe
  p_reg0_wr_mngt : process (clk, rst_n) is
  begin  -- process p_reg0_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      ctrl_register                  <= (others => '0');
      entry_mode_set_config_register <= (others => '0');
      disp_on_off_config_register    <= (others => '0');
      cursor_disp_config_register    <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Write in CTRL Register
      if(reg_wr_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '0' and slv_strobe(0) = '1') then
        ctrl_register <= slv_wdata(C_CTRL_WIDTH - 1 downto 0);
      end if;

      -- Write in ENTRY MODE SET Config. Register
      if(reg_wr_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '0' and slv_strobe(1) = '1') then
        entry_mode_set_config_register <= slv_wdata(C_ENTRY_MODE_SET_CONFIG_WIDTH - 1 + 8 downto 0 + 8);
      end if;

      -- Write in disp_on_off_config_register Register
      if(reg_wr_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '0' and slv_strobe(2) = '1') then
        disp_on_off_config_register <= slv_wdata(C_DISP_ON_OFF_CONFIG_WIDTH - 1 + 2*8 downto 0 + 2*8);
      end if;

      -- Write in cursor_disp_config_register register
      if(reg_wr_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '0' and slv_strobe(3) = '1') then
        cursor_disp_config_register <= slv_wdata(C_CURSOR_DISP_CONFIG_WIDTH - 1 + 3*8 downto 0 + 3*8);
      end if;

    end if;
  end process p_reg0_wr_mngt;


  -- purpose: REG1 Write Management
  -- Write in register :
  -- FUNC_SET_CONFIG
  -- WDATA_DISPLAY
  -- CHAR_POSITION
  -- LCD_CMDS0
  p_reg1_wr_mngt : process (clk, rst_n) is
  begin  -- process p_reg1_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      func_set_config_register <= (others => '0');
      wdata_display_register   <= (others => '0');
      char_position_register   <= (others => '0');
      lcd_cmds_0_register      <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Write in FUNC_SET_CONFIG Register
      if(reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0' and slv_strobe(0) = '1') then
        func_set_config_register <= slv_wdata(C_FUNC_SET_CONFIG_WIDTH - 1 + 0*8 downto 0 + 0*8);
      end if;

      -- Write in WDATA DISPLAY Register
      if(reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0' and slv_strobe(1) = '1') then
        wdata_display_register <= slv_wdata(C_WDATA_DISPLAY_WIDTH - 1 + 1*8 downto 0 + 1*8);
      end if;

      -- Write in CHAR_POSITION Register
      if(reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0' and slv_strobe(2) = '1') then
        char_position_register <= slv_wdata(C_CHAR_POSITION_WIDTH - 1 + 2*8 downto 0 + 2*8);
      end if;

      -- Write in LCD_CMDS0 register
      -- Write only in this field if en_wr_cmds_0 = '1' (One command bit selected at a time)
      -- Write Only in this field if no other commands (single or display update) is being processed
      if(reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0' and
         slv_strobe(3) = '1' and en_wr_cmds_0 = '1' and lcd_cmd_ongoing = '0') then

        -- Enable to write commands only if one commands is set or equals to '0'
        -- Otherwise no write access
        lcd_cmds_0_register <= a_wdata_cmds_0_field;


      -- Reset the register after the write access (CW type)
      else
        lcd_cmds_0_register <= (others => '0');
      end if;

    end if;
  end process p_reg1_wr_mngt;

  -- en_wr_cmds_0 : set only when one bit of the vector is set at a time
  en_wr_cmds_0 <= '1' when a_wdata_cmds_0_field = "10000000" else
                  '1' when a_wdata_cmds_0_field = "01000000" else
                  '1' when a_wdata_cmds_0_field(7 downto 6) = "00" and a_wdata_cmds_0_field(3 downto 0) = "0000" else
                  '1' when a_wdata_cmds_0_field(7 downto 2) = "000000" else
                  '1' when a_wdata_cmds_0_field = "00000100" else
                  '1' when a_wdata_cmds_0_field = "00001000" else
                  '0';


  -- purpose:       wr_en_fifo_display_int management
  p_wr_en_fifo_display_mngt : process (clk, rst_n) is
  begin  -- process p_wr_en_fifo_display_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      wr_en_fifo_display_int <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- If the register is selected and if the FIFO is not empty -> Enable to write the data in the fifo
      if(reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0' and slv_strobe(1) = '1' and lcd_status_register(0) = '0') then
        wr_en_fifo_display_int <= '1';
      else
        wr_en_fifo_display_int <= '0';
      end if;

    end if;
  end process p_wr_en_fifo_display_mngt;

  -- ===========================

  -- WDATA DISPLAY error detection
  -- Detect the error if the FIFO en FULL and a write access is performed
  wdata_display_wr_error <= '1' when (reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0'
                                      and slv_strobe(1) = '1' and lcd_status_register(0) = '1')
                            else '0';

  -- Slave WRite Access error :
  -- Wrong Write selection or
  -- FIFO is full or
  -- During selection of C_REG1_IDX : Wdata not correct (multiple cmd set at the same time) or a single_command is being processed
  slv_wr_access_error <= reg_wr_sel_error or
                         wdata_display_wr_error or
                         (((not en_wr_cmds_0) or lcd_cmd_ongoing) and (reg_wr_sel(C_REG1_IDX) and slv_strobe(3)));


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
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) > C_REG2_ADDR) then
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
        slv_rdata <= x"0" & "00" & cursor_disp_config_register & x"0" & "0" & disp_on_off_config_register &
                     x"0" & "00" & entry_mode_set_config_register & x"0" & "000" & ctrl_register;

      -- Set RDATA when reading REG1
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG1_ADDR) then
        slv_rdata <= lcd_cmds_0_register & "000" & char_position_register & wdata_display_register &
                     x"0" & "0" & func_set_config_register;

      -- Set RDATA when reading REG2
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG2_ADDR) then
        slv_rdata <= std_logic_vector(to_unsigned(0, G_DATA_WIDTH - C_LCD_STATUS_WIDTH)) & lcd_status_register;

      -- Otherwise REturn (others => '0');
      else
        slv_rdata <= (others => '0');
      end if;

    end if;
  end process p_slv_rdata_mngt;

  -- ==========================

  lcd_cmd_ongoing <= single_cmd_ongoing or update_disp_ongoing;
  
  -- Inputs Set
  lcd_status_register(0) <= fifo_full_display;
  lcd_status_register(1) <= fifo_empty_display;
  lcd_status_register(2) <= init_ongoing;
  lcd_status_register(3) <= single_cmd_ongoing;
  lcd_status_register(4) <= update_disp_ongoing;

  -- == OUTPUTS Affectation ==
  lcd_on <= ctrl_register(0);

  -- LCD Commands
  update_one_char   <= lcd_cmds_0_register(7);
  update_all_lcd    <= lcd_cmds_0_register(6);
  func_set          <= lcd_cmds_0_register(5);
  cursor_disp_shift <= lcd_cmds_0_register(4);
  disp_on_off_ctrl  <= lcd_cmds_0_register(3);
  entry_mode_set    <= lcd_cmds_0_register(2);
  return_home       <= lcd_cmds_0_register(1);
  clear_disp        <= lcd_cmds_0_register(0);

  char_position      <= char_position_register;
  wr_en_fifo_display <= wr_en_fifo_display_int;
  wdata_fifo_display <= wdata_display_register;
  dl_n_f             <= func_set_config_register;
  dcb                <= disp_on_off_config_register;
  sc_rl              <= cursor_disp_config_register;
  id_sh              <= entry_mode_set_config_register;

end architecture rtl;
