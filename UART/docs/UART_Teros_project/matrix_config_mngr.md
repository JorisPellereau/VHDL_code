# Entity: matrix_config_mngr
## Diagram
![Diagram](matrix_config_mngr.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name      | Type                 | Value | Description |
| ----------------- | -------------------- | ----- | ----------- |
| G_UART_DATA_WIDTH | integer range 5 to 9 | 8     |             |
### Table 1.2 Ports
| Port name            | Direction | Type                                             | Description |
| -------------------- | --------- | ------------------------------------------------ | ----------- |
| clk                  | in        | std_logic                                        |             |
| rst_n                | in        | std_logic                                        |             |
| i_config_done        | in        | std_logic                                        |             |
| i_load_config        | in        | std_logic                                        |             |
| o_load_config_done   | out       | std_logic                                        |             |
| i_update_config      | in        | std_logic                                        |             |
| o_update_config_done | out       | std_logic                                        |             |
| o_display_test       | out       | std_logic                                        |             |
| o_decod_mode         | out       | std_logic_vector(7 downto 0)                     |             |
| o_intensity          | out       | std_logic_vector(7 downto 0)                     |             |
| o_scan_limit         | out       | std_logic_vector(7 downto 0)                     |             |
| o_shutdown           | out       | std_logic_vector(7 downto 0)                     |             |
| i_rx_data            | in        | std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0) |             |
| i_rx_done            | in        | std_logic                                        |             |
## Signals, constants and types
### Signals
| Name                    | Type                         | Description |
| ----------------------- | ---------------------------- | ----------- |
| s_load_config_ongoing   | std_logic                    |             |
| s_update_config_ongoing | std_logic                    |             |
| s_update_config_done    | std_logic                    |             |
| s_cnt_5                 | integer range 0 to 5         |             |
| s_load_config_done      | std_logic                    |             |
| s_display_test          | std_logic                    |             |
| s_decod_mode            | std_logic_vector(7 downto 0) |             |
| s_intensity             | std_logic_vector(7 downto 0) |             |
| s_scan_limit            | std_logic_vector(7 downto 0) |             |
| s_shutdown              | std_logic_vector(7 downto 0) |             |
## Processes
- **p_config_mngt**: ***( clk, rst_n )***

- **p_rx_data_mngt**: ***( clk, rst_n )***

- **p_update_config_mngt**: ***( clk, rst_n )***

