module aging_SoC_top(
  b_pad_gpio_porta,
  i_pad_clk,
  i_pad_jtg_nrst_b,
  i_pad_jtg_tclk,
  i_pad_jtg_tms,
  i_pad_jtg_trst_b,
  i_pad_rst_b,
  i_pad_uart0_sin,
  o_pad_uart0_sout,
  i_pad_clk_net,
  o_pad_txd,
  o_pad_txdl,
  o_pad_scl,
  o_pad_led,
  o_pad_sda,
  i_pad_RXD
);

// &Ports("compare", "../src_rtl/soc_top_golden_port.v"); @25
input           i_pad_clk;             
input           i_pad_jtg_nrst_b;      
input           i_pad_jtg_tclk;        
input           i_pad_jtg_trst_b;      
input           i_pad_rst_b;           
input           i_pad_uart0_sin;       
output          o_pad_uart0_sout;      
inout   [7 :0]  b_pad_gpio_porta;      
inout           i_pad_jtg_tms;         
input wire i_pad_clk_net;
output wire  o_pad_txd;
output wire o_pad_txdl;
output wire  o_pad_led;
output wire o_pad_scl;
output wire o_pad_sda;
input wire i_pad_RXD;

// &Regs; @26

// &Wires; @27
wire    [7 :0]  b_pad_gpio_porta;      
wire    [31:0]  biu_pad_haddr;         
wire    [2 :0]  biu_pad_hburst;        
wire    [3 :0]  biu_pad_hprot;         
wire    [2 :0]  biu_pad_hsize;         
wire    [1 :0]  biu_pad_htrans;        
wire    [31:0]  biu_pad_hwdata;        
wire            biu_pad_hwrite;        
wire    [1 :0]  biu_pad_lpmd_b;        
wire            clk_en;                
wire            corec_pmu_sleep_out;   
wire            cpu_clk;               
wire            i_pad_cpu_jtg_rst_b;   
wire            i_pad_jtg_nrst_b;      
wire            i_pad_jtg_tclk;        
wire            i_pad_jtg_tms;         
wire            i_pad_jtg_trst_b;      
wire            i_pad_rst_b;           
wire            i_pad_uart0_sin;       
wire            nmi_req;               
wire            o_pad_uart0_sout;      
wire    [31:0]  pad_biu_hrdata;        
wire            pad_biu_hready;        
wire    [1 :0]  pad_biu_hresp;         
wire            pad_cpu_rst_b;         
wire            pad_had_jtg_tclk;      
wire            pad_had_jtg_tms_i;     
wire            pad_had_jtg_trst_b;    
wire            pad_had_jtg_trst_b_pre; 
wire    [31:0]  pad_vic_int_vld;       
wire            per_clk;               
wire            pg_reset_b;            
wire            pmu_corec_isolation;   
wire            pmu_corec_sleep_in;    
wire            smpu_deny;             
wire            sys_rst;               
wire            wakeup_req;            
wire  [31:0] core_sp1;
wire  [31:0] core_sp2;
wire  [31:0] core_sp3;
wire  [31:0] core_sp4;
wire  [31:0] core_sp0;
wire  [4:0] alu_monitor;
wire  [4:0] iu_monitor;

aging_sensor_top u_aging_sensor_top (
    .clk            (cpu_clk),
    .rst_n          (pad_cpu_rst_b),
    .alu_monitor    (alu_monitor),
    .iu_monitor     (iu_monitor),
    .txd            (o_pad_txdl)
);


DaughterBoard #(
    .SimPresent    (1'b0)
) u_DaughterBoard (
    .clk           (i_pad_clk_net),
    .clk_SoC       (i_pad_clk),
    //.wlord0         (core_sp0),
    //.wlord1         (core_sp1),
    //.wlord2         (core_sp2),
    //.wlord3         (core_sp3),
    //.wlord4         (core_sp4),
    .wlord          (core_sp0),
    .TXD           (o_pad_txd),
    .LED           (o_pad_led),
    .scl           (o_pad_scl),
    .sda           (o_pad_sda),
    .RXD           (i_pad_RXD)
);
//***********************Instance cpu_sub_system_ahb****************************
// &Instance("cpu_sub_system_ahb", "x_cpu_sub_system_ahb"); @31
// &Connect( @32
//          .clk_en                 (clk_en              )    @33
//          ); @34
// Support AHB_LITE
// &Instance("cpu_sub_system_ahb", "x_cpu_sub_system_ahb"); @38

pmu u_pmu (
    .apb_pmu_paddr             (apb_pmu_paddr),
    .apb_pmu_penable           (apb_pmu_penable),
    .apb_pmu_psel              (apb_pmu_psel),
    .apb_pmu_pwdata            (apb_pmu_pwdata),
    .apb_pmu_pwrite            (apb_pmu_pwrite),
    .biu_pad_lpmd_b            (biu_pad_lpmd_b),
    .corec_pmu_sleep_out       (corec_pmu_sleep_out),
    .cpu_clk                   (cpu_clk),
    .gate_en0                  (gate_en0),
    .gate_en1                  (gate_en1),
    .had_pad_wakeup_req_b      (had_pad_wakeup_req_b),
    .i_pad_cpu_jtg_rst_b       (i_pad_cpu_jtg_rst_b),
    .i_pad_jtg_tclk            (i_pad_jtg_tclk),
    .intraw_vld                (intraw_vld),
    .pad_cpu_rst_b             (pad_cpu_rst_b),
    .pad_had_jtg_tap_en        (pad_had_jtg_tap_en),
    .pad_had_jtg_tms_i         (pad_had_jtg_tms_i),
    .pad_had_jtg_trst_b        (pad_had_jtg_trst_b),
    .pad_had_jtg_trst_b_pre    (pad_had_jtg_trst_b_pre),
    .pg_reset_b                (pg_reset_b),
    .pmu_apb_prdata            (pmu_apb_prdata),
    .pmu_clk                   (pmu_clk),
    .pmu_corec_isolation       (pmu_corec_isolation),
    .pmu_corec_sleep_in        (pmu_corec_sleep_in),
    .sys_rst                   (sys_rst)
);

