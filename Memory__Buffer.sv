`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 10:43:18
// Design Name: 
// Module Name: Memory__Buffer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Memory__Buffer( gen_clk,rst,rdy,rd,addr, dout, A, B, C, D, E, F, G, H, I  );
    
input rst, rd ;
output reg [23:0] A = 24'hFFFFFF, B = 24'hFFFFFF, C = 24'hFFFFFF, D = 24'hFFFFFF, E = 24'hFFFFFF, F = 24'hFFFFFF, G = 24'hFFFFFF, H = 24'hFFFFFF, I = 24'hFFFFFF  ;
output reg rdy ;
parameter Image_width = 712 ;
parameter Image_height = 712 ;
reg [23:0] LB1[(Image_width +1):0] ;
reg [23:0] LB2[(Image_width +1):0] ;
reg [23:0] LB3[(Image_width +1):0] ;
reg [7:0] row ;
reg [9:0] count1 = 1 ;
reg [9:0] count2 = 1 ;
reg [9:0] count3 = 1 ;
output reg[18:0]addr = 0 ;
input [23:0] dout ;
reg first = 0 , first1 = 1;
reg [1:0] tmp = 1 ;
reg once = 0 ;
input  gen_clk ;
integer i, j ;


always@(posedge gen_clk)
begin
    if(rst)
      begin  
      for(i = 0; i <= (Image_width +1); i = i + 1)
        begin
            LB1[i] <= 24'hFFFFFF ;
        end   
       row <= 8'h00 ;
       rdy <= 0 ;
       first <= 1 ; first1 <= 1 ;
       LB2[0] <= 24'hFFFFFF ;
       LB3[0] <= 24'hFFFFFF ;
       LB2[(Image_width +1)] <= 24'hFFFFFF ;
       LB3[(Image_width +1)] <= 24'hFFFFFF ;
       count1 <= 1 ;
       count2 <= 1 ;
       count3 <= 1 ;
       addr <= 0 ;
       tmp<= 1 ;
      end
  
          else  if(first && (count2 < (Image_width +1))&& (~rst))
            begin
             LB2[count2] = dout ;  
             count2 = count2 +1 ;
             addr = addr + 1 ; 
            end
   
           else if(first && (count3 < (Image_width +1)))
                begin
                 LB3[count3] = dout ;  
                 count3 = count3 +1 ;
                 addr = addr + 1 ; 
                end 
                else if(first && (count3 == (Image_width +1)) )
                begin
                    first <= 0 ;
                    count1 <= 1 ;
                    count2 <= 1 ;
                    count3 <= 1 ;
                    rdy <= 1 ;
                end    
            
              else if(rd)
                begin
                    case (tmp)
                        1 : begin
                                if(once == 0 )
                                begin
                                    once <= 1 ; first1 <= 0 ;
                                    A <= LB1[count1 - 1 ] ;
                                    B <= LB1[count1] ;
                                    C <= LB1[count1 + 1 ] ;
                                    D <= LB2[count1 - 1 ] ;
                                    E <= LB2[count1] ;
                                    F <= LB2[count1 + 1 ] ;
                                    G <= LB3[count1 - 1 ] ;
                                    H <= LB3[count1] ;
                                    I <= LB3[count1 + 1 ] ;
                                    if(first1 == 0)
                                    begin
                                     LB3[Image_width  ] <= (addr <= ((Image_width*Image_height) -1))? dout :24'hFFFFFF ;
                                    addr <= addr + 1;
                                    end
                                    
                                end
                                else
                                begin
                                    A <= LB1[count1 ] ;
                                    B <= LB1[count1 + 1] ;
                                    C <= LB1[count1 + 2 ] ;
                                    D <= LB2[count1 ] ;
                                    E <= LB2[count1 + 1] ;
                                    F <= LB2[count1 + 2 ] ;
                                    G <= LB3[count1 ] ;
                                    H <= LB3[count1 + 1] ;
                                    I <= LB3[count1 + 2 ] ;
                                    
                                    LB1[count1 ] <= (addr <= ((Image_width*Image_height) -1))? dout :24'hFFFFFF ; 
                                    count1 = count1 +1 ;
                                    addr = addr + 1 ;
                                    if(count1 == Image_width)
                                    begin
                                        tmp <= tmp +1 ;
                                        count1 <= 1 ;
                                        once <= 0 ;
                                    end
                                end
                            end
                            
                        2 : begin
                               if(once == 0 )
                                begin
                                    once = 1 ;
                                    A <= LB2[count2 - 1 ] ;
                                    B <= LB2[count2] ;
                                    C <= LB2[count2 + 1 ] ;
                                    D <= LB3[count2 - 1 ] ;
                                    E <= LB3[count2] ;
                                    F <= LB3[count2 + 1 ] ;
                                    G <= LB1[count2 - 1 ] ;
                                    H <= LB1[count2] ;
                                    I <= LB1[count2 + 1 ] ;
                                    LB1[Image_width] <= (addr <= ((Image_width*Image_height) -1))? dout :24'hFFFFFF ;
                                    addr <= addr + 1;
                                end
                                else
                                begin
                                    A <= LB2[count2 ] ;
                                    B <= LB2[count2 + 1] ;
                                    C <= LB2[count2 + 2 ] ;
                                    D <= LB3[count2 ] ;
                                    E <= LB3[count2 + 1] ;
                                    F <= LB3[count2 + 2 ] ;
                                    G <= LB1[count2 ] ;
                                    H <= LB1[count2 + 1] ;
                                    I <= LB1[count2 + 2 ] ;
                                    
                                    LB2[count2 ] <= (addr <= ((Image_width*Image_height) -1))? dout :24'hFFFFFF ; 
                                    count2 = count2 +1 ;
                                    addr = addr + 1 ;
                                    if(count2 == Image_width)
                                    begin
                                        tmp <= tmp +1 ;
                                        count2 <= 1 ;
                                        once <= 0 ;
                                    end
                                end
                            end
                        3 : begin
                                if(once == 0 )
                                begin
                                    once <= 1 ;
                                    A <= LB3[count3 - 1 ] ;
                                    B <= LB3[count3] ;
                                    C <= LB3[count3 + 1 ] ;
                                    D <= LB1[count3 - 1 ] ;
                                    E <= LB1[count3] ;
                                    F <= LB1[count3 + 1 ] ;
                                    G <= LB2[count3 - 1 ] ;
                                    H <= LB2[count3] ;
                                    I <= LB2[count3 + 1 ] ;
                                    LB2[Image_width ] <= (addr <= ((Image_width*Image_height) -1))? dout :24'hFFFFFF ;
                                    addr <= addr + 1;
                                end
                                else
                                begin
                                    A <= LB3[count3 ] ;
                                    B <= LB3[count3 + 1] ;
                                    C <= LB3[count3 + 2 ] ;
                                    D <= LB1[count3 ] ;
                                    E <= LB1[count3 + 1] ;
                                    F <= LB1[count3 + 2 ] ;
                                    G <= LB2[count3 ] ;
                                    H <= LB2[count3 + 1] ;
                                    I <= LB2[count3 + 2 ] ;
                                   
                                    LB3[count3 ] <= (addr <= ((Image_width*Image_height) -1))? dout :24'hFFFFFF ; 
                                    count3 = count3 +1 ;
                                    addr = addr + 1 ;
                                    if(count3 == Image_width)
                                    begin
                                        tmp <= 1 ;
                                        count3 <= 1 ;
                                        once <= 0 ;
                                    end
                                end
                            end 
                            
                    endcase
                end
end
endmodule
