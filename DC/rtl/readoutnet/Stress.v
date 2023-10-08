module  Stress #(
    parameter                   SP = 0,
    parameter                   Toogle = 2
)   (
    input   wire                clk,
    input   wire                rstn,
    output  wire                Stress_o
);

reg     [5:0]   StrCnt = 6'b0;

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        StrCnt  <=  6'b0;
    else
        StrCnt  <=  StrCnt + 1'b1; 
end

/*generate
    if(SP == 0) begin : SP0
        assign  Stress_o    =  1'b0;
    end else if(SP == 1) begin : SP1
        assign  Stress_o    =  StrCnt < 3'h1;
    end else if(SP == 2) begin : SP2
        assign  Stress_o    =  StrCnt < 3'h2;
    end else if(SP == 3) begin : SP3
        assign  Stress_o    =  StrCnt < 3'h3;
    end else if(SP == 4) begin : SP4
        assign  Stress_o    =  StrCnt < 3'h4;
    end else if(SP == 5) begin : SP5
        assign  Stress_o    =  StrCnt < 3'h5;
    end else if(SP == 6) begin : SP6
        assign  Stress_o    =  StrCnt < 3'h6;
    end else if(SP == 7) begin : SP7
        assign  Stress_o    =  StrCnt < 3'h7;
    end
endgenerate*/

generate
    case(SP)
        3'd1: begin : SP1
            case(Toogle)
                2'd0: assign Stress_o = (StrCnt % 32 < 6'd4);                                                            //0.0625
                2'd1: assign Stress_o = (StrCnt % 16 < 6'd2);                                                            //0.125
                2'd2: assign Stress_o = ((StrCnt % 32 < 6'd2) || (StrCnt % 32 == 6'd3) || (StrCnt % 32 == 6'd5));         //0.1875
                2'd3: assign Stress_o = (StrCnt % 8 == 6'd0);                                                            //0.25
            endcase
        end
        3'd3: begin : SP3
            case(Toogle)
                2'd0: assign Stress_o = (StrCnt % 16 < 6'd6);                                                           //0.125
                2'd1: assign Stress_o = (StrCnt % 8 < 6'd3);                                                            //0.25
                2'd2: assign Stress_o = (StrCnt % 5 < 6'd2) && (StrCnt < 6'd60);                                        //0.375
                2'd3: assign Stress_o = ((StrCnt % 8 < 6'd2) || (StrCnt % 8 == 6'd4) );                                 //0.5
            endcase
        end
        3'd5: begin : SP5
            case(Toogle)
                2'd0: assign Stress_o = (StrCnt % 16 < 6'd10);                                                              //0.125
                2'd1: assign Stress_o = ((StrCnt % 8 < 6'd8) && (StrCnt % 8 > 6'd2)) ;         //0.25
                2'd2: assign Stress_o = ((StrCnt % 16 < 6'd4) || ((StrCnt % 16 < 6'd9) && (StrCnt % 16 > 6'd5)) || ((StrCnt % 16 < 6'd13) && (StrCnt % 16 > 6'd9)) );  //0.375
                2'd3: assign Stress_o = (StrCnt % 8 < 6'd4) || (StrCnt % 8 == 6'd6);                                        //0.5
            endcase
        end
        3'd7: begin : SP7
            case(Toogle)
                2'd0: assign Stress_o = (StrCnt % 32 < 6'd28);                                                             //0.0625
                2'd1: assign Stress_o = (StrCnt % 16 < 6'd14);                                                              //0.125
                2'd2: assign Stress_o = ((StrCnt % 32 == 6'd2) || (StrCnt % 32 == 6'd4) || ((StrCnt % 32 < 6'd32) && (StrCnt % 32 > 6'd5)));  //0.1875
                2'd3: assign Stress_o = (StrCnt % 8 < 6'd7);                                                                  //0.25
            endcase
        end
        default: begin : SPDEFAULT
            assign Stress_o = 0;
        end
    endcase
endgenerate

endmodule