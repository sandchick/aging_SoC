module mbit_counter #(parameter time_count = 4) (
    input clk,
    input reset,
    input warning_signal,
    output reg [time_count-1 :0]  counter
    );

    
    always @(posedge clk or posedge reset) begin
        if (reset)begin
            counter <= 1'b0;
        end
        else begin
            if (warning_signal) begin
                counter <= counter + 1;
            end
            else begin
                counter <= counter;
        end 
    end
    end

    
    endmodule