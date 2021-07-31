# Entity: max7219_cmd_decod
## Diagram
![Diagram](max7219_cmd_decod.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name        | Type                          | Value       | Description |
| ------------------- | ----------------------------- | ----------- | ----------- |
| G_RAM_ADDR_WIDTH    | integer                       | 8           |             |
| G_RAM_DATA_WIDTH    | integer                       | 16          |             |
| G_DECOD_MAX_CNT_32B | std_logic_vector(31 downto 0) | x"02FAF080" |             |
### Table 1.2 Ports
| Port name            | Direction | Type                                            | Description |
| -------------------- | --------- | ----------------------------------------------- | ----------- |
| clk                  | in        | std_logic                                       |             |
| rst_n                | in        | std_logic                                       |             |
| i_en                 | in        | std_logic                                       |             |
| i_me                 | in        | std_logic                                       |             |
| i_we                 | in        | std_logic                                       |             |
| i_addr               | in        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_wdata              | in        | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| o_rdata              | out       | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| i_start_ptr          | in        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_last_ptr           | in        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_ptr_val            | in        | std_logic                                       |             |
| i_loop               | in        | std_logic                                       |             |
| o_ptr_equality       | out       | std_logic                                       |             |
| o_discard            | out       | std_logic                                       |             |
| i_max7219_if_done    | in        | std_logic                                       |             |
| o_max7219_if_start   | out       | std_logic                                       |             |
| o_max7219_if_en_load | out       | std_logic                                       |             |
| o_max7219_if_data    | out       | std_logic_vector(15 downto 0)                   |             |
## Signals, constants and types
### Signals
| Name          | Type                                            | Description |
| ------------- | ----------------------------------------------- | ----------- |
| s_me_decod    | std_logic                                       |             |
| s_we_decod    | std_logic                                       |             |
| s_addr_decod  | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| s_wdata_decod | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| s_rdata_decod | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
## Instantiations
- **tdpram_inst_0**: tdpram_sclk

- **max7219_ram_decod_inst_0**: max7219_ram_decod

