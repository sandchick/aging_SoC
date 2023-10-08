//module for clear counter every 16 clk 

module timer #(parameter time_count = 4)(
    input clk,
    input rst_n,
    output wire counter_rst,
    output reg uart_start
    );

    reg [time_count-1 :0] counter=1'b0;

   always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
       counter <= 1'b0; 
    end
    else begin
        counter <= counter + 1'b1;
    end
   end

    assign counter_rst = & counter;

    reg [8:0] uart_counter = 1'b0;

   always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
       uart_counter <= 1'b0; 
    end
    else begin
        uart_counter <= uart_counter + 1'b1;
    end
   end

    always @ (posedge clk ) begin
        if (&uart_counter) begin
            uart_start <= 1'b1;
        end
        else begin
            uart_start <= 1'b0;
        end
    end



            


endmodule