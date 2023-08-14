`define count_window 4 
`define sim 1
module aging_sensor_top(
    input clk,
    input rst_n,
    input [4:0] alu_monitor,
    input [4:0] iu_monitor,
    output txd
);
    
wire [`count_window*5-1:0] alu_aging_signal;
wire [`count_window*5-1:0] iu_aging_signal;
genvar i;
generate
  for (i = 0; i < 5; i = i + 1)begin:u_alu_monitor
  aging_sensor alu_aging_sensor(
    .clk      (clk),
    .monitor_signal (alu_monitor[i]),
    .aging_signal (alu_aging_signal[((i+1)*`count_window)-1:i*`count_window])
  ) ;end
endgenerate

genvar l;
generate
  for (i = 0; i < 5; i = i + 1)begin:u_iu_monitor
  aging_sensor iu_aging_sensor(
    .clk      (clk),
    .monitor_signal (iu_monitor[i]),
    .aging_signal (iu_aging_signal[((i+1)*`count_window)-1:i*`count_window])
  ) ;end
endgenerate

wire clk_uart;
clkuart_gen #(
    //.DIV    (868)
    .DIV    (8) //for sim
    ) u_clkuart_gen(
    .clk_in (clk)
    ,.clk_out (clk_uart)
    ,.rst_n (rst_n)
);
wire Ready_o;
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


UART_TX u_UART_TX (
    .clk         (clk),
    .clk_uart    (clk_uart),
    .RSTn        (rst_n),
    .data        (UartData_o),
    .tx_en       (UartTrans_o),
    .TXD         (TXD),
    .busy_o      (UartBusy_i),
    .empty_o     (UartEmpty_i),
    .bps_en      (bps_en)
);

endmodule