`include    ".\\head_mips.v"

module mips ( clk, rst, HWInt, PrDIn, PrDOut, PrAddr, BE, Wen ) ;
  //mips:
  input clk ;                                                    //clock
  input rst ;                                                    //reset
  input [7:2] HWInt ;
  input [31:0] PrDIn ;
  
  output [31:2] PrAddr ;
  output  [3:0] BE ;
  output [31:0] PrDOut ;
  output        Wen ;
  
  wire [31:0] inst ;                                              //instruction
  wire [31:0] ir_inst ;
  
  //Signals:
  wire [1:0]  RegDst ;
  wire [1:0]  ALUSrcA ;
  wire [1:0]  ALUSrcB ;
  wire        MemWrite, RegWrite, PCWrite, IRWrite, Ready, MDCtrl, TimerWrite, EPC_Wen, EXLSet, EXLClr ;
  wire [2:0]  MemtoReg ;
  wire [2:0]  PCSrc ;
  wire [3:0]  be ;
  wire [3:0]  ALUOp ;
  wire [3:0]  ALUoperation ;
  wire [2:0]  MDOp ;
  wire [1:0]  MT ;
  
  //GPR:
  wire [31:0] Reg1 ;                                             //first visiting address of GPR
  wire [31:0] Reg2 ;                                             //second visiting address of GPR
  wire [31:0] GPR_Wdata;                                         //data written into GPR
  wire [4:0]  Wreg ;                                             //writing data's address
  wire [31:0] Rdata1 ;                                           //data read from Reg1
  wire [31:0] Rdata2 ;                                           //data read from Reg2
  wire [31:0] GPR_A ;
  wire [31:0] GPR_B ;
  
  //ALU:
  wire [31:0] ALU_A ;                                            //input A into ALU
  wire [31:0] ALU_B ;                                            //input B into ALU
  wire        Zero ;                                             //if ALU's result is 0
  wire [31:0] ALU_result ;                                       //ALU's output
  wire [31:0] ALUout ;
  
  //DM:
  wire [16:2] DM_add ;                                           //visiting address of DM
  wire [31:0] DM_Wdata ;                                         //data written into DM
  wire [31:0] DM_Rdata ;                                         //data read from DM
  wire [31:0] DRout ;
  wire [31:0] EXT_dout ;
  
  //PC&NPC:
  wire [31:2] PC ;                                                //program counter
  wire [31:2] NPC ;                                              //next PC
  wire [25:0] Jumpadd ;                                          //jump address
  
  //EXT:
  wire [15:0] imm16 ;                                            //immediate number (16-bit)
  wire [31:0] imm ;                                              //Sign-ext immediate number (32-bit)
  
  //MULT & DIV
  wire [31:0] HI ;
  wire [31:0] LO ;
  
  //CP0
  wire [31:2] EPC ;
  wire [31:0] CP0DIn ;
  wire [31:0] CP0DOut ;
  wire  [4:0] Sel ;
  wire        IntReq ;
  
  //[Instantiation]
  
  //datapath:
  gpr U_RF( Reg1, Reg2, clk, rst, GPR_Wdata, Wreg, RegWrite, Rdata1, Rdata2 ) ;
  im_8k U_IM ( PC[21:2], inst ) ;
  dmout_ext DMOUT_EXT ( ir_inst[31:26], DM_Rdata, ALUout[1:0], EXT_dout ) ;
  dm_12k U_DM( DM_add[16:2], DM_Wdata, MemWrite, be, clk, DM_Rdata, rst ) ;
  npc NextPC( PC, GPR_A, ALUout, Jumpadd, PCSrc, Zero, EPC, NPC ) ;
  ext EXT( ir_inst[31:26], imm16, imm ) ;
  alu ALU( ALU_A, ALU_B, ALUoperation ,Zero, ALU_result ) ;
  pc U_PC ( clk, rst, NPC, PCWrite, PC ) ;
  mult_div MULT_DIV ( clk, MDCtrl, ALU_A, ALU_B, HI, LO, MDOp, MT, GPR_A, MemtoReg, Ready ) ;
  
  //registers:
  ir IR ( clk, IRWrite, inst, ir_inst ) ;
  dr DR ( clk, EXT_dout, DRout ) ;
  gpr_a A ( clk, Rdata1, GPR_A ) ;
  gpr_b B ( clk, Rdata2, GPR_B ) ;
  aluout ALUOUT ( clk, ALU_result, ALUout ) ;
  
  //control:
  control_unit controller( clk, rst, ir_inst[31:26], ir_inst[5:0], ALUout[31:0], Zero, ir_inst[25:21], ir_inst[20:16], IntReq, Ready, PCSrc, RegDst, MemtoReg, ALUSrcA, ALUSrcB, be, MemWrite, RegWrite, IRWrite, PCWrite, ALUOp, MDOp, MT, MDCtrl, TimerWrite, EPC_Wen, EXLSet, EXLClr ) ;
  ALU_ctrl alu_controller( ALUOp ,ir_inst[5:0] ,ALUoperation ) ;
  
  //MUX:
  MUX_RegDst m_regdst( RegDst, Wreg, ir_inst ) ;
  MUX_MemtoReg m_memtoreg( MemtoReg, ALUout, DRout, HI, LO, PrDIn, CP0DOut, GPR_Wdata ) ;
  MUX_ALUSrcA m_alusrca( ALUSrcA, GPR_A, PC, ir_inst, ALU_A ) ;
  MUX_ALUSrcB m_alusrcb( ALUSrcB, imm, GPR_B, ALU_B ) ;
  
  //CP0:
  cp0 U_CP0 ( clk, rst, PC, CP0DIn, HWInt, Sel, EPC_Wen, EXLSet, EXLClr, IntReq, EPC, CP0DOut ) ;
  
  //[Interface]
  assign Reg1     = ir_inst [25:21] ;
  assign Reg2     = ir_inst [20:16] ;
  assign imm16    = ir_inst [15:0] ;
  assign Jumpadd  = ir_inst [25:0]<<2 ;
  assign DM_add   = ALUout ;
  assign DM_Wdata = GPR_B ;
  
  assign BE       = be ;
  assign Wen      = TimerWrite ;
  assign PrAddr   = DM_add[16:2] ;
  assign PrDOut   = DM_Wdata ;
  
  assign Sel      = ir_inst [15:11] ;
  assign CP0DIn   = GPR_B ;
  
endmodule