clk_divider u_clk_divider (
    .clk_div_1        (clk_div_1),
    .clk_div_2        (clk_div_2),
    .clk_div_3        (clk_div_3),
    .clk_div_4        (clk_div_4),
    .clk_div_5        (clk_div_5),
    .clk_div_6        (clk_div_6),
    .clk_div_7        (clk_div_7),
    .clk_div_8        (clk_div_8),
    .clk_en_1         (clk_en_1),
    .clk_en_2         (clk_en_2),
    .clk_en_3         (clk_en_3),
    .clk_en_4         (clk_en_4),
    .clk_en_5         (clk_en_5),
    .clk_en_6         (clk_en_6),
    .clk_en_7         (clk_en_7),
    .clk_en_8         (clk_en_8),
    .osc_clk          (i_pad_clk),
    .pad_cpu_rst_b    (pad_cpu_rst_b)
);

clk_aligner u_clk_aligner (
    .clk_div_1         (clk_div_1),
    .clk_div_2         (clk_div_2),
    .clk_div_3         (clk_div_3),
    .clk_div_4         (clk_div_4),
    .clk_div_5         (clk_div_5),
    .clk_div_6         (clk_div_6),
    .clk_div_7         (clk_div_7),
    .clk_div_8         (clk_div_8),
    .clk_en            (clk_en),
    .clk_en_1          (clk_en_1),
    .clk_en_2          (clk_en_2),
    .clk_en_3          (clk_en_3),
    .clk_en_4          (clk_en_4),
    .clk_en_5          (clk_en_5),
    .clk_en_6          (clk_en_6),
    .clk_en_7          (clk_en_7),
    .clk_en_8          (clk_en_8),
    .clkrst_b          (clkrst_b),
    .cpu_clk           (cpu_clk),
    .forever_cpuclk    (i_pad_clk),
    .gate_en0          (gate_en0),
    .gate_en1          (gate_en1),
    .paddr             (paddr),
    .penable           (penable),
    .per_clk           (per_clk),
    .pmu_clk           (pmu_clk),
    .prdata            (prdata),
    .psel              (psel),
    .pwdata            (pwdata),
    .pwrite            (pwrite),
    .wic_clk           (wic_clk)
);

    // Input Port SI0
    wire  [31:0] HADDRS0;         // Address bus
    wire   [1:0] HTRANSS0;        // Transfer type
    wire         HWRITES0;        // Transfer direction
    wire   [2:0] HSIZES0;         // Transfer size
    wire   [2:0] HBURSTS0;        // Burst type
    wire   [3:0] HPROTS0;         // Protection control
    wire  [31:0] HWDATAS0;        // Write data
    wire         HMASTLOCKS0;     // Locked Sequence

    wire  [31:0] HRDATAS0;        // Read data bus
    wire         HREADYS0;     // HREADY feedback
    wire         HRESPS0;         // Transfer response
    wire  [31:0] HAUSERS0;        // Address USER signals
    wire  [31:0] HWUSERS0;        // Write-data USER signals
    wire  [31:0] HRUSERS0;        // Read-data USER signals

    // Input Port SI1
    wire  [31:0] HADDRS1;         // Address bus
    wire   [1:0] HTRANSS1;        // Transfer type
    wire         HWRITES1;        // Transfer direction
    wire   [2:0] HSIZES1;         // Transfer size
    wire   [2:0] HBURSTS1;        // Burst type
    wire   [3:0] HPROTS1;         // Protection control
    wire  [31:0] HWDATAS1;        // Write data
    wire         HMASTLOCKS1;     // Locked Sequence

    wire  [31:0] HRDATAS1;        // Read data bus
    wire         HREADYS1;     // HREADY feedback
    wire         HRESPS1;         // Transfer response
    wire  [31:0] HAUSERS1;        // Address USER signals
    wire  [31:0] HWUSERS1;        // Write-data USER signals
    wire  [31:0] HRUSERS1;        // Read-data USER signals

    // Input Port SI2
    wire  [31:0] HADDRS2;         // Address bus
    wire   [1:0] HTRANSS2;        // Transfer type
    wire         HWRITES2;        // Transfer direction
    wire   [2:0] HSIZES2;         // Transfer size
    wire   [2:0] HBURSTS2;        // Burst type
    wire   [3:0] HPROTS2;         // Protection control
    wire  [31:0] HWDATAS2;        // Write data
    wire         HMASTLOCKS2;     // Locked Sequence

    wire  [31:0] HRDATAS2;        // Read data bus
    wire         HREADYS2;     // HREADY feedback
    wire         HRESPS2;         // Transfer response
    wire  [31:0] HAUSERS2;        // Address USER signals
    wire  [31:0] HWUSERS2;        // Write-data USER signals
    wire  [31:0] HRUSERS2;        // Read-data USER signals

    // Input Port SI3
    wire  [31:0] HADDRS3;         // Address bus
    wire   [1:0] HTRANSS3;        // Transfer type
    wire         HWRITES3;        // Transfer direction
    wire   [2:0] HSIZES3;         // Transfer size
    wire   [2:0] HBURSTS3;        // Burst type
    wire   [3:0] HPROTS3;         // Protection control
    wire  [31:0] HWDATAS3;        // Write data
    wire         HMASTLOCKS3;     // Locked Sequence

    wire  [31:0] HRDATAS3;        // Read data bus
    wire         HREADYS3;     // HREADY feedback
    wire         HRESPS3;         // Transfer response
    wire  [31:0] HAUSERS3;        // Address USER signals
    wire  [31:0] HWUSERS3;        // Write-data USER signals
    wire  [31:0] HRUSERS3;        // Read-data USER signals

    // Input Port SI4
    wire  [31:0] HADDRS4;         // Address bus
    wire   [1:0] HTRANSS4;        // Transfer type
    wire         HWRITES4;        // Transfer direction
    wire   [2:0] HSIZES4;         // Transfer size
    wire   [2:0] HBURSTS4;        // Burst type
    wire   [3:0] HPROTS4;         // Protection control
    wire  [31:0] HWDATAS4;        // Write data
    wire         HMASTLOCKS4;     // Locked Sequence

    wire  [31:0] HRDATAS4;        // Read data bus
    wire         HREADYS4;     // HREADY feedback
    wire         HRESPS4;         // Transfer response
    wire  [31:0] HAUSERS4;        // Address USER signals
    wire  [31:0] HWUSERS4;        // Write-data USER signals
    wire  [31:0] HRUSERS4;        // Read-data USER signals
 // Common AHB signals
    wire         HCLK;            // AHB System Clock
    assign HCLK = per_clk;
    wire         HRESETn;         // AHB System Reset
    assign HRESETn = pad_cpu_rst_b;
    // System Address Remap control
    wire   [3:0] REMAP;           // System REMAP signal
    assign REMAP = 1'b0;
    // Input Port SI0
    wire  [31:0] HADDRS5;         // Address bus
    wire   [1:0] HTRANSS5;        // Transfer type
    wire         HWRITES5;        // Transfer direction
    wire   [2:0] HSIZES5;         // Transfer size
    wire   [2:0] HBURSTS5;        // Burst type
    wire   [3:0] HPROTS5;         // Protection control
    wire  [31:0] HWDATAS5;        // Write data
    wire         HMASTLOCKS5;     // Locked Sequence

    wire  [31:0] HRDATAS5;        // Read data bus
    wire         HREADYS5;     // HREADY feedback
    wire         HRESPS5;         // Transfer response
    wire  [31:0] HAUSERS5;        // Address USER signals
    wire  [31:0] HWUSERS5;        // Write-data USER signals
    wire  [31:0] HRUSERS5;        // Read-data USER signals

    // Input Port SI1
    wire  [31:0] HADDRS6;         // Address bus
    wire   [1:0] HTRANSS6;        // Transfer type
    wire         HWRITES6;        // Transfer direction
    wire   [2:0] HSIZES6;         // Transfer size
    wire   [2:0] HBURSTS6;        // Burst type
    wire   [3:0] HPROTS6;         // Protection control
    wire  [31:0] HWDATAS6;        // Write data
    wire         HMASTLOCKS6;     // Locked Sequence

    wire  [31:0] HRDATAS6;        // Read data bus
    wire         HREADYS6;     // HREADY feedback
    wire         HRESPS6;         // Transfer response
    wire  [31:0] HAUSERS6;        // Address USER signals
    wire  [31:0] HWUSERS6;        // Write-data USER signals
    wire  [31:0] HRUSERS6;        // Read-data USER signals

    // Input Port SI2
    wire  [31:0] HADDRS7;         // Address bus
    wire   [1:0] HTRANSS7;        // Transfer type
    wire         HWRITES7;        // Transfer direction
    wire   [2:0] HSIZES7;         // Transfer size
    wire   [2:0] HBURSTS7;        // Burst type
    wire   [3:0] HPROTS7;         // Protection control
    wire  [31:0] HWDATAS7;        // Write data
    wire         HMASTLOCKS7;     // Locked Sequence

    wire  [31:0] HRDATAS7;        // Read data bus
    wire         HREADYS7;     // HREADY feedback
    wire         HRESPS7;         // Transfer response
    wire  [31:0] HAUSERS7;        // Address USER signals
    wire  [31:0] HWUSERS7;        // Write-data USER signals
    wire  [31:0] HRUSERS7;        // Read-data USER signals

    // Input Port SI3
    wire  [31:0] HADDRS8;         // Address bus
    wire   [1:0] HTRANSS8;        // Transfer type
    wire         HWRITES8;        // Transfer direction
    wire   [2:0] HSIZES8;         // Transfer size
    wire   [2:0] HBURSTS8;        // Burst type
    wire   [3:0] HPROTS8;         // Protection control
    wire  [31:0] HWDATAS8;        // Write data
    wire         HMASTLOCKS8;     // Locked Sequence

    wire  [31:0] HRDATAS8;        // Read data bus
    wire         HREADYS8;     // HREADY feedback
    wire         HRESPS8;         // Transfer response
    wire  [31:0] HAUSERS8;        // Address USER signals
    wire  [31:0] HWUSERS8;        // Write-data USER signals
    wire  [31:0] HRUSERS8;        // Read-data USER signals

    // Input Port SI4
    wire  [31:0] HADDRS9;         // Address bus
    wire   [1:0] HTRANSS9;        // Transfer type
    wire         HWRITES9;        // Transfer direction
    wire   [2:0] HSIZES9;         // Transfer size
    wire   [2:0] HBURSTS9;        // Burst type
    wire   [3:0] HPROTS9;         // Protection control
    wire  [31:0] HWDATAS9;        // Write data
    wire         HMASTLOCKS9;     // Locked Sequence

    wire  [31:0] HRDATAS9;        // Read data bus
    wire         HREADYS9;     // HREADY feedback
    wire         HRESPS9;         // Transfer response
    wire  [31:0] HAUSERS9;        // Address USER signals
    wire  [31:0] HWUSERS9;        // Write-data USER signals
    wire  [31:0] HRUSERS9;        // Read-data USER signals

    // Output Port MI0
    wire         HSELM0;          // Slave Select
    wire  [31:0] HADDRM0;         // Address bus
    wire   [1:0] HTRANSM0;        // Transfer type
    wire         HWRITEM0;        // Transfer direction
    wire   [2:0] HSIZEM0;         // Transfer size
    wire   [2:0] HBURSTM0;        // Burst type
    wire   [3:0] HPROTM0;         // Protection control
    wire  [31:0] HWDATAM0;        // Write data
    wire         HMASTLOCKM0;     // Locked Sequence
    wire         HREADYMUXM0;     // Transfer done

    wire  [31:0] HRDATAM0;        // Read data bus
    wire         HREADYOUTM0;     // HREADY feedback
    wire         HRESPM0;         // Transfer response
    wire  [31:0] HAUSERM0;        // Address USER signals
    wire  [31:0] HWUSERM0;        // Write-data USER signals
    wire  [31:0] HRUSERM0;        // Read-data USER signals

    


