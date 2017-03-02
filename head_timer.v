// Value After RESET
`define RST_IM              0
`define RST_Mode            2'b0
`define RST_Enable          0
`define RST_PRESET          32'b0
`define RST_COUNT           32'b0

// CTRL Register:
// IM
`define IM_FORBID           0
`define IM_ALLOW            1

// Mode
`define Mode_0              2'b0
`define Mode_1              2'b1
`define Mode_UNDEF_1        2'b10
`define Mode_UNDEF_2        2'b11

// Enable
`define EN_STOP             0
`define EN_ALLOW            1

// ADD
`define ADD_CTRL            2'b0
`define ADD_PRESET          2'b1
`define ADD_COUNT           2'b10