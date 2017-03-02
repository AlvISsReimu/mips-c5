`include    ".\\head_mips.v"

module bridge ( PrAddr_I, PrWD_I, DEV_RD_I, BE_I, PrRD_O, DEV_Addr_O, DEV_WD_O ) ;
  input  [31:2] PrAddr_I ;
  input  [31:0] PrWD_I ;
  input  [31:0] DEV_RD_I ;
  input  [3:0]  BE_I ;
  
  output [31:0] PrRD_O ;
  output [1:0]  DEV_Addr_O ;
  output [31:0] DEV_WD_O ;
  
  reg [31:0] dev_wd = 32'b0 ;
  
  assign PrRD_O     = DEV_RD_I ;
  assign DEV_Addr_O = PrAddr_I[5:4] ;
  assign DEV_WD_O   = dev_wd ;
  
  always @(*)
  begin
    case ( BE_I )
    `be_sw:              dev_wd        <= PrWD_I ;
    `be_sh_byte10: begin dev_wd[15:0]  <= PrWD_I[15:0] ; dev_wd = {16'b0,dev_wd[15:0]} ; end
    `be_sh_byte32: begin dev_wd[31:16] <= PrWD_I[15:0] ; dev_wd = {dev_wd[31:16],16'b0} ; end
    `be_sb_byte0:  begin dev_wd[7:0]   <= PrWD_I[7:0] ;  dev_wd = {24'b0,dev_wd[7:0]} ; end
    `be_sb_byte1:  begin dev_wd[15:8]  <= PrWD_I[7:0] ;  dev_wd = {16'b0,dev_wd[15:8],8'b0} ; end
    `be_sb_byte2:  begin dev_wd[23:16] <= PrWD_I[7:0] ;  dev_wd = {9'b0,dev_wd[23:16],16'b0} ; end
    `be_sb_byte3:  begin dev_wd[31:24] <= PrWD_I[7:0] ;  dev_wd = {dev_wd[31:24],24'b0} ; end
    endcase
  end
  
endmodule