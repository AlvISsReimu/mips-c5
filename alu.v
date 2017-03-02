`include    ".\\head_mips.v"

module alu( A_I, B_I, ALUoperation_I, Zero_O, Result_O ) ;
  input  [31:0]  A_I ;
  input  [31:0]  B_I ;
  input  [3:0]   ALUoperation_I ;
  output         Zero_O ;
  output [31:0]  Result_O ;
  
  reg [31:0] cout ;
  reg ifzero ;
  reg [31:0] temp ;
  
  assign Result_O = cout ;
  assign Zero_O   = ifzero ;
  
  integer i ;
  
  always @(*)
    begin
      ifzero = 0;
      case (ALUoperation_I)
        `MUX_ALU_ADD:  cout = A_I + B_I ;
        `MUX_ALU_SUB:  cout = A_I - B_I ;
        `MUX_ALU_COMP: cout = ( ($signed(A_I) < $signed(B_I)) ? 1 : 0) ;
        `MUX_ALU_COMPU:cout = ( (A_I < B_I) ? 1 : 0) ;
        `MUX_ALU_OR:   cout = A_I | B_I ;
        `MUX_ALU_UP:   cout = B_I << 16 ;
        `MUX_ALU_AND:  cout = A_I & B_I ;
        `MUX_ALU_XOR:  cout = (A_I&~(B_I))|(B_I&~(A_I)) ;
        `MUX_ALU_NOR:  cout = ~(A_I | B_I) ;
        `MUX_ALU_BLEZ: cout = ( ($signed(A_I) <= 0) ? 0 : 1) ;
        `MUX_ALU_BGTZ: cout = ( ($signed(A_I) > 0) ? 0 : 1) ;
        `MUX_ALU_BLTZ: cout = ( ($signed(A_I) < 0) ? 0 : 1) ;
        `MUX_ALU_BGEZ: cout = ( ($signed(A_I) >= 0) ? 0 : 1) ;
        `MUX_ALU_SLL:  cout = B_I << A_I ;
        `MUX_ALU_SRL:  cout = B_I >> A_I ;
        `MUX_ALU_SRA:  begin temp <= B_I ;
                         for (i=0;i<A_I;i=i+1)
                           temp = { B_I[31], temp[31:1] } ;
                         cout = temp ;
                       end
        default:       cout = 0 ;
      endcase
      ifzero <= (cout == 0 ? 1 : 0) ;
    end
    
 endmodule