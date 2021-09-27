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
reg     [2:0]   current_state, next_state;
wire    [2:0]   state;

localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S2 = 3'b011;
localparam S3 = 3'b110;
localparam S4 = 3'b101;
localparam S5 = 3'b010;

debounce debounce(clk, BTND, clk_o);

// add your code here

always @(negedge BTNU or posedge clk_o) begin
    if(~BTNU)
        current_state <= S0;
    else
        current_state <= next_state;
    end
always @(current_state or SW1 or BTNU) begin
    case(current_state)
        S0: next_state <= SW1 ? S1 : S0;
		S1: next_state <= SW1 ? S1 : S2;
		S2: next_state <= SW1 ? S3 : S0;
		S3: next_state <= SW1 ? S1 : S4;
		S4: next_state <= SW1 ? S5 : S0;
		S5: next_state <= SW1 ? S1 : S4;
		default: next_state <= S0;
    endcase
end

always @(negedge BTNU or posedge clk_o) begin
	if (~BTNU)
        LED0 <= 0;
    else
		LED0 <= (current_state == S5 && SW1) ? 1 : 0;
end

assign LED6[3] = current_state[0];
assign LED6[4] = current_state[1];
assign LED6[5] = current_state[2];
endmodule
