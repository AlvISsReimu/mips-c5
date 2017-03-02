`include    ".\\head_mips.v"

module MUX_RegDst ( RegDst, Wreg, Ir ) ;
  input  [31:0] Ir ;
  input  [1:0]  RegDst ;
  output [4:0]  Wreg ;
  
  reg [4:0] wreg ;
  
  assign Wreg = wreg ;
  
  always @(*)
  begin
    case (RegDst)
      `MUX_RegDst_Rt: wreg <= Ir[20:16] ;
      `MUX_RegDst_Rd: wreg <= Ir[15:11] ;
      `MUX_RegDst_31: wreg <= 31 ;
      `MUX_RegDst_Rs: wreg <= Ir[25:21] ;
    endcase
  end
  
endmodule

module MUX_MemtoReg ( MemtoReg, Aluout, Dr, High, Low, PrDIn, CP0, Wdata ) ;
  input  [31:0] Aluout ;
  input  [31:0] Dr ;
  input  [31:0] High ;
  input  [31:0] Low ;
  input  [31:0] PrDIn ;
  input  [31:0] CP0 ;
  input  [2:0]  MemtoReg ;
  output [31:0] Wdata ;
  
  reg [31:0] mmt ;
  
  assign Wdata = mmt ;
  
  always @(*)
  begin
    case (MemtoReg)
      `MUX_MemtoReg_ALUOUT: mmt <= Aluout ;
      `MUX_MemtoReg_DR:     mmt <= Dr ;
      `MUX_MemtoReg_HI:     mmt <= High ;
      `MUX_MemtoReg_LO:     mmt <= Low ;
      `MUX_MemtoReg_PRDIN:  mmt <= PrDIn ;
      `MUX_MemtoReg_CP0:  mmt <= CP0 ;
      endcase
  end
  
endmodule

module MUX_ALUSrcA ( ALUSrcA, GPR_A, Pc, Ir, A ) ;
  input  [31:2] Pc ;
  input  [31:0] GPR_A ;
  input   [1:0] ALUSrcA ;
  input  [31:0] Ir ;
  output [31:0] A ;
  
  reg [31:0] a ;
  
  assign A = a ;
  
  always @(*)
  begin
    case (ALUSrcA)
      `MUX_ALUSrcA_GPR_A: a <= GPR_A ;
      `MUX_ALUSrcA_PC: a <= Pc ;
      `MUX_ALUSrcA_SA: a <= { 27'b0, Ir[10:6] } ;
      endcase
  end
  
endmodule

module MUX_ALUSrcB ( ALUSrcB, EXT, GPR_B, B ) ;
  input  [1:0]  ALUSrcB ;
  input  [31:0] EXT ;
  input  [31:0] GPR_B ;
  output [31:0] B ;
  
  reg [31:0] b ;
  
  assign B = b ;
  
  always @(*)
  begin
    case (ALUSrcB)
      `MUX_ALUSrcB_EXT:     b <= EXT ;
      `MUX_ALUSrcB_GPR_B:   b <= GPR_B ;
      `MUX_ALUSrcB_PCCYCLE: b <= 0 ;
      `MUX_ALUSrcB_EXT2:    b <= EXT<<2 ;
      endcase
  end
  
endmodule