module  LogicMap #(
    parameter                   SimPresent  =   0
)   (
    input   wire                clk,
    input   wire                clk_SoC,
    input   wire                rstn,
//    input  wire [31:0]          wlord0,
//    input  wire [31:0]          wlord1,
//    input  wire [31:0]          wlord2,
//    input  wire [31:0]          wlord3,
//    input  wire [31:0]          wlord4,
//
    
    input  wire [31:0]          wlord,
    input   wire    [4:0]       R01Addr_i,
    output  wire    [23:0]      R01Data_o,

    input   wire    [4:0]       R03Addr_i,
    output  wire    [23:0]      R03Data_o,

    input   wire    [4:0]       R05Addr_i,
    output  wire    [23:0]      R05Data_o,

    input   wire    [4:0]       R07Addr_i,
    output  wire    [23:0]      R07Data_o,

    input   wire    [4:0]       R11Addr_i,
    output  wire    [23:0]      R11Data_o,

    input   wire    [4:0]       R13Addr_i,
    output  wire    [23:0]      R13Data_o,

    input   wire    [4:0]       R15Addr_i,
    output  wire    [23:0]      R15Data_o,

    input   wire    [4:0]       R17Addr_i,
    output  wire    [23:0]      R17Data_o,

    input   wire    [4:0]       R21Addr_i,
    output  wire    [23:0]      R21Data_o,

    input   wire    [4:0]       R23Addr_i,
    output  wire    [23:0]      R23Data_o,

    input   wire    [4:0]       R25Addr_i,
    output  wire    [23:0]      R25Data_o,

    input   wire    [4:0]       R27Addr_i,
    output  wire    [23:0]      R27Data_o,

    input   wire    [4:0]       R31Addr_i,
    output  wire    [23:0]      R31Data_o,

    input   wire    [4:0]       R33Addr_i,
    output  wire    [23:0]      R33Data_o,

    input   wire    [4:0]       R35Addr_i,
    output  wire    [23:0]      R35Data_o,

    input   wire    [4:0]       R37Addr_i,
    output  wire    [23:0]      R37Data_o,

    input   wire    [4:0]       ALUAddr_i,
    output  wire    [23:0]      ALUData_o


);

wire    StressClock;
wire clk_RO;
assign clk_RO = clk_SoC;

//-------------------------------
//  Reserver for PLL
//-------------------------------

/*clk_wiz_1 MMCM(
    .clk_in1                    (clk),
    .clk_out1                   (StressClock)
);*/

//-------------------------------
//  for Different SW
//-------------------------------

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (1),
    .SimPresent                 (SimPresent),
    .Toogle                     (0)
)   InstLR01 (
    .clk                        (clk),
    .rstn                       (rstn),
    .clk_RO                     (clk_RO),
    //.StressClock                (StressClock),
    .Addr_i                     (R01Addr_i),
    .Data_o                     (R01Data_o)
);

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (3),
    .SimPresent                 (SimPresent),
    .Toogle                     (0)
)   InstLR03 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R03Addr_i),
    .Data_o                     (R03Data_o)
);

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (5),
    .SimPresent                 (SimPresent),
    .Toogle                     (0)
)   InstLR05 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R05Addr_i),
    .Data_o                     (R05Data_o)
);


LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (7),
    .SimPresent                 (SimPresent),
    .Toogle                     (0)
)   InstLR07 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R07Addr_i),
    .Data_o                     (R07Data_o)
);


LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (1),
    .SimPresent                 (SimPresent),
    .Toogle                     (1)
)   InstLR11 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R11Addr_i),
    .Data_o                     (R11Data_o)
);


LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (3),
    .SimPresent                 (SimPresent),
    .Toogle                     (1)
)   InstLR13 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R13Addr_i),
    .Data_o                     (R13Data_o)
);

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (5),
    .SimPresent                 (SimPresent),
    .Toogle                     (1)
)   InstLR15 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R15Addr_i),
    .Data_o                     (R15Data_o)
);


LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (7),
    .SimPresent                 (SimPresent),
    .Toogle                     (1)
)   InstLR17 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R17Addr_i),
    .Data_o                     (R17Data_o)
);


LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (1),
    .SimPresent                 (SimPresent),
    .Toogle                     (2)
)   InstLR21 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R21Addr_i),
    .Data_o                     (R21Data_o)
);

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (3),
    .SimPresent                 (SimPresent),
    .Toogle                     (2)
)   InstLR23 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R23Addr_i),
    .Data_o                     (R23Data_o)
);

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (5),
    .SimPresent                 (SimPresent),
    .Toogle                     (2)
)   InstLR25 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R25Addr_i),
    .Data_o                     (R25Data_o)
);

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (7),
    .SimPresent                 (SimPresent),
    .Toogle                     (2)
)   InstLR27 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R27Addr_i),
    .Data_o                     (R27Data_o)
);

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (1),
    .SimPresent                 (SimPresent),
    .Toogle                     (3)
)   InstLR31 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R31Addr_i),
    .Data_o                     (R31Data_o)
);


LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (3),
    .SimPresent                 (SimPresent),
    .Toogle                     (3)
)   InstLR33 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R33Addr_i),
    .Data_o                     (R33Data_o)
);

LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (5),
    .SimPresent                 (SimPresent),
    .Toogle                     (3)
)   InstLR35 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R35Addr_i),
    .Data_o                     (R35Data_o)
);


LogicRegion #(
    .OscDepth                   (20),
    .NumOsc                     (10),
    .SP                         (7),
    .SimPresent                 (SimPresent),
    .Toogle                     (3)
)   InstLR37 (
    .clk                        (clk),
    .clk_RO                     (clk_RO),
    .rstn                       (rstn),
    //.StressClock                (StressClock),
    .Addr_i                     (R37Addr_i),
    .Data_o                     (R37Data_o)
);

SoCRegion  #(
    .NumSoC               (1)
)   SoCRegion(
    .clk_sample           (clk         ),
    .clk                  (clk_SoC),
    .rstn                 (rstn        ),
    //.wlord0                 (wlord0),
    //.wlord1                 (wlord1),
    //.wlord2                 (wlord2),
    //.wlord3                 (wlord3),
    //.wlord4                 (wlord4),
    .wlord                 (wlord),
    .Addr_i               (ALUAddr_i   ),
    .Data_o               (ALUData_o   ) 
);

endmodule