`include    ".\\head_mips.v"

module control_unit ( clk_I, rst_I, op_I, Func_I, ALUout_I, Zero_I, Ir_25_21_I, Ir_20_16_I, IntReq_I, Ready, PCSrc_O, RegDst_O, MemtoReg_O, ALUSrcA_O, ALUSrcB_O, be_O, MemWrite_O, RegWrite_O, IRWrite_O, PCWrite_O, ALUOp_O, MDOp_O, MT_O, MDCTRL_O, TimerWrite_O, EPC_Wen_O, EXLSet_O, EXLClr_O ) ;
  input          clk_I ;
  input          rst_I ;
  input  [31:26] op_I ;
  input  [5:0]   Func_I ;
  input  [31:0]  ALUout_I ;
  input          Zero_I ;
  input  [4:0]   Ir_20_16_I ;
  input  [4:0]   Ir_25_21_I ;
  input          IntReq_I ;
  input          Ready ;
  output [2:0]   PCSrc_O ;
  output [1:0]   RegDst_O ;
  output [2:0]   MemtoReg_O ;
  output [1:0]   ALUSrcA_O ;
  output [1:0]   ALUSrcB_O ;
  output [3:0]   be_O ;
  output         MemWrite_O ;
  output         RegWrite_O ;
  output         IRWrite_O ;
  output         PCWrite_O ;
  output [3:0]   ALUOp_O ;
  output [2:0]   MDOp_O ;
  output [1:0]   MT_O ;
  output         MDCTRL_O ;
  output         TimerWrite_O ;
  output         EPC_Wen_O ;
  output         EXLSet_O ;
  output         EXLClr_O ;
  
  reg       memwrite, regwrite, irwrite, pcwrite, mdctrl, timerwrite, epc_wen, exlset, exlclr ;
  reg [2:0] pcsrc = `MUX_PCSrc_PCCYCLE ;
  reg [1:0] regdst ;
  reg [2:0] memtoreg ;
  reg [1:0] alusrca ;
  reg [1:0] alusrcb ;
  reg [3:0] be ;
  reg [3:0] aluop ;
  reg [2:0] mdop ;
  reg [1:0] mt ;
  reg [4:0] fsm_state ;
  
  assign PCSrc_O    = pcsrc ;
  assign RegDst_O   = regdst ;
  assign MemtoReg_O = memtoreg ;
  assign ALUSrcA_O  = alusrca ;
  assign ALUSrcB_O  = alusrcb ;
  assign MemWrite_O = memwrite ;
  assign RegWrite_O = regwrite ;
  assign IRWrite_O  = irwrite ;
  assign PCWrite_O  = pcwrite ;
  assign be_O       = be ;
  assign ALUOp_O    = aluop ;
  assign MDOp_O     = mdop ;
  assign MT_O       = mt ;
  assign MDCTRL_O   = mdctrl ;
  assign TimerWrite_O = timerwrite ;
  assign EPC_Wen_O  = epc_wen ;
  assign EXLSet_O   = exlset ;
  assign EXLClr_O   = exlclr ;
  
  always @(posedge clk_I or posedge rst_I)
  begin
    if (rst_I)
      fsm_state <= `S0 ;
    else
    begin
    case ( fsm_state )
      `S0 : fsm_state <= `S1 ;
      `S1 : begin
              case ( op_I )
                `OP_SPECIAL: begin case (Func_I)
                                     `FUNC_JR:   fsm_state <= `S11 ;
                                     `FUNC_JALR: fsm_state <= `S12 ;
                                     `FUNC_MULT: fsm_state <= `S14 ;
                                     `FUNC_MULTU:fsm_state <= `S14 ;
                                     `FUNC_DIV:  fsm_state <= `S14 ;
                                     `FUNC_DIVU: fsm_state <= `S14 ;
                                     `FUNC_MFHI: fsm_state <= `S15 ;
                                     `FUNC_MFLO: fsm_state <= `S15 ;
                                     `FUNC_MTHI: fsm_state <= `S17 ;
                                     `FUNC_MTLO: fsm_state <= `S17 ;
                                        default: fsm_state <= `S2 ;
                                   endcase 
                             end
                             
                `OP_ORI:     fsm_state <= `S4 ;
                `OP_LUI:     fsm_state <= `S4 ;
                `OP_ADDI:    fsm_state <= `S4 ;
                `OP_ADDIU:   fsm_state <= `S4 ;
                `OP_SLTI:    fsm_state <= `S4 ;
                `OP_ANDI:    fsm_state <= `S4 ;
                `OP_XORI:    fsm_state <= `S4 ;
                `OP_SLTIU:   fsm_state <= `S4 ;
                
                `OP_LW:      fsm_state <= `S6 ;
                `OP_LB:      fsm_state <= `S6 ;
                `OP_LBU:     fsm_state <= `S6 ;
                `OP_LH:      fsm_state <= `S6 ;
                `OP_LHU:     fsm_state <= `S6 ;
                `OP_SW:      fsm_state <= `S6 ;
                `OP_SB:      fsm_state <= `S6 ;
                `OP_SH:      fsm_state <= `S6 ;
                
                `OP_BEQ:     fsm_state <= `S10 ;
                `OP_BNE:     fsm_state <= `S10 ;
                `OP_BLEZ:    fsm_state <= `S10 ;
                `OP_BGTZ:    fsm_state <= `S10 ;
                `OP_REGIMM:  fsm_state <= `S10 ;
                
                `OP_J:       fsm_state <= `S11 ;
                `OP_JAL:     fsm_state <= `S12 ;
                
                `OP_COP0: begin
                  if ( Func_I==`COP0_ERET )
                    fsm_state <= `S19 ;
                  else
                    fsm_state <= ( Ir_25_21_I==`COP0_MFC0 )?`S20:`S21;
                  end
              endcase
            end
      `S2 : fsm_state <= `S3 ;
      `S3 : fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S4 : fsm_state <= `S5 ;
      `S5 : fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S6 : begin
              case ( op_I )
                `OP_LW:    fsm_state <= `S7 ;
                `OP_LB:    fsm_state <= `S7 ;
                `OP_LBU:   fsm_state <= `S7 ;
                `OP_LH:    fsm_state <= `S7 ;
                `OP_LHU:   fsm_state <= `S7 ;
                `OP_SW:    fsm_state <= `S9 ;
                `OP_SB:    fsm_state <= `S9 ;
                `OP_SH:    fsm_state <= `S9 ;
              endcase
            end
      `S7 : fsm_state <= `S8 ;
      `S8 : fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S9 : fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S10: fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S11: fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S12: fsm_state <= `S13 ;
      `S13: fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S14: fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S15: begin
        if ( Ready==1 )
          fsm_state <= `S16 ;
        else
          begin
            if ( mdop==`MDOP_OFF )
              fsm_state <= `S16 ;
            else
              fsm_state <= `S15 ;
          end
        end
      `S16: fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S17: fsm_state <= (IntReq_I)?`S18:`S0 ;
      `S18: fsm_state <= `S0 ;
      `S19: fsm_state <= `S0 ;
      `S20: fsm_state <= `S0 ;
      `S21: fsm_state <= `S0 ;
      default: fsm_state <= `S0 ;
    endcase
  end
  end
  
  always @(*)
  begin
    case ( fsm_state )
      `S0 : begin
      pcsrc=(pcsrc!=`MUX_PCSrc_EPC)?`MUX_PCSrc_PCCYCLE:`MUX_PCSrc_EPC2;
      memwrite=0;
      epc_wen=0;
      be=`be_sw;
      timerwrite=0;
      regwrite=0;
      irwrite=1;
      pcwrite=1;
      exlset=0;
      exlclr=0;
      mt=`MT_OFF;
      memtoreg=`MUX_MemtoReg_ALUOUT;
      end
      
      `S1 : begin
      alusrca=`MUX_ALUSrcA_PC;
      alusrcb=`MUX_ALUSrcB_EXT2;
      memwrite=0;
      timerwrite=0;
      regwrite=0;
      irwrite=0;
      pcwrite=0;
      aluop=4'b1;
      end
      
      `S2 : begin
      alusrcb=`MUX_ALUSrcB_GPR_B;
      aluop=4'b0;
      mdop<=`MDOP_OFF;
      mdctrl=`MDCTRL_OFF;
      case ( Func_I )
      `FUNC_SLL: alusrca=`MUX_ALUSrcA_SA;
      `FUNC_SRL: alusrca=`MUX_ALUSrcA_SA;
      `FUNC_SRA: alusrca=`MUX_ALUSrcA_SA;
      default: alusrca=`MUX_ALUSrcA_GPR_A;
      endcase
      end
      
      `S3 : begin
      regdst=`MUX_RegDst_Rd;
      memtoreg=`MUX_MemtoReg_ALUOUT;
      regwrite=1;
      end
      
      `S4 : begin
      alusrca=`MUX_ALUSrcA_GPR_A;
      alusrcb=`MUX_ALUSrcB_EXT;
      mdop<=`MDOP_OFF;
      mdctrl=`MDCTRL_OFF;
      case ( op_I )
      `OP_ORI:   aluop=4'b11 ;
      `OP_LUI:   aluop=4'b100 ;
      `OP_ADDI:  aluop=4'b1 ;
      `OP_ADDIU: aluop=4'b1 ;
      `OP_SLTI:  aluop=4'b101 ;
      `OP_ANDI:  aluop=4'b110 ;
      `OP_XORI:  aluop=4'b111 ;
      `OP_SLTIU: aluop=4'b1100 ;
      endcase
      end
      
      `S5 : begin
      regdst=`MUX_RegDst_Rt;
      memtoreg=`MUX_MemtoReg_ALUOUT;
      regwrite=1;
      end
      
      `S6 : begin
      alusrca=`MUX_ALUSrcA_GPR_A;
      alusrcb=`MUX_ALUSrcB_EXT;
      aluop=4'b1;
      mdop<=`MDOP_OFF;
      mdctrl=`MDCTRL_OFF;
      end
      
      `S8 : begin
        if ( (ALUout_I>='h7F00)&&((ALUout_I<='h7F0B)) )
          memtoreg=`MUX_MemtoReg_PRDIN;
        else
          memtoreg=`MUX_MemtoReg_DR;
      regdst=`MUX_RegDst_Rt;
      regwrite=1;
      end
      
      `S9 : begin
        if ( (ALUout_I>=32'h7F00)&&((ALUout_I<=32'h7F0B)) )
          timerwrite = 1 ;
        else
          memwrite = 1;
      casex ( {op_I,ALUout_I[1:0]} )
      8'b101011_??: be=`be_sw ;
      8'b101001_0?: be=`be_sh_byte10 ;
      8'b101001_1?: be=`be_sh_byte32 ;
      8'b101000_00: be=`be_sb_byte0 ;
      8'b101000_01: be=`be_sb_byte1 ;
      8'b101000_10: be=`be_sb_byte2 ;
      8'b101000_11: be=`be_sb_byte3 ;
      endcase
      end
      
      `S10: begin
      alusrca=`MUX_ALUSrcA_GPR_A;
      alusrcb=`MUX_ALUSrcB_GPR_B;
      mdop<=`MDOP_OFF;
      mdctrl=`MDCTRL_OFF;
      case ( op_I )
      `OP_BNE:    begin aluop=4'b10;   pcwrite=(!Zero_I?1:0); pcsrc=`MUX_PCSrc_SHIFT_BNE; end
      `OP_BEQ:    begin aluop=4'b10;   pcwrite=(Zero_I?1:0);  pcsrc=`MUX_PCSrc_SHIFT; end
      `OP_BLEZ:   begin aluop=4'b1000; pcwrite=(Zero_I?1:0);  pcsrc=`MUX_PCSrc_SHIFT; end
      `OP_BGTZ:   begin aluop=4'b1001; pcwrite=(Zero_I?1:0);  pcsrc=`MUX_PCSrc_SHIFT; end
      `OP_REGIMM: begin aluop=(( Ir_20_16_I==0 )?4'b1010:4'b1011);  pcwrite=(Zero_I?1:0);  pcsrc=`MUX_PCSrc_SHIFT; end
      endcase
      end
      
      `S11: begin
      pcwrite=1;
      mdop<=`MDOP_OFF;
      mdctrl=`MDCTRL_OFF;
      case ( op_I )
      `OP_J       : pcsrc=`MUX_PCSrc_JUMPADD;
      `OP_SPECIAL : pcsrc=`MUX_PCSrc_GPR_A;
      endcase
      end
      
      `S12: begin
      alusrca=`MUX_ALUSrcA_PC;
      alusrcb=`MUX_ALUSrcB_PCCYCLE;
      aluop=4'b1; mdop<=`MDOP_OFF;
      mdctrl=`MDCTRL_OFF;
      end
      
      `S13: begin
      memtoreg=`MUX_MemtoReg_ALUOUT;
      regwrite=1;
      pcwrite=1;
      case ( op_I )
      `OP_JAL     : begin pcsrc=`MUX_PCSrc_JUMPADD; regdst=`MUX_RegDst_31; end
      `OP_SPECIAL : begin pcsrc=`MUX_PCSrc_GPR_A;   regdst=`MUX_RegDst_Rd; end
      endcase
      end
      
      `S14: begin
      alusrca=`MUX_ALUSrcA_GPR_A;
      alusrcb=`MUX_ALUSrcB_GPR_B;
      mdctrl=`MDCTRL_ON;
      case ( Func_I )
      `FUNC_MULT:  mdop <=  `MDOP_MULT ;
      `FUNC_MULTU: mdop <=  `MDOP_MULTU ;
      `FUNC_DIV:   mdop <=  `MDOP_DIV ;
      `FUNC_DIVU:  mdop <=  `MDOP_DIVU ;
      endcase
      end
      
      `S16: begin
      regdst=`MUX_RegDst_Rd;
      regwrite=1;
      mdctrl=`MDCTRL_OFF;
      case ( Func_I )
      `FUNC_MFHI: memtoreg <= `MUX_MemtoReg_HI ;
      `FUNC_MFLO: memtoreg <= `MUX_MemtoReg_LO ;
      endcase
      end
      
      `S17: begin
      mdop<=`MDOP_OFF;
      mdctrl=`MDCTRL_OFF;
      case ( Func_I )
      `FUNC_MTHI: mt <= `MT_HI ;
      `FUNC_MTLO: mt <= `MT_LO ;
      default: mt <= `MT_OFF ;
      endcase
      end
      
      `S18: begin
        pcwrite=1;
        epc_wen=1;
        pcsrc=`MUX_PCSrc_ISR;
        exlclr=0;
        exlset=1;
      end
      
      `S19: begin
        pcsrc=`MUX_PCSrc_EPC;
        pcwrite=1;
        exlset=0;
        exlclr=1;
        mdop<=`MDOP_OFF;
        mdctrl=`MDCTRL_OFF;
      end
      
      `S20: begin
        memtoreg=`MUX_MemtoReg_CP0;
        regdst=`MUX_RegDst_Rt;
        regwrite=1;
        mdop<=`MDOP_OFF;
        mdctrl=`MDCTRL_OFF;
      end
      
      `S21: begin
        epc_wen=1;
        mdop<=`MDOP_OFF;
        mdctrl=`MDCTRL_OFF;
      end
      
      endcase
      end
      
endmodule