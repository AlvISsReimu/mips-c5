module gpr_a ( clk, din, dout ) ;
  input         clk  ;
  input  [31:0] din  ;
  output [31:0] dout ;
  
  reg [31:0] register ;
  
  always @(posedge clk)
  begin
    register = din ;
  end
  
  assign dout = register ;
  
endmodule