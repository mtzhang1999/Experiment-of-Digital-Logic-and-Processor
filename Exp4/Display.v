`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/10 20:17:10
// Design Name: 
// Module Name: Display
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


module Display(clk,reset, in_cnt, Cathodes, AN);
input clk, reset;
input [15:0] in_cnt;
output reg [6:0]Cathodes;
output reg [3:0] AN;

reg [1:0] cnt;


always @(posedge reset or posedge clk)
begin
    if(reset) cnt <= 2'b00;
    else begin
        if(cnt == 2'b11) cnt <= 2'b00;
        else cnt <= cnt + 1;
    end
end
reg [3:0] cnt_t;

always@(*)
begin
case(cnt)
    2'b00:  cnt_t = in_cnt[3:0];
    2'b01:  cnt_t = in_cnt[7:4];  
    2'b10:  cnt_t = in_cnt[11:8];
    2'b11:  cnt_t = in_cnt[15:12];
    default: cnt_t = 4'b0000;
endcase
end

always@(*)
begin
    case(cnt)
        2'b00 : AN = 4'b1110;
        2'b01 : AN = 4'b1101;
        2'b10 : AN = 4'b1011;
        2'b11 : AN = 4'b0111;
        default : AN = 4'b1111;
    endcase
end
 always @(*) begin
if (cnt_t==4'h0) Cathodes <= 7'b1000000;
else if (cnt_t==4'h1) Cathodes <= 7'b1111001;
else if (cnt_t==4'h2) Cathodes <= 7'b0100100;
else if (cnt_t==4'h3) Cathodes <= 7'b0110000;
else if (cnt_t==4'h4) Cathodes <= 7'b0011001;
else if (cnt_t==4'h5) Cathodes <= 7'b0010010;
else if (cnt_t==4'h6) Cathodes <= 7'b0000010;
else if (cnt_t==4'h7) Cathodes <= 7'b1111000;
else if (cnt_t==4'h8) Cathodes <= 7'b0000000;
else if (cnt_t==4'h9) Cathodes <= 7'b0010000;
else if (cnt_t==4'ha) Cathodes <= 7'b1000000;
else if (cnt_t==4'hb) Cathodes <= 7'b0000011;
else if (cnt_t==4'hc) Cathodes <= 7'b1000110;
else if (cnt_t==4'hd) Cathodes <= 7'b0100001;
else if (cnt_t==4'he) Cathodes <= 7'b0000100;
else if (cnt_t==4'hf) Cathodes <= 7'b0001110;
else Cathodes <= 7'b1111111;

end
endmodule

