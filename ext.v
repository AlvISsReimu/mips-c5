`include    ".\\head_mips.v"

module ext ( op_I, imm16_I, Signext_O ) ;
  input  [31:26] op_I ;
  input  [15:0]  imm16_I ;
  output [31:0]  Signext_O ;
  
  reg signed [31:0] extended ;
  
  assign Signext_O = extended ;
  
  always @(*)
  begin
    if ( (op_I==`OP_SLTI)||(op_I==`OP_ADDI)||(op_I==`OP_ADDIU)||(op_I==`OP_SLTIU)||(op_I==`OP_BEQ)||(op_I==`OP_BNE)||(op_I==`OP_BLEZ)||(op_I==`OP_BGTZ)||(op_I==`OP_REGIMM) )
      extended = ( imm16_I[15] ? { 16'hFFFF, imm16_I } : { 16'b0, imm16_I } ) ;
    else
      extended = { 16'b0, imm16_I } ;
  end
  
endmodule