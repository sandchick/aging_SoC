module  RingOscillator #(
    parameter                   Depth = 80-1
)   (
    input   wire                clk_RO,
    input   wire                Stress_i,
    input   wire                TestEnable_i,
    output  reg                 Osc_o
);

wire    [Depth-1 : 0]   BufferIn;
wire                    Osc;
//  First LUT -- NOT & MUX

//(* dont_touch="true" *) LUT3 #(
//    .INIT(8'h4e)
//)	OscHeader (
//    .O(BufferIn[0]),	
//    .I0(TestEnable_i),
//    .I1(Stress_i),
//    .I2(Osc)
//);
//
//      Buffer
//assign BufferIn[0] = TestEnable_i ? ~Osc : Stress_i;
reg [7:0] count = 1'b0;
reg Osc_reg = 1'b0;
always @(posedge clk_RO) begin
   count <= count +1'b1; 
end

always @ (posedge clk_RO) begin
    if (&count) Osc_reg = ~Osc_reg;
end
assign Osc = Osc_reg;
//genvar i;
//
//generate
//    for(i = 0;i < Depth;i = i + 1) begin : Buffer
//        if(i == Depth - 1) begin
//
//           // (* dont_touch="true" *) LUT1 #(
//             LUT1 #(
//                .INIT(2'b10)
//            )	BufferLast (
//                .clk (clk_RO),
//                .O(Osc),
//                .I0(BufferIn[Depth-1])
//            );
//        
//        end else begin
//
//            //(* dont_touch="true" *) LUT1 #(
//             LUT1 #(
//                .INIT(2'b10)
//            )	BufferMain (
//                .clk (clk_RO),
//                .O(BufferIn[i+1]),
//                .I0(BufferIn[i])
//            );
//
//        end
//    end
//endgenerate

always@(posedge Osc or negedge TestEnable_i) begin
    if(~TestEnable_i) begin
        Osc_o   <=  1'b0;
    end else begin
        Osc_o   <=  ~Osc_o;
    end
end


endmodule