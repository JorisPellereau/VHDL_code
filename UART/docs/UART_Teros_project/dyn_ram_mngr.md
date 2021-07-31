# Entity: dyn_ram_mngr
## Diagram
![Diagram](dyn_ram_mngr.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name         | Type                 | Value | Description |
| -------------------- | -------------------- | ----- | ----------- |
| G_RAM_ADDR_WIDTH_DYN | integer              | 8     |             |
| G_RAM_DATA_WIDTH_DYN | integer              | 8     |             |
| G_UART_DATA_WIDTH    | integer range 5 to 9 | 8     |             |
### Table 1.2 Ports
| Port name           | Direction | Type                                                | Description |
| ------------------- | --------- | --------------------------------------------------- | ----------- |
| clk                 | in        | std_logic                                           |             |
| rst_n               | in        | std_logic                                           |             |
| i_rdata_dyn         | in        | std_logic_vector(G_RAM_DATA_WIDTH_DYN - 1 downto 0) |             |
| o_me_dyn            | out       | std_logic                                           |             |
| o_we_dyn            | out       | std_logic                                           |             |
| o_addr_dyn          | out       | std_logic_vector(G_RAM_ADDR_WIDTH_DYN - 1 downto 0) |             |
| o_wdata_dyn         | out       | std_logic_vector(G_RAM_DATA_WIDTH_DYN - 1 downto 0) |             |
| i_init_dyn_ram      | in        | std_logic                                           |             |
| o_init_dyn_ram_done | out       | std_logic                                           |             |
| i_load_dyn_ram      | in        | std_logic                                           |             |
| o_load_dyn_ram_done | out       | std_logic                                           |             |
| i_rx_data           | in        | std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0)    |             |
| i_rx_done           | in        | std_logic                                           |             |
## Signals, constants and types
### Signals
| Name                   | Type                                                | Description |
| ---------------------- | --------------------------------------------------- | ----------- |
| s_wr_ptr               | std_logic_vector(G_RAM_ADDR_WIDTH_DYN - 1 downto 0) |             |
| s_init_ram_ongoing     | std_logic                                           |             |
| s_init_dyn_ram_done    | std_logic                                           |             |
| s_load_dyn_ram_ongoing | std_logic                                           |             |
| s_load_dyn_ram_done    | std_logic                                           |             |
| s_me_dyn               | std_logic                                           |             |
| s_we_dyn               | std_logic                                           |             |
| s_wdata_dyn            | std_logic_vector(G_RAM_DATA_WIDTH_DYN - 1 downto 0) |             |
| s_cnt_rx_data          | integer range 0 to 258                              |             |
| s_start_ptr            | integer                                             |             |
| s_last_ptr             | integer                                             |             |
| s_data_rdy             | std_logic                                           |             |
## Processes
- **p_ram_mngt**: ***( clk, rst_n )***

- **p_ram_access_mngt**: ***( clk, rst_n )***

