module top(
    sysclk,
    BTNU,
    BTND,
    LED,
    Cathodes,
    AN,
    dot
    );
input sysclk;
input BTNU;
input BTND;
output LED;
output [6:0] Cathodes;
output [3:0] AN;
output dot;

wire clk_divided;
wire [1:0] select;
wire stop;
wire [3:0] en0;
wire [3:0] en1;
wire [3:0] en2;
wire [3:0] en3;
wire [3:0] cnt;


Delay_1sec delay (BTNU, sysclk, LED);
EN En (BTND, BTNU, LED, stop);
clk_gen clk_gen (sysclk, BTNU, clk_divided);
Test test (BTNU, clk_divided, LED, stop, en0, en1, en2, en3);
Select sel (clk_divided, select, BTNU);
MUX mux (clk_divided, select, en3, en2, en1, en0, cnt, dot);
Decoder Decoder(clk_divided, select, cnt, AN, Cathodes);
endmodule
