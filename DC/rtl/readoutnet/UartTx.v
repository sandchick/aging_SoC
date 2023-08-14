module UartTx #(
    parameter               SimPresent  =   1
)   (
    input   wire            clk,
    input   wire            clk_uart,
    input   wire            rstn,
    input   wire    [7:0]   data_i,
    input   wire            trans_en_i,
    output  wire            busy_o,
    output  wire            empty_o,
    output  wire            TXD,
    output  wire            bps_en_o
);

//------------------------------------------
//  FIFO
//------------------------------------------

wire            fifo_rdreq;
wire            fifo_wrreq;
wire    [7:0]   fifo_rddata;
wire            fifo_empty;
wire            fifo_full;

/*
FIFO #(
    .DataWidth      (8),
    .AddrWidth      (3)
)   u_fifo(
    .clk            (clk),
    .rstn           (1'b1),
    .rdreq_i        (fifo_rdreq),
    .wrreq_i        (fifo_wrreq),
    .full_o         (fifo_full),
    .empty_o        (fifo_empty),
    .data_i         (data_i),
    .q_o            (fifo_rddata)
);
*/

DW_fifo_s1_sf_inst #(
    .width             (8),
    .depth             (8),
    .ae_level          (1),
    .af_level          (1),
    .err_mode          (0),
    .rst_mode          (0)
)UartFIFO(
    .inst_clk          (clk), 
    .inst_rst_n        (rstn), 
    .inst_push_req_n   (~fifo_wrreq),
    .inst_pop_req_n    (~fifo_rdreq), 
    .inst_diag_n       (1'b1), 
    .inst_data_in      (data_i),
    .empty_inst        (fifo_empty), 
    .almost_empty_inst (), 
    .half_full_inst    (),
    .almost_full_inst  (fifo_full), 
    .full_inst         (),  
    .error_inst        (),
    .data_out_inst     (fifo_rddata)
);

assign  fifo_wrreq  =   ~fifo_full  &   trans_en_i;

//------------------------------------------
//  STATE CONTROL
//------------------------------------------ 

reg                     counter_en;

reg     [13:0]          interval;
wire    [13:0]          interval_nxt;
wire                    interval_done;

generate
    if(SimPresent) begin : sim_intv

        assign  interval_done   =   interval    ==  14'h000f;

    end else begin : syn_intv

        assign  interval_done   =   &interval;

    end
endgenerate

assign  interval_nxt    =   counter_en      ?   14'b0       :   (
                            interval_done   ?   interval    :   interval + 1'b1);

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        interval    <=  14'b0;
    else
        interval    <=  interval_nxt;
end

reg [9:0]               shift_reg;

wire                    trans_finish;

wire                    trans_start;
assign  trans_start     =   ~counter_en & ~fifo_empty & interval_done;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        counter_en  <=  1'b0;
    else if(trans_start) 
        counter_en <= 1'b1;
    else if(trans_finish) 
        counter_en <= 1'b0;
end

assign  bps_en_o        =   counter_en;
assign  fifo_rdreq      =   ~fifo_empty & trans_start;   

//------------------------------------------
//  SHIFTER
//------------------------------------------

wire    [9:0]   data_formed;

assign          data_formed =   {1'b1,fifo_rddata,1'b0};

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        shift_reg   <=  10'h3ff;
    else if(trans_start)
        shift_reg   <=  data_formed;
    else if(counter_en & clk_uart)
        shift_reg   <=  {1'b1,shift_reg[9:1]};
end

//------------------------------------------
//  TRANS COUNTER
//------------------------------------------

reg     [3:0]   cnt_trans;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        cnt_trans   <=  4'h0;
    else if(~counter_en)
        cnt_trans   <=  4'h0;
    else if(clk_uart)
        cnt_trans   <=  cnt_trans + 1'b1;
end

assign  trans_finish    =   counter_en  &   cnt_trans   ==  4'ha;

//------------------------------------------
//  OUTPUT
//------------------------------------------

assign  TXD     =   counter_en  ?   shift_reg[0]    :   1'b1;
assign  busy_o  =   fifo_full;
assign  empty_o =   fifo_empty;

endmodule
