module  DaughterBoard #(
    parameter                       SimPresent = 1'b0,
    parameter                       ROFlag =1'b1
)   (
    input   wire                    clk,
    input   wire                    clk_SoC,
   // input   wire [31:0]             wlord0,
   // input   wire [31:0]             wlord1,
   // input   wire [31:0]             wlord2,
   // input   wire [31:0]             wlord3,
   // input   wire [31:0]             wlord4,
    input   wire [31:0]             wlord,

    output  wire                    TXD,
    output  wire                    LED,
    output  wire                    TXDL,
    output  wire                    scl,
    output  wire                    sda,
    input                           RXD
);

assign  LED = ~TXD;
assign  TXDL = TXD;

wire    [4:0]   Addr0;
wire    [4:0]   Addr1;
wire    [4:0]   Addr2;
wire    [4:0]   Addr3;
wire    [4:0]   Addr4;
wire    [4:0]   Addr5;
wire    [4:0]   Addr6;
wire    [4:0]   Addr7;
wire    [4:0]   Addr8;
wire    [4:0]   Addr9;
wire    [4:0]   AddrA;
wire    [4:0]   AddrB;
wire    [4:0]   AddrC;
wire    [4:0]   AddrD;
wire    [4:0]   AddrE;
wire    [4:0]   AddrF;
wire    [4:0]   AddrALU;
wire    [23:0]  Data0;
wire    [23:0]  Data1;
wire    [23:0]  Data2;
wire    [23:0]  Data3;
wire    [23:0]  Data4;
wire    [23:0]  Data5;
wire    [23:0]  Data6;
wire    [23:0]  Data7;
wire    [23:0]  Data8;
wire    [23:0]  Data9;
wire    [23:0]  DataA;
wire    [23:0]  DataB;
wire    [23:0]  DataC;
wire    [23:0]  DataD;
wire    [23:0]  DataE;
wire    [23:0]  DataF;
wire    [23:0]  DataALU;

reg   clk_50M = 0;

always@(posedge clk)begin
    clk_50M <= ~clk_50M;
end


