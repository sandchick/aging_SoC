module VoltageDriver(
    input           clk,
    input           rstn,
    input           adjust_i,
    input           recover_i,
    output [7:0]    v_data_o,
    output          vld_o
);

parameter INIT     = 3'b001;
parameter CTRL     = 3'b010;
parameter FINISH   = 3'b100;
parameter START_V  = 8'h2d;
parameter NORMOL_V = 8'h32;
parameter END_V    = 8'h37;

reg  [7:0] vreg;

reg  [2:0] cur_state = INIT;
reg  [2:0] nxt_state = INIT;

always @(*) begin
    case(cur_state)
        INIT:
            nxt_state = adjust_i ? CTRL : INIT;
        CTRL:
            nxt_state = FINISH;
        FINISH:
            nxt_state = recover_i ? INIT : FINISH;
        default:
            nxt_state = INIT;
    endcase
end

always @(posedge clk or negedge rstn) begin
    if (~rstn)
        cur_state <= INIT;
    else 
        cur_state <= nxt_state;
end

reg  [7:0] cur_v = START_V;
wire [7:0] nxt_v = (cur_v == END_V) ? START_V : cur_v + 1'b1;

always @(posedge clk or negedge rstn) begin
    if (~rstn) 
        cur_v <= START_V;
    else if (adjust_i)
        cur_v <= nxt_v;
end

reg  vld_reg;
always @(posedge clk or negedge rstn) begin
    if (~rstn) 
        vld_reg <= 1'b0;
    else 
        vld_reg <= adjust_i | recover_i;
end

assign v_data_o = cur_state[0] ? NORMOL_V : cur_v;
assign vld_o    = vld_reg;

endmodule