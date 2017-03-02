`include    ".\\head_mips.v"

module mult_div ( clk_I, MDCtrl_I, A_I, B_I, HI_O, LO_O, op_I, MT_I, Wdata_I, memtoreg, Ready_O ) ;
  input         clk_I, MDCtrl_I ;
  input  [31:0] A_I ;
  input  [31:0] B_I ;
  input  [2:0]  op_I ;
  input  [1:0]  MT_I ;
  input  [2:0]  memtoreg ;
  input  [31:0] Wdata_I ;
  output [31:0] HI_O ;
  output [31:0] LO_O ;
  output reg    Ready_O ;
  
  parameter s0 = 0, s1 = 1, s2 = 2;
  
  reg [31:0] hi = 0 ;
  reg [31:0] lo  = 0 ;
  reg [5:0] count = 0 ;
  reg [1:0] state = 0 ;
  reg [63:0] P = 0, T = 0, rem = 0, dis = 0 ;
  reg [31:0] quo = 0 ;
  reg [31:0] a = 0 ;
  reg [31:0] b = 0 ;
  reg [31:0] x_reg = 0 ;
  reg [31:0] y_reg = 0 ;
  
  assign HI_O = hi ;
  assign LO_O = lo ;
  
  always @( negedge clk_I )
  begin
    
    if ( MDCtrl_I == `MDCTRL_OFF )
      begin
        case ( MT_I )
          `MT_HI: hi <= Wdata_I ;
          `MT_LO: lo <= Wdata_I ;
          default: ;
        endcase
      end
      
    else
      
      begin
        Ready_O = 0 ;
        if ((op_I==`MDOP_MULT)||(op_I==`MDOP_MULTU))
          begin
        case (state)
          s0: begin
            count = 0;
            P = 0;
            a = A_I;
            b = B_I;
            x_reg = A_I;
            y_reg = B_I;
            if ((B_I[31]==1)&&(op_I==`MDOP_MULT))
              y_reg = ~y_reg + 1 ;
            if ((A_I[31]==1)&&(op_I==`MDOP_MULT))
              x_reg = ~x_reg + 1 ;
            T = {32'h0, x_reg};
            state = s1;
          end
          s1: begin
            if(count == 32)
              state = s2;
              else begin
                if(y_reg[0] == 1'b1)
                  P = P + T;
                else
                  P = P;
                y_reg = y_reg >> 1;
                T = T << 1;
                count = count + 1;
                state = s1;
              end
            end
            s2: begin
                  if ((a[31]+b[31]==1)&&(op_I==`MDOP_MULT))
                    P = ~(P-1) ;
               hi = P[63:32];
               lo = P[31:0];
               Ready_O = 1;
               state = s0;
               count = 0;
             end
             default: ;
           endcase
         end
         
       else if ((op_I==`MDOP_DIV)||(op_I==`MDOP_DIVU))
         begin
           
           case (state)
             s0: begin
               count = 0 ;
               quo = 0 ;
               a = A_I;
               b = B_I;
               x_reg = A_I;
               y_reg = B_I;
               if ((B_I[31]==1)&&(op_I==`MDOP_DIV))
                 y_reg = ~y_reg + 1 ;
               if ((A_I[31]==1)&&(op_I==`MDOP_DIV))
                 x_reg = ~x_reg + 1 ;
               rem = { 32'b0, x_reg };
               dis = { y_reg , 32'b0 };
               state = s1;
             end
             s1: begin
                 rem = rem - dis ;
                 if ( rem[63]==0 )
                   begin
                     quo = quo<<1 ;
                     quo[0] = 1 ;
                   end
                 else
                   begin
                     rem = rem + dis ;
                     quo = quo<<1 ;
                     quo[0] = 0 ;
                   end
                 dis = {1'b0,dis[63:1]} ;
                 count = count + 1;
                 if(count == 33)
                   state = s2 ;
                 else
                   state = s1 ;
               end
             s2: begin
               lo = quo ;
               hi = rem[31:0] ;
               if ((a[31]+b[31]==1)&&(op_I==`MDOP_DIV))
                 lo = ~(lo-1) ;
               if (hi[31]!=a[31])
                 begin
                    if (hi[31]==0)
                      hi = ~(hi-1) ;
                    else
                      hi = ~hi + 1 ;
                 end
                 Ready_O = 1;
                 state = s0 ;
                 count = 0;
              end
              default: ;
            endcase
          end

      end
      
  end
  
endmodule