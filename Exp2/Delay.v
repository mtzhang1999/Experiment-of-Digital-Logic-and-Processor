module Delay_1sec(
    BTNU,
    clk,
    LED
    );
input BTNU;
input clk;
output LED;
reg LED;

reg [31:0] count;

always @(posedge BTNU or posedge clk)
begin
    if (BTNU)
    begin
        count = 32'd0;
        LED = 0;                                                                              
    end
    else begin
    count = count + 1;
    LED = count > 32'd100000000 ? 1 : 0;
    end
end
endmodule