# Entity: static_ram_mngr
## Diagram
![Diagram](static_ram_mngr.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name            | Type                 | Value | Description |
| ----------------------- | -------------------- | ----- | ----------- |
| G_RAM_ADDR_WIDTH_STATIC | integer              | 8     |             |
| G_RAM_DATA_WIDTH_STATIC | integer              | 16    |             |
| G_UART_DATA_WIDTH       | integer range 5 to 9 | 8     |             |
### Table 1.2 Ports
| Port name              | Direction | Type                                                   | Description |
| ---------------------- | --------- | ------------------------------------------------------ | ----------- |
| clk                    | in        | std_logic                                              |             |
| rst_n                  | in        | std_logic                                              |             |
| i_rdata_static         | in        | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0) |             |
| o_me_static            | out       | std_logic                                              |             |
| o_we_static            | out       | std_logic                                              |             |
| o_addr_static          | out       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0) |             |
| o_wdata_static         | out       | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0) |             |
| i_init_static_ram      | in        | std_logic                                              |             |
| o_init_static_ram_done | out       | std_logic                                              |             |
| i_load_static_ram      | in        | std_logic                                              |             |
| o_load_static_ram_done | out       | std_logic                                              |             |
| i_rx_data              | in        | std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0)       |             |
| i_rx_done              | in        | std_logic                                              |             |
## Signals, constants and types
### Signals
| Name                      | Type                                                   | Description |
| ------------------------- | ------------------------------------------------------ | ----------- |
| s_wr_ptr                  | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0) |             |
| s_init_ram_ongoing        | std_logic                                              |             |
| s_init_static_ram_done    | std_logic                                              |             |
| s_load_static_ram_ongoing | std_logic                                              |             |
| s_load_static_ram_done    | std_logic                                              |             |
| s_me_static               | std_logic                                              |             |
| s_we_static               | std_logic                                              |             |
| s_wdata_static            | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0) |             |
| s_cnt_rx_data             | integer range 0 to 129                                 |             |
| s_cnt_2                   | integer range 0 to 2                                   |             |
| s_data_rdy                | std_logic                                              |             |
## Processes
- **p_ram_mngt**: ***( clk, rst_n )***

- **p_ram_access_mngt**: ***( clk, rst_n )***

