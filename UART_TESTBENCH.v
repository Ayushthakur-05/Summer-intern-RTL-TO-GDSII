`timescale 1ns / 1ps
module uart_top_tb;

    reg clk, rst;
    reg [7:0] data_in;
    reg wr_en;
    reg rdy_clr;
    wire rdy;
    wire [7:0] dout;
    wire busy;

    reg [7:0] tx_data_log;
    reg [7:0] rx_data_log;
    integer tx_count = 0;
    integer rx_count = 0;
    integer pass_count = 0;
    integer fail_count = 0;

    uart_top dut (
        .rst(rst), .data_in(data_in), .wr_en(wr_en),
        .clk(clk), .rdy_clr(rdy_clr), .rdy(rdy),
        .busy(busy), .data_out(dout)
    );

    initial {clk, rst, data_in, wr_en, rdy_clr} = 0;
    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (wr_en) begin
            tx_data_log = data_in;
            tx_count = tx_count + 1;
            $display(" TX #%0d -> Sent : 0x%02H (%d) '%s'",
                     $time, tx_count,
                     data_in, data_in, data_in);
        end
    end

    always @(posedge rdy) begin
        rx_data_log = dout;
        rx_count = rx_count + 1;
        $display(" RX #%0d <- Received : 0x%02H (%d) '%s'",
                 $time, rx_count,
                 dout, dout, dout);

        if (tx_data_log == dout) begin
            $display("[PASS] TX == RX (0x%02H)", dout);
            pass_count = pass_count + 1;
        end else begin
            $display(
                "[FAIL] TX=0x%02H RX=0x%02H MISMATCH!",
                tx_data_log, dout
            );
            fail_count = fail_count + 1;
        end
    end

    task send_byte(input [7:0] din);
    begin
        @(negedge clk);
        data_in = din;
        wr_en = 1'b1;
        @(negedge clk);
        wr_en = 1'b0;
        @(negedge clk);
    end
    endtask

    task clear_ready;
    begin
        @(negedge clk);
        rdy_clr = 1'b1;
        @(negedge clk);
        rdy_clr = 1'b0;
    end
    endtask

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, uart_top_tb);

        @(negedge clk);
        rst = 1'b1;
        @(negedge clk);
        rst = 1'b0;

        send_byte(8'h41);
        wait (busy);
        wait (rdy);
        clear_ready;

        send_byte(8'h55);
        wait (busy);
        wait (rdy);
        clear_ready;

        send_byte(8'hA5);
        wait (busy);
        wait (rdy);
        clear_ready;

        send_byte(8'hFF);
        wait (busy);
        wait (rdy);
        clear_ready;

        $display(
            "  Total TX: %0d   Total RX: %0d   PASS: %0d   FAIL: %0d",
            tx_count, rx_count, pass_count, fail_count
        );

        #4 $finish;
    end

endmodule
