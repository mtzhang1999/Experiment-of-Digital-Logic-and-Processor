module top (SW0, clk, leds);
input SW0;
input clk;
output [6:0] leds;

wire [6:0] leds;
wire [3:0] bcd;

counter counter (SW0, clk, bcd);
BCD7 BCD7 (bcd, leds);

endmodule
