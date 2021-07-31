# Entity: uart_max7219_display_ctrl
## Diagram
![Diagram](uart_max7219_display_ctrl.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name              | Type                 | Value     | Description |
| ------------------------- | -------------------- | --------- | ----------- |
| G_STOP_BIT_NUMBER         | integer range 1 to 2 | 1         |             |
| G_PARITY                  | t_parity             | even      |             |
| G_BAUDRATE                | t_baudrate           | b115200   |             |
| G_UART_DATA_SIZE          | integer range 5 to 9 | 8         |             |
| G_POLARITY                | std_logic            | '1'       |             |
| G_FIRST_BIT               | t_first_bit          | lsb_first |             |
| G_CLOCK_FREQUENCY         | integer              | 50000000  |             |
| G_MATRIX_NB               | integer range 2 to 8 | 8         |             |
| G_RAM_ADDR_WIDTH_STATIC   | integer              | 8         |             |
| G_RAM_DATA_WIDTH_STATIC   | integer              | 16        |             |
| G_RAM_ADDR_WIDTH_SCROLLER | integer              | 8         |             |
| G_RAM_DATA_WIDTH_SCROLLER | integer              | 8         |             |
### Table 1.2 Ports
| Port name                | Direction | Type                                                     | Description |
| ------------------------ | --------- | -------------------------------------------------------- | ----------- |
| clk                      | in        | std_logic                                                |             |
| rst_n                    | in        | std_logic                                                |             |
| i_rx                     | in        | std_logic                                                |             |
| o_tx                     | out       | std_logic                                                |             |
| o_static_dyn             | out       | std_logic                                                |             |
| o_new_display            | out       | std_logic                                                |             |
| i_config_done            | in        | std_logic                                                |             |
| o_display_test           | out       | std_logic                                                |             |
| o_decod_mode             | out       | std_logic_vector(7 downto 0)                             |             |
| o_intensity              | out       | std_logic_vector(7 downto 0)                             |             |
| o_scan_limit             | out       | std_logic_vector(7 downto 0)                             |             |
| o_shutdown               | out       | std_logic_vector(7 downto 0)                             |             |
| o_new_config_val         | out       | std_logic                                                |             |
| o_en_static              | out       | std_logic                                                |             |
| i_rdata_static           | in        | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0)   |             |
| o_me_static              | out       | std_logic                                                |             |
| o_we_static              | out       | std_logic                                                |             |
| o_addr_static            | out       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| o_wdata_static           | out       | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0)   |             |
| o_start_ptr_static       | out       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| o_last_ptr_static        | out       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| i_ptr_equality_static    | in        | std_logic                                                |             |
| i_static_busy            | in        | std_logic                                                |             |
| i_scroller_busy          | in        | std_logic                                                |             |
| o_ram_start_ptr_scroller | out       | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| o_msg_length_scroller    | out       | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| o_max_tempo_cnt_scroller | out       | std_logic_vector(31 downto 0)                            |             |
| i_rdata_scroller         | in        | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| o_me_scroller            | out       | std_logic                                                |             |
| o_we_scroller            | out       | std_logic                                                |             |
| o_addr_scroller          | out       | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| o_wdata_scroller         | out       | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
## Signals, constants and types
### Signals
| Name                              | Type                                            | Description |
| --------------------------------- | ----------------------------------------------- | ----------- |
| s_rx_meta                         | std_logic                                       |             |
| s_rx_stable                       | std_logic                                       |             |
| s_rx                              | std_logic                                       |             |
| s_rx_data                         | std_logic_vector(G_UART_DATA_SIZE - 1 downto 0) |             |
| s_rx_done                         | std_logic                                       |             |
| s_parity_rcvd                     | std_logic                                       |             |
| s_start_tx                        | std_logic                                       |             |
| s_tx_data                         | std_logic_vector(G_UART_DATA_SIZE - 1 downto 0) |             |
| s_tx                              | std_logic                                       |             |
| s_tx_done                         | std_logic                                       |             |
| s_data_decod                      | std_logic_vector(G_UART_DATA_SIZE - 1 downto 0) |             |
| s_data_valid                      | std_logic                                       |             |
| s_commands                        | std_logic_vector(C_NB_CMD - 1 downto 0)         |             |
| s_discard                         | std_logic                                       |             |
| s_rx_data_sel                     | std_logic                                       |             |
| s_data_static                     | std_logic_vector(G_UART_DATA_SIZE - 1 downto 0) |             |
| s_data_static_done                | std_logic                                       |             |
| s_data_dyn                        | std_logic_vector(G_UART_DATA_SIZE - 1 downto 0) |             |
| s_data_dyn_done                   | std_logic                                       |             |
| s_data_config                     | std_logic_vector(G_UART_DATA_SIZE - 1 downto 0) |             |
| s_data_config_done                | std_logic                                       |             |
| s_rx_done_p1                      | std_logic                                       |             |
| s_rx_done_r_edge                  | std_logic                                       |             |
| s_init_static_ram_done            | std_logic                                       |             |
| s_init_static_ram                 | std_logic                                       |             |
| s_init_scroller_ram_done          | std_logic                                       |             |
| s_init_scroller_ram               | std_logic                                       |             |
| s_load_pattern_static             | std_logic                                       |             |
| s_load_pattern_static_done        | std_logic                                       |             |
| s_load_pattern_scroller           | std_logic                                       |             |
| s_load_pattern_scroller_done      | std_logic                                       |             |
| s_load_config                     | std_logic                                       |             |
| s_load_config_done                | std_logic                                       |             |
| s_update_config                   | std_logic                                       |             |
| s_update_config_done              | std_logic                                       |             |
| s_run_pattern_static              | std_logic                                       |             |
| s_update_pattern_static_done      | std_logic                                       |             |
| s_update_pattern_static_discard   | std_logic                                       |             |
| s_run_pattern_scroller            | std_logic                                       |             |
| s_update_pattern_scroller_done    | std_logic                                       |             |
| s_update_pattern_scroller_discard | std_logic                                       |             |
| s_run_static_pattern_rdy          | std_logic                                       |             |
| s_run_scroller_pattern_rdy        | std_logic                                       |             |
| s_run_pattern_static_done         | std_logic                                       |             |
| s_run_pattern_scroller_done       | std_logic                                       |             |
| s_run_pattern_static_discard      | std_logic                                       |             |
| s_run_pattern_scroller_discard    | std_logic                                       |             |
| s_load_tempo_scroller_done        | std_logic                                       |             |
| s_load_tempo_scroller             | std_logic                                       |             |
## Processes
- **p_rx_resynch**: ***( clk, rst_n )***

- **p_pipe_signals**: ***( clk, rst_n )***

## Instantiations
- **i_rx_uart_0**: rx_uart

- **i_tx_uart_0**: tx_uart

- **i_uart_cmd_decod_0**: uart_cmd_decod

- **i_sequencer_uart_cmd_0**: sequencer_uart_cmd

- **i_static_ram_mngr**: static_ram_mngr

- **i_dyn_ram_mngr_0**: dyn_ram_mngr

- **i_matrix_config_mngr_0**: matrix_config_mngr

- **i_run_pattern_mngt_0**: run_pattern_mngt

