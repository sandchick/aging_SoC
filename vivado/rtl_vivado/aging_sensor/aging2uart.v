module aging2uart (
    input   wire                    clk,
    input   wire                    rstn,

    input   wire    [19:0]          Data_i_iu,
    input   wire    [19:0]          Data_i_alu,

    output  reg     [7:0]           UartData_o,
    output  reg                     UartTrans_o,
    output  reg                     Ready_o,
    input   wire                    UartBusy_i,
    input   wire                    UartEmpty_i
);

localparam  TA0 =   4'h0;
localparam  TA1 =   4'h1;
localparam  TA2 =   4'h2;
localparam  TA3 =   4'h3;
localparam  TA4 =   4'h4;
localparam  TI0 =   4'h5;
localparam  TI1 =   4'h6;
localparam  TI2 =   4'h7;
localparam  TI3 =   4'h8;
localparam  TI4 =   4'h9;



reg     [3:0]   StateCr = TA0;
reg     [3:0]   StateNxt;

always@(posedge clk or negedge rstn) begin
    if(~rstn) begin
        StateCr <=  TA0;
    end else begin
        StateCr <=  StateNxt;
    end 
end

always@(*) begin
    case(StateCr)
        TA0 : begin
            if(UartEmpty_i) begin
                StateNxt    =   TA1;
            end else begin
                StateNxt    =   StateCr;
            end
        end TA1 : begin
            if(~UartBusy_i) begin
                StateNxt    =   TA2;
            end else begin
                StateNxt    =   StateCr;
            end
        end TA2 : begin
            if(~UartBusy_i) begin
                    StateNxt    =   TA3;
                end else begin
                    StateNxt    =   StateCr;
                end
        end TA3 : begin
            if(~UartBusy_i) begin
                StateNxt    =   TA4;
            end else begin
                StateNxt    =   StateCr;
            end
        end TA4 : begin
            if(~UartBusy_i) begin
                StateNxt    =   TI0;
            end else begin
                StateNxt    =   StateCr;
            end
        end TI0 : begin
            if(~UartBusy_i) begin
                StateNxt    =   TI1;
            end else begin
                StateNxt    =   StateCr;
            end
        end TI1 : begin
            if(~UartBusy_i) begin
                StateNxt    =   TI2;
            end else begin
                StateNxt    =   StateCr;
            end
        end TI2 : begin
            if(~UartBusy_i) begin
                StateNxt    =   TI3;
            end else begin
                StateNxt    =   StateCr;
            end
        end TI3 : begin
            if(~UartBusy_i) begin
                StateNxt    =   TI4;
            end else begin
                StateNxt    =   StateCr;
            end
        end TI4 : begin
            if(~UartBusy_i) begin
                StateNxt    =   TA0;
            end else begin
                StateNxt    =   StateCr;
            end
        end default : begin
            StateNxt    =   TA1;
        end
    endcase
end

always@(*) begin
    case(StateCr) 
        TA0 : begin
            UartData_o  =   {TA0,Data_i_alu[3:0]};
            if(UartEmpty_i) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b0;
        end TA1 : begin
            UartData_o  =   {TA1,Data_i_alu[7:4]};
            if(~UartBusy_i) begin
                UartTrans_o =   1'b1;
                Ready_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
                Ready_o =   1'b0;
            end
        end TA2 : begin
            UartData_o  =   {TA2,Data_i_alu[11:8]}; 
            if(~UartBusy_i ) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b0;
        end TA3 : begin
            UartData_o  =   {TA3,Data_i_alu[15:12]};
            if(~UartBusy_i) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b0;
        end TA4 : begin
            UartData_o  =   {TA4,Data_i_alu[19:16]};
            if(~UartBusy_i) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b0;
        end TI0 : begin
            UartData_o  =   {TI0,Data_i_iu[3:0]};
            if(~UartBusy_i) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b0;
        end TI1 : begin
            UartData_o  =   {TI1,Data_i_iu[7:4]};
            if(~UartBusy_i) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b0;
        end TI2 : begin
            UartData_o  =   {TI2,Data_i_iu[11:8]}; 
            if(~UartBusy_i ) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b0;
        end TI3 : begin
            UartData_o  =   {TI3,Data_i_iu[15:12]};
            if(~UartBusy_i) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b0;
        end TI4 : begin
            UartData_o  =   {TI4,Data_i_iu[19:16]};
            if(~UartBusy_i) begin
                UartTrans_o =   1'b1;
            end else begin
                UartTrans_o =   1'b0;
            end
            Ready_o =   1'b1;
        end default : begin
            UartTrans_o =   1'b0;
            Ready_o =   1'b0;
        end
    endcase
end

endmodule