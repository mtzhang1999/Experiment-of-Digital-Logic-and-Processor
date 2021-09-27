module Test(
    BTNU,
    clk,
    LED,
    stop,
    en0,
    en1,
    en2,
    en3
    );
input clk;
input BTNU;
input LED;
input stop;
output en0;
output en1;
output en2;
output en3;

reg [3:0] en0;
reg [3:0] en1;
reg [3:0] en2;
reg [3:0] en3;

always @(posedge BTNU or posedge clk or posedge stop)
begin
    if(BTNU) begin
        en0 <= 4'd0;
        en1 <= 4'd0;
        en2 <= 4'd0;
        en3 <= 4'd0;
    end
    else if(stop)begin
    end
          else if (clk && LED)
          if (en0 == 4'd9)
                if (en1 == 4'd9)
                    if (en2 == 4'd9)
                         if (en3 == 4'd9) begin
                            en0 <= 4'd0;
                            en1 <= 4'd0;
                            en2 <= 4'd0;
                            en3 <= 4'd0; 
                         end
                         else begin
                            en0 <= 4'd0;
                            en1 <= 4'd0;
                            en2 <= 4'd0;
                            en3 <= en3 + 1;
                         end
                    else begin
                        en0 <= 4'd0;
                        en1 <= 4'd0;
                        en2 <= en2 + 1;
                    end
                else begin
                    en0 <= 4'd0;
                    en1 <= en1 + 1;
                end
            else
                en0 <= en0 + 1;
        else begin
            en0 <= 4'd0;
            en1 <= 4'd0;
            en2 <= 4'd0;
            en3 <= 4'd0;
        end
end
endmodule
