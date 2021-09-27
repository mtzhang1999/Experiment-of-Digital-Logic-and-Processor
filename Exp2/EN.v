module EN(
    BTND,
    BTNU,
    LED,
    stop
    );
input BTND;
input BTNU;
input LED;
output stop;

reg stop;

always @(posedge BTNU or posedge BTND)
begin
    if (BTNU)
        stop <= 0;
    else if (LED)
        stop <= 1;
    else
        stop <= 0;
end
endmodule
