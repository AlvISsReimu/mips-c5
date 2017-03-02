module ir ( clk, we, din, dout ) ;
  input         clk  ;
  input         we   ;
  input  [31:0] din  ;
  output [31:0] dout ;
  
  reg [31:0] register ;
  
  always @(posedge clk)
  begin
    if (we)
      register = din ;
  end
  
  assign dout = register ;
  
endmodule