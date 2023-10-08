`define test  1
module UART_TX(
    input clk,
    input clk_uart,
    input RSTn,
    input [7:0] data,
    input tx_en,
    output reg TXD,
    output wire busy_o,
    output wire empty_o,
    output wire state,
    output wire bps_en
);

//FIFO 8bit-16depth
wire FIFOrd_en;
wire FIFOwr_en;
wire [7:0] FIFOdata;
wire FIFOempty;
wire FIFOfull;
FIFO_Aging FIFO(
    .clock(clk),
    .sclr(RSTn),
    .rdreq(FIFOrd_en),
    .wrreq(FIFOwr_en),
    .full(FIFOfull),
    .empty(FIFOempty),
    .data(data),
    .q(FIFOdata)
);

//FIFO write control
assign FIFOwr_en = (~FIFOfull) & tx_en;

assign state = FIFOfull;

//UART TX 
reg counter_en=1'b0;
reg [3:0] counter=1'b0;
//state control
reg     [31:0]          interval = 14'b0;
wire    [31:0]          interval_nxt;
wire                    interval_done;

generate
    if(`test) begin : sim_intv

        assign  interval_done   =   interval    ==  32'h0000_ffff;

    end else begin : syn_intv

        assign  interval_done   =   &interval;

    end
endgenerate

assign  interval_nxt    =   counter_en      ?   32'b0       :   (
                            interval_done   ?   interval    :   interval + 1'b1);

always@(posedge clk or negedge RSTn) begin
    if(~RSTn)
        interval    <=  32'b0;
    else
        interval    <=  interval_nxt;
end



wire                    trans_start;
assign  trans_start     =   ~counter_en & ~FIFOempty & interval_done;


wire trans_finish;
assign trans_finish = (counter == 4'hb);

//wire trans_start;
//assign trans_start = (~FIFOempty) & (~counter_en);

always@(posedge clk or negedge RSTn) begin
    if(~RSTn) counter_en <= 1'b0;
    else if(trans_start) counter_en <= 1'b1;
    else if(trans_finish) counter_en <= 1'b0;
end

always@(posedge clk or negedge RSTn) begin
    if(~RSTn) counter <= 4'h0;
    else if(counter_en) begin 
        if(clk_uart) counter <= counter + 1'b1;
        else if(trans_finish) counter <= 4'h0;
    end
end

assign bps_en = counter_en;

wire [9:0] data_formed;

assign data_formed = {1'b1,FIFOdata,1'b0};

always@(posedge clk or negedge RSTn) begin
    if(~RSTn) TXD <= 1'b1;
    else if(counter_en) begin
        if(clk_uart && (counter <= 4'h9)) TXD <= data_formed[counter];
    end else TXD <= 1'b1;
end

//FIFO read control
assign FIFOrd_en = (~FIFOempty) & trans_finish;

assign busy_o = FIFOfull;
assign empty_o = FIFOempty;

endmodule