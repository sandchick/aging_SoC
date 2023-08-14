
module UartClk #( 
	parameter 		BPS_PARA = 10417 
)	(
	input	wire	bps_en_i,
	input 	wire	clk,	
	input	wire	rstn,	
	output 	wire	clk_uart		
);	
 
reg	[13:0] cnt = 0;

always @ (posedge clk or negedge rstn) begin
	if(~rstn)
		cnt	<=	14'b0;
	else if((cnt >= BPS_PARA-1) || (!bps_en_i)) 
		cnt <= 14'b0;		
	else 
		cnt <= cnt + 1'b1;
end

reg			clk_uart_reg;

always @ (posedge clk or negedge rstn) begin
	if(~rstn)
		clk_uart_reg	<=	1'b0;
	else if(cnt == BPS_PARA - 1) 
		clk_uart_reg <= 1'b1;
	else 
		clk_uart_reg <= 1'b0;	
end

assign	clk_uart	=	clk_uart_reg;
 
endmodule