onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_PERIOD
add wave -noupdate /DE1_SoC_testbench/clk
add wave -noupdate /DE1_SoC_testbench/reset
add wave -noupdate /DE1_SoC_testbench/sw0
add wave -noupdate /DE1_SoC_testbench/sw1
add wave -noupdate /DE1_SoC_testbench/out
add wave -noupdate /DE1_SoC_testbench/dut/ps
add wave -noupdate /DE1_SoC_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1002 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1344 ps}
