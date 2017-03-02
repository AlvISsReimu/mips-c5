`include    ".\\head_mips.v"

module gpr( A1_I, A2_I, clk_I, clr_I, WD_I, Wreg_I, RegWrite_I, RD1_O, RD2_O ) ;
  input  [31:0]   A1_I ; 
  input  [31:0]   A2_I ;
  input          clk_I ;
  input          clr_I ;
  input  [31:0]  WD_I ;
  input  [4:0]   Wreg_I ;
  input          RegWrite_I ;
  output [31:0]  RD1_O ;
  output [31:0]  RD2_O ;
  
  reg [31:0] register [31:0] ;
  
  integer i ;
  
  always @(posedge clk_I)
  begin
    if (clr_I)
      for (i=0;i<32;i=i+1)
        register[i] <= 'h0 ;
  end
  
  always @(negedge clk_I)
  begin
    if (RegWrite_I)
      register[Wreg_I] = WD_I ;
      `ifdef DEBUG
        $display ("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X, ", 0, register[1], register[2], register[3], register[4], register[5], register[6], register[7]);
        $display ("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X, ", register[8], register[9], register[10], register[11], register[12], register[13], register[14], register[15]);
        $display ("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X, ", register[16], register[17], register[18], register[19], register[20], register[21], register[22], register[23]);
        $display ("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X, ", register[24], register[25], register[26], register[27], register[28], register[29], register[30], register[31]);
      `endif
  end
  
  assign RD1_O = register[A1_I] ;
  assign RD2_O = register[A2_I] ;

endmodule