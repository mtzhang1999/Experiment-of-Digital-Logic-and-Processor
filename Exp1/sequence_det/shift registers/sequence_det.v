module sequence_det(
	clk,
	BTNU,
	BTND,
	SW1,
	LED0,
	LED6
);

input 			clk;
input 			BTNU, BTND;
input 			SW1;
output 			LED0;
output 	[5:0]	LED6;


wire            clk_o;
reg             LED0;
wire    [5:0]   LED6;

debounce debounce(clk, BTND, clk_o);

// add your code here
shift_register SR(clk_o, BTNU, SW1, LED6);
always @(LED6) begin
    if(LED6[5: 0] == 6'b110101)
        LED0 <= 1;
    else
        LED0 <= 0;
end
endmodule
