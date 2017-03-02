`include    ".\\head_mips.v"

module dm_12k( addr, din, we, be, clk, dout ,clr ) ;
  input  [16:2] addr ;  //adress bus
  input  [31:0] din ;   //32-bit input data
  input         we ;    //memory write enable
  input  [3:0]  be ;
  input         clk ;   //clock
  input         clr ;   //reset
  output [31:0] dout ;  //32-bit memory output
  
  reg [31:0] dm [`STO_DM-1:0] ;
  
  integer i ;

  
  always @(posedge clk)
  begin 
    if (clr)
    begin
      for (i=0;i<`STO_DM;i=i+1)
          dm[i] <= 32'h0 ;
    end
      else
        if (we)
          begin
            case (be)
            `be_sw:        dm[addr>>2]        <= din ;
            `be_sh_byte10: dm[addr>>2][15:0]  <= din [15:0] ;
            `be_sh_byte32: dm[addr>>2][31:16] <= din [15:0] ;
            `be_sb_byte0:  dm[addr>>2][7:0]   <= din [7:0] ;
            `be_sb_byte1:  dm[addr>>2][15:8]  <= din [7:0] ;
            `be_sb_byte2:  dm[addr>>2][23:16] <= din [7:0] ;
            `be_sb_byte3:  dm[addr>>2][31:24] <= din [7:0] ;
            endcase
          end
  end
  
  assign dout = (addr/4<=`STO_DM-1)?dm[addr>>2]:32'b0 ;
  
endmodule