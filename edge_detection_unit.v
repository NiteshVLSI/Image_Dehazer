`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2024 10:22:05
// Design Name: 
// Module Name: edge_detect
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
module main_dark(input clk, [7:0]a_r,b_r,c_r,d_r,e_r,f_r,g_r,h_r,i_r,a_g,b_g,c_g,d_g,e_g,f_g,g_g,h_g,i_g,a_b,b_b,c_b,d_b,e_b,f_b,g_b,h_b,i_b ,
           output reg[7:0]I_dark_2_3);
         
         wire edr,edg,edb,sel;
         wire[7:0] r_min,g_min,b_min,min_selr,min_selb,min_selg,I_dark;
         
         edge_detect er(.a(a_r),.b(b_r),.c(c_r),.d(d_r),.f(f_r),.g(g_r),.h(h_r),.i(i_r),.E(edr))  ;
         edge_detect eg(.a(a_g),.b(b_g),.c(c_g),.d(d_g),.f(f_g),.g(g_g),.h(h_g),.i(i_g),.E(edg))  ;
         edge_detect eb(.a(a_b),.b(b_b),.c(c_b),.d(d_b),.f(f_b),.g(g_b),.h(h_b),.i(i_b),.E(edb))  ;  
         assign sel = edr|edg|edb;
         
         
         min8 m_r(.a(a_r),.b(b_r),.c(c_r),.d(d_r),.f(f_r),.g(g_r),.h(h_r),.i(i_r),.min(r_min));
         min8 m_g(.a(a_g),.b(b_g),.c(c_g),.d(d_g),.f(f_g),.g(g_g),.h(h_g),.i(i_g),.min(g_min));
         min8 m_b(.a(a_b),.b(b_b),.c(c_b),.d(d_b),.f(f_b),.g(g_b),.h(h_b),.i(i_b),.min(b_min));
         
         assign min_selr = (sel)?e_r:r_min;
         assign min_selg = (sel)?e_g:g_min;
         assign min_selb = (sel)?e_b:b_min;
         
         min3 m1(.a(min_selr),.b(min_selg),.c(min_selb),.min(I_dark));
         
         
         
         always @(posedge clk)
         begin
         I_dark_2_3<=I_dark;
         end
         
         

endmodule

module edge_detect(a,b,c,d,f,g,h,i,E

    );
    parameter eth=20;
    input [7:0]a,b,c,d,f,g,h,i;
    output E;
    
    wire [7:0]o1,o2,o3,o4;
    wire e1,e2,e3,e4;
    
    abs_sub i1(.in1(a),.in2(i),.out(o1));
    abs_sub i2(.in1(b),.in2(h),.out(o2));
    abs_sub i3(.in1(c),.in2(g),.out(o3));
    abs_sub i4(.in1(d),.in2(f),.out(o4));
    
    assign e1 = (o1>eth)?1:0;
    assign e2 = (o2>eth)?1:0;
    assign e3 = (o3>eth)?1:0;
    assign e4 = (o4>eth)?1:0;
    assign E = e1|e2|e3|e4;
    
    
endmodule

module abs_sub(in1,in2,out);
  input [7:0]in1,in2;
  output reg[7:0] out;
 reg[7:0] temp;
  
  always @(*)
    begin
      temp = in1- in2;
      if(temp[7]==1)
        out= -temp;
        else
        out= temp;
    end
  
  
endmodule


module min8(input [7:0] a, b, c, d, f, g, h, i, output  [7:0] min);
wire[7:0] o1,o2,o3,o4,o5,o6;
comparator c1(a,b,o1);
comparator c2(o1,c,o2);
comparator c3(o2,d,o3);
comparator c4(o3,f,o4);
comparator c5(o4,g,o5);
comparator c6(o5,h,o6);
comparator c8(o6,i,min);

   
endmodule

module min3(input [7:0] a, b, c, output  [7:0] min);
wire[7:0]o1;
comparator c9(a,b,o1);
comparator c10(o1,c,min);
   
endmodule


module comparator(input[7:0] in1,in2 , output[7:0]min);
assign min = (in1<in2)?in1:in2;

endmodule