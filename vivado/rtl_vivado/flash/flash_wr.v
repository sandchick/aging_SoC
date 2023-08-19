module flash_wr
#(
	parameter	WR_RD_ADDR	=	24'h00_00_00	//数据写入地址
)
(
	input				clk,
	input				rst_n,
	input				key_in,					//全擦除标志信号
	input				rx_valid,
	input		[7:0]	rx_data,
	
	output	reg		    cs_n,
	output	reg		    sck,
	output	reg		    mosi,
	output	reg[31:0]	rx_data_num				//uart接收数据总数
);
localparam	WR_EN_INST	=	8'h06;			//写使能指令
localparam	BE_INST		=	8'hc7;			//全擦除指令
localparam	PP_INST		=	8'h02;			//页写指令
 
localparam	IDLE		=	3'd0;	
localparam	WR_EN0		=	3'd1;
localparam	DELAY0		=	3'd2;
localparam	BE			=	3'd3;
localparam	WR_EN1		=	3'd4;
localparam	DELAY1		=	3'd5;
localparam	PP			=	3'd6;
reg	[3:0]		curr_state;
reg	[3:0]		next_state;
reg	[4:0]		clk_cnt;		//系统时钟计数器
reg	[3:0]		byte_cnt;	    //字节计数器
reg	[2:0]		bit_cnt;		//数据位计数器
reg	[1:0]		sck_cnt;		//sck时钟计数器
reg	[23:0]	addr_r;		        //数据写入地址寄存器
reg	[23:0]	addr;			    //数据写入地址
always @(posedge clk or negedge rst_n)
begin	
	if(!rst_n)
		curr_state	<=	IDLE;
	else 
		curr_state	<=	next_state;
end
always @(*)
begin
	next_state	<=	IDLE;
	case(curr_state)
	
		IDLE:begin
			if(key_in)
				next_state	<=	WR_EN0;
			else if(rx_valid)
				next_state	<=	WR_EN1;
			else
				next_state	<=	IDLE;
		end
		
		WR_EN0:begin
			if(byte_cnt == 4'd2 && clk_cnt == 5'd31)
				next_state	<=	DELAY0;
			else 
				next_state	<=	WR_EN0;
		end
		
		DELAY0:begin
			if(byte_cnt == 4'd3 && clk_cnt == 5'd31)
				next_state	<=	BE;
			else
				next_state	<=	DELAY0;
		end
		
		BE:begin
			if(byte_cnt == 4'd6 && clk_cnt == 5'd31)
				next_state	<=	IDLE;
			else
				next_state	<=	BE;
		end
			
		WR_EN1:begin
			if(byte_cnt == 4'd2 && clk_cnt == 5'd31)
				next_state	<=	DELAY1;
			else
				next_state	<=	WR_EN1;		
		end
		DELAY1:begin
			if(byte_cnt == 4'd3 && clk_cnt == 5'd31)
				next_state	<=	PP;
			else
				next_state	<=	DELAY1;		
		end
		
		PP:begin
			if(byte_cnt == 4'd10 && clk_cnt == 5'd31)
				next_state	<=	IDLE;
			else
				next_state	<=	PP;
		end
		
		default: next_state	<=	IDLE;
	endcase
end
//addr_r:数据写入地址寄存器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		addr_r	<=	WR_RD_ADDR;
	else if(rx_valid)
		addr_r	<=	addr_r + 1'b1;
end
 
//addr:数据写入地址
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		addr	<=	24'd0;
	else if(rx_valid)
		addr	<=	addr_r;	
end
//rx_data_num:接收数据计数器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		rx_data_num	<=	32'd0;
	else if(rx_valid)
		rx_data_num	<=	rx_data_num + 1'b1;
	else
		rx_data_num	<=	rx_data_num;
end
//clk_cnt:系统时钟计数器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		clk_cnt	<=	5'd0;
	else if(curr_state != IDLE)
		clk_cnt	<=	clk_cnt + 1'b1;
	else
		clk_cnt	<=	5'd0;
end
 
