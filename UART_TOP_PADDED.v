module uart_top_padded (

    // Chip I/O Pads
    rst,
    wr_en,
    clk,
    rdy_clr,
    data_in,

    rdy,
    busy,
    data_out,

    VDD,
    VSS
);

    //----------------------------------------------------
    // Chip-Level I/O
    //----------------------------------------------------
    input           rst;
    input           wr_en;
    input           clk;
    input           rdy_clr;
    input [7:0]     data_in;

    output          rdy;
    output          busy;
    output [7:0]    data_out;

    inout VDD;
    inout VSS;

    //----------------------------------------------------
    // Core Signals
    //----------------------------------------------------
    wire            rst_core;
    wire            wr_en_core;
    wire            clk_core;
    wire            rdy_clr_core;
    wire [7:0]      data_in_core;

    wire            rdy_core;
    wire            busy_core;
    wire [7:0]      data_out_core;

    //
    // INPUT PADS
    //----------------------------------------------------

    IPAD20 ipad_rst_inst (
        .OUT1(rst_core),
        .IN1(rst)
    );

    IPAD20 ipad_wr_en_inst (
        .OUT1(wr_en_core),
        .IN1(wr_en)
    );

    IPAD20 ipad_clk_inst (
        .OUT1(clk_core),
        .IN1(clk)
    );

    IPAD20 ipad_rdy_clr_inst (
        .OUT1(rdy_clr_core),
        .IN1(rdy_clr)
    );

    // pad_data_in[7:0]
    IPAD20 ipad_data_in0 (.OUT1(data_in_core[0]), .IN1(data_in[0]));
    IPAD20 ipad_data_in1 (.OUT1(data_in_core[1]), .IN1(data_in[1]));
    IPAD20 ipad_data_in2 (.OUT1(data_in_core[2]), .IN1(data_in[2]));
    IPAD20 ipad_data_in3 (.OUT1(data_in_core[3]), .IN1(data_in[3]));
    IPAD20 ipad_data_in4 (.OUT1(data_in_core[4]), .IN1(data_in[4]));
    IPAD20 ipad_data_in5 (.OUT1(data_in_core[5]), .IN1(data_in[5]));
    IPAD20 ipad_data_in6 (.OUT1(data_in_core[6]), .IN1(data_in[6]));
    IPAD20 ipad_data_in7 (.OUT1(data_in_core[7]), .IN1(data_in[7]));


    uart_top core_inst (
        .rst        (rst_core),
        .data_in    (data_in_core),
        .wr_en      (wr_en_core),
        .clk        (clk_core),
        .rdy_clr    (rdy_clr_core),
        .rdy        (rdy_core),
        .busy       (busy_core),
        .data_out   (data_out_core)
    );


    OPAD02 opad_rdy_inst (
        .PAD(rdy),
        .IN1(core)
    );

    OPAD02 opad_busy_inst (
        .PAD(busy),
        .IN1(busy_core)
    );

    OPAD02 opad_data_out0 (.PAD(data_out[0]), .IN1(data_out_core[0]));
    OPAD02 opad_data_out1 (.PAD(data_out[1]), .IN1(data_out_core[1]));
    OPAD02 opad_data_out2 (.PAD(data_out[2]), .IN1(data_out_core[2]));
    OPAD02 opad_data_out3 (.PAD(data_out[3]), .IN1(data_out_core[3]));
    OPAD02 opad_data_out4 (.PAD(data_out[4]), .IN1(data_out_core[4]));
    OPAD02 opad_data_out5 (.PAD(data_out[5]), .IN1(data_out_core[5]));
    OPAD02 opad_data_out6 (.PAD(data_out[6]), .IN1(data_out_core[6]));
    OPAD02 opad_data_out7 (.PAD(data_out[7]), .IN1(data_out_core[7]));

endmodule
