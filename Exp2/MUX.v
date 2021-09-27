module MUX(
    clk,
    select,
    en3,
    en2,
    en1,
    en0,
    cnt,
    dot
    );
input clk;
input [1:0] select;
input [1:0] en0;
input [3:0] en1;
input [3:0] en2;
input [3:0] en3;
output reg [3:0] cnt;
output dot;
assign dot = (select == 2'b11) ? 1'b0 : 1'b1;
always @(posedge clk)
begin
    case(select)
        2'b00:  begin
        cnt <= en0;
        end
        2'b01:  begin
        cnt <= en1;
        end
        2'b10:  begin
        cnt <= en2;
        end
        2'b11:  begin
        cnt <= en3;
        end
        default: cnt <= en0;
    endcase
end

endmodule