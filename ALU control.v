`include    ".\\head_mips.v"

module ALU_ctrl ( ALUOp_I, Func_I, ALUoperation_O ) ;
  input  [3:0] ALUOp_I ;
  input  [5:0] Func_I ;
  output [3:0] ALUoperation_O ;
  
  reg [3:0] op_out ;
  
  assign ALUoperation_O = op_out ;
  
  always @(*)
  begin
    casex ( { Func_I, ALUOp_I } )
      10'b100000_0000 : op_out = `MUX_ALU_ADD ;
      10'b100001_0000 : op_out = `MUX_ALU_ADD ;
      10'b100010_0000 : op_out = `MUX_ALU_SUB ;
      10'b100011_0000 : op_out = `MUX_ALU_SUB ;
      10'b000000_0000 : op_out = `MUX_ALU_SLL ;
      10'b000010_0000 : op_out = `MUX_ALU_SRL ;
      10'b000011_0000 : op_out = `MUX_ALU_SRA ;
      10'b000100_0000 : op_out = `MUX_ALU_SLL ;
      10'b000110_0000 : op_out = `MUX_ALU_SRL ;
      10'b000111_0000 : op_out = `MUX_ALU_SRA ;
      10'b100100_0000 : op_out = `MUX_ALU_AND ;
      10'b100101_0000 : op_out = `MUX_ALU_OR ;
      10'b100110_0000 : op_out = `MUX_ALU_XOR ;
      10'b100111_0000 : op_out = `MUX_ALU_NOR ;
      10'b101010_0000 : op_out = `MUX_ALU_COMP ;
      10'b101011_0000 : op_out = `MUX_ALU_COMPU ;

      10'b??????_0001 : op_out = `MUX_ALU_ADD ;
      10'b??????_0010 : op_out = `MUX_ALU_SUB ;
      10'b??????_0011 : op_out = `MUX_ALU_OR ;
      10'b??????_0100 : op_out = `MUX_ALU_UP ;
      10'b??????_0101 : op_out = `MUX_ALU_COMP ;
      10'b??????_0110 : op_out = `MUX_ALU_AND ;
      10'b??????_0111 : op_out = `MUX_ALU_XOR ;
      10'b??????_1000 : op_out = `MUX_ALU_BLEZ ;
      10'b??????_1001 : op_out = `MUX_ALU_BGTZ ;
      10'b??????_1010 : op_out = `MUX_ALU_BLTZ ;
      10'b??????_1011 : op_out = `MUX_ALU_BGEZ ;
      10'b??????_1100 : op_out = `MUX_ALU_COMPU ;
              default : op_out = 4'b0 ;
    endcase
  end
  
endmodule