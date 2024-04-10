`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2024 16:23:50
// Design Name: 
// Module Name: scene_restoration
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


module scene_restoration(
    input i_clk,
    input i_rst,
    input [10:0]on_by_t,
    input [7:0]er,
    input [7:0]eg,
    input [7:0]eb,
    input [7:0]Arlocal,
    input [7:0]Aglocal,
    input [7:0]Ablocal,
    output  [8:0]o_r,
    output  [8:0]o_b,
    output  [8:0]o_g
    );
    
    reg [7:0]sub_r;
    reg [7:0]sub_b;
    reg [7:0]sub_g;
    reg [10:0]t1;
    
    wire [15:0]mul_r;
    wire [15:0]mul_b;
    wire [15:0]mul_g;
    
    wire [7:0]s_r;
    wire [7:0]s_b;
    wire [7:0]s_g;
   
    reg [7:0]temp_r;
    reg [7:0]temp_b;
    reg [7:0]temp_g;
   wire[7:0]check_r,check_g,check_b;
    wire[8:0]i_r,i_r1,i_g,i_g1,i_b,i_b1;
    
    
    always@(posedge i_clk)
    begin
        t1<=on_by_t;
        temp_r<=Arlocal;
        temp_b<=Ablocal;
        temp_g<=Aglocal;
        
        sub_r=er-Arlocal;
        sub_g=eg-Aglocal;
        sub_b=eb-Ablocal;
    end
    
      assign check_r = (sub_r[7]==0)?(sub_r):(-sub_r);
       assign check_g = (sub_g[7]==0)?(sub_g):(-sub_g);
        assign check_b = (sub_b[7]==0)?(sub_b):(-sub_b);
    
        
        assign mul_r = t1*check_r;
        assign mul_b = t1*check_b;
        assign mul_g = t1*check_g;
        
        
        
       assign s_r =mul_r>>3;
       assign s_b =mul_b>>3;
       assign s_g =mul_g>>3;
       
       assign i_r = s_r+temp_r;
        assign i_g = s_g+temp_g;
         assign i_b = s_b+temp_b;
       
       
       assign  o_r=(sub_r[7]==0)?((i_r>=255)?255:(s_r+temp_r)):((s_r>=temp_r)?0:(-s_r+temp_r));
       assign  o_g= (sub_g[7]==0)?((i_g>=255)?255:(s_g+temp_g)):((s_g>=temp_g)?0:(-s_g+temp_g));
       assign  o_b= (sub_b[7]==0)?((i_b>=255)?255:(s_b+temp_b)):((s_b>=temp_b)?0:(-s_b+temp_b));
       

    
    
endmodule
