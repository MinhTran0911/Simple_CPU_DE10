onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 100 -radix unsigned -radixshowbase 1 /B_bus_selector_tb/in_B_reg
add wave -noupdate -height 100 -radix unsigned -radixshowbase 1 /B_bus_selector_tb/in_ext_input
add wave -noupdate -height 100 /B_bus_selector_tb/in_B_sel
add wave -noupdate -height 100 -radix unsigned -radixshowbase 1 /B_bus_selector_tb/out_B_bus
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {109253 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 375
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {100650 ps}
