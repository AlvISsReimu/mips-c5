`timescale  1ns/1ns

//`define DEBUG

`define CLK_FRQ             50000000                // 50MGHz : system clock
`define CYCLE               (1000000000/`CLK_FRQ)
`define DELAY_MS            1000                    // the delay unit is microsecond
`define PC_INITIAL          ('h0000_3000)
`define PC_CYCLE            4

//Storage
`define STO_DM              3072
`define STO_IM              2048

//OP code
`define OP_SPECIAL          6'b000000
`define OP_ANDI             6'b001100
`define OP_XORI             6'b001110
`define OP_ORI              6'b001101
`define OP_LUI              6'b001111
`define OP_ADDI             6'b001000
`define OP_ADDIU            6'b001001
`define OP_SLTI             6'b001010
`define OP_SLTIU            6'b001011
`define OP_LW               6'b100011
`define OP_LB               6'b100000
`define OP_LBU              6'b100100
`define OP_LH               6'b100001
`define OP_LHU              6'b100101
`define OP_SW               6'b101011
`define OP_SB               6'b101000
`define OP_SH               6'b101001
`define OP_BEQ              6'b000100
`define OP_BNE              6'b000101
`define OP_BLEZ             6'b000110
`define OP_BGTZ             6'b000111
`define OP_REGIMM           6'b000001
`define OP_J                6'b000010
`define OP_JAL              6'b000011
`define OP_COP0             6'b010000

//Function code
`define FUNC_JR             6'b001000
`define FUNC_JALR           6'b001001
`define FUNC_SLL            6'b000000
`define FUNC_SRL            6'b000010
`define FUNC_SRA            6'b000011
`define FUNC_MFHI           6'b010000
`define FUNC_MTHI           6'b010001
`define FUNC_MFLO           6'b010010
`define FUNC_MTLO           6'b010011
`define FUNC_MULT           6'b011000
`define FUNC_MULTU          6'b011001
`define FUNC_DIV            6'b011010
`define FUNC_DIVU           6'b011011

//COP0
`define COP0_ERET           6'b011000
`define COP0_MFC0           5'b00000
`define COP0_MTC0           5'b00100

//MULT & DIV op
`define MDOP_MULT           3'b0
`define MDOP_MULTU          3'b1
`define MDOP_DIV            3'b10
`define MDOP_DIVU           3'b11
`define MDOP_OFF            3'b100

//MULT & DIV control
`define MDCTRL_ON           1
`define MDCTRL_OFF          0

//MULT & DIV MoveTo HI/LO
`define MT_HI               2'b1
`define MT_LO               2'b0
`define MT_OFF              2'b10


//MUX encode:

//MUX_RegDst
`define MUX_RegDst_Rt       2'b0
`define MUX_RegDst_Rd       2'b1
`define MUX_RegDst_31       2'b10
`define MUX_RegDst_Rs       2'b11

//MUX_MemtoReg
`define MUX_MemtoReg_ALUOUT 3'b0
`define MUX_MemtoReg_DR     3'b1
`define MUX_MemtoReg_HI     3'b10
`define MUX_MemtoReg_LO     3'b11
`define MUX_MemtoReg_PRDIN  3'b100
`define MUX_MemtoReg_CP0    3'b101

//MUX_ALUSrcA
`define MUX_ALUSrcA_GPR_A   2'b0
`define MUX_ALUSrcA_PC      2'b1
`define MUX_ALUSrcA_SA      2'b10

//MUX_ALUSrcB
`define MUX_ALUSrcB_EXT     2'b0
`define MUX_ALUSrcB_GPR_B   2'b1
`define MUX_ALUSrcB_PCCYCLE 2'b10
`define MUX_ALUSrcB_EXT2    2'b11


//MUX_PCSrc
`define MUX_PCSrc_PCCYCLE   3'b0
`define MUX_PCSrc_GPR_A     3'b1
`define MUX_PCSrc_SHIFT     3'b10
`define MUX_PCSrc_JUMPADD   3'b11
`define MUX_PCSrc_SHIFT_BNE 3'b100
`define MUX_PCSrc_ISR       3'b101
`define MUX_PCSrc_EPC       3'b110
`define MUX_PCSrc_EPC2      3'b111

//MUX_ALU
`define MUX_ALU_ADD         4'b0
`define MUX_ALU_SUB         4'b1
`define MUX_ALU_COMP        4'b10
`define MUX_ALU_OR          4'b11
`define MUX_ALU_UP          4'b100
`define MUX_ALU_AND         4'b101
`define MUX_ALU_XOR         4'b110
`define MUX_ALU_NOR         4'b111
`define MUX_ALU_BLEZ        4'b1000
`define MUX_ALU_BGTZ        4'b1001
`define MUX_ALU_BLTZ        4'b1010
`define MUX_ALU_BGEZ        4'b1011
`define MUX_ALU_SLL         4'b1100
`define MUX_ALU_SRL         4'b1101
`define MUX_ALU_SRA         4'b1110
`define MUX_ALU_COMPU       4'b1111

//be
`define be_sw               4'b1111
`define be_sh_byte10        4'b0011
`define be_sh_byte32        4'b1100
`define be_sb_byte0         4'b0001
`define be_sb_byte1         4'b0010
`define be_sb_byte2         4'b0100
`define be_sb_byte3         4'b1000

//FSM_STATE
`define S0                  5'b0
`define S1                  5'b1
`define S2                  5'b10
`define S3                  5'b11
`define S4                  5'b100
`define S5                  5'b101
`define S6                  5'b110
`define S7                  5'b111
`define S8                  5'b1000
`define S9                  5'b1001
`define S10                 5'b1010
`define S11                 5'b1011
`define S12                 5'b1100
`define S13                 5'b1101
`define S14                 5'b1110
`define S15                 5'b1111
`define S16                 5'b10000
`define S17                 5'b10001
`define S18                 5'b10010
`define S19                 5'b10011
`define S20                 5'b10100
`define S21                 5'b10101