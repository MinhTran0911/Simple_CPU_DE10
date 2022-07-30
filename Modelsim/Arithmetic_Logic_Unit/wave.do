onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 100 -radix unsigned -radixshowbase 1 /Arithmetic_Logic_Unit_tb/in_A
add wave -noupdate -height 100 -radix unsigned -radixshowbase 1 /Arithmetic_Logic_Unit_tb/in_B
add wave -noupdate -height 100 -radix binary -radixshowbase 1 /Arithmetic_Logic_Unit_tb/in_F
add wave -noupdate -height 100 -radix unsigned -radixshowbase 1 /Arithmetic_Logic_Unit_tb/out_C
add wave -noupdate -height 100 -radix binary -radixshowbase 1 /Arithmetic_Logic_Unit_tb/out_flags
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {72900 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 403
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
WaveRestoreZoom {67364 ps} {202096 ps}
