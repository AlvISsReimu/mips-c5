`include    ".\\head_mips.v"

module testbench_mips() ;
  
  reg clk,rst ;

  //mips U_MIPS( clk, rst ) ;
  mini_machine U_MINI_MACHINE ( clk, rst ) ; 
  
  always
  #(`CYCLE/2) clk = ~clk ;
  
  initial
  begin
    clk     = 0 ;
    rst     = 1 ;
    #(1.2*`CYCLE/2) rst = 0 ;
    
    #(25*`DELAY_MS) ;
    $stop ;
  end
  
endmodule