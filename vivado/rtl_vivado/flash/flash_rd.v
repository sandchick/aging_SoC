
module flash_rd
#(
	parameter	WR_RD_ADDR	=	24'h00_00_00	//数据读出地址
)
(
	input				clk,
	input				rst_n,
	input				key_in,			//按键按下
	input				miso,			//读出Flash数据
	input		[31:0]	data_num,		//待读出数据总数
	
	output reg			flash_rd_busy,	//flash读取数据忙碌状态
	output reg			cs_n,			//片选信号		
	output reg			sck,			//sck串行时钟
	output reg			mosi,			//主输出从输入数据
	output reg			tx_en,			//发送使能信号
	output wire  [7:0] tx_data,
	output wire		led_valid,
	output wire		[7:0]	led_data//发送数据
);
localparam	IDLE	=	3'b001;			//空闲状态
localparam	READ	=	3'b010;			//数据读状态
localparam	SEND	=	3'b100;			//数据发送状态
 
localparam	READ_INST	=	8'h03;	    //数据读指令
//等待计数最大值，波特率9600时，发送1bit数据需要5208个时钟周期，这里计数值需要大于5208*10
localparam	WAIT_MAX_CNT=	32'd50_000_00;		
//localparam	WAIT_MAX_CNT=	32'd5000;		
 
wire	[31:0] fifo_data_num;		    //fifo中数据个数
 
reg	[2:0]	curr_state;
reg	[2:0]	next_state;
reg	[4:0]	clk_cnt;			//系统时钟计数
reg	[15:0]  byte_cnt;				//字节计数器
reg	[1:0]	sck_cnt;			//sck时钟计数器
reg	[2:0]	bit_cnt;			//数据位计数器
 
reg			miso_flag;			//miso数据提取标志信号
reg	[7:0]	miso_r;				//对输入的miso数据进行移位拼接
reg			wr_req_r;			//读请求信号
reg			wr_req;				//写请求信号
reg	[7:0]	wr_data;			//写数据
reg			fifo_rd_valid;		//fifo读有效信号
reg	[31:0]  wait_cnt;				//等待时钟计数器
reg			rd_req;				//读请求信号
reg	[31:0]	rd_data_num;		//读出fifo数据个数
 
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		curr_state	<=	IDLE;
	else
		curr_state	<=	next_state;
end
 
always @(*)
begin
	next_state	=	IDLE;
	case(curr_state)
		IDLE:begin
			if(key_in)
				next_state	=	READ;
			else
				next_state	=	IDLE;
		end
		READ:begin
			if(byte_cnt == data_num + 2'd3 && clk_cnt == 5'd31)
				next_state	=	IDLE;
			else
				next_state	=	READ;
		end
		
		SEND:begin
			if(rd_data_num == data_num && wait_cnt == WAIT_MAX_CNT)
				next_state	=	IDLE;
			else
				next_state	=	SEND;	
		end
		
		default: next_state	=	IDLE;
	endcase
end
 
//clk_cnt:系统时钟计数器		
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		clk_cnt	<=	5'd0;
	else if(curr_state == READ)
		clk_cnt	<=	clk_cnt + 1'b1;
	else
		clk_cnt	<=	5'd0;
