`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 20:25:35
// Design Name: 
// Module Name: te
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


module te(

input i_clk,
input i_rst,
input [7:0]Idark,
input [7:0]Agloc,
input [7:0]Abloc,
input [7:0]Arloc,

output [10:0]one_by_t
    );
    
    reg [7:0]temp_i;
    reg [7:0]temp_r;
    reg [7:0]temp_b;
    reg [7:0]temp_g;
      reg [7:0]temp_r_buff;
    reg [7:0]temp_b_buff;
    reg [7:0]temp_g_buff;
      reg [7:0]temp_r_buff2;
    reg [7:0]temp_b_buff2;
    reg [7:0]temp_g_buff2;
    reg [7:0]Ar_sub;
    reg [7:0]Ag_sub;
    reg [7:0]Ab_sub;
    reg bm0_ena;
    reg bm1_ena;
    reg bm2_ena;
    
    reg [19:0]mul_b;
    reg [19:0]mul_g;
    reg [19:0]mul_r;
    wire [19:0]min;
    reg [7:0]addressr,addressb,addressg;
    
   // reg [11:0] d_r[254:0];
   // reg [11:0] d_b[254:0];
   // reg [11:0] d_g[254:0];
    wire [11:0] lut_r;
    wire [11:0] lut_b;
    wire [11:0] lut_g;
    
    
    blk_mem_gen_0 bm0 (
  .clka(i_clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addressr),  // input wire [7 : 0] addra
  .dina(dina),    // input wire [11 : 0] dina
  .douta(lut_r)  // output wire [11 : 0] douta
);

blk_mem_gen_1 bm1 (
  .clka(i_clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addressb),  // input wire [7 : 0] addra
  .dina(dina),    // input wire [11 : 0] dina
  .douta(lut_b)  // output wire [11 : 0] douta
);

blk_mem_gen_2 bm2 (
  .clka(i_clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addressg),  // input wire [7 : 0] addra
  .dina(dina),    // input wire [11 : 0] dina
  .douta(lut_g)  // output wire [11 : 0] douta
);
    
  /*  always@(posedge i_clk) begin
        if(i_rst) 
            addressr<=0;
        else if(bm2_ena && bm1_ena && bm0_ena)
            address<= address+1;
            d_r[address]<=lut_r;
            d_b[address]<=lut_b;
            d_g[address]<=lut_g;
         end
    */
    
    always@(posedge i_clk) begin
        temp_i<=Idark;
        temp_r<=Arloc;
        temp_b<=Abloc;
        temp_g<=Agloc;
        temp_r_buff<=temp_r;
        temp_b_buff<=temp_b;
        temp_g_buff<=temp_g;
        temp_r_buff2<=temp_r_buff;
        temp_b_buff2<=temp_b_buff;
        temp_g_buff2<=temp_g_buff;
        
        end
        
        
    always@(posedge i_clk)
        begin
         if(i_rst)
        addressr<=0;
        else 
        
            if(Arloc>Idark)
                addressr<= (Arloc-Idark)-1;
               else 
                    addressr<=0;
            
                mul_r<=temp_r_buff2* lut_r;
          end
          
     always@(posedge i_clk)
        begin
        if(i_rst)
        addressg<=0;
        else 
        if(Agloc>Idark)
                 addressg<= (Agloc-Idark)-1;
                 else 
                   addressg<=0;
             
                 mul_g<=temp_g_buff2* lut_g;
        end
        
        always@(posedge i_clk)
        begin
         if(i_rst)
        addressb<=0;
        else 
            if(Abloc>Idark)
                 addressb<= (Abloc-Idark)-1;
                 else 
                    addressb<=0;
           
                     mul_b<=temp_b_buff2* lut_b; 
          end
                    
          assign min = (mul_r <= mul_g && mul_r <= mul_b) ? mul_r : (mul_g <= mul_r && mul_g <= mul_b) ? mul_g : mul_b;
          assign  one_by_t=    min>>9;
endmodule
