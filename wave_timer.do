onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk -radix binary /testbench_timer/U_TIMER/CLK_I
add wave -noupdate -label rst -radix binary /testbench_timer/U_TIMER/RST_I
add wave -noupdate -label WE -radix binary /testbench_timer/U_TIMER/WE_I
add wave -noupdate -label ADD -radix unsigned /testbench_timer/U_TIMER/ADD_I
add wave -noupdate -label DAT_I -radix hexadecimal /testbench_timer/U_TIMER/DAT_I
add wave -noupdate -label PRESET -radix hexadecimal /testbench_timer/U_TIMER/PRESET
add wave -noupdate -label COUNT -radix unsigned /testbench_timer/U_TIMER/COUNT
add wave -noupdate -label CTRL -radix hexadecimal /testbench_timer/U_TIMER/CTRL
add wave -noupdate -label Mode -radix unsigned /testbench_timer/U_TIMER/Mode
add wave -noupdate -label Enable -radix binary /testbench_timer/U_TIMER/Enable
add wave -noupdate -label IM -radix binary /testbench_timer/U_TIMER/IM
add wave -noupdate -label IRQ -radix binary /testbench_timer/U_TIMER/IRQ_O
add wave -noupdate -label DAT_O -radix hexadecimal /testbench_timer/U_TIMER/DAT_O
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9340 ns} 0}
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {9262 ns} {10262 ns}
