# Entity: max7219_display_controller
## Diagram
![Diagram](max7219_display_controller.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name              | Type                          | Value       | Description |
| ------------------------- | ----------------------------- | ----------- | ----------- |
| G_MATRIX_NB               | integer range 2 to 8          | 8           |             |
| G_MAX_HALF_PERIOD         | integer                       | 4           |             |
| G_LOAD_DURATION           | integer                       | 4           |             |
| G_RAM_ADDR_WIDTH_STATIC   | integer                       | 8           |             |
| G_RAM_DATA_WIDTH_STATIC   | integer                       | 16          |             |
| G_DECOD_MAX_CNT_32B       | std_logic_vector(31 downto 0) | x"02FAF080" |             |
| G_RAM_ADDR_WIDTH_SCROLLER | integer                       | 8           |             |
| G_RAM_DATA_WIDTH_SCROLLER | integer                       | 8           |             |
### Table 1.2 Ports
| Port name                | Direction | Type                                                     | Description |
| ------------------------ | --------- | -------------------------------------------------------- | ----------- |
| clk                      | in        | std_logic                                                |             |
| rst_n                    | in        | std_logic                                                |             |
| i_static_dyn             | in        | std_logic                                                |             |
| i_new_display            | in        | std_logic                                                |             |
| i_display_test           | in        | std_logic                                                |             |
| i_decod_mode             | in        | std_logic_vector(7 downto 0)                             |             |
| i_intensity              | in        | std_logic_vector(7 downto 0)                             |             |
| i_scan_limit             | in        | std_logic_vector(7 downto 0)                             |             |
| i_shutdown               | in        | std_logic_vector(7 downto 0)                             |             |
| i_new_config_val         | in        | std_logic                                                |             |
| o_config_done            | out       | std_logic                                                |             |
| i_en_static              | in        | std_logic                                                |             |
| i_me_static              | in        | std_logic                                                |             |
| i_we_static              | in        | std_logic                                                |             |
| i_addr_static            | in        | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| i_wdata_static           | in        | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0)   |             |
| o_rdata_static           | out       | std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0)   |             |
| i_start_ptr_static       | in        | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| i_last_ptr_static        | in        | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| i_loop_static            | in        | std_logic                                                |             |
| o_ptr_equality_static    | out       | std_logic                                                |             |
| o_static_busy            | out       | std_logic                                                |             |
| i_ram_start_ptr_scroller | in        | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| i_msg_length_scroller    | in        | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| i_max_tempo_cnt_scroller | in        | std_logic_vector(31 downto 0)                            |             |
| o_scroller_busy          | out       | std_logic                                                |             |
| i_me_scroller            | in        | std_logic                                                |             |
| i_we_scroller            | in        | std_logic                                                |             |
| i_addr_scroller          | in        | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| i_wdata_scroller         | in        | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| o_rdata_scroller         | out       | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| o_max7219_load           | out       | std_logic                                                |             |
| o_max7219_data           | out       | std_logic                                                |             |
| o_max7219_clk            | out       | std_logic                                                |             |
## Signals, constants and types
### Signals
| Name                          | Type                                                     | Description |
| ----------------------------- | -------------------------------------------------------- | ----------- |
| s_start_ptr_static            | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_last_ptr_static             | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_ptr_val_static              | std_logic                                                |             |
| s_loop_static                 | std_logic                                                |             |
| s_ram_start_ptr_scroller      | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| s_msg_length_scroller         | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| s_start_scroll                | std_logic                                                |             |
| s_max7219_if_done_config      | std_logic                                                |             |
| s_max7219_if_start_config     | std_logic                                                |             |
| s_max7219_if_en_load_config   | std_logic                                                |             |
| s_max7219_if_data_config      | std_logic_vector(15 downto 0)                            |             |
| s_config_done                 | std_logic                                                |             |
| s_max7219_if_done_static      | std_logic                                                |             |
| s_max7219_if_start_static     | std_logic                                                |             |
| s_max7219_if_en_load_static   | std_logic                                                |             |
| s_max7219_if_data_static      | std_logic_vector(15 downto 0)                            |             |
| s_ptr_equality_static         | std_logic                                                |             |
| s_ptr_equality_static_p1      | std_logic                                                |             |
| s_discard_static              | std_logic                                                |             |
| s_status_static               | std_logic                                                |             |
| s_busy_scroller               | std_logic                                                |             |
| s_max7219_if_done_scroller    | std_logic                                                |             |
| s_max7219_if_start_scroller   | std_logic                                                |             |
| s_max7219_if_en_load_scroller | std_logic                                                |             |
| s_max7219_if_data_scroller    | std_logic_vector(15 downto 0)                            |             |
| s_max7219_if_start            | std_logic                                                |             |
| s_max7219_if_en_load          | std_logic                                                |             |
| s_max7219_if_data             | std_logic_vector(15 downto 0)                            |             |
| s_max7219_load                | std_logic                                                |             |
| s_max7219_data                | std_logic                                                |             |
| s_max7219_clk                 | std_logic                                                |             |
| s_max7219_if_done             | std_logic                                                |             |
| s_mux_sel                     | std_logic_vector(1 downto 0)                             |             |
| s_new_config_val              | std_logic                                                |             |
## Processes
- **p_static_status_mngt**: ***( clk, rst_n )***

## Instantiations
- **max7219_display_sequencer_inst_0**: max7219_display_sequencer

- **max7219_config_if_inst_0**: max7219_config_if

- **max7219_cmd_decod_inst_0**: max7219_cmd_decod

- **max7219_scroller_ctrl_inst_0**: max7219_scroller_ctrl

- **max7219_mux_sel_inst_0**: max7219_mux_sel

- **max7219_if_inst_0**: max7219_if

