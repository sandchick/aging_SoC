module v_dec(
    input  [6:0]    v_in,
    output [7:0]    d_o
);

parameter D_BASE = 7'b0101000;

assign d_o = {1'b0, v_in + D_BASE};

endmodule