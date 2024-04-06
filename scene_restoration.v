`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2024 11:27:55
// Design Name: 
// Module Name: scene
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


module scene(
    input i_clk,
    input i_rst,
    input [7:0]on_by_t,
    input [7:0]er,
    input [7:0]eg,
    input [7:0]eb,
    input [7:0]Arlocal,
    input [7:0]Aglocal,
    input [7:0]Ablocal,
    output  [7:0]o_r,
    output  [7:0]o_b,
    output  [7:0]o_g
    );
    
    reg [7:0]sub_r;
    reg [7:0]sub_b;
    reg [7:0]sub_g;
    reg [7:0]t1;
    
    wire [15:0]mul_r;
    wire [15:0]mul_b;
    wire [15:0]mul_g;
    
    wire [7:0]s_r;
    wire [7:0]s_b;
    wire [7:0]s_g;
   
    reg [7:0]temp_r;
    reg [7:0]temp_b;
    reg [7:0]temp_g;
    
    
    
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
    
      
    
        
        assign mul_r = t1*sub_r;
        assign mul_b = t1*sub_b;
        assign mul_g = t1*sub_g;
        
       assign s_r =mul_r>>8;
       assign s_b =mul_b>>8;
       assign s_g =mul_g>>8;
       
       assign o_r= s_r+temp_r;
       assign o_b= s_b+temp_b;
       assign o_g= s_g+temp_g;
    

    
    
endmodule
