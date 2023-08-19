module flash2ram_if #(
  parameter FLASH_WIDTH = 19
)(
    input clk,
    input rst_n,
    input [7:0] flash_rdata,
    input flash_rdata_valid,
    output [IMEM_WIDTH-1:0] ram_addr,
    output reg [3:0] ram_wen,
    output [7:0] ram0_din,
    output [7:0] ram1_din,
    output [7:0] ram2_din,
    output [7:0] ram3_din
    
);
parameter IMEM_WIDTH = 19;
reg [FLASH_WIDTH-1:0] flash_addr;

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


always @(flash_addr ) begin
    case(flash_addr[1:0])
    2'b00:ram_wen = 4'b0001;
    2'b01:ram_wen = 4'b0010;
    2'b10:ram_wen = 4'b0100;
    2'b11:ram_wen = 4'b1000;
    default:ram_wen = 4'b0000;
    endcase
end



assign ram_addr = flash_addr[IMEM_WIDTH-1:2];



endmodule