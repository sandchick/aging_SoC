module VoltageCtrl(
    input           clk_50m,
    input           rxd,
    output          scl,
    inout           sda
    // output  [7:0]   led
);

// TRI-STATE
wire sda_is_out;
wire sda_i, sda_o, scl_o;
assign sda = sda_is_out ? sda_o : 1'bz;
assign sda_i = sda;
assign scl = scl_o;

wire [7:0]  uart_data;
wire        clk_uart;
wire        rx_done;

wire clk_iicm;

UartClk # (
     .BPS_PARA      (434)
) clock_division(
     .bps_en_i      (1'b1)
    ,.clk           (clk_50m)
    ,.rstn          (1'b1)
    ,.clk_uart      (clk_uart)
);

UartRx uart_receive(
     .clk           (clk_50m)
    ,.clk_uart      (clk_uart)
    ,.rst_n         (1'b1)
    ,.rxd           (rxd)
    ,.data          (uart_data)
    ,.rx_done       (rx_done)
);

wire is_ack_o;

// VOLTAGE DECODER
wire [7:0] voltage_data;
v_dec voltage_decoder(
     .v_in          (uart_data[6:0])
    ,.d_o           (voltage_data)
);

// STATE CHANGE
// if sel == 2'b01, write reg01 to unlock
// else if sel == 2'10, write reg00 to change voltage
wire finish_reg, finish_v;
reg [1:0] sel;
always @ (posedge clk_50m) begin
    if (rx_done) sel <= 2'b01; // write reg01
    else if (finish_reg) sel <= 2'b10; // write reg00 to change voltage
    else if (finish_v)   sel <= 2'b00;
end

wire scl_o_reg, sda_o_reg, scl_o_v, sda_o_v, sda_is_out_reg, sda_is_out_o, sda_is_out_v;

assign scl_o = sel[0] ? scl_o_reg : scl_o_v;
assign sda_o = sel[0] ? sda_o_reg : sda_o_v;
assign sda_is_out = sel[0] ? sda_is_out_reg : sda_is_out_v;

// Write Reg01
iicm # (
     .REG_ADDR      (8'h01)    
) iic_reg (
     .clk           (clk_50m)
    ,.rstn          (1'b1)
    ,.data          (8'b11100000)
    ,.start_sys     (rx_done)
    ,.scl_o         (scl_o_reg)
    ,.sda_i         (sda_i)
    ,.sda_o         (sda_o_reg)
    ,.sda_is_out    (sda_is_out_reg)
    ,.finish        (finish_reg)
);

// Write Reg00
iicm # (
     .REG_ADDR      (8'h00)
) iic_voltage (
     .clk           (clk_50m)
    ,.rstn          (1'b1)
    ,.data          (voltage_data)
    ,.start_sys     (finish_reg)
    ,.scl_o         (scl_o_v)
    ,.sda_i         (sda_i)
    ,.sda_o         (sda_o_v)
    ,.sda_is_out    (sda_is_out_v)
    ,.finish        (finish_v)
);

// JUST FOR DBG
reg [1:0] cntu;
always @(posedge clk_50m) begin
    if (rx_done) cntu <= cntu + 1'b1;
end

// assign led = {sel, 4'b0, cntu};

endmodule