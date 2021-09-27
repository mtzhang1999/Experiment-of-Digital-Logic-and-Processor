module Top(BTNU, BTND, clk, PC, SW0, SW1, AN, BCD);
input BTNU;
input BTND;
input clk;

input SW0;
input SW1;

output PC;
output wire [3:0] AN;
output wire [6:0] BCD;

wire reset_o;
wire clk_o;
wire clk_div;

wire [15:0] a0;
wire [15:0] v0;
wire [15:0] sp;
wire [15:0] ra;
wire [7:0] PC;
wire [15:0] ret;

debounce Debounce_reset (clk, BTNU, reset_o);
debounce Debounce_clk (clk, BTND, clk_o);
MultiCycleCPU MultiCycleCPU_1(reset_o, clk_o, a0, v0, sp, ra);

//MultiCycleCPU MultiCycleCPU_1(BTNU£¬BTND, a0, v0, sp, ra);

assign result = SW0 ? (SW1 ? a0 : v0) : (SW1 ? sp : ra);
assign PC = MultiCycleCPU_1.PC_o[7:0];

clk_gen Clk_gen(
    sysclk, 
    BTNU, 
    clk_div
);

Display(clk_div, BTNU, ret, BCD, AN);

endmodule
