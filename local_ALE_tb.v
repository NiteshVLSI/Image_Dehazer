`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2024 11:12:01
// Design Name: 
// Module Name: local_ALE_tb
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


module local_ALE_tb( );

reg clk;
reg [7:0] IDark_dash;
reg [7:0] AR_global;
reg [7:0] AG_global;
reg [7:0] AB_global;
wire [7:0] AR_local;
wire [7:0] AG_local;
wire [7:0] AB_local;

Local_ALE dut_tb(clk,IDark_dash,AR_global,AG_global,AB_global,AR_local,AG_local,AB_local);

initial begin
clk<=0;
IDark_dash <= 8'd150;
AR_global <= 8'd120;
AG_global <= 8'd140;
AB_global <= 8'd160;
#40
IDark_dash <= 8'd100;
#20
IDark_dash <= 8'd180;
#20
IDark_dash <= 8'd60;
#20
IDark_dash <= 8'd80;

end

always
begin
#10
clk <= ~clk;
end



endmodule
