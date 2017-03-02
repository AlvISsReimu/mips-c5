`include    ".\\head_mips.v"
`include    ".\\head_timer.v"

module timer( CLK_I, RST_I, ADD_I, WE_I, DAT_I, DAT_O, IRQ_O ) ;
  input             CLK_I ;
  input             RST_I ;
  input      [3:2]  ADD_I ;
  input             WE_I ;
  input      [31:0] DAT_I ;
  output reg [31:0] DAT_O ;
  output reg        IRQ_O ;
  
  reg    [31:0] CTRL ;
  reg    [31:0] PRESET ;
  reg    [31:0] COUNT ;
  
  reg           IM ;
  reg    [2:1]  Mode ;
  reg           Enable ;
  
  always @( posedge CLK_I or posedge RST_I )
  begin
    if ( RST_I )
      begin
        IM     = `RST_IM ;
        Mode   = `RST_Mode ;
        Enable = `RST_Enable ;
        CTRL   = { 28'b0, IM, Mode[2:1], Enable } ;
        PRESET = `RST_PRESET ;
        COUNT  = `RST_COUNT ;
        IRQ_O  = 0 ;
      end
    else
      begin
        
        if ( Enable==`EN_ALLOW )
          begin
            if ( COUNT>0 )
              COUNT = COUNT - 1 ;
            else
              begin
                Enable = `EN_STOP ;
                COUNT = PRESET ;
                if ( (Mode==`Mode_0)&&(IM==`IM_ALLOW) )
                  IRQ_O = 1 ;
                if ( Mode==`Mode_1 )
                  Enable = `EN_ALLOW ;
              end
          end
        
        
        
        
        
        
        if ( WE_I )
          begin
            case ( ADD_I )
              `ADD_CTRL : begin
              CTRL = DAT_I ;
              IM = DAT_I[3] ;
              Mode = DAT_I[2:1] ;
              Enable = DAT_I[0] ;
              end
              `ADD_PRESET : begin
              PRESET = DAT_I ;
              COUNT = PRESET ;
              Enable = `EN_ALLOW ;
              IRQ_O = 0 ;
              end
              default : ;
            endcase
          end
          

          
      end
  end
    
    always @(*)
    begin
      case ( ADD_I )
        `ADD_CTRL :   DAT_O <= CTRL ;
        `ADD_PRESET : DAT_O <= PRESET ;
        `ADD_COUNT :  DAT_O <= COUNT ;
      endcase
    end
    
endmodule