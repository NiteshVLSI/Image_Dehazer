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


module Wrapper(clk, gen_clk, rst, arg, agg, abg);

output [7:0] arg, agg, abg ;
output reg gen_clk  = 0 ;
input clk , rst ;
reg [1:0] clk_count = 0 ;
reg tmp = 0 ,rd_GALC  = 0 , rd_mem = 0;
wire rdy ;
wire [13:0]addr ;
wire [23:0] dout ;

wire[23:0] A, B, C, D, E, F, G, H, I ;
Memory__Buffer m1(gen_clk,rst,rdy,rd_mem,addr, dout, A, B, C, D, E, F, G, H, I  );

GALC GALC1(
 .rdy(rdy) ,.Rd(rd_GALC) ,
.clk(gen_clk),.reset(rst), .a_b(A[7:0]),.b_b(B[7:0]),.c_b(C[7:0]),.d_b(D[7:0]),.e_b(E[7:0]),.f_b(F[7:0]),.g_b(G[7:0]),.h_b(H[7:0]),.i_b(I[7:0]),
.a_g(A[15:8]),.b_g(B[15:8]),.c_g(C[15:8]),.d_g(D[15:8]),.e_g(E[15:8]),.f_g(F[15:8]),.g_g(G[15:8]),.h_g(H[15:8]),.i_g(I[15:8]),
.a_r(A[23:16]),.b_r(B[23:16]),.c_r(C[23:16]),.d_r(D[23:16]),.e_r(E[23:16]),.f_r(F[23:16]),.g_r(G[23:16]),.h_r(H[23:16]),.i_r(I[23:16]) ,
.arg3_4(arg),.agg3_4(agg),.agb3_4(abg));

  blk_mem_gen_0 img (
.clka(clk),    // input wire clka
.wea(0),      // input wire [2 : 0] wea
.addra(addr),  // input wire [13 : 0] addra
.dina(0),    // input wire [23 : 0] dina
.douta(dout)  // output wire [23 : 0] douta
);
    
always@(posedge gen_clk)
begin
    if(rst)
    begin
        tmp <= 0 ;
        rd_GALC <= 0 ;
        rd_mem <= 0 ;
   end     
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
