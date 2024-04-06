module alpha_calc(
    input [7:0] dark_diff,
    input [7:0]denominator,
    output reg [6:0] alpha
);
  
  
  //reg[7:0] d_2,d_4,d_3_4;
  
  always @(*)
  begin
  
  if(dark_diff>=denominator)
  alpha=7'd125;
  else if(dark_diff>=(denominator-(denominator>>3)))
  alpha=7'd112;
   else if(dark_diff>=(denominator>>1)+(denominator>>2))
  alpha=7'd96;
   else if(dark_diff>=(denominator>>1)+(denominator>>3))
  alpha=7'd80;
   else if(dark_diff>=(denominator>>1))
  alpha=7'd64;
  else if(dark_diff>=(denominator>>2)+(denominator>>3))
  alpha=7'd48;
   else if(dark_diff>=(denominator>>2))
  alpha=7'd32;
  else if(dark_diff>=(denominator>>3))
  alpha=7'd16;
  else
  alpha=7'd0;
  end
  
endmodule

