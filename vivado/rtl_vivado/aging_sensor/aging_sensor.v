`define count_window 4 
`define sim 0
module aging_sensor (
    input clk,
    input delay_clk_pll,
    input monitor_signal,
    output [`count_window -1 : 0] aging_signal
    //input rst_n,
    //output wire txd,
    //output wire LED
);

wire delay_clk;
wire delay_clk_pll;
wire detec_window;

wire rst_n;
assign rst_n = 1'b1;
//xilinx ip
//clk_wiz_0 u_clk_wiz(
//    .clk_in1 (clk)
//    ,.clk_out1 (delay_clk_pll)
//    ,.reset (~rst_n)
//);
reg delay_sim_clk;
always #2 delay_sim_clk = clk;

assign delay_clk = `sim ? delay_sim_clk : delay_clk_pll;

assign detec_window =( (~delay_clk) & (~clk));// for sy
//assign detec_window =~( delay_clk & clk);  // for sim

wire warning_signal_monitor;
wire warning_signal_counter;
(* dont_touch="TRUE" *) monitor u_monitor (
    .detec_window      (detec_window),
    .monitor_signal    (monitor_signal),
    .clk               (clk),
    .delay_clk         (delay_clk),
    .warning_signal    (warning_signal_monitor)
);

reg Q1;
reg Q2;
reg Q3;
wire reset_Q1;

assign reset_Q1 = (~warning_signal_monitor) & Q3;

always @(posedge warning_signal_monitor or posedge reset_Q1) begin
   if (reset_Q1) begin
    Q1 <= 1'b0;
   end
   else begin
    Q1 <= 1'b1;
   end
end

always @(posedge clk) begin
   Q2 <= Q1; 
end

always @(posedge clk) begin
   Q3 <= Q2; 
end


assign warning_signal_counter = Q3 & (~Q2);

wire counter_rst;
wire [`count_window-1:0] counter;
wire uart_start;
 (* dont_touch="TRUE" *) timer #(
    .time_count     (`count_window)
) u_timer (
    .clk            (clk),
    .rst_n          (rst_n),
    .counter_rst    (counter_rst),
    .uart_start     (uart_start)
);

 (* dont_touch="TRUE" *) mbit_counter #(
    .time_count        (`count_window)
) u_mbit_counter (
    .clk               (clk),
    .reset             (counter_rst),
    .warning_signal    (warning_signal_counter),
    .counter           (counter)
);
wire [`count_window-1 :0]  aging_signal;
 (* dont_touch="TRUE" *) sig_extrator #(
    .time_count      (`count_window)
) u_sig_extrator (
    .counter         (counter),
    .aging_signal    (aging_signal)
);

//wire clk_uart;
//clkuart_gen #(
//    .DIV    (868)
//    ) u_clkuart_gen(
//    .clk_in (clk)
//    ,.clk_out (clk_uart)
//    ,.rst_n (rst_n)
//);
//
////test uart_tx
//wire [7:0] test_uart_data; 
//assign test_uart_data = 8'h0f;
//
////end test
//
//  (* dont_touch="TRUE" *) UART_TX u_uart_tx (
//    .clk         (clk),
//    .clk_uart    (clk_uart),
//    .RSTn       (rst_n),
//    .tx_en       (warning_signal_counter),
//    .data        (aging_signal),
//    .TXD         (txd)
//);
//assign LED = txd;
endmodule