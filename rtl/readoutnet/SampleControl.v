module  SampleControl #(
    parameter                       NumOsc = 10
)   (
    input   wire                    clk,
    input   wire                    rstn,

    output  wire    [NumOsc-1:0]    TestEnable_o,
    // output  wire                    AdjustEn_o,

    output  wire    [4:0]           OscSel_o,
    output  wire                    Count_o,
    output  wire                    Sample_o,
    output  wire                    Resetn_o
);

reg     [31:0]  Counter = 32'b0;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        Counter <=  32'b0;
    else if((Counter[31:24] == NumOsc - 1) && &Counter[23:0])
        Counter <=  32'b0;
    else
        Counter <=  Counter +   1'b1; 
end

reg             CountReg = 1'b0;

// Osc计数使能信号, 计数周期是32767, 当 Counter 从 0x00010000 到 0x00017fff 时, CountReg 输出1, 否则输出0.
always@(posedge clk or negedge rstn) begin
    if(~rstn)
        CountReg    <=  1'b0;
    else 
        CountReg    <=  ~|Counter[23:17] & Counter[16] & ~Counter[15];
end

reg             SampleReg = 1'b0;

// SRAM 写使能信号, 当 Counter == 0x0001ffff 时, SampleReg 输出1, 否则输出0.
always@(posedge clk or negedge rstn) begin
    if(~rstn)
        SampleReg   <=  1'b0;
    else
        SampleReg   <=  ~|Counter[23:17] & &Counter[16:0];
end

wire    [NumOsc-1:0]    Dec;

genvar i;

generate
    for(i = 0;i < NumOsc;i = i + 1) begin
        assign  Dec[i]  =   Counter[28:24] == i;
    end
endgenerate

reg     [NumOsc-1:0]    TestEnableReg = {NumOsc{1'b0}};

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        TestEnableReg   <=  {NumOsc{1'b0}};
    else 
        TestEnableReg   <=  Dec &   {NumOsc{~|Counter[23:17]}};
end

reg                     ResetnReg = 1'b0;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        ResetnReg   <=  1'b0;
    else 
        ResetnReg   <=  ~&Counter[23:0];
end

assign  Resetn_o        =   ResetnReg;
assign  Count_o         =   CountReg;
assign  Sample_o        =   SampleReg;
assign  TestEnable_o    =   TestEnableReg;
assign  OscSel_o        =   Counter[28:24];

endmodule