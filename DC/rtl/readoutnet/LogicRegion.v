module  LogicRegion #(
    parameter                       OscDepth    = 80-1,
    parameter                       NumOsc      = 10,
    parameter                       SP          = 0,
    parameter                       SimPresent  = 0,
    parameter                       ROFlag      = 1,
    parameter                       Toogle      = 0
)   (
    input   wire                    clk,
    input   wire                    clk_RO,
    input   wire                    rstn,

    //input   wire                    StressClock,

    input   wire    [4:0]           Addr_i,
    output  wire    [23:0]          Data_o
);

genvar i;

wire                    OscStress;

Stress #(
    .SP                 (SP),
    .Toogle             (Toogle)
)   InstOscStress (
    .clk                (clk),
    .rstn               (rstn),
    .Stress_o           (OscStress)
);

wire    [NumOsc-1:0]    Osc;
wire    [NumOsc-1:0]    TestEnable;

generate 
    if(ROFlag) begin : ROSim

        assign  Osc =   {NumOsc{clk}};

    end else begin : ROSyn

        for(i = 0;i < NumOsc;i = i + 1) begin : RingOsc

            RingOscillator #(
                .Depth          (OscDepth)
            )   RingOsc (
                .clk_RO         (clk_RO),
                .Stress_i       (OscStress),
                .TestEnable_i   (TestEnable[i]),
                .Osc_o          (Osc[i])
            );

        end

    end
endgenerate

wire    [4:0]           OscSel;
wire                    OscCount;
wire                    OscSample;
wire                    OscResetn;

SampleControl #(
    .NumOsc             (NumOsc)
)   InstSmpCtrl (
    .clk                (clk),
    .rstn               (rstn),
    .TestEnable_o       (TestEnable),
    .OscSel_o           (OscSel),
    .Count_o            (OscCount),
    .Sample_o           (OscSample),
    .Resetn_o           (OscResetn)
);

wire    [4:0]           MemAddr;
wire    [23:0]          MemData;
wire                    MemWrite;

OscSample #(
    .NumOsc             (NumOsc)
)   InstOscSmp (
    .clk                (clk),
    .rstn               (OscResetn),
    .Osc_i              (Osc),
    .OscSel_i           (OscSel),
    .Count_i            (OscCount),
    .Sample_i           (OscSample),
    .Addr_o             (MemAddr),
    .Data_o             (MemData),
    .Write_o            (MemWrite)
);

//SRAM #(
//    .AddrWidth          (5),
//    .DataWidth          (24)
//)   InstMem (
//    .clk                (clk),
//    .rstn               (rstn),
//    .AddrA_i            (MemAddr),
//    .DinA_i             (MemData),
//    .WriteA_i           (MemWrite),
//    .AddrB_i            (Addr_i),
//    .DoutB_o            (Data_o)
//);

DW_ram_r_w_s_dff_inst InstRAM(
	.inst_clk       (clk), 
	.inst_rst_n     (rstn), 
	.inst_cs_n      (1'b0),  
	.inst_wr_n      (MemWrite),
	.inst_rd_addr   (Addr_i), 
	.inst_wr_addr   (MemAddr), 
	.inst_data_in   (MemData),
	.data_out_inst  (Data_o)
);



endmodule
        