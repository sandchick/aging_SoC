module spcounter #(parameter  width = 12,
parameter N = 32)(
    clk, rst_n, wlord, sp_out
);
   input clk;
   input rst_n;
   input [N-1:0] wlord ;
   output[width+5:0] sp_out;

wire [width-1:0]high_count_out[N-1:0];
//wire [width-1:0]low_count_out[N-1:0];
wire [width-1:0]sp_out_single[N-1:0];
//reg [width-1:0]sp_out_low;
reg [width+5:0]sp_out_high;

generate 
    genvar i;
    for(i = 0;i < N; i = i + 1)begin:high_level_counter 
    level_counter  #(
        .width (width)
    )high_level_counter(
        .rst_n (rst_n)
        ,.clk  (clk)
        ,.en  (wlord[i])
        ,.sign (high_count_out[i])
    );end
endgenerate

integer l;
always @* begin
    sp_out_high = 1'b0;
    //sp_out_low = 1'b0;
    for(l=0;l<width;l=l+1)begin
        sp_out_high = sp_out_high + high_count_out[l];
        //sp_out_low = sp_out_low + low_count_out[l];
    end
end
//generate
//    genvar l;
//    for(l = 0; l < N; l = l + 1)begin
//        assign sp_out_high = sp_out_high + high_count_out[l];
//        assign sp_out_low = sp_out_low + low_count_out[l];
//    end
//endgenerate

assign sp_out = sp_out_high;
//assign sp_out = cur_sp ? {1'b1,sp_out_high}:{1'b0,sp_out_low};


endmodule
