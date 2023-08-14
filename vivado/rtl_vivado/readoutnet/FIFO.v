//it is just a normal FIFO
module FIFO #(
    parameter           DataWidth   = 8,
    parameter           AddrWidth   = 4
)   (
    input   wire                    clk,
    input   wire                    rstn,
    input   wire                    rdreq_i,
    input   wire                    wrreq_i,
    output  wire                    full_o,
    output  wire                    empty_o,

    input   wire    [DataWidth-1:0] data_i,
    output  wire    [DataWidth-1:0] q_o

);

(* ram_style="block" *)reg [DataWidth - 1 : 0] mem [2 ** AddrWidth - 1 : 0];
reg [AddrWidth - 1 : 0] wp      =   0;
reg [AddrWidth - 1 : 0] rp      =   0;
reg                     w_flag  =   0;
reg                     r_flag  =   0;


always @(posedge clk or negedge rstn) begin
    if(~rstn) begin
        wp      <=  0;
        w_flag  <=  1'b0;
    end else if(!full_o && wrreq_i) begin 
        wp      <=  (wp == 2 ** AddrWidth - 1)  ?   0       :   wp + 1'b1;
        w_flag  <=  (wp == 2 ** AddrWidth - 1)  ?   ~w_flag :   w_flag;
    end
end

always @(posedge clk) begin
    if(wrreq_i && !full_o)begin
        mem[wp] <= data_i;
    end
end

always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
        rp      <=  0;
        r_flag  <=  1'b0;
    end else if(!empty_o && rdreq_i) begin 
        rp      <=  (rp == 2 ** AddrWidth - 1)  ?   0       :   rp + 1'b1;
        r_flag  <=  (rp == 2 ** AddrWidth - 1)  ?   ~r_flag :   r_flag;
    end
end

assign q_o = mem[rp];

assign  full_o  =   wp ^ rp         ?   1'b0    :   (
                    r_flag ^ w_flag ?   1'b1    :   1'b0);

assign  empty_o =   wp ^ rp         ?   1'b0    :   (
                    r_flag ^ w_flag ?   1'b0    :   1'b1);

endmodule