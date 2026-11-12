`timescale 1ns / 1ps

module uart_top(
    input       rst,
    input [7:0] data_in,
    input       wr_en,
    input       clk,
    input       rdy_clr,
    output      rdy,
    output      busy,
    output [7:0] data_out
);

    wire rx_clk_en;
    wire tx_clk_en;
    wire tx_temp;

    baud_rate_generator bg (.clock(clk), .reset(rst), .enb_tx(tx_clk_en), .enb_rx(rx_clk_en));
    uart_sender us (.clk(clk), .rst(rst), .enb(tx_clk_en), .wr_en(wr_en),
                    .data_in(data_in), .tx(tx_temp), .tx_busy(busy));
    uart_receiver ur (.clk(clk), .rst(rst), .rx(tx_temp), .rdy_clr(rdy_clr),
                      .clken(rx_clk_en), .rdy(rdy), .data_out(data_out));

endmodule
