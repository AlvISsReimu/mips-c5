`include    ".\\head_mips.v"

module dmout_ext( op, dout, ALUout, ext_dout ) ;
  input  [5:0]  op ;
  input  [31:0] dout ;
  input  [1:0]  ALUout ;
  output [31:0] ext_dout ;
  
  reg [31:0] out = 0 ;
  
  assign ext_dout = out ;
  
  always @(*)
  begin
    case (op)
      `OP_LW: out = dout ;
      
      `OP_LB: begin
        case (ALUout)
          2'b00: out = { (dout[7]==1?24'hFFFFFF:24'b0), dout[7:0] } ;
          2'b01: out = { (dout[15]==1?24'hFFFFFF:24'b0), dout[15:8] };
          2'b10: out = { (dout[23]==1?24'hFFFFFF:24'b0), dout[23:16] } ;
          2'b11: out = { (dout[31]==1?24'hFFFFFF:24'b0), dout[31:24] } ;
        endcase
      end
      
      `OP_LBU: begin
        case (ALUout)
          2'b00: out = {24'b0,dout[7:0]} ;
          2'b01: out = {24'b0,dout[15:8]} ;
          2'b10: out = {24'b0,dout[23:16]} ;
          2'b11: out = {24'b0,dout[31:24]} ;
        endcase
      end
      
      `OP_LH: begin
        case (ALUout[1])
          0: out = { (dout[15]==1?16'hFFFF:16'b0), dout[15:0] } ;
          1: out = { (dout[31]==1?16'hFFFF:16'b0), dout[31:16] } ;
        endcase
      end
      
      `OP_LHU: begin
        case (ALUout[1])
          0: out = {16'b0,dout[15:0]} ;
          1: out = {16'b0,dout[31:16]} ;
        endcase
      end
      
    endcase
  end
  
endmodule