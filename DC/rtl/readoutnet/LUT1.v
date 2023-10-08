module LUT1 #(parameter INIT = 2'b10)
(
    input I0,
    input clk,
    output wire O  
);
reg O_reg;
always @(posedge clk ) begin
   O_reg <= I0; 
end
assign O = O_reg;
endmodule