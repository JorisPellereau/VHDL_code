# Entity: max7219_ram_decod
## Diagram
![Diagram](max7219_ram_decod.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name     | Type                          | Value       | Description |
| ---------------- | ----------------------------- | ----------- | ----------- |
| G_RAM_ADDR_WIDTH | integer                       | 8           |             |
| G_RAM_DATA_WIDTH | integer                       | 16          |             |
| G_MAX_CNT_32B    | std_logic_vector(31 downto 0) | x"02FAF080" |             |
### Table 1.2 Ports
| Port name      | Direction | Type                                            | Description |
| -------------- | --------- | ----------------------------------------------- | ----------- |
| clk            | in        | std_logic                                       |             |
| rst_n          | in        | std_logic                                       |             |
| i_en           | in        | std_logic                                       |             |
| o_me           | out       | std_logic                                       |             |
| o_we           | out       | std_logic                                       |             |
| o_addr         | out       | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_rdata        | in        | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| i_start_ptr    | in        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_last_ptr     | in        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_ptr_val      | in        | std_logic                                       |             |
| i_loop         | in        | std_logic                                       |             |
| o_ptr_equality | out       | std_logic                                       |             |
| o_discard      | out       | std_logic                                       |             |
| o_start        | out       | std_logic                                       |             |
| o_en_load      | out       | std_logic                                       |             |
| o_data         | out       | std_logic_vector(15 downto 0)                   |             |
| i_done         | in        | std_logic                                       |             |
## Signals, constants and types
### Signals
| Name               | Type                                            | Description |
| ------------------ | ----------------------------------------------- | ----------- |
| s_decod_busy       | std_logic                                       |             |
| s_start_ram_access | std_logic                                       |             |
| s_me               | std_logic                                       |             |
| s_we               | std_logic                                       |             |
| s_me_p1            | std_logic                                       |             |
| s_me_p2            | std_logic                                       |             |
| s_rdata_valid      | std_logic                                       |             |
| s_en_load          | std_logic                                       |             |
| s_decod_done       | std_logic                                       |             |
| s_start            | std_logic                                       |             |
| s_inc_done         | std_logic                                       |             |
| s_max_cnt_valid    | std_logic                                       |             |
| s_start_cnt        | std_logic                                       |             |
| s_cnt_done         | std_logic                                       |             |
| s_ptr_equality     | std_logic                                       |             |
| s_update_ptr       | std_logic                                       |             |
| s_ptr_val          | std_logic                                       |             |
| s_ptr_val_r_edge   | std_logic                                       |             |
| s_data             | std_logic_vector(15 downto 0)                   |             |
| s_addr             | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| s_rdata            | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| s_cnt_32b          | std_logic_vector(31 downto 0)                   |             |
| s_max_cnt_32b      | std_logic_vector(31 downto 0)                   |             |
| s_start_ptr        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| s_last_ptr         | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
## Processes
- **p_pipe_ptr_val**: ***( clk, rst_n )***

- **p_last_ptr_update**: ***( clk, rst_n )***

- **p_last_ptr_comp**: ***( clk, rst_n )***

- **p_rd_ram_access**: ***( clk, rst_n )***

- **p_pipe_me**: ***( clk, rst_n )***

- **p_rdata_latch**: ***( clk, rst_n )***

- **p_decod_rdata**: ***( clk, rst_n )***

- **p_max7219_is_access**: ***( clk, rst_n )***

- **p_addr_inc**: ***( clk, rst_n )***

- **p_cnt_mngt**: ***( clk, rst_n )***

