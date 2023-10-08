module SoCRegion # (parameter NumSoC = 1)(
    input   wire                    clk,
    input   wire                    clk_sample,
    input   wire                    rstn,
    input   wire    [31:0]          wlord,
    //input   wire    [31:0]          wlord0,
    //input   wire    [31:0]          wlord1,
    //input   wire    [31:0]          wlord2,
    //input   wire    [31:0]          wlord3,
    //input   wire    [31:0]          wlord4,

    input   wire    [4:0]           Addr_i,
    output  wire    [23:0]          Data_o
);

wire        OscCount;
wire        OscSample;
wire        OscResetn;
wire        OscResetnsp_i;
wire        OscResetnsp_o;
wire [4:0]  MemAddr;
wire [23:0] MemData;
wire        MemWrite;


CounterControl #(
    .NumOsc             (NumSoC)
)   InstSmpCtrl (
    .clk                (clk_sample),
    .rstn               (rstn),
    .OscSel_o           (MemAddr),
    .Sample_o           (MemWrite),
    .Resetn_o           (OscResetn)
);

reg OscResetnReg0 = 1'b1;
reg OscResetnReg1;
reg OscResetnReg0_d;
reg OscResetnReg1_d;

assign OscResetnsp_i = OscResetn & rstn;

always @(posedge clk_sample or negedge rstn)begin
    if (~rstn) OscResetnReg0 <= 1'b0;
    else if (~OscResetnsp_i) OscResetnReg0 <= 1'b1;
    else if (~OscResetnsp_o) OscResetnReg0 <= 1'b0;
end

always @(posedge clk)begin
    OscResetnReg1 <= OscResetnReg0;
    OscResetnReg0_d <= OscResetnReg1;
    OscResetnReg1_d <= OscResetnReg0_d;
end
assign OscResetnsp_o = ~(~OscResetnReg1_d & OscResetnReg0_d);



spcounter #(
    .N         (32),
    .width     (19)
) u_spcounter_soc (
    .clk       (clk),
    .rst_n     (OscResetnsp_o),
    .wlord     (wlord),
    .sp_out    (MemData)
); 
reg [23:0] Memdatareg0;
reg [23:0] Memdatareg1;

always @ (clk_sample)begin
    Memdatareg0 <= MemData;
    Memdatareg1 <= Memdatareg0;
end


// 5 soc sp 


//spcounter #(
//    .N         (32),
//    .width     (19)
//) u_spcounter_soc0 (
//    .clk       (clk),
//    .rst_n     (OscResetnsp_o),
//    .wlord     (wlord0),
//    .sp_out    (MemData0)
//); 
//reg [23:0] Memdatareg0_soc0;
//reg [23:0] Memdatareg1_soc0;
//
//always @ (clk_sample)begin
//    Memdatareg0_soc0 <= MemData0;
//    Memdatareg1_soc0 <= Memdatareg0_soc0;
//end
//
//
//spcounter #(
//    .N         (32),
//    .width     (19)
//) u_spcounter_soc1 (
//    .clk       (clk),
//    .rst_n     (OscResetnsp_o),
//    .wlord     (wlord1),
//    .sp_out    (MemData1)
//); 
//reg [23:0] Memdatareg0_soc1;
//reg [23:0] Memdatareg1_soc1;
//
//always @ (clk_sample)begin
//    Memdatareg0_soc1 <= MemData1;
//    Memdatareg1_soc1 <= Memdatareg0_soc1;
//end
//
//spcounter #(
//    .N         (32),
//    .width     (19)
//) u_spcounter_soc2 (
//    .clk       (clk),
//    .rst_n     (OscResetnsp_o),
//    .wlord     (wlord2),
//    .sp_out    (MemData2)
//); 
//reg [23:0] Memdatareg0_soc2;
//reg [23:0] Memdatareg1_soc2;
//
//always @ (clk_sample)begin
//    Memdatareg0_soc2 <= MemData0;
//    Memdatareg1_soc2 <= Memdatareg0_soc2;
//end
//
//spcounter #(
//    .N         (32),
//    .width     (19)
//) u_spcounter_soc3 (
//    .clk       (clk),
//    .rst_n     (OscResetnsp_o),
//    .wlord     (wlord3),
//    .sp_out    (MemData3)
//); 
//reg [23:0] Memdatareg0_soc3;
//reg [23:0] Memdatareg1_soc3;
//
//always @ (clk_sample)begin
//    Memdatareg0_soc3 <= MemData3;
//    Memdatareg1_soc3 <= Memdatareg0_soc3;
//end
//
//spcounter #(
//    .N         (32),
//    .width     (19)
//) u_spcounter_soc4 (
//    .clk       (clk),
//    .rst_n     (OscResetnsp_o),
//    .wlord     (wlord4),
//    .sp_out    (MemData4)
//); 
//reg [23:0] Memdatareg0_soc4;
//reg [23:0] Memdatareg1_soc4;
//
//always @ (clk_sample)begin
//    Memdatareg0_soc4 <= MemData4;
//    Memdatareg1_soc4 <= Memdatareg0_soc4;
//end
//
//
//reg [23:0] MemdataMux;
//always @ (MemAddr) begin
//    case (MemAddr)
//    5'b00000: MemdataMux = Memdatareg1_soc0;
//    5'b00001: MemdataMux = Memdatareg1_soc1;
//    5'b00010: MemdataMux = Memdatareg1_soc2;
//    5'b00011: MemdataMux = Memdatareg1_soc3;
//    5'b00100: MemdataMux = Memdatareg1_soc4;
//    default: MemdataMux = 1'b0;
//    endcase
//end
//
//SRAM #(
//    .AddrWidth          (5),
//    .DataWidth          (24)
//)   InstMem (
//    .clk                (clk_sample),
//    .rstn               (rstn),
//    .AddrA_i            (MemAddr),
//    .DinA_i             (Memdatareg1),
//    .WriteA_i           (MemWrite),
//    .AddrB_i            (Addr_i),
//    .DoutB_o            (Data_o)
//);
DW_ram_r_w_s_dff_inst InstRAM(
	.inst_clk       (clk_sample), 
	.inst_rst_n     (rstn), 
	.inst_cs_n      (1'b0),  
	.inst_wr_n      (MemWrite),
	.inst_rd_addr   (Addr_i), 
	.inst_wr_addr   (MemAddr), 
	.inst_data_in   (Memdatareg1),
	.data_out_inst  (Data_o)
);
endmodule