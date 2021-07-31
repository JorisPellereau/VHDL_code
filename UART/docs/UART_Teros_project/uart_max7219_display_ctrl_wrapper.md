# Entity: uart_max7219_display_ctrl_wrapper
## Diagram
![Diagram](uart_max7219_display_ctrl_wrapper.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name              | Type                          | Value       | Description |
| ------------------------- | ----------------------------- | ----------- | ----------- |
| G_STOP_BIT_NUMBER         | integer range 1 to 2          | 1           |             |
| G_PARITY                  | t_parity                      | even        |             |
| G_BAUDRATE                | t_baudrate                    | b115200     |             |
| G_UART_DATA_SIZE          | integer range 5 to 9          | 8           |             |
| G_POLARITY                | std_logic                     | '1'         |             |
| G_FIRST_BIT               | t_first_bit                   | lsb_first   |             |
| G_CLOCK_FREQUENCY         | integer                       | 50000000    |             |
| G_MATRIX_NB               | integer range 2 to 8          | 8           |             |
| G_RAM_ADDR_WIDTH_STATIC   | integer                       | 8           |             |
| G_RAM_DATA_WIDTH_STATIC   | integer                       | 16          |             |
| G_RAM_ADDR_WIDTH_SCROLLER | integer                       | 8           |             |
| G_RAM_DATA_WIDTH_SCROLLER | integer                       | 8           |             |
| G_MAX_HALF_PERIOD         | integer                       | 4           |             |
| G_LOAD_DURATION           | integer                       | 4           |             |
| G_DECOD_MAX_CNT_32B       | std_logic_vector(31 downto 0) | x"02FAF080" |             |
### Table 1.2 Ports
| Port name      | Direction | Type      | Description |
| -------------- | --------- | --------- | ----------- |
| clk            | in        | std_logic |             |
| rst_n          | in        | std_logic |             |
| i_rx           | in        | std_logic |             |
| o_tx           | out       | std_logic |             |
| o_max7219_load | out       | std_logic |             |
| o_max7219_data | out       | std_logic |             |
| o_max7219_clk  | out       | std_logic |             |
## Signals, constants and types
### Signals
| Name                     | Type                                                     | Description |
| ------------------------ | -------------------------------------------------------- | ----------- |
| s_static_dyn             | std_logic                                                |             |
| s_new_display            | std_logic                                                |             |
| s_config_done            | std_logic                                                |             |
| s_display_test           | std_logic                                                |             |
| s_decod_mode             | std_logic_vector(7 downto 0)                             |             |
| s_intensity              | std_logic_vector(7 downto 0)                             |             |
| s_scan_limit             | std_logic_vector(7 downto 0)                             |             |
| s_shutdown               | std_logic_vector(7 downto 0)                             |             |
| s_new_config_val         | std_logic                                                |             |
| s_en_static              | std_logic                                                |             |
| s_rdata_static           | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0)   |             |
| s_me_static              | std_logic                                                |             |
| s_we_static              | std_logic                                                |             |
| s_addr_static            | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_wdata_static           | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0)   |             |
| s_start_ptr_static       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_last_ptr_static        | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_ptr_equality_static    | std_logic                                                |             |
| s_static_busy            | std_logic                                                |             |
| s_scroller_busy          | std_logic                                                |             |
| s_ram_start_ptr_scroller | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| s_msg_length_scroller    | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| s_max_tempo_cnt_scroller | std_logic_vector(31 downto 0)                            |             |
| s_rdata_scroller         | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| s_me_scroller            | std_logic                                                |             |
| s_we_scroller            | std_logic                                                |             |
| s_addr_scroller          | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| s_wdata_scroller         | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
## Instantiations
- **i_uart_max7219_display_ctrl_0**: uart_max7219_display_ctrl

- **i_max7219_display_controller_0**: max7219_display_controller