LogicMap #(
    .SimPresent     (SimPresent),
    .ROFlag           (ROFlag)
)   InstLM(
    .clk            (clk_50M),
    .clk_SoC        (clk_SoC),
    .rstn           (1'b1),
    .R01Addr_i      (Addr0),
    .R01Data_o      (Data0),
    .R03Addr_i      (Addr1),
    .R03Data_o      (Data1),
    .R05Addr_i      (Addr2),
    .R05Data_o      (Data2),
    .R07Addr_i      (Addr3),
    .R07Data_o      (Data3),
    .R11Addr_i      (Addr4),
    .R11Data_o      (Data4),
    .R13Addr_i      (Addr5),
    .R13Data_o      (Data5),
    .R15Addr_i      (Addr6),
    .R15Data_o      (Data6),
    .R17Addr_i      (Addr7),
    .R17Data_o      (Data7), 
    .R21Addr_i      (Addr8),
    .R21Data_o      (Data8),
    .R23Addr_i      (Addr9),
    .R23Data_o      (Data9),
    .R25Addr_i      (AddrA),
    .R25Data_o      (DataA),
    .R27Addr_i      (AddrB),
    .R27Data_o      (DataB),   
    .R31Addr_i      (AddrC),
    .R31Data_o      (DataC),
    .R33Addr_i      (AddrD),
    .R33Data_o      (DataD),
    .R35Addr_i      (AddrE),
    .R35Data_o      (DataE),
    .R37Addr_i      (AddrF),
    .R37Data_o      (DataF),
    //.wlord0          (wlord0),
    //.wlord1          (wlord1),
    //.wlord2          (wlord2),
    //.wlord3          (wlord3),
    //.wlord4          (wlord4),
    .wlord          (wlord),
    .ALUAddr_i      (AddrALU),
    .ALUData_o      (DataALU)
);


wire    [7:0]   UartData;
wire            UartTrans;
wire            UartBusy;
wire            UartEmpty;

MNoC #(
    .SimPresent         (SimPresent)
)   InstMNOC (
    .clk                (clk_50M),
    .rstn               (1'b1),

    .UartData_o         (UartData),
    .UartTrans_o        (UartTrans),
    .UartBusy_i         (UartBusy),
    .UartEmpty_i        (UartEmpty),

    .Addr0_o            (Addr0),
    .Data0_i            (Data0),
    .Mem0Flag_i         (1'b0),
    .Mem0Data_i         (24'b0),
    .Mem0SendEn_o       (),
    
    .Addr1_o            (Addr1),
    .Data1_i            (Data1),
    .Mem1Flag_i         (1'b0),
    .Mem1Data_i         (24'b0),
    .Mem1SendEn_o       (),

    .Addr2_o            (Addr2),
    .Data2_i            (Data2),
    .Mem2Flag_i         (1'b0),
    .Mem2Data_i         (24'b0),
    .Mem2SendEn_o       (),

    .Addr3_o            (Addr3),
    .Data3_i            (Data3),
    .Mem3Flag_i         (1'b0),
    .Mem3Data_i         (24'b0),
    .Mem3SendEn_o       (),

    .Addr4_o            (Addr4),
    .Data4_i            (Data4),
    .Mem4Flag_i         (1'b0),
    .Mem4Data_i         (24'b0),
    .Mem4SendEn_o       (),

    .Addr5_o            (Addr5),
    .Data5_i            (Data5),
    .Mem5Flag_i         (1'b0),
    .Mem5Data_i         (24'b0),
    .Mem5SendEn_o       (),

    .Addr6_o            (Addr6),
    .Data6_i            (Data6),
    .Mem6Flag_i         (1'b0),
    .Mem6Data_i         (24'b0),
    .Mem6SendEn_o       (),

    .Addr7_o            (Addr7),
    .Data7_i            (Data7),
    .Mem7Flag_i         (1'b0),
    .Mem7Data_i         (24'b0),
    .Mem7SendEn_o       (),

    .Addr8_o            (Addr8),
    .Data8_i            (Data8),
    .Mem8Flag_i         (1'b0),
    .Mem8Data_i         (24'b0),
    .Mem8SendEn_o       (),
    
    .Addr9_o            (Addr9),
    .Data9_i            (Data9),
    .Mem9Flag_i         (1'b0),
    .Mem9Data_i         (24'b0),
    .Mem9SendEn_o       (),

    .AddrA_o            (AddrA),
    .DataA_i            (DataA),
    .MemAFlag_i         (1'b0),
    .MemAData_i         (24'b0),
    .MemASendEn_o       (),

    .AddrB_o            (AddrB),
    .DataB_i            (DataB),
    .MemBFlag_i         (1'b0),
    .MemBData_i         (24'b0),
    .MemBSendEn_o       (),

    .AddrC_o            (AddrC),
    .DataC_i            (DataC),
    .MemCFlag_i         (1'b0),
    .MemCData_i         (24'b0),
    .MemCSendEn_o       (),

    .AddrD_o            (AddrD),
    .DataD_i            (DataD),
    .MemDFlag_i         (1'b0),
    .MemDData_i         (24'b0),
    .MemDSendEn_o       (),

    .AddrE_o            (AddrE),
    .DataE_i            (DataE),
    .MemEFlag_i         (1'b0),
    .MemEData_i         (24'b0),
    .MemESendEn_o       (),

    .AddrF_o            (AddrF),
    .DataF_i            (DataF),
    .MemFFlag_i         (1'b0),
    .MemFData_i         (24'b0),
    .MemFSendEn_o       (),

    .AddrALU_o          (AddrALU),
    .DataALU_i          (DataALU)

);

wire            clk_uart;
wire            bps_en0, bps_en1;

generate
    if(SimPresent) begin : sim_upwm

        UartClk #(
            .BPS_PARA           (100)
        )   InstUCK(
            .bps_en_i           (bps_en0 | bps_en1),
            .clk                (clk_50M),
            .clk_uart           (clk_uart),
            .rstn               (1'b1)
        );
    
    end else begin : syn_upwm

        UartClk #(
            .BPS_PARA           (434) //868
        )   InstUCK(
            .bps_en_i           (bps_en0 | bps_en1),
            .clk                (clk_50M),
            .clk_uart           (clk_uart),
            .rstn               (1'b1)
        );

    end
endgenerate

UartTx #(
    .SimPresent         (SimPresent)
)   InstUTX0(
    .clk                (clk_50M),
    .clk_uart           (clk_uart),
    .rstn               (1'b1),
    .data_i             (UartData),
    .trans_en_i         (UartTrans),
    .busy_o             (UartBusy),
    .empty_o            (UartEmpty),
    .TXD                (TXD),
    .bps_en_o           (bps_en0)
);

VoltageCtrl InstVCtrl(
     .clk_50m           (clk_50M)
    ,.rxd               (RXD)
    ,.scl               (scl)
    ,.sda               (sda)
);

endmodule