module  SRAM #(
    parameter                       AddrWidth = 5,
    parameter                       DataWidth = 16
)   (
    input   wire                    clk,
    input   wire                    rstn,

    input   wire    [AddrWidth-1:0] AddrA_i,
    input   wire    [DataWidth-1:0] DinA_i,
    input   wire                    WriteA_i,

    input   wire    [AddrWidth-1:0] AddrB_i,
    output  reg     [DataWidth-1:0] DoutB_o
);

(* ram_style="block" *)reg     [DataWidth-1:0] Mem [2**AddrWidth-1:0];

always@(posedge clk) begin
    if(WriteA_i)
        Mem[AddrA_i]    <=   DinA_i;
    DoutB_o         <=   Mem[AddrB_i];
end

endmodule