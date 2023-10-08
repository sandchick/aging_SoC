module  CounterControl #(
    parameter                       NumOsc = 10
)   (
    input   wire                    clk,
    input   wire                    rstn,


    output  wire    [4:0]           OscSel_o,
    output  wire                    Sample_o,
    output  wire                    Resetn_o
);

reg     [31:0]  Counter = 32'b0;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        Counter <=  32'b0;
    else if((Counter[31:27] == NumOsc - 1) && &Counter[26:0])
    //else if((Counter[31:24] == NumOsc - 1) && &Counter[23:0])
        Counter <=  32'b0;
    else
        Counter <=  Counter +   1'b1; 
end

reg             SampleReg = 1'b0;

// SRAM 写使能信号, 当 Counter[26:0] == 0x1ffff 时, SampleReg 输出1, 否则输出0.
always@(posedge clk or negedge rstn) begin
    if(~rstn)
        SampleReg   <=  1'b0;
    else
        SampleReg <= ~|Counter[26:3] & &Counter[2:0];
        //SampleReg <= &Counter[23:3] & ~|Counter[2:0];
end


reg ResetnReg = 1'b0;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        ResetnReg   <=  1'b0;
    else 
        ResetnReg   <=  ~&Counter[26:0];
        //ResetnReg   <=  ~&Counter[23:0];
end

assign  Resetn_o        =   ResetnReg;
assign  Sample_o        =   SampleReg;
assign  OscSel_o        =   Counter[31:27];
//assign  OscSel_o        =   Counter[28:24];

endmodule