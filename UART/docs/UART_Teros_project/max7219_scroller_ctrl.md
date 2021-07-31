# Entity: max7219_scroller_ctrl
## Diagram
![Diagram](max7219_scroller_ctrl.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name     | Type                 | Value | Description |
| ---------------- | -------------------- | ----- | ----------- |
| G_MATRIX_NB      | integer range 2 to 8 | 8     |             |
| G_RAM_ADDR_WIDTH | integer              | 8     |             |
| G_RAM_DATA_WIDTH | integer              | 8     |             |
### Table 1.2 Ports
| Port name            | Direction | Type                                            | Description |
| -------------------- | --------- | ----------------------------------------------- | ----------- |
| clk                  | in        | std_logic                                       |             |
| rst_n                | in        | std_logic                                       |             |
| i_me                 | in        | std_logic                                       |             |
| i_we                 | in        | std_logic                                       |             |
| i_addr               | in        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_wdata              | in        | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| o_rdata              | out       | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| i_ram_start_ptr      | in        | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| i_msg_length         | in        | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| i_start_scroll       | in        | std_logic                                       |             |
| i_max_tempo_cnt      | in        | std_logic_vector(31 downto 0)                   |             |
| i_max7219_if_done    | in        | std_logic                                       |             |
| o_max7219_if_start   | out       | std_logic                                       |             |
| o_max7219_if_en_load | out       | std_logic                                       |             |
| o_max7219_if_data    | out       | std_logic_vector(15 downto 0)                   |             |
| o_busy               | out       | std_logic                                       |             |
## Signals, constants and types
### Signals
| Name               | Type                                            | Description |
| ------------------ | ----------------------------------------------- | ----------- |
| s_me_b             | std_logic                                       |             |
| s_we_b             | std_logic                                       |             |
| s_addr_b           | std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0) |             |
| s_wdata_b          | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| s_rdata_b          | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| s_seg_data         | std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0) |             |
| s_seg_data_valid   | std_logic                                       |             |
| s_scroller_if_busy | std_logic                                       |             |
| s_done             | std_logic                                       |             |
| s_start            | std_logic                                       |             |
| s_en_load          | std_logic                                       |             |
| s_data             | std_logic_vector(15 downto 0)                   |             |
## Instantiations
- **max7219_ram2scroller_if_inst_0**: max7219_ram2scroller_if

- **max7219_scroller_if_inst_0**: max7219_scroller_if

- **tdpram_inst_0**: tdpram_sclk

