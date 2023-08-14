module flash2ram_if #(
  parameter FLASH_WIDTH = 19
)(
    input clk,
    input rst_n,
    input key_ram,
    input [7:0] flash_rdata,
    input flash_rdata_valid,
    output reg uart_valid,
    output [IMEM_WIDTH + 1 : 0] rd_addr,
    output reg [7:0] ram_dout
);
localparam	WAIT_MAX_CNT=	32'd50_000_000;	
parameter IMEM_WIDTH = 19;
reg [FLASH_WIDTH-1:0] flash_addr;
wire [7:0]ram0_din;
wire [7:0]ram1_din;
wire [7:0]ram2_din;
wire [7:0]ram3_din;
wire [7:0]ram0_dout;
wire [7:0]ram1_dout;
wire [7:0]ram2_dout;
wire [7:0]ram3_dout;
assign ram0_din[7:0] = flash_rdata[7:0];
assign ram1_din[7:0] = flash_rdata[7:0];
assign ram2_din[7:0] = flash_rdata[7:0];
assign ram3_din[7:0] = flash_rdata[7:0];
//assign ram_dout = {ram0_dout,ram1_dout,ram2_dout,ram3_dout};

always @ (posedge clk or negedge rst_n)begin
	if (~rst_n) flash_addr <= 1'b0;
	else if (flash_rdata_valid) flash_addr <= flash_addr + 1'b1; 
end

always @ (rd_addr) begin
  case(rd_addr[1:0])
  2'b00:ram_dout = ram0_dout;
  2'b01:ram_dout = ram1_dout;
  2'b10:ram_dout = ram2_dout;
  2'b11:ram_dout = ram3_dout;
  default:ram_dout = 8'hff;
  endcase
end

always@(posedge clk) begin
  if(!key_ram) uart_valid <= 1'b0;
  else if(wait_cnt == WAIT_MAX_CNT) uart_valid <= 1'b1;
  else uart_valid <= 1'b0;
end
  
reg [3:0] ram_wen;
always @(flash_addr & key_ram) begin
  if (key_ram) ram_wen = 4'b0000;
  else 
    case(flash_addr[1:0])
    2'b00:ram_wen = 4'b0001;
    2'b01:ram_wen = 4'b0010;
    2'b10:ram_wen = 4'b0100;
    2'b11:ram_wen = 4'b1000;
    default:ram_wen = 4'b0000;
    endcase
end
wire [IMEM_WIDTH-1:0] ram_addr;
reg [IMEM_WIDTH+1:0] rd_addr;


reg [31:0] wait_cnt;
always @(posedge clk )
begin
	if(key_ram == 1'b0)
		wait_cnt	<=	32'd0;
	else if(wait_cnt == WAIT_MAX_CNT)
		wait_cnt	<=	32'd0;
	else if(key_ram == 1'b1)
		wait_cnt	<=	wait_cnt + 1'b1;
	else
		wait_cnt	<=	32'd0;
end

always@(posedge clk)begin
  if (~key_ram) rd_addr <= 1'b0;
  else if (wait_cnt == WAIT_MAX_CNT) rd_addr <= rd_addr + 1'b1;
end

assign ram_addr = key_ram ? rd_addr[IMEM_WIDTH-1:2] : flash_addr[IMEM_WIDTH-1:2];

soc_fpga_ram #(8, IMEM_WIDTH-2) ram0(
  .PortAClk (clk),
  .PortAAddr(ram_addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram_wen[0]),
  .PortADataOut(ram0_dout));

soc_fpga_ram #(8, IMEM_WIDTH-2) ram1(
  .PortAClk (clk),
  .PortAAddr(ram_addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram_wen[1]),
  .PortADataOut(ram1_dout));

soc_fpga_ram #(8, IMEM_WIDTH-2) ram2(
  .PortAClk (clk),
  .PortAAddr(ram_addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram_wen[2]),
  .PortADataOut(ram2_dout));

soc_fpga_ram #(8, IMEM_WIDTH-2) ram3(
  .PortAClk (clk),
  .PortAAddr(ram_addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram_wen[3]),
  .PortADataOut(ram3_dout));



endmodule