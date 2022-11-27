library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;


entity lcd_cfah_cmd_generator is

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_cmd_req : in std_logic;           -- Command Request

    i_clear_display : in std_logic;     -- Clear Display Cmd request
    i_return_home   : in std_logic;     -- Return Home Cmd Request

    i_entry_mode_set : in std_logic;    -- Entry Mode Set Cmd Request
    i_id_sh          : in std_logic_vector(1 downto 0);  -- Bits Control

    i_display_ctrl : in std_logic;      -- Display ON/OFF Ctrl Cmd Req
    i_dcb          : in std_logic_vector(2 downto 0);  -- Control bits

    i_cursor_display_shift : in std_logic;  -- Cursor Display Shift Cmd Req
    i_sc_rl                : in std_logic_vector(1 downto 0);  -- Cursor Display Bits control

    i_function_set : in std_logic;      -- Function Set cmd Req
    i_dl_n_f       : in std_logic_vector(2 downto 0);  -- Function SET bis control

    i_set_gcram_addr : in std_logic;    -- Set CGRAM Address Command Req
    i_set_ddram_addr : in std_logic;    -- Set DDRAM Address Command Req
    i_read_busy_flag : in std_logic;    -- Read Busy Flag and Addr command Req
    i_wr_data        : in std_logic;    -- Write Data to RAM Command Req
    i_rd_data        : in std_logic;    -- Read Data from RAM Command Req
    i_data_bus       : in std_logic_vector(7 downto 0);  -- Write data bus

    o_lcd_rdata : out std_logic_vector(7 downto 0);
    o_done      : out std_logic;        -- Done received

    -- LCD ITF
    i_lcd_rdata    : in  std_logic_vector(7 downto 0);
    i_lcd_itf_done : in  std_logic;
    o_rs           : out std_logic;
    o_rw           : out std_logic;
    o_lcd_wdata    : out std_logic_vector(7 downto 0);
    o_start        : out std_logic

    );

end entity lcd_cfah_cmd_generator;

architecture rtl of lcd_cfah_cmd_generator is

  -- INTERNAL SIGNALS
  signal s_busy      : std_logic;                     -- Internal Busy Flag
  signal s_lcd_wdata : std_logic_vector(7 downto 0);  -- LCD WDATA

begin  -- architecture rtl

  -- purpose: Internal busy Flag Management 
  p_busy_mngt : process (clk, rst_n) is
  begin  -- process p_busy_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_busy <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(i_cmd_req = '1' and s_busy = '0') then
        s_busy <= '1';

      elsif(i_lcd_itf_done = '1') then
        s_busy <= '0';
      end if;
    end if;
  end process p_busy_mngt;

  -- purpose: Start Management
  p_start_mngt : process (clk, rst_n) is
  begin  -- process p_start_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_start     <= '0';
      o_lcd_wdata <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(i_cmd_req = '1' and s_busy = '0') then
        o_start     <= '1';
        o_lcd_wdata <= s_lcd_wdata;
      else
        o_start     <= '0';
        o_lcd_wdata <= (others => '0');
      end if;
    end if;
  end process p_start_mngt;


  -- purpose: o_rs Management
  p_rs_mngt : process (clk, rst_n) is
  begin  -- process p_rs_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_rs <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Set o_rs to '1' only for these 2 commands
      if(i_wr_data = '1' or i_rd_data = '1') then
        o_rs <= '1';
      else
        o_rs <= '0';
      end if;
    end if;
  end process p_rs_mngt;

  -- purpose: o_rw Management
  p_rw_mngt : process (clk, rst_n) is
  begin  -- process p_rw_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_rw <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(i_read_busy_flag = '1' or i_rd_data = '1') then
        o_rw <= '1';
      else
        o_rw <= '0';
      end if;
    end if;
  end process p_rw_mngt;


  -- purpose: Done Management
  p_done_mngt : process (clk, rst_n) is
  begin  -- process p_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_done      <= '0';
      o_lcd_rdata <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_busy = '1' and i_lcd_itf_done = '1') then
        o_done      <= '1';
        o_lcd_rdata <= i_lcd_rdata;
      else
        o_done      <= '0';
        o_lcd_rdata <= (others => '0');
      end if;
    end if;
  end process p_done_mngt;


  -- LCD DATA Bus Set decoder
  s_lcd_wdata <= x"01" when i_clear_display = '1' else
                 x"02"                         when i_return_home = '1' else
                 (4 downto 0 => '0') & i_id_sh when i_entry_mode_set = '1' else
                 "00001" & i_dcb               when i_display_ctrl = '1' else
                 x"1" & i_sc_rl & "00"         when i_cursor_display_shift = '1' else
                 "001" & i_dl_n_f & "00"       when i_function_set = '1' else
                 "01" & i_data_bus(5 downto 0) when i_set_gcram_addr = '1' else
                 '1' & i_data_bus(6 downto 0)  when i_set_ddram_addr = '1' else
                 i_data_bus                    when i_wr_data = '1' else
                 (others     => '0');   -- Read busy flag and i_rd_data command

end architecture rtl;
