`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2024 18:35:16
// Design Name: 
// Module Name: Wrapper
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


module Wrapper(clk, gen_clk, rst, arg, agg, abg,Image_R,Image_G,Image_B);
output [7:0] Image_R,Image_G,Image_B;
output [7:0] arg, agg, abg ;
output reg gen_clk  = 0 ;
input clk , rst ;
reg [1:0] clk_count = 0 ;
reg tmp = 0 ,rd_GALC  = 0 , rd_mem = 0;
wire rdy ;
wire [18:0]addr ;
wire [23:0] dout ;
wire [7:0] IDark , IDark_dash ;
wire [7:0] AR_local, AG_local, AB_local ;
wire [10:0] one_by_t ;
wire [7:0] dout_R, dout_G, dout_B ;

reg [7:0] IDark3_4, IDark2_3 ;
reg [7:0] PR1R,PR2R,PR3R,PR4R,PR5R,PR6R,PR7R;
reg [7:0] PR1G,PR2G,PR3G,PR4G,PR5G,PR6G,PR7G;
reg [7:0] PR1B,PR2B,PR3B,PR4B,PR5B,PR6B,PR7B;
reg [7:0] PR1_local_R,PR1_local_G,PR1_local_B,PR2_local_R,PR2_local_G,PR2_local_B,PR3_local_R,PR3_local_G,PR3_local_B,
PR4_local_R,PR4_local_G,PR4_local_B;

reg [10:0] one_by_t5_6 ;
wire[23:0] A, B, C, D, E, F, G, H, I ;
Memory__Buffer m1(gen_clk,rst,rdy,rd_mem,addr, dout, A, B, C, D, E, F, G, H, I  );

GALC GALC1(
 .rdy(rdy) ,.Rd(rd_GALC) ,
.clk(gen_clk),.reset(rst), .a_b(A[7:0]),.b_b(B[7:0]),.c_b(C[7:0]),.d_b(D[7:0]),.e_b(E[7:0]),.f_b(F[7:0]),.g_b(G[7:0]),.h_b(H[7:0]),.i_b(I[7:0]),
.a_g(A[15:8]),.b_g(B[15:8]),.c_g(C[15:8]),.d_g(D[15:8]),.e_g(E[15:8]),.f_g(F[15:8]),.g_g(G[15:8]),.h_g(H[15:8]),.i_g(I[15:8]),
.a_r(A[23:16]),.b_r(B[23:16]),.c_r(C[23:16]),.d_r(D[23:16]),.e_r(E[23:16]),.f_r(F[23:16]),.g_r(G[23:16]),.h_r(H[23:16]),.i_r(I[23:16]) ,
.arg3_4(arg),.agg3_4(agg),.agb3_4(abg));

assign dout = {dout_R, dout_G, dout_B } ;

blk_mem_gen_5 Img_R (
  .clka(clk),    // input wire clka
  .wea(0),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [18 : 0] addra
  .dina(0),    // input wire [7 : 0] dina
  .douta(dout_R)  // output wire [7 : 0] douta
);

blk_mem_gen_4 Img_G (
  .clka(clk),    // input wire clka
  .wea(0),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [18 : 0] addra
  .dina(0),    // input wire [7 : 0] dina
  .douta(dout_G)  // output wire [7 : 0] douta
);

blk_mem_gen_0 Img_B (
  .clka(clk),    // input wire clka
  .wea(0),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [18 : 0] addra
  .dina(0),    // input wire [7 : 0] dina
  .douta(dout_B)  // output wire [7 : 0] douta
);

Modified_IDark I_Dark_m( .clk(gen_clk), 
    .a_b(A[7:0]),.b_b(B[7:0]),.c_b(C[7:0]),.d_b(D[7:0]),.e_b(E[7:0]),.f_b(F[7:0]),.g_b(G[7:0]),.h_b(H[7:0]),
    .i_b(I[7:0]),.a_g(A[15:8]),.b_g(B[15:8]),.c_g(C[15:8]),.d_g(D[15:8]),.e_g(E[15:8]),.f_g(F[15:8]),.g_g(G[15:8]),
    .h_g(H[15:8]),.i_g(I[15:8]),.a_r(A[23:16]),.b_r(B[23:16]),.c_r(C[23:16]),.d_r(D[23:16]),.e_r(E[23:16]),
    .f_r(F[23:16]),.g_r(G[23:16]),.h_r(H[23:16]),.i_r(I[23:16]) , .I_dark_2_3(IDark_dash));
    
    
 LALC Local_light( .clk(gen_clk), .IDark_dash(IDark_dash), .AR_global(8'd240), .AG_global(8'd240), .AB_global(8'd240), 
                   .AR_local(AR_local), .AG_local(AG_local), .AB_local(AB_local)  );

    
transmission_calc Trans_calc(.i_clk(gen_clk), .i_rst(rst),.Idark(IDark3_4),.Agloc(AG_local),.Abloc(AB_local),.Arloc(AR_local)
                   ,.one_by_t(one_by_t) );   
                   
scene_restoration Restoration(.i_clk(gen_clk), .i_rst(rst),.on_by_t(one_by_t5_6),.er(PR6R),.eg(PR6G),.eb(PR6B),
                    .Arlocal(PR4_local_R),.Aglocal(PR4_local_G),.Ablocal(PR4_local_B),.o_r(Image_R),.o_b(Image_B),.o_g(Image_G) ); 
    
always@(posedge gen_clk)
begin
    if(rst)
    begin
        tmp <= 0 ;
        rd_GALC <= 0 ;
        rd_mem <= 0 ;
   end     
end

always@(posedge gen_clk)
begin
PR1R <= E[23:16];
PR2R <= PR1R;
PR3R <= PR2R;
PR4R <= PR3R;
PR5R <= PR4R;
PR6R <= PR5R;


PR1G <= E[15:8];
PR2G <= PR1G;
PR3G <= PR2G;
PR4G <= PR3G;
PR5G <= PR4G;
PR6G <= PR5G;

PR1B <= E[7:0];
PR2B <= PR1B;
PR3B <= PR2B;
PR4B <= PR3B;
PR5B <= PR4B;
PR6B <= PR5B;

PR1_local_R <= AR_local;
PR2_local_R <= PR1_local_R;
PR3_local_R <= PR2_local_R;
PR4_local_R <= PR3_local_R;

PR1_local_G <= AG_local;
PR2_local_G <= PR1_local_G;
PR3_local_G <= PR2_local_G;
PR4_local_G <= PR3_local_G;

PR1_local_B <= AB_local;
PR2_local_B <= PR1_local_B;
PR3_local_B <= PR2_local_B;
PR4_local_B <= PR3_local_B;

one_by_t5_6 <= one_by_t ;

end



always@(posedge gen_clk )
begin

IDark3_4 <= IDark_dash ;

end 

always@(posedge clk)
begin
 clk_count <= clk_count + 1 ;
 if( clk_count == 2'b11)
  gen_clk <= 1 ;
  else if(clk_count == 2'b01)
  gen_clk <= 0 ;

end    
    
always@(posedge gen_clk)
begin
    if(tmp)
    begin
        rd_GALC <= 1 ;
    end
    if(rdy)
    begin
        tmp <= 1 ;
        rd_mem<= 1 ;
    end
end

endmodule
