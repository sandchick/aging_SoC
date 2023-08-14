module  OscSample #(
    parameter                       NumOsc = 10
)   (
    input   wire                    clk,
    input   wire                    rstn,

    input   wire    [NumOsc-1:0]    Osc_i,
    input   wire    [4:0]           OscSel_i,

    input   wire                    Count_i,
    input   wire                    Sample_i,

    output  wire    [4:0]           Addr_o,
    output  wire    [23:0]          Data_o,
    output  wire                    Write_o
);

genvar i;

wire    [NumOsc-1:0]    OscDec;

generate
    for(i = 0;i < NumOsc;i = i + 1) begin : decoder

        assign  OscDec[i]   =   OscSel_i    ==  i;
    
    end
endgenerate

wire                    Osc;

assign  Osc =   |(OscDec & Osc_i);


reg  Count_enReg0, Count_enReg1;

always @(posedge Osc) begin
    Count_enReg0 <= Count_i;
    Count_enReg1 <= Count_enReg0;
end

wire Count_en = Count_enReg1;

reg     [15:0]  Freq = 16'b0;

always@(posedge Osc or negedge rstn) begin
    if(~rstn)
        Freq    <=  16'b0;
    else if(Count_en)
        Freq    <=  Freq + 1'b1;
end

reg     [15:0]  FreqReg0 = 16'b0;
reg     [15:0]  FreqReg1 = 16'b0;

always@(posedge clk) begin
    FreqReg0    <=  Freq;
    FreqReg1    <=  FreqReg0;
end

assign  Addr_o  =   OscSel_i;
assign  Write_o =   Sample_i;
assign  Data_o  =   {     FreqReg1,
                        ~(FreqReg1[15] ^ FreqReg1[11] ^ FreqReg1[7] ^ FreqReg1[3]),
                        ~(FreqReg1[14] ^ FreqReg1[10] ^ FreqReg1[6] ^ FreqReg1[2]),
                        ~(FreqReg1[13] ^ FreqReg1[9]  ^ FreqReg1[5] ^ FreqReg1[1]),
                        ~(FreqReg1[12] ^ FreqReg1[8]  ^ FreqReg1[4] ^ FreqReg1[0]),
                        ~^FreqReg1[15:12],
                        ~^FreqReg1[11:8],
                        ~^FreqReg1[7:4],
                        ~^FreqReg1[3:0]};


endmodule


