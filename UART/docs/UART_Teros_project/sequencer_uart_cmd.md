# Entity: sequencer_uart_cmd
## Diagram
![Diagram](sequencer_uart_cmd.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name      | Type                 | Value | Description |
| ----------------- | -------------------- | ----- | ----------- |
| G_NB_CMD          | integer              | 4     |             |
| G_UART_DATA_WIDTH | integer range 5 to 9 | 8     |             |
### Table 1.2 Ports
| Port name                      | Direction | Type                                             | Description |
| ------------------------------ | --------- | ------------------------------------------------ | ----------- |
| clk                            | in        | std_logic                                        |             |
| rst_n                          | in        | std_logic                                        |             |
| i_cmd_pulses                   | in        | std_logic_vector(G_NB_CMD - 1 downto 0)          |             |
| i_cmd_discard                  | in        | std_logic                                        |             |
| o_rx_data_sel                  | out       | std_logic                                        |             |
| i_init_static_ram_done         | in        | std_logic                                        |             |
| o_init_static_ram              | out       | std_logic                                        |             |
| o_load_pattern_static          | out       | std_logic                                        |             |
| i_load_pattern_static_done     | in        | std_logic                                        |             |
| i_init_scroller_ram_done       | in        | std_logic                                        |             |
| o_init_scroller_ram            | out       | std_logic                                        |             |
| o_load_pattern_scroller        | out       | std_logic                                        |             |
| i_load_pattern_scroller_done   | in        | std_logic                                        |             |
| o_load_config                  | out       | std_logic                                        |             |
| i_load_config_done             | in        | std_logic                                        |             |
| o_update_config                | out       | std_logic                                        |             |
| i_update_config_done           | in        | std_logic                                        |             |
| o_run_pattern_static           | out       | std_logic                                        |             |
| i_run_pattern_static_rdy       | in        | std_logic                                        |             |
| i_run_pattern_static_done      | in        | std_logic                                        |             |
| i_run_pattern_static_discard   | in        | std_logic                                        |             |
| o_run_pattern_scroller         | out       | std_logic                                        |             |
| i_run_pattern_scroller_rdy     | in        | std_logic                                        |             |
| i_run_pattern_scroller_done    | in        | std_logic                                        |             |
| i_run_pattern_scroller_discard | in        | std_logic                                        |             |
| i_load_tempo_scroller_done     | in        | std_logic                                        |             |
| o_load_tempo_scroller          | out       | std_logic                                        |             |
| i_tx_done                      | in        | std_logic                                        |             |
| o_tx_uart_start                | out       | std_logic                                        |             |
| o_tx_data                      | out       | std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0) |             |
## Signals, constants and types
### Signals
| Name                    | Type                                             | Description |
| ----------------------- | ------------------------------------------------ | ----------- |
| s_init_static_ram       | std_logic                                        |             |
| s_init_scroller_ram     | std_logic                                        |             |
| s_load_pattern_static   | std_logic                                        |             |
| s_load_pattern_scroller | std_logic                                        |             |
| s_tx_uart_start         | std_logic                                        |             |
| s_tx_data               | std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0) |             |
| s_resp_ongoing          | std_logic                                        |             |
| s_cnt_tx_data           | integer                                          |             |
| s_resp_done             | std_logic                                        |             |
| s_rx_data_sel           | std_logic                                        |             |
| s_tx_done               | std_logic                                        |             |
| s_tx_done_r_edge        | std_logic                                        |             |
| s_first_access          | std_logic                                        |             |
| s_index_resp            | integer                                          |             |
| s_load_matrix           | std_logic                                        |             |
| s_update_matrix         | std_logic                                        |             |
| s_run_pattern_static    | std_logic                                        |             |
| s_run_pattern_scroller  | std_logic                                        |             |
| s_load_tempo_scroller   | std_logic                                        |             |
## Processes
- **p_pipe_in**: ***( clk, rst_n )***

- **p_pulses_decoder**: ***( clk, rst_n )***

- **p_tx_uart_mngt**: ***( clk, rst_n )***

