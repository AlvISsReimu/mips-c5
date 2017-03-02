module mini_machine ( clk, rst ) ; 

input rst, clk ;

wire        we ; 
wire [7:2]  HWInt ;
wire [31:0] PrDIn ;
wire [31:0] PrDOut ;
wire [31:2] PrAddr ;
wire [3:0]  BE ;
wire [1:0]  DEV_Addr_O ;
wire [31:0] DEV_WD_O ;
wire [31:0] DEV_RD_I ;

mips U_MIPS ( clk, rst, {5'b0,HWInt[2]}, PrDIn, PrDOut, PrAddr, BE, we ) ;
timer U_TIMER ( clk, rst, DEV_Addr_O, we, DEV_WD_O, DEV_RD_I, HWInt[2] ) ;
bridge U_BRIDGE ( PrAddr, PrDOut, DEV_RD_I, BE, PrDIn, DEV_Addr_O, DEV_WD_O ) ;

endmodule