`define count_window 4 
module aging_sensor_top(
    input clk,
    input rst_n,
    input [4:0] alu_monitor,
    input [4:0] iu_monitor,
    output txd
);

reg [4:0] alu_monitor_reg1, alu_monitor_reg2;
reg [4:0] iu_monitor_reg1, iu_monitor_reg2;
always@(posedge clk )begin
  alu_monitor_reg1  <= alu_monitor;
  alu_monitor_reg2 <= alu_monitor_reg1;
end 

always@(posedge clk )begin
  iu_monitor_reg1  <= iu_monitor;
  iu_monitor_reg2 <=  iu_monitor_reg1;
end 

wire [`count_window*5-1:0] alu_aging_signal;
wire [`count_window*5-1:0] iu_aging_signal;
wire delay_clk_pll;
//xilinx ip
clk_wiz_0 u_clk_wiz(
    .clk_in1 (clk)
    ,.clk_out1 (delay_clk_pll)
    ,.reset (~rst_n)
);
genvar i;
generate
  for (i = 0; i < 5; i = i + 1)begin:u_alu_monitor
  aging_sensor alu_aging_sensor(
    .clk      (clk),
    .delay_clk_pll (delay_clk_pll),
    .monitor_signal (alu_monitor_reg2[i]),
    .aging_signal (alu_aging_signal[((i+1)*`count_window)-1:i*`count_window])
  ) ;end
endgenerate

genvar l;
generate
  for (i = 0; i < 5; i = i + 1)begin:u_iu_monitor
  aging_sensor iu_aging_sensor(
    .clk      (clk),
    .delay_clk_pll (delay_clk_pll),
    .monitor_signal (iu_monitor_reg2[i]),
    .aging_signal (iu_aging_signal[((i+1)*`count_window)-1:i*`count_window])
  ) ;end
endgenerate

wire clk_uart;
clkuart_gen #(
    //.DIV    (868)
    .DIV    (87) //for sim
    ) u_clkuart_gen(
    .clk_in (clk)
    ,.clk_out (clk_uart)
    ,.rst_n (rst_n)
);
reg [`count_window*5-1:0] alu_aging_signal_reg;
reg [`count_window*5-1:0] iu_aging_signal_reg;
always @ (posedge clk) begin
  if (Ready_o) begin
    alu_aging_signal_reg <= alu_aging_signal;
    iu_aging_signal_reg <= iu_aging_signal;
  end
  else begin
    alu_aging_signal_reg <= alu_aging_signal_reg;
    iu_aging_signal_reg <= iu_aging_signal_reg;
  end
end
wire [7:0] UartData_o;
wire UartTrans_o;
wire Ready_o;
wire UartBusy_i;
wire UartEmpty_i;
aging2uart u_aging2uart (
    .clk            (clk),
    .rstn           (rst_n),
    .Data_i_iu      (iu_aging_signal_reg),
    .Data_i_alu      (alu_aging_signal_reg),
    .UartData_o     (UartData_o),
    .UartTrans_o    (UartTrans_o),
    .Ready_o        (Ready_o),
    .UartBusy_i     (UartBusy_i),
    .UartEmpty_i    (UartEmpty_i)
);
//aging2uart u_aging2uart (
//    .clk            (clk),
//    .rstn           (rst_n),
//    .Data_i_iu      (),
//    .Data_i_alu      (1'b0),
//    .UartData_o     (UartData_o),
//    .UartTrans_o    (UartTrans_o),
//    .Ready_o        (Ready_o),
//    .UartBusy_i     (UartBusy_i),
//    .UartEmpty_i    (UartEmpty_i)
//);

UART_TX u_UART_TX (
    .clk         (clk),
    .clk_uart    (clk_uart),
    .RSTn        (rst_n),
    .data        (UartData_o),
    .tx_en       (UartTrans_o),
    .TXD         (txd),
    .busy_o      (UartBusy_i),
    .empty_o     (UartEmpty_i),
    .bps_en      (bps_en)
);

endmodule