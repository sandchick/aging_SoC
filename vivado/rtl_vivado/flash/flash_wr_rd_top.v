//`define sim
module flash_wr_rd_top #(
  parameter FLASH_WIDTH = 19,
  parameter IMEM_WIDTH = 19
)(
	//系统输入端口
	input			clk,
	input			rst_n,
	//按键控制端口
	input 			data_en,
	input			key_be,
	input			key_rd,
	//spi_flash
	input			miso,		
	output			cs_n,
	output			sck,
	output			mosi,

	output 	[7:0]		led_data,
	//output to coderam
    output [IMEM_WIDTH-1:0] ram_addr,
    output [3:0] ram_wen,
    output [7:0] ram0_din,
    output [7:0] ram1_din,
    output [7:0] ram2_din,
    output [7:0] ram3_din
);
wire [20 : 0] rd_addr;
//seg_decode u_seg_decode (
//    .clk        (sys_clk),
//    .rstn       (rst_n),
////    .data_in    (ram_data),
//    .data_in    (ram_data),
//    // 要显示的数据
//    .bit_sel    (bit_sel),
//    // 位选信号
//    // 段选信号
//    .seg_sel    (seg_sel)
//);
//
wire locked; 
//(*mark_debug="true"*)wire sys_clk;
wire sys_clk;
`ifndef sim
clk_wiz_0 inst
 (
 // Clock out ports  
 .clk_out1(sys_clk),
 // Status and control signals               
 .reset(0), 
 .locked(locked),
// Clock in ports
 .clk_in1(clk)
 );
`else
assign sys_clk = clk;
`endif
 

parameter	WR_RD_ADDR	=	24'h00_00_00;
 
wire	be_flag;				//擦除按键标志信号
wire	rd_flag;				//读操作标志信号
 
wire	cs_n_wr;			
wire	sck_wr;
wire	mosi_wr;
wire	cs_n_rd;
wire	sck_rd;
wire	mosi_rd;
	

wire	[7:0]	tx_data;	    
wire			rx_valid;	    
wire	[7:0]	rx_data;	    
wire	[31:0]	data_num;	    
wire	        flash_rd_busy;	
wire    [7:0]  led_data;


//flash_wr：flash写操作模块


flash_wr #(
	.WR_RD_ADDR(WR_RD_ADDR)				//数据写入地址
)
u_flash_wr(
	.clk(sys_clk),
	.rst_n(rst_n),
	.key_in(be_flag),
	.rx_valid(rx_valid),
	.rx_data(rx_data),
	
	.cs_n(cs_n_wr),
	.sck(sck_wr),
	.mosi(mosi_wr),
	.rx_data_num(data_num)
);
wire flash_addr_en;
reg [18:0] flash_addr;
wire [7:0] flash_rdata;
assign led_data = flash_rdata;
//flash_rd：flash读操作模块例化
flash_rd #(
	.WR_RD_ADDR(WR_RD_ADDR)				//数据写入地址
)
u_flash_rd(
	.clk(sys_clk),
	.rst_n(rst_n),		
	.key_in(rd_flag),					//读按键
	.miso(miso),						//读出Flash数据
	.data_num(data_num),
	
	.flash_rd_busy(flash_rd_busy),	    //flash读取数据忙碌状态
	.cs_n(cs_n_rd),						//片选信号		
	.sck(sck_rd),						//sck串行时钟
	.mosi(mosi_rd),						//主输出从输入数据
	//.tx_en(flash_addr_en),
	.led_valid (flash_addr_en),						//发送使能
	.led_data (flash_rdata)					
	//.tx_data (led_data)					//发送数据
);



flash2ram_if #(
    .FLASH_WIDTH          (19)
) u_flash2ram_if (
    .clk                  (clk),
    .rst_n                (rst_n),
    .flash_rdata          (flash_rdata),
    .flash_rdata_valid    (flash_rdata_valid),
    .ram_addr             (ram_addr),
    .ram_wen              (ram_wen),
    .ram0_din             (ram0_din),
    .ram1_din             (ram1_din),
    .ram2_din             (ram2_din),
    .ram3_din             (ram3_din)
);

//flash_wr_rd:flash读写控制模块例化
flash_wr_rd u_flash_wr_rd(
	.clk(sys_clk),
	.rst_n(rst_n),
	.flash_rd_busy(flash_rd_busy),	    //flash读操作忙碌标志信号
	.cs_n_wr(cs_n_wr),				
	.sck_wr(sck_wr),
	.mosi_wr(mosi_wr),
	
	.cs_n_rd(cs_n_rd),
	.sck_rd(sck_rd),
	.mosi_rd(mosi_rd),
	
	.cs_n(cs_n),
	.sck(sck),
	.mosi(mosi)
);

data2rx u_data2rx (
	.clk		(sys_clk),
	.en			(data_en),
	.clk_uart	 (uart_clkrx),
    .rst_n       (rst_n),
    .rx_data     (rx_data),
    .rx_valid    (rx_valid)
);



key_filter u1_key_filter(
	.clk(sys_clk),
	.rst_n(rst_n),
	.key_in(key_be),			//按键输入
	
	.key_out(be_flag)		    //检测到按键按下标志信号
);
 
//key_filter：读操作按键消抖模块例化
key_filter u2_key_filter(
	.clk(sys_clk),
	.rst_n(rst_n),
	.key_in(key_rd),		//按键输入
	
	.key_out(rd_flag)		//检测到按键按下标志信号
);
 
endmodule