//byte_cnt:字节计数器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		byte_cnt	<=	4'd0;
	else if(curr_state == BE && byte_cnt == 4'd6 && clk_cnt == 5'd31)
		byte_cnt	<=	4'd0;
	else if(curr_state == PP && byte_cnt == 4'd10 && clk_cnt == 5'd31)
		byte_cnt	<=	4'd0;
	else if(clk_cnt == 5'd31)
		byte_cnt	<=	byte_cnt + 1'b1;
	else
		byte_cnt	<=	byte_cnt;
end
//sck_cnt:sck时钟计数器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		sck_cnt <=	2'd0;
	else if(curr_state == WR_EN0 && byte_cnt == 4'd1)
		sck_cnt	<=	sck_cnt + 1'b1;
	else if(curr_state == BE && byte_cnt == 4'd5)
		sck_cnt	<=	sck_cnt + 1'b1;
	else if(curr_state == WR_EN1 && byte_cnt == 4'd1)
		sck_cnt	<=	sck_cnt + 1'b1;
	else if(curr_state == PP && byte_cnt >= 4'd5 && byte_cnt <= 4'd9)
		sck_cnt	<=	sck_cnt + 1'b1;
	else
		sck_cnt	<=	2'd0;
end
 
//bit_cnt:数据位计数器
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		bit_cnt	<=	3'd0;
	else if(sck_cnt == 2'd1)
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
	else if(curr_state == WR_EN0 && byte_cnt == 4'd2 && clk_cnt == 5'd31) 
		cs_n	<=	1'b1;
	else if(curr_state == DELAY0 && byte_cnt == 4'd3 && clk_cnt == 5'd31)
		cs_n	<=	1'b0;
	else if(curr_state == BE && byte_cnt === 4'd6 && clk_cnt == 5'd31)
		cs_n	<=	1'b1;
	else if(rx_valid)
		cs_n	<=	1'b0;
	else if(curr_state == WR_EN1 && byte_cnt == 4'd2 && clk_cnt == 5'd31)
		cs_n	<=	1'b1;
	else if(curr_state == DELAY1 && byte_cnt == 4'd3 && clk_cnt	== 5'd31)
		cs_n	<=	1'b0;
	else if(curr_state == PP && byte_cnt == 4'd10 && clk_cnt == 5'd31)
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
	else if(curr_state == WR_EN0 && byte_cnt == 4'd2)
		mosi	<=	1'b0;
	else if(curr_state == BE && byte_cnt == 4'd6)
		mosi	<=	1'b0;	
	else if(curr_state == WR_EN1 && byte_cnt == 4'd2)
		mosi	<=	1'b0;
	else if(curr_state == PP && byte_cnt == 4'd10)
		mosi	<=	1'b0;
	else if(curr_state == WR_EN0 && byte_cnt == 4'd1 && sck_cnt == 2'd0)	
		mosi	<=	WR_EN_INST[7 - bit_cnt];    //输出WR_EN_INST指令
	else if(curr_state == BE && byte_cnt == 3'd5 && sck_cnt == 2'd0)		
		mosi	<=	BE_INST[7 - bit_cnt];	    //输出BE_INST指令
	else if(curr_state == WR_EN1 && byte_cnt == 4'd1 && sck_cnt == 2'd0)
		mosi	<=	WR_EN_INST[7 - bit_cnt];    //输出WR_EN_INST指令
	else if(curr_state == PP && byte_cnt == 4'd5 && sck_cnt == 2'd0)
		mosi	<=	PP_INST[7 - bit_cnt];	    //输出PP_INST指令
	else if(curr_state == PP && byte_cnt == 4'd6 && sck_cnt == 2'd0)
		mosi	<=	addr[23 - bit_cnt];		    //输出扇区地址
	else if(curr_state == PP && byte_cnt == 4'd7 && sck_cnt == 2'd0)
		mosi	<=	addr[15 - bit_cnt];		    //输出页地址
	else if(curr_state == PP && byte_cnt == 4'd8 && sck_cnt == 2'd0)
		mosi	<=	addr[7- bit_cnt];	        //输出字节地址
	else if(curr_state == PP && byte_cnt == 4'd9 && sck_cnt == 2'd0)
		mosi	<=	rx_data[7- bit_cnt];        //输出uart串口接收到的数据
	else
		mosi	<=	mosi;
end
 
endmodule 