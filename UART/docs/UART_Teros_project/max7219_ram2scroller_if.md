# Entity: max7219_ram2scroller_if
## Diagram
![Diagram](max7219_ram2scroller_if.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name     | Type                 | Value | Description |
| ---------------- | -------------------- | ----- | ----------- |
| G_MATRIX_NB      | integer range 2 to 8 | 8     |             |
| G_RAM_ADDR_WIDTH | integer              | 8     |             |
| G_RAM_DATA_WIDTH | integer              | 8     |             |
### Table 1.2 Ports
| Port name          | Direction | Type                                            | Description |
| ------------------ | --------- | ----------------------------------------------- | ----------- |
| clk                | in        | std_logic                                       |             |
| rst_n              | in        | std_logic                                       |             |
| i_start            | in        | std_logic                                       |             |
| i_msg_length       | in        | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| i_ram_start_ptr    | in        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_rdata            | in        | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| o_me               | out       | std_logic                                       |             |
| o_we               | out       | std_logic                                       |             |
| o_addr             | out       | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| o_seg_data         | out       | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| o_seg_data_valid   | out       | std_logic                                       |             |
| i_scroller_if_busy | in        | std_logic                                       |             |
| o_busy             | out       | std_logic                                       |             |
## Signals, constants and types
### Signals
| Name                         | Type                                            | Description |
| ---------------------------- | ----------------------------------------------- | ----------- |
| s_busy                       | std_logic                                       |             |
| s_start                      | std_logic                                       |             |
| s_start_r_edge               | std_logic                                       |             |
| s_scroller_if_busy           | std_logic                                       |             |
| s_scroller_if_busy_f_edge    | std_logic                                       |             |
| s_scroller_if_busy_f_edge_p  | std_logic                                       |             |
| s_scroller_if_busy_f_edge_p2 | std_logic                                       |             |
| s_inputs_val                 | std_logic                                       |             |
| s_we                         | std_logic                                       |             |
| s_me                         | std_logic                                       |             |
| s_me_p                       | std_logic                                       |             |
| s_rdata_valid                | std_logic                                       |             |
| s_access_cnt_done            | std_logic                                       |             |
| s_ram_sel                    | std_logic                                       |             |
| s_seg_data_valid             | std_logic                                       |             |
| s_msg_length                 | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| s_ram_addr                   | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| s_rdata                      | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| s_access_cnt                 | std_logic_vector(G_RAM_DATA_WIDTH downto 0)     |             |
| s_max_access                 | std_logic_vector(G_RAM_DATA_WIDTH downto 0)     |             |
| s_seg_data                   | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| s_reject_scroll              | std_logic                                       |             |
## Processes
- **p_pipe_in**: ***( clk, rst_n )***

- **p_latch_in**: ***( clk, rst_n )***

- **p_ram_access**: ***( clk, rst_n )***

- **p_scroller_if_access**: ***( clk, rst_n )***

- **p_ram_sel**: ***( clk, rst_n )***

- **p_busy_mngt**: ***( clk, rst_n )***

