`include    ".\\head_cp0.v"
`include    ".\\head_mips.v"

module cp0 ( clk, rst, PC, DIn, HWInt, Sel, Wen, EXLSet, EXLClr, IntReq, EPC, DOut ) ;
  input         clk ;
  input         rst ;
  input  [31:2] PC ;
  input  [31:0] DIn ;
  input  [5:0]  HWInt ;
  input  [4:0]  Sel ;
  input         Wen ;
  input         EXLSet ;
  input         EXLClr ;
  
  output        IntReq  ;
  output [31:2] EPC ;
  output [31:0] DOut ;
  
  reg [15:10] im ;
  reg exl, ie ;
  reg [15:10] ip ;
  reg [31:2] epc ;
  reg [31:0] prid ;
  
  integer flag = 0 ;
  
  assign EPC = epc ;
  assign IntReq = |(HWInt[5:0]&im[15:10])&ie&(~exl) ;
  assign DOut = (Sel==`Sel_SR)    ? {16'b0, im, 8'b0, exl, ie} :
                (Sel==`Sel_CAUSE) ? {16'b0, ip, 10'b0} :
                (Sel==`Sel_EPC)   ? {epc, 2'b0} :
                (Sel==`Sel_PRId)  ? prid :
                32'b0 ;
  
  always @( posedge clk )
  begin
    if ( rst )
      begin
      prid <= `PRId_Value ;
      epc <= 30'b0 ;
      im <= 6'b0 ;
      ip <= 6'b0 ;
      exl <= 0 ;
      ie <= 1 ;
      end
    else
      begin
        if ( PC==`ISR_Add )
    //Cause
    if ( (Wen==1)&&(Sel==`Sel_CAUSE) )
      ip = DIn[15:10] ;
    ip <= HWInt[5:0] ;

    //SR
    //im <= HWInt[5:0] ;
    if ( (Wen==1)&&(Sel==`Sel_SR) )
      { im, exl, ie } <= { DIn[15:10], DIn[1], DIn[0] } ;
    if ( EXLSet )
      exl <= 1 ;
    if ( EXLClr )
      begin
      exl <= 0 ;
      flag = 0 ;
      end
    
    //PrID
    if ( (Wen==1)&&(Sel==`Sel_PRId) )
      prid = DIn;
    
    //EPC
    if ( (Wen==1)&&(Sel==`Sel_EPC) )
      epc = DIn ;
    if ((IntReq)&&(!flag))
      begin
      epc = PC - `PC_CYCLE ;
      flag = 1 ;
      end
    
      end
      
  end
  
endmodule