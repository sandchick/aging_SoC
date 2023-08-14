module level_counter #(parameter  width= 32)(
    rst_n,en,clk,sign
);
input rst_n;
input clk;
input en;
output reg [width-1 :0]sign = 1'b0;

reg [5:0] count = 1'd0;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)begin
        count <= 1'd0;
    end
    else begin 
        if (en) count <= count + 1'b1;
    end
end

//assign sign = ~rst_n?1'b0:((count == 5'h3f)?sign : (sign+1'b1));
always @ (count or rst_n)begin
    if (!rst_n)begin
        sign = 1'b0;
    end
   else if(count == 5'b11111)begin
    sign = sign + 1;
   end
end
assign over = & sign;
endmodule