cpu_sub_system_ahb u_cpu0_sub_system_ahb (
    .alu_monitor             (alu_monitor[0]),
    .biu_pad_haddr           (HADDRS0),
    .biu_pad_hburst          (HBURSTS0),
    .biu_pad_hprot           (HPROTS0),
    .biu_pad_hsize           (HSIZES0),
    .biu_pad_htrans          (HTRANSS0),
    .biu_pad_hwdata          (HWDATAS0),
    .biu_pad_hwrite          (HWRITES0),
    .biu_pad_retire          (iu_monitor[0]),
    .biu_pad_lpmd_b          (biu_pad_lpmd_b),
    .clk_en                  (clk_en),
    .corec_pmu_sleep_out     (corec_pmu_sleep_out),
    .cpu_clk                 (cpu_clk),
    .core_sp                 (core_sp0),
    .i_pad_jtg_tms           (i_pad_jtg_tms),
    .nmi_req                 (nmi_req),
    .pad_biu_bigend_b        (1'b1),
    .pad_biu_hrdata          (HRDATAS0),
    .pad_biu_hready          (HREADYS0),
    .pad_biu_hresp           (HRESPS0),
    .pad_had_jtg_tclk        (pad_had_jtg_tclk),
    .pad_had_jtg_tms_i       (pad_had_jtg_tms_i),
    .pad_had_jtg_trst_b      (pad_had_jtg_trst_b),
    .pad_vic_int_vld         (pad_vic_int_vld),
    .pad_yy_gate_clk_en_b    (1'b0),
    .pad_yy_test_mode        (1'b0),
    .pg_reset_b              (pg_reset_b),
    .pmu_corec_isolation     (pmu_corec_isolation),
    .pmu_corec_sleep_in      (pmu_corec_sleep_in),
    .iahbl_pad_htrans        (HTRANSS5),
    .iahbl_pad_haddr         (HADDRS5),
    .iahbl_pad_hsize         (HSIZES5),
    .iahbl_pad_hwdata        (HWDATAS5),
    .iahbl_pad_hwrite        (HWRITES5),
    .pad_iahbl_hrdata        (HRDATAS5),
    .pad_iahbl_hready        (HREADYS5),
    .pad_iahbl_hresp         (HRESPS5),
    .pad_cpu_rst_b           (pad_cpu_rst_b),
    .sys_rst                 (sys_rst),
    .wakeup_req              (wakeup_req)
);

cpu_sub_system_ahb u_cpu1_sub_system_ahb (
    .alu_monitor             (alu_monitor[1]),
    .biu_pad_haddr           (HADDRS1),
    .biu_pad_hburst          (HBURSTS1),
    .biu_pad_hprot           (HPROTS1),
    .biu_pad_hsize           (HSIZES1),
    .biu_pad_htrans          (HTRANSS1),
    .biu_pad_hwdata          (HWDATAS1),
    .biu_pad_hwrite          (HWRITES1),
    .biu_pad_retire          (iu_monitor[1]),
    .biu_pad_lpmd_b          (biu_pad_lpmd_b),
    .clk_en                  (clk_en),
    .corec_pmu_sleep_out     (corec_pmu_sleep_out),
    .cpu_clk                 (cpu_clk),
    .core_sp                 (core_sp1),
    .i_pad_jtg_tms           (i_pad_jtg_tms),
    .nmi_req                 (nmi_req),
    .pad_biu_bigend_b        (1'b1),
    .pad_biu_hrdata          (HRDATAS1),
    .pad_biu_hready          (HREADYS1),
    .pad_biu_hresp           (HRESPS1),
    .pad_had_jtg_tclk        (pad_had_jtg_tclk),
    .pad_had_jtg_tms_i       (pad_had_jtg_tms_i),
    .pad_had_jtg_trst_b      (pad_had_jtg_trst_b),
    .pad_vic_int_vld         (pad_vic_int_vld),
    .pad_yy_gate_clk_en_b    (1'b0),
    .pad_yy_test_mode        (1'b0),
    .pg_reset_b              (pg_reset_b),
    .pmu_corec_isolation     (pmu_corec_isolation),
    .pmu_corec_sleep_in      (pmu_corec_sleep_in),
    .iahbl_pad_htrans        (HTRANSS6),
    .iahbl_pad_haddr         (HADDRS6),
    .iahbl_pad_hsize         (HSIZES6),
    .iahbl_pad_hwdata        (HWDATAS6),
    .iahbl_pad_hwrite        (HWRITES6),
    .pad_iahbl_hrdata        (HRDATAS6),
    .pad_iahbl_hready        (HREADYS6),
    .pad_iahbl_hresp         (HRESPS6),
    .pad_cpu_rst_b           (pad_cpu_rst_b),
    .sys_rst                 (sys_rst),
    .wakeup_req              (wakeup_req)
);

cpu_sub_system_ahb u_cpu2_sub_system_ahb (
    .alu_monitor             (alu_monitor[2]),
    .biu_pad_haddr           (HADDRS2),
    .biu_pad_hburst          (HBURSTS2),
    .biu_pad_hprot           (HPROTS2),
    .biu_pad_hsize           (HSIZES2),
    .biu_pad_htrans          (HTRANSS2),
    .biu_pad_hwdata          (HWDATAS2),
    .biu_pad_hwrite          (HWRITES2),
    .biu_pad_retire          (iu_monitor[2]),
    .biu_pad_lpmd_b          (biu_pad_lpmd_b),
    .clk_en                  (clk_en),
    .corec_pmu_sleep_out     (corec_pmu_sleep_out),
    .cpu_clk                 (cpu_clk),
    .core_sp                 (core_sp2),
    .i_pad_jtg_tms           (i_pad_jtg_tms),
    .nmi_req                 (nmi_req),
    .pad_biu_bigend_b        (1'b1),
    .pad_biu_hrdata          (HRDATAS2),
    .pad_biu_hready          (HREADYS2),
    .pad_biu_hresp           (HRESPS2),
    .pad_had_jtg_tclk        (pad_had_jtg_tclk),
    .pad_had_jtg_tms_i       (pad_had_jtg_tms_i),
    .pad_had_jtg_trst_b      (pad_had_jtg_trst_b),
    .pad_vic_int_vld         (pad_vic_int_vld),
    .pad_yy_gate_clk_en_b    (1'b0),
    .pad_yy_test_mode        (1'b0),
    .pg_reset_b              (pg_reset_b),
    .pmu_corec_isolation     (pmu_corec_isolation),
    .pmu_corec_sleep_in      (pmu_corec_sleep_in),
    .iahbl_pad_htrans        (HTRANSS7),
    .iahbl_pad_haddr         (HADDRS7),
    .iahbl_pad_hsize         (HSIZES7),
    .iahbl_pad_hwdata        (HWDATAS7),
    .iahbl_pad_hwrite        (HWRITES7),
    .pad_iahbl_hrdata        (HRDATAS7),
    .pad_iahbl_hready        (HREADYS7),
    .pad_iahbl_hresp         (HRESPS7),
    .pad_cpu_rst_b           (pad_cpu_rst_b),
    .sys_rst                 (sys_rst),
    .wakeup_req              (wakeup_req)
);

cpu_sub_system_ahb u_cpu3_sub_system_ahb (
    .alu_monitor             (alu_monitor[3]),
    .biu_pad_haddr           (HADDRS3),
    .biu_pad_hburst          (HBURSTS3),
    .biu_pad_hprot           (HPROTS3),
    .biu_pad_hsize           (HSIZES3),
    .biu_pad_htrans          (HTRANSS3),
    .biu_pad_hwdata          (HWDATAS3),
    .biu_pad_hwrite          (HWRITES3),
    .biu_pad_retire          (iu_monitor[3]),
    .biu_pad_lpmd_b          (biu_pad_lpmd_b),
    .clk_en                  (clk_en),
    .corec_pmu_sleep_out     (corec_pmu_sleep_out),
    .cpu_clk                 (cpu_clk),
    .core_sp                 (core_sp3),
    .i_pad_jtg_tms           (i_pad_jtg_tms),
    .nmi_req                 (nmi_req),
    .pad_biu_bigend_b        (1'b1),
    .pad_biu_hrdata          (HRDATAS3),
    .pad_biu_hready          (HREADYS3),
    .pad_biu_hresp           (HRESPS3),
    .pad_had_jtg_tclk        (pad_had_jtg_tclk),
    .pad_had_jtg_tms_i       (pad_had_jtg_tms_i),
    .pad_had_jtg_trst_b      (pad_had_jtg_trst_b),
    .pad_vic_int_vld         (pad_vic_int_vld),
    .pad_yy_gate_clk_en_b    (1'b0),
    .pad_yy_test_mode        (1'b0),
    .pg_reset_b              (pg_reset_b),
    .pmu_corec_isolation     (pmu_corec_isolation),
    .pmu_corec_sleep_in      (pmu_corec_sleep_in),
    .iahbl_pad_htrans        (HTRANSS8),
    .iahbl_pad_haddr         (HADDRS8),
    .iahbl_pad_hsize         (HSIZES8),
    .iahbl_pad_hwdata        (HWDATAS8),
    .iahbl_pad_hwrite        (HWRITES8),
    .pad_iahbl_hrdata        (HRDATAS8),
    .pad_iahbl_hready        (HREADYS8),
    .pad_iahbl_hresp         (HRESPS8),
    .pad_cpu_rst_b           (pad_cpu_rst_b),
    .sys_rst                 (sys_rst),
    .wakeup_req              (wakeup_req)
);

cpu_sub_system_ahb u_cpu4_sub_system_ahb (
    .alu_monitor             (alu_monitor[4]),
    .biu_pad_haddr           (HADDRS4),
    .biu_pad_hburst          (HBURSTS4),
    .biu_pad_hprot           (HPROTS4),
    .biu_pad_hsize           (HSIZES4),
    .biu_pad_htrans          (HTRANSS4),
    .biu_pad_hwdata          (HWDATAS4),
    .biu_pad_hwrite          (HWRITES4),
    .biu_pad_retire          (iu_monitor[4]),
    .biu_pad_lpmd_b          (biu_pad_lpmd_b),
    .clk_en                  (clk_en),
    .corec_pmu_sleep_out     (corec_pmu_sleep_out),
    .cpu_clk                 (cpu_clk),
    .core_sp                 (core_sp4),
    .i_pad_jtg_tms           (i_pad_jtg_tms),
    .nmi_req                 (nmi_req),
    .pad_biu_bigend_b        (1'b1),
    .pad_biu_hrdata          (HRDATAS4),
    .pad_biu_hready          (HREADYS4),
    .pad_biu_hresp           (HRESPS4),
    .pad_had_jtg_tclk        (pad_had_jtg_tclk),
    .pad_had_jtg_tms_i       (pad_had_jtg_tms_i),
    .pad_had_jtg_trst_b      (pad_had_jtg_trst_b),
    .pad_vic_int_vld         (pad_vic_int_vld),
    .pad_yy_gate_clk_en_b    (1'b0),
    .pad_yy_test_mode        (1'b0),
    .pg_reset_b              (pg_reset_b),
    .pmu_corec_isolation     (pmu_corec_isolation),
    .pmu_corec_sleep_in      (pmu_corec_sleep_in),
    .iahbl_pad_htrans        (HTRANSS9),
    .iahbl_pad_haddr         (HADDRS9),
    .iahbl_pad_hsize         (HSIZES9),
    .iahbl_pad_hwdata        (HWDATAS9),
    .iahbl_pad_hwrite        (HWRITES9),
    .pad_iahbl_hrdata        (HRDATAS9),
    .pad_iahbl_hready        (HREADYS9),
    .pad_iahbl_hresp         (HRESPS9),
    .pad_cpu_rst_b           (pad_cpu_rst_b),
    .sys_rst                 (sys_rst),
    .wakeup_req              (wakeup_req)
);





// &Connect(.clk_en                  (clk_en             ), @40
//          .pad_yy_gate_clk_en_b    (1'b0               ), @41
//          .pad_yy_bist_tst_en      (1'b0               ), @42
//          .pad_yy_scan_enable      (1'b0               ), @43
//          .pad_yy_test_mode        (1'b0               ), @44
//          .pad_biu_bigend_b        (1'b1               ), @45
//          .pad_biu_int_b           (1'b1               ), @46
//          .pad_biu_fint_b          (1'b1               ), @47
//          .pad_biu_fintraw_b       (1'b1               ), @48
//          .pad_biu_avec_b          (1'b0               ), @49
//          .pad_biu_vec_b           (8'b0               ), @50
//          .pad_biu_gsb             (32'b0              ), @51
//          //add for debug @52
//          .pad_biu_dbgrq_b         (1'b1               ),  @53
//          .pad_had_jtg_tap_en      (1'b1               ), @54
//          .pad_biu_clkratio        (3'b0               ), @55
//          .pad_biu_hready          (fifo_biu_hready    ) @56
//         ); @57

//assign i_pad_cpu_jtg_rst_b = i_pad_rst_b & i_pad_jtg_trst_b;
assign i_pad_cpu_jtg_rst_b = i_pad_rst_b & i_pad_jtg_nrst_b;

//assign pad_cpu_rst_b = i_pad_rst_b;
assign pad_cpu_rst_b = i_pad_cpu_jtg_rst_b;
//assign pll_core_cpuclk = cpu_clk;
assign pad_had_jtg_tclk = i_pad_jtg_tclk;
assign pad_had_jtg_trst_b_pre = i_pad_jtg_trst_b;
//assign pad_had_jtg_trst_b_pre = i_pad_cpu_jtg_rst_b;
// //&Force("inout","i_pad_jtg_tms"); @77
//assign pad_had_jtg_tms = i_pad_jtg_tms;
//assign i_pad_jtg_tms = had_pad_jtg_tms_oe ? pad_had_jtg_tms : 1'bz;
// //&Force("nonport","pad_had_jtg_tms"); @80
// &Force("nonport","had_pad_jdb_ack_b"); @82
//***********************Instance ahb delay simulator ***********************
// &Instance("ahb_fifo", "x_ahb_fifo"); @84

// &Connect( @85
//          .cpu_clk                 (per_clk            ), @86
//          .cpu_rst_b               (pg_reset_b         ), @87
//          .counter_num0            (32'h1              ) @88
//          ); @89

//***********************Instance ahb bus arbiter****************************
// &Instance("ahb", "x_ahb"); @92

cmsdk_MyBusMatrixName_lite u_cmsdk_MyBusMatrixName_lite (
    // Common AHB signals
    .HCLK           (HCLK),
    .HRESETn        (HRESETn),
    // System Address Remap control
    .REMAP          (4'b0),
    // Input port SI0 (inputs from master 0)
    .HADDRS5        (HADDRS5),
    .HTRANSS5       (HTRANSS5),
    .HWRITES5       (HWRITES5),
    .HSIZES5        (HSIZES5),
    .HBURSTS5       (HBURSTS5),
    .HPROTS5        (HPROTS5),
    .HWDATAS5       (HWDATAS5),
    .HMASTLOCKS5    (HMASTLOCKS5),
    .HAUSERS5       (HAUSERS5),
    .HWUSERS5       (HWUSERS5),
    // Input port SI1 (inputs from master 1)
    .HADDRS6        (HADDRS6),
    .HTRANSS6       (HTRANSS6),
    .HWRITES6       (HWRITES6),
    .HSIZES6        (HSIZES6),
    .HBURSTS6       (HBURSTS6),
    .HPROTS6        (HPROTS6),
    .HWDATAS6       (HWDATAS6),
    .HMASTLOCKS6    (HMASTLOCKS6),
    .HAUSERS6       (HAUSERS6),
    .HWUSERS6       (HWUSERS6),
    // Input port SI2 (inputs from master 2)
    .HADDRS7        (HADDRS7),
    .HTRANSS7       (HTRANSS7),
    .HWRITES7       (HWRITES7),
    .HSIZES7        (HSIZES7),
    .HBURSTS7       (HBURSTS7),
    .HPROTS7        (HPROTS7),
    .HWDATAS7       (HWDATAS7),
    .HMASTLOCKS7    (HMASTLOCKS7),
    .HAUSERS7       (HAUSERS7),
    .HWUSERS7       (HWUSERS7),
    // Input port SI3 (inputs from master 3)
    .HADDRS8        (HADDRS8),
    .HTRANSS8       (HTRANSS8),
    .HWRITES8       (HWRITES8),
    .HSIZES8        (HSIZES8),
    .HBURSTS8       (HBURSTS8),
    .HPROTS8        (HPROTS8),
    .HWDATAS8       (HWDATAS8),
    .HMASTLOCKS8    (HMASTLOCKS8),
    .HAUSERS8       (HAUSERS8),
    .HWUSERS8       (HWUSERS8),
    // Input port SI4 (inputs from master 4)
    .HADDRS9        (HADDRS9),
    .HTRANSS9       (HTRANSS9),
    .HWRITES9       (HWRITES9),
    .HSIZES9        (HSIZES9),
    .HBURSTS9       (HBURSTS9),
    .HPROTS9        (HPROTS9),
    .HWDATAS9       (HWDATAS9),
    .HMASTLOCKS9    (HMASTLOCKS9),
    .HAUSERS9       (HAUSERS9),
    .HWUSERS9       (HWUSERS9),
    // Output port MI0 (inputs from slave 0)
    .HRDATAM0       (HRDATAM0),
    .HREADYOUTM0    (HREADYOUTM0),
    .HRESPM0        (HRESPM0),
    .HRUSERM0       (HRUSERM0),
    // Scan test dummy signals; not connected until scan insertion
    .SCANENABLE     (SCANENABLE),
    // Scan Test Mode Enable
    .SCANINHCLK     (SCANINHCLK),
    // Scan Chain Input


    // Output port MI0 (outputs to slave 0)
    .HSELM0         (HSELM0),
    .HADDRM0        (HADDRM0),
    .HTRANSM0       (HTRANSM0),
    .HWRITEM0       (HWRITEM0),
    .HSIZEM0        (HSIZEM0),
    .HBURSTM0       (HBURSTM0),
    .HPROTM0        (HPROTM0),
    .HWDATAM0       (HWDATAM0),
    .HMASTLOCKM0    (HMASTLOCKM0),
    .HREADYMUXM0    (HREADYMUXM0),
    .HAUSERM0       (HAUSERM0),
    .HWUSERM0       (HWUSERM0),
    // Input port SI0 (outputs to master 0)
    .HRDATAS5       (HRDATAS5),
    .HREADYS5       (HREADYS5),
    .HRESPS5        (HRESPS5),
    .HRUSERS5       (HRUSERS5),
    // Input port SI1 (outputs to master 1)
    .HRDATAS6       (HRDATAS6),
    .HREADYS6       (HREADYS6),
    .HRESPS6        (HRESPS6),
    .HRUSERS6       (HRUSERS6),
    // Input port SI2 (outputs to master 2)
    .HRDATAS7       (HRDATAS7),
    .HREADYS7       (HREADYS7),
    .HRESPS7        (HRESPS7),
    .HRUSERS7       (HRUSERS7),
    // Input port SI3 (outputs to master 3)
    .HRDATAS8       (HRDATAS8),
    .HREADYS8       (HREADYS8),
    .HRESPS8        (HRESPS8),
    .HRUSERS8       (HRUSERS8),
    // Input port SI4 (outputs to master 4)
    .HRDATAS9       (HRDATAS9),
    .HREADYS9       (HREADYS9),
    .HRESPS9        (HRESPS9),
    .HRUSERS9       (HRUSERS9),
    // Scan test dummy signals; not connected until scan insertion
    // Scan Chain Output

    .SCANOUTHCLK    (SCANOUTHCLK)
);

// &Connect( @93
//          .pll_core_cpuclk         (per_clk            ), @94
//          .pad_cpu_rst_b           (pg_reset_b         ), @95
//          .biu_pad_hbusreq         (fifo_pad_hreq      ), @96
//          .biu_pad_haddr           (fifo_pad_haddr     ), @97
//          .biu_pad_hburst          (fifo_pad_hburst    ), @98
//          .biu_pad_hlock           (fifo_pad_hlock     ), @99
//          .biu_pad_hprot           (fifo_pad_hprot     ), @100
//          .biu_pad_hsize           (fifo_pad_hsize     ), @101
//          .biu_pad_htrans          (fifo_pad_htrans    ),     @102
//          .biu_pad_hwrite          (fifo_pad_hwrite    )   @103
//          ); @104

//***********************Instance ahb slave 1    ****************************

// &Instance("mem_ctrl", "x_smem_ctrl"); @108
iahb_mem_ctrl  x_iahb_mem_ctrl (
  .lite_mmc_hsel       (HSELM0),
  .lite_yy_haddr       (HADDRM0),
  .lite_yy_hsize       (HSIZEM0),
  .lite_yy_htrans      (HTRANSM0),
  .lite_yy_hwdata      (HWDATAM0),
  .lite_yy_hwrite      (HWRITEM0),
  .mmc_lite_hrdata     (HRDATAM0),
  .mmc_lite_hready     (HREADYOUTM0),
  .mmc_lite_hresp      (HRESPM0),
  .pad_biu_bigend_b    (1'b1 ),
  .pad_cpu_rst_b       (pad_cpu_rst_b      ),
  .pll_core_cpuclk     (per_clk)
);
wire HREADYOUTM1;
wire HREADYOUTM2;
wire HREADYOUTM3;
wire HREADYOUTM4;
wire HREADYOUTM5;
wire [31:0] HRDATAM1;
wire [31:0] HRDATAM2;
wire [31:0] HRDATAM3;
wire [31:0] HRDATAM4;
wire [31:0] HRDATAM5;


wire [31:0] HADDRM1;
wire [2:0] HBURSTM1;
wire [3:0]  HPROTM1;
wire [31:0]HWDATAM1;
wire    HREADYOUTM1;
wire        HRESPM1;
wire         HSELM1;
wire [2:0]  HSIZEM1;
wire [1:0] HTRANSM1;
wire       HWRITEM1;
assign HADDRM1 = HADDRS0;
assign HBURSTM1 = HBURSTS0;
assign HPROTM1 = HPROTS0;
assign HWDATAM1 = HWDATAS0;
assign HREADYS0 = HREADYOUTM1;
assign HRESPS0 = HRESPM1;
assign HSELM1 = HTRANSS0[1];
assign HSIZEM1 = HSIZES0;
assign HTRANSM1 = HTRANSS0;
assign HRDATAS0 = HRDATAM1;
assign HWRITEM1 = HWRITES0;
mem_ctrl  x_smem_ctrl_1 (
  .haddr_s1        (HADDRM1       ),
  .hburst_s1       (HBURSTM1      ),
  .hprot_s1        (HPROTM1       ),
  .hrdata_s1       (HRDATAM1      ),
  .hready_s1       (HREADYOUTM1      ),
  .hresp_s1        (HRESPM1       ),
  .hsel_s1         (HSELM1        ),
  .hsize_s1        (HSIZEM1       ),
  .htrans_s1       (HTRANSM1),
  .hwdata_s1       (HWDATAM1),
  .hwrite_s1       (HWRITEM1),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pll_core_cpuclk (per_clk        )
);
wire [31:0] HADDRM2;
wire [2:0] HBURSTM2;
wire [3:0]  HPROTM2;
wire [31:0]HWDATAM2;
wire    HREADYOUTM2;
wire        HRESPM2;
wire         HSELM2;
wire [2:0]  HSIZEM2;
wire [1:0] HTRANSM2;
wire       HWRITEM2;
assign HADDRM2 = HADDRS1;
assign HBURSTM2 = HBURSTS1;
assign HPROTM2 = HPROTS1;
assign HWDATAM2 = HWDATAS1;
assign HREADYS1 = HREADYOUTM2;
assign HRESPS1 = HRESPM2;
assign HSELM2 = HTRANSS1[1];
assign HSIZEM2 = HSIZES1;
assign HTRANSM2 = HTRANSS1;
assign HRDATAS1 = HRDATAM2;
assign HWRITEM2 = HWRITES1;
mem_ctrl  x_smem_ctrl_2(
  .haddr_s1        (HADDRM2       ),
  .hburst_s1       (HBURSTM2      ),
  .hprot_s1        (HPROTM2       ),
  .hrdata_s1       (HRDATAM2      ),
  .hready_s1       (HREADYOUTM2      ),
  .hresp_s1        (HRESPM2       ),
  .hsel_s1         (HSELM2        ),
  .hsize_s1        (HSIZEM2       ),
  .htrans_s1       (HTRANSM2),
  .hwdata_s1       (HWDATAM2),
  .hwrite_s1       (HWRITEM2),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pll_core_cpuclk (per_clk        )
);
wire [31:0] HADDRM3;
wire [2:0] HBURSTM3;
wire [3:0]  HPROTM3;
wire [31:0]HWDATAM3;
wire    HREADYOUTM3;
wire        HRESPM3;
wire         HSELM3;
wire [2:0]  HSIZEM3;
wire [1:0] HTRANSM3;
wire       HWRITEM3;
assign HADDRM3 = HADDRS2;
assign HBURSTM3 = HBURSTS2;
assign HPROTM3 = HPROTS2;
assign HWDATAM3 = HWDATAS2;
assign HREADYS2 = HREADYOUTM2;
assign HRESPS2 = HRESPM3;
assign HSELM3 = HTRANSS2[1];
assign HSIZEM3 = HSIZES2;
assign HTRANSM3 = HTRANSS2;
assign HRDATAS2 = HRDATAM3;
assign HWRITEM3 = HWRITES2;
mem_ctrl  x_smem_ctrl_3 (
  .haddr_s1        (HADDRM3       ),
  .hburst_s1       (HBURSTM3      ),
  .hprot_s1        (HPROTM3       ),
  .hrdata_s1       (HRDATAM3      ),
  .hready_s1       (HREADYOUTM3      ),
  .hresp_s1        (HRESPM3       ),
  .hsel_s1         (HSELM3        ),
  .hsize_s1        (HSIZEM3       ),
  .htrans_s1       (HTRANSM3),
  .hwdata_s1       (HWDATAM3),
  .hwrite_s1       (HWRITEM3),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pll_core_cpuclk (per_clk        )
);
wire [31:0] HADDRM4;
wire [2:0] HBURSTM4;
wire [3:0]  HPROTM4;
wire [31:0]HWDATAM4;
wire    HREADYOUTM4;
wire        HRESPM4;
wire         HSELM4;
wire [2:0]  HSIZEM4;
wire [1:0] HTRANSM4;
wire       HWRITEM4;
assign HADDRM4 = HADDRS3;
assign HBURSTM4 = HBURSTS3;
assign HPROTM4 = HPROTS3;
assign HWDATAM4 = HWDATAS3;
assign HREADYS3 = HREADYOUTM4;
assign HRESPS3 = HRESPM4;
assign HSELM4 = HTRANSS3[1];
assign HSIZEM4 = HSIZES3;
assign HTRANSM4 = HTRANSS3;
assign HRDATAS3 = HRDATAM4;
assign HWRITEM4 = HWRITES3;
mem_ctrl  x_smem_ctrl_4 (
  .haddr_s1        (HADDRM4       ),
  .hburst_s1       (HBURSTM4      ),
  .hprot_s1        (HPROTM4       ),
  .hrdata_s1       (HRDATAM4      ),
  .hready_s1       (HREADYOUTM4      ),
  .hresp_s1        (HRESPM4       ),
  .hsel_s1         (HSELM4        ),
  .hsize_s1        (HSIZEM4       ),
  .htrans_s1       (HTRANSM4),
  .hwdata_s1       (HWDATAM4),
  .hwrite_s1       (HWRITEM4),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pll_core_cpuclk (per_clk        )
);
wire [31:0] HADDRM5;
wire [2:0] HBURSTM5;
wire [3:0]  HPROTM5;
wire [31:0]HWDATAM5;
wire    HREADYOUTM5;
wire        HRESPM5;
wire         HSELM5;
wire [2:0]  HSIZEM5;
wire [1:0] HTRANSM5;
wire       HWRITEM5;
assign HADDRM5 = HADDRS4;
assign HBURSTM5 = HBURSTS4;
assign HPROTM5 = HPROTS4;
assign HWDATAM5 = HWDATAS4;
assign HREADYS4 = HREADYOUTM5;
assign HRESPS4 = HRESPM5;
assign HSELM5 = HTRANSS4[1];
assign HSIZEM5 = HSIZES4;
assign HTRANSM5 = HTRANSS4;
assign HRDATAS4 = HRDATAM5;
assign HWRITEM5 = HWRITES4;
mem_ctrl  x_smem_ctrl_5 (
  .haddr_s1        (HADDRM5       ),
  .hburst_s1       (HBURSTM5      ),
  .hprot_s1        (HPROTM5       ),
  .hrdata_s1       (HRDATAM5      ),
  .hready_s1       (HREADYOUTM5      ),
  .hresp_s1        (HRESPM5       ),
  .hsel_s1         (HSELM5        ),
  .hsize_s1        (HSIZEM5       ),
  .htrans_s1       (HTRANSM5),
  .hwdata_s1       (HWDATAM5),
  .hwrite_s1       (HWRITEM5),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pll_core_cpuclk (per_clk        )
);

endmodule