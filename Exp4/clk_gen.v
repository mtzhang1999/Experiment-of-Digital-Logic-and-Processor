`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/10 21:13:27
// Design Name: 
// Module Name: clk_gen
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


module clk_gen(
    clk, 
    reset, 
    clk_1K
);

input           clk;
input           reset;
output          clk_1K;

reg             clk_1K;

parameter   CNT = 16'd5000;

reg     [15:0]  count;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        clk_1K <= 1'b0;
        count <= 16'd0;
    end
    else begin
        count <= (count==CNT-16'd1) ? 16'd0 : count + 16'd1;
        clk_1K <= (count==16'd0) ? ~clk_1K : clk_1K;
    end
end

endmodule