`timescale 1ns/1ps
`define PERIOD 10

module UART_MEM_tb();
reg   clk;
reg   rst;
reg   mem2uart;

/*---------------------------MEM--------------------------------*/
wire  recv_done;
wire  send_done;
/*---------------------------UART-------------------------------*/
wire  Tx_Serial;
wire  Rx_Serial;
/*--------------------------------UART RX-------------------------*/
wire  Rx_DV;
wire  [7:0] Rx_Byte;
wire  Rx_Serial_R;
/*--------------------------------UART TX-------------------------*/
reg   Tx_DV;
reg   [7:0] Tx_Byte;
wire  Tx_Active;
wire  Tx_Done;
wire  Tx_Serial_T;

parameter CLKS_PER_BIT = 16'd100;
parameter MEM_SIZE = 512;
/*--------------------------------DATA MEM ADDR-------------------------*/
integer ADDR_send, ADDR_recv;
initial begin
    ADDR_send <= 1;
    ADDR_recv <= 1;
end

/*--------------------------------SET MEM-------------------------*/
reg [7:0] send_mem [8 * MEM_SIZE: 1];
reg [7:0] recv_mem [4 * MEM_SIZE: 1];

assign Rx_Serial = Tx_Serial_T;
assign Rx_Serial_R = Tx_Serial;

UART_MEM #(.CLKS_PER_BIT(CLKS_PER_BIT), .MEM_SIZE(MEM_SIZE)) UART_MEM_inst
         (.clk(clk),
          .rst(rst),
          .mem2uart(mem2uart),
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
    mem2uart <= 0;
    clk <= 0;
    rst <= 1;
/* read data from 发送.txt and save data in the mem*/
    $readmemh("F:/THU/2021Spring/Fundamental Experiment of Fundamental of Digital Logic and Processor/hw4/发送.txt", send_mem);
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
    if (ADDR_send <= MEM_SIZE * 8) begin
        Tx_Byte <= send_mem[ADDR_send];
        ADDR_send <= ADDR_send + 1;
    end
    else begin
        Tx_DV <= 0;
    end
end

always @(posedge recv_done) begin
    mem2uart <= 1'b1;    /*recv data from mem*/
end

always @(posedge Rx_DV) begin
    if (ADDR_recv <= MEM_SIZE * 4) begin
        recv_mem[ADDR_recv] = Rx_Byte;
        if (ADDR_recv == 4 * MEM_SIZE) begin
            $writememh("F:/THU/2021Spring/Fundamental Experiment of Fundamental of Digital Logic and Processor/hw4/理论接收.txt", recv_mem);
            $finish;
        end
    end
    ADDR_recv <= ADDR_recv + 1;
end
endmodule
