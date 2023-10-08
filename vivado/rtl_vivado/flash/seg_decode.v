module seg_decode(
    input  wire         clk,
    input  wire         rstn,
    input  wire [23:0]  data_in,    // 要显示的数据
    output wire [5:0]   bit_sel,    // 位选信号
    output wire [7:0]   seg_sel     // 段选信号
);
//localparam WAIT_MAX_CNT = 32'd50_000_000;

//reg [31:0] cnt;
//reg flag = 1'b0;
//always@(posedge clk or negedge rstn)
//begin
//    if(!rstn) begin
//        cnt <= 32'd0;
//        flag <= 1'd0;
//    end else if(cnt==WAIT_MAX_CNT) begin
//        cnt <= 32'd0;
//        flag <= !flag;
//    end else begin
//        cnt <= cnt + 1'b1;
//    end
//end
//
reg [2:0] bit_cnt;
always@(posedge clk or negedge rstn)
begin
    if(!rstn) begin
        bit_cnt <= 3'b000;
    end else if(bit_cnt==3'd5) begin
        bit_cnt <= 3'b000;
    end else begin
        bit_cnt <= bit_cnt + 1'b1;
    end
end

reg [5:0] bit_sel_reg;
assign bit_sel = bit_sel_reg;

always @(*) begin
    case(bit_cnt)
        3'b000 : bit_sel_reg = 6'b111110;
        3'b001 : bit_sel_reg = 6'b111101;
        3'b010 : bit_sel_reg = 6'b111011;
        3'b011 : bit_sel_reg = 6'b110111;
        3'b100 : bit_sel_reg = 6'b101111;
        3'b101 : bit_sel_reg = 6'b011111;
        default : bit_sel_reg = 6'b111111;
    endcase
end

reg [3:0] data_disp;
//reg [3:0] data_disp1;
always@(*) begin
    case(bit_cnt)
        3'b000  : data_disp = data_in[3:0];
        3'b001  : data_disp = data_in[7:4];
        3'b010  : data_disp = data_in[11:8];
        3'b011  : data_disp = data_in[15:12];
        3'b100  : data_disp = data_in[19:16];
        3'b101  : data_disp = data_in[23:20];
        default : data_disp = 4'h0;
    endcase
end

//always@(*) begin
//    case(bit_cnt)
//        3'b000  : data_disp1 = data_in[27:24];
//        3'b001  : data_disp1 = data_in[31:28];
//        3'b010  : data_disp1 = 4'd0;
//        3'b011  : data_disp1 = 4'd0;
//        3'b100  : data_disp1 = 4'd0;
//        3'b101  : data_disp1 = 4'd0;
//        default : data_disp1 = 4'h0;
//    endcase
//end

reg [7:0] seg_sel_reg;
//reg [7:0] seg_sel_reg1;

always@(*) begin
    case(data_disp)
        4'h0 : seg_sel_reg = 8'h3f;
        4'h1 : seg_sel_reg = 8'h06;
        4'h2 : seg_sel_reg = 8'h5b;
        4'h3 : seg_sel_reg = 8'h4f;
        4'h4 : seg_sel_reg = 8'h66;
        4'h5 : seg_sel_reg = 8'h6d;
        4'h6 : seg_sel_reg = 8'h7d;
        4'h7 : seg_sel_reg = 8'h07;
        4'h8 : seg_sel_reg = 8'h7f;
        4'h9 : seg_sel_reg = 8'h6f;
        4'ha : seg_sel_reg = 8'h77;
        4'hb : seg_sel_reg = 8'h7c;
        4'hc : seg_sel_reg = 8'h39;
        4'hd : seg_sel_reg = 8'h5e;
        4'he : seg_sel_reg = 8'h79;
        4'hf : seg_sel_reg = 8'h71;
        default :seg_sel_reg = 8'h0;
    endcase
end

//always@(*) begin
//    case(data_disp1)
//        4'h0 : seg_sel_reg1 = 8'h3f;
//        4'h1 : seg_sel_reg1 = 8'h06;
//        4'h2 : seg_sel_reg1 = 8'h5b;
//        4'h3 : seg_sel_reg1 = 8'h4f;
//        4'h4 : seg_sel_reg1 = 8'h66;
//        4'h5 : seg_sel_reg1 = 8'h6d;
//        4'h6 : seg_sel_reg1 = 8'h7d;
//        4'h7 : seg_sel_reg1 = 8'h07;
//        4'h8 : seg_sel_reg1 = 8'h7f;
//        4'h9 : seg_sel_reg1 = 8'h6f;
//        4'ha : seg_sel_reg1 = 8'h77;
//        4'hb : seg_sel_reg1 = 8'h7c;
//        4'hc : seg_sel_reg1 = 8'h39;
//        4'hd : seg_sel_reg1 = 8'h5e;
//        4'he : seg_sel_reg1 = 8'h79;
//        4'hf : seg_sel_reg1 = 8'h71;
//        default :seg_sel_reg1 = 8'h0;
//    endcase
//end

//assign seg_sel = flag ? seg_sel_reg:seg_sel_reg1;
assign seg_sel = seg_sel_reg;


endmodule