end
//byte_cnt:字节计数器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		byte_cnt	<=	16'd0;
	else if(byte_cnt == data_num + 2'd3 && clk_cnt == 5'd31)
		byte_cnt	<=	16'd0;
	else if(clk_cnt == 5'd31)
		byte_cnt	<=	byte_cnt + 1'b1;
	else
		byte_cnt	<=	byte_cnt;
end
//sck_cnt:sck时钟计数器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		sck_cnt	<=	2'd0;
	else if(curr_state == READ)
		sck_cnt	<=	sck_cnt + 1'b1;
	else
		sck_cnt	<=	2'd0;
end
 
//bit_cnt:数据位计数器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		bit_cnt	<=	3'd0;
	else if(sck_cnt == 2'd2)
		bit_cnt	<=	bit_cnt + 1'b1;
	else
		bit_cnt	<=	bit_cnt;
end
//cs_n:片选信号
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		cs_n	<=	1'b1;
	else if(key_in)
		cs_n	<=	1'b0;
	else if(curr_state == READ && byte_cnt == data_num + 2'd3 && clk_cnt == 5'd31)
		cs_n	<=	1'b1;
	else
		cs_n	<=	cs_n;
end
 
//sck:sck时钟生成
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		sck	<=	1'b0;
	else if(sck_cnt == 2'd1)
		sck	<=	1'b1;
	else if(sck_cnt == 2'd3)
		sck	<=	1'b0;
	else
		sck	<=	sck;
end
//mosi:数据输出
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		mosi	<=	1'b0;
	else if(curr_state == READ && byte_cnt >= 16'd4)
		mosi	<=	1'b0;
	else if(byte_cnt == 16'd0 && sck_cnt == 2'd0)
		mosi	<=	READ_INST[7 - bit_cnt];
	else if(byte_cnt == 16'd1 && sck_cnt == 2'd0)
		mosi	<=	WR_RD_ADDR[23 - bit_cnt];
	else if(byte_cnt == 16'd2 && sck_cnt == 2'd0)
		mosi	<=	WR_RD_ADDR[15 - bit_cnt];
	else if(byte_cnt == 16'd3 && sck_cnt == 2'd0)
		mosi	<=	WR_RD_ADDR[7 - bit_cnt];
	else
		mosi	<=	mosi;
end
 
//miso_flag:miso数据提取标志信号
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		miso_flag	<=	1'b0;
	else if(byte_cnt >= 16'd4 && sck_cnt == 2'd1)
		miso_flag	<=	1'b1;
	else
		miso_flag	<=	1'b0;
end
//miso_r:将miso输入数据进行移位寄存，高位在前低位在后
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		miso_r	<=	8'd0;
	else if(miso_flag == 1'b1)
		miso_r	<=	{miso_r[6:0],miso};
	else
		miso_r	<=	miso_r;
end

//wr_req_r:写请求数据标志位
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		wr_req_r	<=	1'b0;
	else if(bit_cnt == 3'd7 && miso_flag == 1'b1)
		wr_req_r	<=	1'b1;
	else 
		wr_req_r	<=	1'b0;
end
 
//wr_req:对wr_req_r打一拍，与写入数据同步
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		wr_req	<=	1'b0;
	else 
		wr_req	<=	wr_req_r;
end
//wr_data:写入数据
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		wr_data	<=	8'd0;
	else if(wr_req_r == 1'b1)
		wr_data	<=	miso_r;
	else
		wr_data	<=	wr_data;
end

assign led_data = wr_data;
assign led_valid = wr_req; 
//fifo_rd_valid:fifo读有效信号
//always @(posedge clk or negedge rst_n)
//begin
//	if(!rst_n)
//		fifo_rd_valid	<=	1'b0;
//	else if(curr_state == SEND && rd_data_num == data_num && wait_cnt == WAIT_MAX_CNT)
//		fifo_rd_valid	<=	1'b0;
//	else if(curr_state == SEND && fifo_data_num <= data_num)
//		fifo_rd_valid	<=	1'b1;
//	else
//		fifo_rd_valid	<=	fifo_rd_valid;
//end
// 
////wait_cnt:数据读取间隔
//always @(posedge clk or negedge rst_n)
//begin
//	if(!rst_n)
//		wait_cnt	<=	32'd0;
//	else if(fifo_rd_valid == 1'b0)
//		wait_cnt	<=	32'd0;
//	else if(wait_cnt == WAIT_MAX_CNT)
//		wait_cnt	<=	32'd0;
//	else if(fifo_rd_valid == 1'b1)
//		wait_cnt	<=	wait_cnt + 1'b1;
//	else
//		wait_cnt	<=	32'd0;
//end
////rd_req_r:fifo读使能标志信号
//always @(posedge clk or negedge rst_n)
//begin
//	if(!rst_n)
//		rd_req	<=	1'b0;
//	//else if(rd_data_num < data_num && wait_cnt == WAIT_MAX_CNT)
//	else if(wait_cnt == WAIT_MAX_CNT)
//		rd_req	<=	1'b1;
//	else
//		rd_req	<=	1'b0;
//end
// 
// 
////rd_data_num:从fifo中读出数据计数器
//always @(posedge clk or negedge rst_n)
//begin
//	if(!rst_n)
//		rd_data_num	<=	32'd0;
//	else if(fifo_rd_valid == 1'b0)
//		rd_data_num	<=	32'd0;
//	else if(rd_req	== 1'b1)
//		rd_data_num	<=	rd_data_num + 1'b1;
//	else
//		rd_data_num	<=	rd_data_num;
//end
////tx_en:uart串口发送使能
//always @(posedge clk or negedge rst_n)
//begin
//	if(!rst_n)
//		tx_en	<=	1'b0;
//	else
//		tx_en	<=	rd_req;
//end
// 
////flash_rd_busy:flash读忙碌标志信号
//
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		flash_rd_busy	<=	1'b0;
	else if(key_in == 1'b1)
		flash_rd_busy	<=	1'b1;
	else
		flash_rd_busy	<=	flash_rd_busy;
end
//wire [7:0] tx_data;
//FIFO	u_fifo(
//	.clk (clk ),			//时钟信号
//	.rstn (rst_n) ,
//	.data_i  (wr_data ),	    //写入数据，8bit
//	.rdreq_i (rd_req),		//读请求
//	.wrreq_i (wr_req ),		//写请求
//	.q_o 	 (tx_data )		//数据读出，8bit
//);
endmodule 