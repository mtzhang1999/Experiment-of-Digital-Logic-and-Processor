module Select(
    clk, cnt, BTNU
    );
input clk, BTNU;
output reg[1:0] cnt;

always @(posedge clk)
begin
    if (cnt == 2'b11) cnt <= 2'b00;
    else cnt <= cnt + 1;
end
endmodule