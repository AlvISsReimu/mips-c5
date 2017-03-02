`include    ".\\head_mips.v"
`include    ".\\head_cp0.v"

module npc ( pc_I, RD1_I, ALUout_I, Jumpadd_I, PCSrc_I, Zero_I, EPC_I, npc_O ) ;
  input  [31:2]  pc_I ;
  input  [31:2]  EPC_I ;
  input  [2:0]   PCSrc_I ;
  input  [31:0]  RD1_I ;
  input  [31:0]  ALUout_I ;
  input  [25:0]  Jumpadd_I ;
  input          Zero_I ;
  output [31:2]  npc_O ;
  
  reg [31:2] pcout ;
  
  assign npc_O = pcout ;
  
  always @(*)
  begin
    case (PCSrc_I)
      `MUX_PCSrc_PCCYCLE   : pcout <= pc_I + `PC_CYCLE ;
      `MUX_PCSrc_GPR_A     : pcout <= RD1_I ;
      `MUX_PCSrc_SHIFT     : if (Zero_I) pcout <= ALUout_I ;
      `MUX_PCSrc_SHIFT_BNE : if (!Zero_I) pcout <= ALUout_I ;
      `MUX_PCSrc_JUMPADD   : pcout <= { pc_I[31:28], Jumpadd_I } ;
      `MUX_PCSrc_ISR       : pcout <= `ISR_Add - `PC_CYCLE ;
      `MUX_PCSrc_EPC       : pcout <= EPC_I ;
      `MUX_PCSrc_EPC2      : pcout <= EPC_I +`PC_CYCLE ;
      default: pcout <= pc_I + `PC_CYCLE ;
    endcase
  end
  
endmodule