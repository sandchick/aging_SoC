module flash_wr_rd(
	//输入信号
	input				clk,
	input				rst_n,
	input				flash_rd_busy,
	//输入flash_wr模块的spi控制信号
	input				cs_n_wr,				
	input				sck_wr,
	input				mosi_wr,
	//输入flash_rd模块的spi控制信号
	input				cs_n_rd,
	input				sck_rd,
	input				mosi_rd,
	//输出FPAG给spi_flash的控制信号
	output				cs_n,
	output				sck,
	output				mosi
);
//如果检测到读按键按下，进入读忙碌状态，待写入Flash中的数据全部读出，退出读忙碌状态
//在读忙碌状态下，FPGA选择flash_rd模块的spi控制信号输出，否则，输出flash_wr模块的spi控制信号
assign cs_n	=	flash_rd_busy ? cs_n_rd : cs_n_wr; 
assign sck	=	flash_rd_busy ? sck_rd  : sck_wr;
assign mosi	=	flash_rd_busy ? mosi_rd : mosi_wr;
	 		
endmodule 