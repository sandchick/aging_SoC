module  AutoBoot (
    input   wire                clk,
    input   wire                rstn,

    input   wire    [16:0]      TokenReady_i,
    output  wire    [16:0]      TokenValid_o


);
localparam  IDLE = 2'b00;
localparam  LOGI = 2'b10;

reg [1:0]   StateCr = IDLE;
reg [1:0]   StateNxt;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        StateCr <=  IDLE;
    else
        StateCr <=  StateNxt; 
end

reg [32:0]  Slack   =   33'b0;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        Slack   <=  33'b0;
    else if(StateCr ==  IDLE)
        Slack   <=  Slack + 33'b1;
    else
        Slack   <=  33'b0;
end

wire    SlackDone;

assign  SlackDone   =   Slack   ==  33'd60_000_000_000;//正常为33'd60_000_000_000
wire            ReadySel;
reg     [4:0]   LogicSel    =   5'h0;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        LogicSel    <=  5'h0;
    else if((StateCr ==  LOGI) & ReadySel & (LogicSel == 5'h10))
        LogicSel    <=  5'h0;
    else if((StateCr ==  LOGI) & ReadySel)
        LogicSel    <=  LogicSel + 5'h1; 
end

assign  ReadySel    =   TokenReady_i[LogicSel];

always@(*) begin
    case(StateCr)
        IDLE : 
            if(SlackDone)
                StateNxt    =   LOGI;
            else
                StateNxt    =   StateCr;
        LOGI : 
            if(ReadySel)
                StateNxt    =   IDLE;
            else
                StateNxt    =   StateCr;
        default : 
            StateNxt        =   IDLE;
    endcase
end

genvar i;
generate
    for(i = 0;i < 17;i = i + 1) begin : TokenDec
        assign  TokenValid_o[i] =   (StateCr == LOGI) & (LogicSel == i);
    end
endgenerate
//
//assign  TokenXValid_o   =   (StateCr == IDLE) & SlackDone;

endmodule