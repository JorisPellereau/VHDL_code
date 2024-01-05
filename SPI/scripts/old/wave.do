onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/reset_n
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/clock
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/ssi
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/start_spi
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/wdata
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/miso
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/mosi
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/sclk
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/ssn
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/rdata
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/start_spi_s
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/start_spi_re
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/tick_clock
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/cnt_half_spi_clock
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/sclk_s
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/cnt_period_clock_spi
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/ssi_s
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/wdata_s
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/cnt_data
add wave -noupdate -expand -group {Master SPI} /test_master_spi/inst_master_spi/en_transaction
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 207
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits us
update
WaveRestoreZoom {147987085 ps} {553263838 ps}
