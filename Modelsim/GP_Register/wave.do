onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 50 /GP_Register_tb/in_clk
add wave -noupdate -height 50 /GP_Register_tb/in_rstn
add wave -noupdate -height 50 /GP_Register_tb/in_wr_ctrl
add wave -noupdate -height 50 -radix unsigned -radixshowbase 1 /GP_Register_tb/in_d
add wave -noupdate -height 50 -radix unsigned -radixshowbase 1 /GP_Register_tb/out_q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70344 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 331
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
WaveRestoreZoom {0 ps} {112968 ps}
