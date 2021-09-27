`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/09 21:33:48
// Design Name: 
// Module Name: MUX_A
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


module MUX_A(Select, Data_i1, Data_i2, Data_i3, Data_i4, Data_o);
    //Control Signal
    input [1:0] Select;
    //Input Data
    input [31:0] Data_i1;
    input [31:0] Data_i2;
    input [5:0] Data_i3; // 6 bits
    input [31:0] Data_i4;
    //Output Data
    output reg [31: 0] Data_o;
    
    always@(*) begin
        case(Select)
            2'b00:Data_o = Data_i1;
            2'b01:Data_o = Data_i2;
            2'b10:Data_o = Data_i3;
            2'b11:Data_o = Data_i4;
        endcase
    end
endmodule
