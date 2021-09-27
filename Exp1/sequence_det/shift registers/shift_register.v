module shift_register(
    clk_o,
    BTNU,
    SW1,
    LED6
    );
input clk_o, BTNU, SW1;
output [5:0] LED6;

reg     [5:0]   LED6;

always@(negedge BTNU or posedge clk_o) begin
    if(~BTNU)
        LED6 <= 0;
    else
        LED6 <= {SW1, LED6[5:1]};
    end
endmodule
