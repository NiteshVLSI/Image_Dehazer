`timescale 1ns / 1ps
module LALC( input clk,input [7:0] IDark_dash,input [7:0] AR_global,input [7:0] AG_global,input [7:0] AB_global, output [7:0] AR_local,output [7:0] AG_local,output [7:0] AB_local  );

wire [7:0] min_out,dark_diff,shift1,shift2,shift3,shift4;
wire [8:0] add1,add2,add3;
wire [6:0] alpha_out;
wire comp_TH,comp_2TH;
reg PR_comp1_3to4,PR_comp2_3to4;
reg [6:0] PR_alpha_3to4;
wire [7:0] AR_Dark,AG_Dark,AB_Dark;
reg [7:0] PR1_2to3,PR2_2to3,PR3_2to3,PR4_2to3;
reg [7:0] PR1a_3to4,PR1b_3to4,PR2a_3to4,PR2b_3to4,PR3a_3to4,PR3b_3to4;
wire [7:0] subtraction;
wire [15:0] mult_R1,mult_R2,mult_G1,mult_G2,mult_B1,mult_B2;
wire [8:0] add_out1,add_out2,add_out3;
wire [7:0] mix_R,mix_G,mix_B;

assign min_out = (AR_global < AG_global) ? ((AR_global < AB_global) ? AR_global : AB_global) : ((AG_global < AB_global) ? AG_global : AB_global);

assign shift1 = PR1_2to3 >> 1;
assign dark_diff = IDark_dash - shift1;
// shift1 and dark_diff should be given to alpha block and obtain alpha_out
alpha_calc dut1(.dark_diff(dark_diff),.denominator(shift1),.alpha(alpha_out));


assign comp_TH = (IDark_dash < shift1) ? 1'b1 : 1'b0;
assign comp_2TH = ( IDark_dash > PR1_2to3) ? 1'b1 : 1'b0;

assign shift2 = PR2_2to3 >> 1;
assign add1 = shift2 + PR2_2to3;
assign AR_Dark[7:0] = add1[8:1];

assign shift3 = PR3_2to3 >> 1;
assign add2 = shift3 + PR3_2to3;
assign AG_Dark[7:0] = add2[8:1];

assign shift4 = PR4_2to3 >> 1;
assign add3 = shift4 + PR4_2to3;
assign AB_Dark[7:0] = add3[8:1];

assign subtraction = 8'd128 - {PR_alpha_3to4};
//set1
assign mult_R1 = ((subtraction<<1) * PR1a_3to4) >> 8;
assign mult_R2 = ({PR_alpha_3to4,1'b0} * PR1b_3to4) >> 8;
assign add_out1 = mult_R1[7:0] + mult_R2[7:0];
assign mix_R = (add_out1>255) ? 8'b11111111 : add_out1[7:0];
//assign mix_R = add_out1[16:9];

mux_4x1 mux_dut1(.I0(mix_R),.I1(PR1b_3to4),.I2(PR1a_3to4),.I3(8'b0),.S1(PR_comp1_3to4),.S0(PR_comp2_3to4),.data_out(AR_local));
//set2
assign mult_G1 = ((subtraction<<1) * PR2a_3to4) >> 8;
assign mult_G2 = ({PR_alpha_3to4,1'b0} * PR2b_3to4) >> 8;
assign add_out2 = mult_G1[7:0] + mult_G2[7:0];
assign mix_G = (add_out2>255) ? 8'b11111111 : add_out2[7:0];

//assign mix_G = add_out2[16:9];

mux_4x1 mux_dut2(.I0(mix_G),.I1(PR2b_3to4),.I2(PR2a_3to4),.I3(8'b0),.S1(PR_comp1_3to4),.S0(PR_comp2_3to4),.data_out(AG_local));
//set3

assign mult_B1 = ((subtraction<<1) * PR3a_3to4) >> 8;
assign mult_B2 = ({PR_alpha_3to4,1'b0} * PR3b_3to4) >> 8;
assign add_out3 = mult_B1[7:0] + mult_B2[7:0];
//assign mix_B = add_out3[16:9];
assign mix_B = (add_out3>255) ? 8'b11111111 : add_out3[7:0];


mux_4x1 mux_dut3(.I0(mix_B),.I1(PR3b_3to4),.I2(PR3a_3to4),.I3(8'b0),.S1(PR_comp1_3to4),.S0(PR_comp2_3to4),.data_out(AB_local));

//Stage-2
always@(posedge clk)
begin
PR1_2to3 <= min_out;
PR2_2to3 <= AR_global;
PR3_2to3 <= AG_global;
PR4_2to3 <= AB_global;
end

//Stage-3
always@(posedge clk)
begin
PR_alpha_3to4 <= alpha_out;
PR_comp1_3to4 <= comp_TH;
PR_comp2_3to4 <= comp_2TH;

PR1a_3to4 <= AR_Dark;
PR1b_3to4 <= PR2_2to3;

PR2a_3to4 <= AG_Dark;
PR2b_3to4 <= PR3_2to3;

PR3a_3to4 <= AB_Dark;
PR3b_3to4 <= PR4_2to3;
end
endmodule


module mux_4x1(
    input [7:0] I0,
    input [7:0] I1,
    input [7:0] I2,
    input [7:0] I3,
    input S0,
    input S1,
    output [7:0] data_out
);

assign data_out = (S1 & S0) ? I3 :
                  (S1 & ~S0) ? I2 :
                  (~S1 & S0) ? I1 :
                  (~S1 & ~S0) ? I0 :
                  8'b00000000;
endmodule