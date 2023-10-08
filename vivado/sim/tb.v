`timescale 1ps/1ps





//clock period
`define CLK_PERIOD          10
`define CLKNET_PERIOD       2
`define clk           tb.clk
`define rst_b         tb.rst_b

`define CPU_TOP        tb.x_soc.u_cpu0_sub_system_ahb.x_e902
`define CPU_CLK        `CPU_TOP.pll_core_cpuclk
`define CPU_RST        `CPU_TOP.pad_cpu_rst_b
`define VIRTUAL_READ   `CPU_TOP.x_cr_tcipif_top.x_cr_tcipif_dbus.dummy_addr_cmplt
`define VIRTUAL_TIME   `CPU_TOP.x_cr_tcipif_top.x_cr_tcipif_dbus.tcipif_rd_data[31:0]

module tb();
reg clk;
reg clk_net;
reg jclk;
reg rst_b;
reg jrst_b;
reg jtap_en;
wire jtg_tms;
wire jtg_tdi;
wire jtg_tdo;

wire uart0_sin;
initial
begin
  clk =0;
  forever begin
    #(`CLK_PERIOD/2) clk = ~clk;
  end
end

initial 
begin 
  clk_net = 0;
  forever begin
    #(`CLKNET_PERIOD/2) clk_net = ~clk_net;
  end
end
reg flash2ram_en;
initial 
begin
  rst_b = 0;
  flash2ram_en = 0;
  # 10 
  rst_b = 1;
  #500000000
  $finish;
end
///////////////////////////////////////
// Memory Initialization  
///////////////////////////////////////
///////////////////////////////////////
// Finish Condition Control 
///////////////////////////////////////

// Reaching the max simulation time.

// No instrunction retired in the last `LAST_CYCLE cycles
//Monitor
//`ifndef NO_MONITOR
//mnt x_mnt();
//`endif
//uart_mnt x_uart_mnt();
assign jtg_tdi = 1'b0;

assign uart0_sin = 1'b1;

//instantiate soc    
aging_SoC_top x_soc(
  .i_pad_clk_net_clk50M        (clk_net),
  .i_pad_uart0_sin      ( uart0_sin            ),
  .o_pad_uart0_sout     ( uart0_sout           ),
  .i_pad_jtg_tclk       ( jclk                 ),
  .i_pad_jtg_trst_b     ( jrst_b               ),
  .i_pad_jtg_nrst_b     ( jrst_b               ),
  .i_pad_flash2ram      ( flash2ram_en),
`ifdef JTAG_5
  .i_pad_jtg_tdi        ( jtg_tdi              ),
  .o_pad_jtg_tdo        ( jtg_tdo              ),
`endif
  .i_pad_jtg_tms        ( jtg_tms              ),
`ifdef RST_ACTIVE_HIGH
  .i_pad_rst            ( !rst_b               )
`else     
  .i_pad_rst_b          ( rst_b                )
`endif     
);




endmodule