
module top_tb();

reg sys_clk;
reg BTNU;
reg BTND;
wire LED;
wire [3:0] AN;
wire [6:0] Cathodes;
wire dot;
top top_tb (sys_clk,
    BTNU,
    BTND,
    LED,
    Cathodes,
    AN,
    dot);

initial begin
sys_clk <= 0;
BTNU <= 0;
BTND <= 0;
end

initial begin
forever #5 sys_clk <= ~sys_clk;
end

initial begin
#10 BTNU <= 1;
#1 BTNU <= 0;
#10500 BTND <= 1;
#1 BTND <= 0;
#50 $finish;
end
endmodule
