onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 50 /Lab_2_tb/in_clk
add wave -noupdate -height 50 /Lab_2_tb/in_rstn
add wave -noupdate -height 50 /Lab_2_tb/in_execute_n
add wave -noupdate -height 50 /Lab_2_tb/in_ext_input
add wave -noupdate -height 50 /Lab_2_tb/in_opcode
add wave -noupdate -height 50 /Lab_2_tb/out_A_bus
add wave -noupdate -height 50 /Lab_2_tb/out_B_bus
add wave -noupdate -height 50 /Lab_2_tb/out_C_bus
add wave -noupdate -height 50 /Lab_2_tb/out_out
add wave -noupdate -height 50 {/Lab_2_tb/out_seven_segs[2]}
add wave -noupdate -height 50 {/Lab_2_tb/out_seven_segs[1]}
add wave -noupdate -height 50 {/Lab_2_tb/out_seven_segs[0]}
add wave -noupdate -height 50 /Lab_2_tb/out_carry_out
add wave -noupdate -height 50 {/Lab_2_tb/out_seven_segs[4]}
add wave -noupdate -height 50 /Lab_2_tb/out_zero_out
add wave -noupdate -height 50 {/Lab_2_tb/out_seven_segs[3]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1192325 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 485
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
WaveRestoreZoom {0 ps} {5460 ns}
