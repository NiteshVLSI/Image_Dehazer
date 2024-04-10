`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 16:23:11
// Design Name: 
// Module Name: GALC
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



module GALC(
input rdy ,Rd ,
input clk,reset, [7:0]a_r,b_r,c_r,d_r,e_r,f_r,g_r,h_r,i_r,a_g,b_g,c_g,d_g,e_g,f_g,g_g,h_g,i_g,a_b,b_b,c_b,d_b,e_b,f_b,g_b,h_b,i_b ,
output reg [7:0]arg3_4,agg3_4,agb3_4
    );
    
    wire[7:0]o1,o2,o3,o4,mux1,mux2,mux3,mux4;
    reg [7:0]m2_3,rm2_3,gm2_3,bm2_3,min3_4;
    
    initial
    begin
    min3_4=8'h0;
    end
    
    min9 m1(a_r,b_r,c_r,d_r,e_r,f_r,g_r,h_r,i_r,o1);
    min9 m2(a_g,b_g,c_g,d_g,e_g,f_g,g_g,h_g,i_g,o2);
    min9 m3(a_b,b_b,c_b,d_b,e_b,f_b,g_b,h_b,i_b,o3);
    min3 m4(o1,o2,o3,o4);
    
    always @(posedge clk)
    begin
    if(reset)
    begin
     rm2_3<=8'h0;
    gm2_3<=8'h0;
    bm2_3<=8'h0;
    m2_3<=8'h0;
   /* min3_4<=mux1;
    arg3_4<=mux2;
    agg3_4<=mux3;
    agb3_4<=mux4;*/
    
    end
    else if(rdy && Rd)
    begin
    rm2_3<=o1;
    gm2_3<=o2;
    bm2_3<=o3;
    m2_3<=o4;
    min3_4<=mux1;
    arg3_4<=mux2;
    agg3_4<=mux3;
    agb3_4<=mux4;
    end
    
    end
    
    assign mux1 = (min3_4>o4)?min3_4:m2_3;
    assign mux2 = (min3_4>o4)?arg3_4:rm2_3;
    assign mux3 = (min3_4>o4)?agg3_4:gm2_3;
    assign mux4 = (min3_4>o4)?agb3_4:bm2_3;
    
    
    
    
    
endmodule


module min9(input [7:0] a, b, c, d, e, f, g, h, i, output  [7:0] min);
wire[7:0] o1,o2,o3,o4,o5,o6,o7;
comparator c1(a,b,o1);
comparator c2(o1,c,o2);
comparator c3(o2,d,o3);
comparator c4(o3,e,o4);
comparator c5(o4,f,o5);
comparator c6(o5,g,o6);
comparator c7(o6,h,o7);
comparator c8(o7,i,min);

   
endmodule

module min3(input [7:0] a, b, c, output  [7:0] min);
wire[7:0]o1;
comparator c9(a,b,o1);
comparator c10(o1,c,min);
   
endmodule


module comparator(input[7:0] in1,in2 , output[7:0]min);
assign min = (in1<in2)?in1:in2;

endmodule