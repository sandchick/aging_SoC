module monitor(
    input detec_window,
    input monitor_signal,
    input clk,
    input delay_clk,
    output wire warning_signal
    );
    
    reg Q1;
    reg Q2;

    wire reset;
    //assign reset = clk & (~delay_clk);// for sy
    assign reset = (~clk) & (~delay_clk);// for sim

    always @(posedge monitor_signal or posedge reset) begin
        if (reset) begin
            Q1 <= 1'b0;
        end
        else begin
            Q1 <= detec_window;
        end
    end

always @(posedge ~monitor_signal or posedge reset) begin
        if (reset) begin
            Q2 <= 1'b0;
        end
        else begin
            Q2 <= detec_window;
        end
    end


    assign warning_signal = Q1 | Q2;

endmodule