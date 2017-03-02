`include    ".\\head_mips.v"

module pc (clk_I ,rst_I, Addr_I, PC_en_I, PC_O) ;
  input clk_I ;
  input rst_I ;
  input [31:2] Addr_I ;
  input PC_en_I ;
  output [31:2] PC_O ;
  
  reg [31:2] addr ;
  
  assign PC_O = addr ;
  
  always @(posedge clk_I or posedge rst_I)
  begin
    if (rst_I)
      addr <= `PC_INITIAL ;
    else if (PC_en_I)
      addr <= Addr_I ;
  end
  
endmodule