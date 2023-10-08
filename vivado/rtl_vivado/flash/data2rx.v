module data2rx (
    input clk_rx,
    input en,
    input rst_n,
    output wire [7:0] rx_data,
    output wire rx_valid
);
reg [7:0] mem [22700:0];
initial 
begin
    $readmemh ("../casemem/caseram8.pat", mem);
end

reg [7:0] data_reg ;
reg [15:0] addr;

always @ (posedge clk_rx or negedge rst_n) begin
    if(~rst_n) addr <= 16'd0;
    else if(en) addr <= addr + 1'b1;
end

always @ (posedge clk_rx or negedge rst_n) begin
    if(~rst_n) data_reg <= 8'd0;
    else if(en) data_reg <= mem[addr];
end
//reg [1:0] cnt;
//always @ (posedge clk_uart or negedge rst_n) begin
//    if (~rst_n) cnt <= 2'b00;
//    else cnt <= cnt + 1'b1;
//end
//
//
//always @ (cnt) begin
//    case(cnt)
//    2'b00:data_reg = 8'h03;
//    2'b01:data_reg = 8'h04;
//    2'b10:data_reg = 8'h18;
//    2'b11:data_reg = 8'hE0;
//    default:data_reg = 8'hff;
//    endcase
//end
//always @(posedge clk) data_reg <= 8'h0f;
assign rx_data = data_reg;
assign rx_valid = en ?  clk_rx : 1'b0;
endmodule