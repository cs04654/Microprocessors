onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix ascii /MCPUtb/cpuinst/STATE_AS_STR
add wave -noupdate /MCPUtb/cpuinst/pc
add wave -noupdate /MCPUtb/cpuinst/opcode
add wave -noupdate /MCPUtb/cpuinst/operand1
add wave -noupdate /MCPUtb/cpuinst/operand2
add wave -noupdate /MCPUtb/cpuinst/operand3
add wave -noupdate /MCPUtb/cpuinst/regset_cmd
add wave -noupdate /MCPUtb/cpuinst/regset_wb
add wave -noupdate /MCPUtb/cpuinst/regdatatoload
add wave -noupdate /MCPUtb/cpuinst/RegOp1
add wave -noupdate /MCPUtb/cpuinst/regfileinst/R
add wave -noupdate -radix unsigned /MCPUtb/cpuinst/raminst/mem
add wave -noupdate -radix unsigned {/MCPUtb/cpuinst/raminst/mem[20]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 101
configure wave -valuecolwidth 91
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
WaveRestoreZoom {0 ps} {1077 ps}
