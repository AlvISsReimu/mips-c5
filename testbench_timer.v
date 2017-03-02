`include    ".\\head_mips.v"
`include    ".\\head_timer.v"

module testbench_timer() ;
  
  reg clk, rst ;
  reg [3:2] add ;
  reg we ;
  reg [31:0] din ;
  
  wire [31:0] dout ;
  wire irq ;

  timer U_TIMER ( clk, rst, add, we, din, dout, irq ) ;
  
  always
  #(`CYCLE/2) clk = ~clk ;
  
  initial
  begin
    clk     = 0 ;
    rst     = 1 ;
    #(1.2*`CYCLE/2) rst = 0 ;
    #50 ;
    we = 1 ;
    add = `ADD_PRESET ;
    din = 300 ;
    #50 ;
    add = `ADD_CTRL ;
    din = 32'b1011 ;
    #50 ;
    we = 0 ;
    
    #10000 ;
    $stop ;
  end
  
endmodule