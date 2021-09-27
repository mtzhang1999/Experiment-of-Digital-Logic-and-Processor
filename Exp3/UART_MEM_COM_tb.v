`timescale 1ns/1ps
`define PERIOD 10

module UART_MEM_COM_tb();
reg   clk;
reg   rst;
reg   mem2uart;
wire  Rx_Serial;
wire  recv_done;
wire  send_done;
wire  Tx_Serial;

wire  Rx_DV;
wire  [7:0] Rx_Byte;
wire  Rx_Serial_R;

reg   Tx_DV;
reg   [7:0] Tx_Byte;
wire  Tx_Active;
wire  Tx_Done;
wire  Tx_Serial_T;

reg   COM;
reg COM_done;

parameter CLKS_PER_BIT = 16'd100;
parameter MEM_SIZE = 512;

/*--------------------------------DATA MEM ADDR-------------------------*/
integer ADDR_send, ADDR_recv;
initial begin
    ADDR_send <= 1;
    ADDR_recv <= 1;
end
reg [7:0] send_mem [8 * MEM_SIZE: 1];
reg [7:0] recv_mem [4 * MEM_SIZE: 1];


assign Rx_Serial = Tx_Serial_T;
assign Rx_Serial_R = Tx_Serial;

UART_MEM_COM #(.CLKS_PER_BIT(CLKS_PER_BIT), .MEM_SIZE(MEM_SIZE)) UART_MEM_inst
         (.clk(clk),
          .rst(rst),
          .mem2uart(mem2uart),
          .COM(COM),
          .Rx_Serial(Rx_Serial),
          .recv_done(recv_done),
          .send_done(send_done),
          .Tx_Serial(Tx_Serial)
         );

uart_rx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_rx_inst
        (.i_Clock(clk),
         .i_Rx_Serial(Rx_Serial_R),
         .o_Rx_DV(Rx_DV),
         .o_Rx_Byte(Rx_Byte)
        );

uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_tx_inst
        (.i_Clock(clk),
         .i_Tx_DV(Tx_DV),
         .i_Tx_Byte(Tx_Byte),
         .o_Tx_Active(Tx_Active),
         .o_Tx_Serial(Tx_Serial_T),
         .o_Tx_Done(Tx_Done)
        );

initial begin
    $readmemh("F:/THU/2021Spring/Fundamental Experiment of Fundamental of Digital Logic and Processor/hw4/·¢ËÍ.txt", send_mem);
    COM <= 1'b0;
	COM_done <= 1'b0;
    ADDR_send <= 1;
    ADDR_recv <= 1;
    clk <= 1'b0;
    rst <= 1'b1;
    mem2uart <= 1'b0;
end

initial fork
    forever
        #(`PERIOD/2) clk <= ~clk;
    #200 rst <= 0;
    #300 Tx_DV <= 1;
    #300 Tx_Byte <= send_mem[1];
    #300 ADDR_send <= ADDR_send + 1;
join

always @(posedge Tx_Done) begin
    if (ADDR_send <= 8 * MEM_SIZE) begin
        Tx_Byte <= send_mem[ADDR_send];
        ADDR_send <= ADDR_send + 1;
    end
    else begin
        Tx_DV <= 1'b0;
    end
end

always @(posedge recv_done) begin
    if (COM) begin
        COM <= 1'b0;
        COM_done <= 1'b1;
        mem2uart <= 1'b1;
		rst <= 1'b1;
		#100 rst <= 1'b0;
		
    end
    else if(~COM_done) begin
        COM <= 1'b1;
        rst <= 1'b1;
        #100 rst <= 1'b0;
    end
end

always @(posedge Rx_DV) begin
    if (ADDR_recv <= 4 * MEM_SIZE) begin
        recv_mem[ADDR_recv] <= Rx_Byte;
        if (ADDR_recv == 4 * MEM_SIZE) begin
            $writememh("F:/THU/2021Spring/Fundamental Experiment of Fundamental of Digital Logic and Processor/hw4/recv.txt", recv_mem);
            $finish;
        end
    end
    ADDR_recv = ADDR_recv + 1;
end

endmodule