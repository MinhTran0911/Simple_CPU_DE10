onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 100 -radix unsigned -radixshowbase 1 /Sev_Segs_Display_tb/in_num
add wave -noupdate -height 100 /Sev_Segs_Display_tb/out_sev_segs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {249357 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 397
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
WaveRestoreZoom {0 ps} {262500 ps}
