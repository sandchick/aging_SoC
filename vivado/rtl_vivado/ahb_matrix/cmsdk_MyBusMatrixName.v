//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2001-2013-2023 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2012-10-15 18:01:36 +0100 (Mon, 15 Oct 2012) $
//
//      Revision            : $Revision: 225465 $
//
//      Release Information : Cortex-M System Design Kit-r1p0-01rel0
//
//-----------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
//  Abstract            : BusMatrix is the top-level which connects together
//                        the required Input Stages, MatrixDecodes, Output
//                        Stages and Output Arbitration blocks.
//
//                        Supports the following configured options:
//
//                         - Architecture type 'ahb2',
//                         - 5 slave ports (connecting to masters),
//                         - 1 master ports (connecting to slaves),
//                         - Routing address width of 32 bits,
//                         - Routing data width of 32 bits,
//                         - xUSER signal width of 32 bits,
//                         - Arbiter type 'round',
//                         - Connectivity mapping:
//                             S<0..4> -> M<0..0>,
//                         - Connectivity type 'full'.
//
//------------------------------------------------------------------------------

`timescale 1ns/1ps

module cmsdk_MyBusMatrixName (

    // Common AHB signals
    HCLK,
    HRESETn,

    // System address remapping control
    REMAP,

    // Input port SI0 (inputs from master 0)
    HSELS5,
    HADDRS5,
    HTRANSS5,
    HWRITES5,
    HSIZES5,
    HBURSTS5,
    HPROTS5,
    HMASTERS5,
    HWDATAS5,
    HMASTLOCKS5,
    HREADYS5,
    HAUSERS5,
    HWUSERS5,

    // Input port SI1 (inputs from master 1)
    HSELS6,
    HADDRS6,
    HTRANSS6,
    HWRITES6,
    HSIZES6,
    HBURSTS6,
    HPROTS6,
    HMASTERS6,
    HWDATAS6,
    HMASTLOCKS6,
    HREADYS6,
    HAUSERS6,
    HWUSERS6,

    // Input port SI2 (inputs from master 2)
    HSELS7,
    HADDRS7,
    HTRANSS7,
    HWRITES7,
    HSIZES7,
    HBURSTS7,
    HPROTS7,
    HMASTERS7,
    HWDATAS7,
    HMASTLOCKS7,
    HREADYS7,
    HAUSERS7,
    HWUSERS7,

    // Input port SI3 (inputs from master 3)
    HSELS8,
    HADDRS8,
    HTRANSS8,
    HWRITES8,
    HSIZES8,
    HBURSTS8,
    HPROTS8,
    HMASTERS8,
    HWDATAS8,
    HMASTLOCKS8,
    HREADYS8,
    HAUSERS8,
    HWUSERS8,

    // Input port SI4 (inputs from master 4)
    HSELS9,
    HADDRS9,
    HTRANSS9,
    HWRITES9,
    HSIZES9,
    HBURSTS9,
    HPROTS9,
    HMASTERS9,
    HWDATAS9,
    HMASTLOCKS9,
    HREADYS9,
    HAUSERS9,
    HWUSERS9,

    // Output port MI0 (inputs from slave 0)
    HRDATAM0,
    HREADYOUTM0,
    HRESPM0,
    HRUSERM0,

    // Scan test dummy signals; not connected until scan insertion
    SCANENABLE,   // Scan Test Mode Enable
    SCANINHCLK,   // Scan Chain Input


    // Output port MI0 (outputs to slave 0)
    HSELM0,
    HADDRM0,
    HTRANSM0,
    HWRITEM0,
    HSIZEM0,
    HBURSTM0,
    HPROTM0,
    HMASTERM0,
    HWDATAM0,
    HMASTLOCKM0,
    HREADYMUXM0,
    HAUSERM0,
    HWUSERM0,

    // Input port SI0 (outputs to master 0)
    HRDATAS5,
    HREADYOUTS5,
    HRESPS5,
    HRUSERS5,

    // Input port SI1 (outputs to master 1)
    HRDATAS6,
    HREADYOUTS6,
    HRESPS6,
    HRUSERS6,

    // Input port SI2 (outputs to master 2)
    HRDATAS7,
    HREADYOUTS7,
    HRESPS7,
    HRUSERS7,

    // Input port SI3 (outputs to master 3)
    HRDATAS8,
    HREADYOUTS8,
    HRESPS8,
    HRUSERS8,

    // Input port SI4 (outputs to master 4)
    HRDATAS9,
    HREADYOUTS9,
    HRESPS9,
    HRUSERS9,

    // Scan test dummy signals; not connected until scan insertion
    SCANOUTHCLK   // Scan Chain Output

    );


// -----------------------------------------------------------------------------
// Input and Output declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    input         HCLK;            // AHB System Clock
    input         HRESETn;         // AHB System Reset

    // System address remapping control
    input   [3:0] REMAP;           // REMAP input

    // Input port SI0 (inputs from master 0)
    input         HSELS5;          // Slave Select
    input  [31:0] HADDRS5;         // Address bus
    input   [1:0] HTRANSS5;        // Transfer type
    input         HWRITES5;        // Transfer direction
    input   [2:0] HSIZES5;         // Transfer size
    input   [2:0] HBURSTS5;        // Burst type
    input   [3:0] HPROTS5;         // Protection control
    input   [3:0] HMASTERS5;       // Master select
    input  [31:0] HWDATAS5;        // Write data
    input         HMASTLOCKS5;     // Locked Sequence
    input         HREADYS5;        // Transfer done
    input  [31:0] HAUSERS5;        // Address USER signals
    input  [31:0] HWUSERS5;        // Write-data USER signals

    // Input port SI1 (inputs from master 1)
    input         HSELS6;          // Slave Select
    input  [31:0] HADDRS6;         // Address bus
    input   [1:0] HTRANSS6;        // Transfer type
    input         HWRITES6;        // Transfer direction
    input   [2:0] HSIZES6;         // Transfer size
    input   [2:0] HBURSTS6;        // Burst type
    input   [3:0] HPROTS6;         // Protection control
    input   [3:0] HMASTERS6;       // Master select
    input  [31:0] HWDATAS6;        // Write data
    input         HMASTLOCKS6;     // Locked Sequence
    input         HREADYS6;        // Transfer done
    input  [31:0] HAUSERS6;        // Address USER signals
    input  [31:0] HWUSERS6;        // Write-data USER signals

    // Input port SI2 (inputs from master 2)
    input         HSELS7;          // Slave Select
    input  [31:0] HADDRS7;         // Address bus
    input   [1:0] HTRANSS7;        // Transfer type
    input         HWRITES7;        // Transfer direction
    input   [2:0] HSIZES7;         // Transfer size
    input   [2:0] HBURSTS7;        // Burst type
    input   [3:0] HPROTS7;         // Protection control
    input   [3:0] HMASTERS7;       // Master select
    input  [31:0] HWDATAS7;        // Write data
    input         HMASTLOCKS7;     // Locked Sequence
    input         HREADYS7;        // Transfer done
    input  [31:0] HAUSERS7;        // Address USER signals
    input  [31:0] HWUSERS7;        // Write-data USER signals

    // Input port SI3 (inputs from master 3)
    input         HSELS8;          // Slave Select
    input  [31:0] HADDRS8;         // Address bus
    input   [1:0] HTRANSS8;        // Transfer type
    input         HWRITES8;        // Transfer direction
    input   [2:0] HSIZES8;         // Transfer size
    input   [2:0] HBURSTS8;        // Burst type
    input   [3:0] HPROTS8;         // Protection control
    input   [3:0] HMASTERS8;       // Master select
    input  [31:0] HWDATAS8;        // Write data
    input         HMASTLOCKS8;     // Locked Sequence
    input         HREADYS8;        // Transfer done
    input  [31:0] HAUSERS8;        // Address USER signals
    input  [31:0] HWUSERS8;        // Write-data USER signals

    // Input port SI4 (inputs from master 4)
    input         HSELS9;          // Slave Select
    input  [31:0] HADDRS9;         // Address bus
    input   [1:0] HTRANSS9;        // Transfer type
    input         HWRITES9;        // Transfer direction
    input   [2:0] HSIZES9;         // Transfer size
    input   [2:0] HBURSTS9;        // Burst type
    input   [3:0] HPROTS9;         // Protection control
    input   [3:0] HMASTERS9;       // Master select
    input  [31:0] HWDATAS9;        // Write data
    input         HMASTLOCKS9;     // Locked Sequence
    input         HREADYS9;        // Transfer done
    input  [31:0] HAUSERS9;        // Address USER signals
    input  [31:0] HWUSERS9;        // Write-data USER signals

    // Output port MI0 (inputs from slave 0)
    input  [31:0] HRDATAM0;        // Read data bus
    input         HREADYOUTM0;     // HREADY feedback
    input   [1:0] HRESPM0;         // Transfer response
    input  [31:0] HRUSERM0;        // Read-data USER signals

    // Scan test dummy signals; not connected until scan insertion
    input         SCANENABLE;      // Scan enable signal
    input         SCANINHCLK;      // HCLK scan input


    // Output port MI0 (outputs to slave 0)
    output        HSELM0;          // Slave Select
    output [31:0] HADDRM0;         // Address bus
    output  [1:0] HTRANSM0;        // Transfer type
    output        HWRITEM0;        // Transfer direction
    output  [2:0] HSIZEM0;         // Transfer size
    output  [2:0] HBURSTM0;        // Burst type
    output  [3:0] HPROTM0;         // Protection control
    output  [3:0] HMASTERM0;       // Master select
    output [31:0] HWDATAM0;        // Write data
    output        HMASTLOCKM0;     // Locked Sequence
    output        HREADYMUXM0;     // Transfer done
    output [31:0] HAUSERM0;        // Address USER signals
    output [31:0] HWUSERM0;        // Write-data USER signals

    // Input port SI0 (outputs to master 0)
    output [31:0] HRDATAS5;        // Read data bus
    output        HREADYOUTS5;     // HREADY feedback
    output  [1:0] HRESPS5;         // Transfer response
    output [31:0] HRUSERS5;        // Read-data USER signals

    // Input port SI1 (outputs to master 1)
    output [31:0] HRDATAS6;        // Read data bus
    output        HREADYOUTS6;     // HREADY feedback
    output  [1:0] HRESPS6;         // Transfer response
    output [31:0] HRUSERS6;        // Read-data USER signals

    // Input port SI2 (outputs to master 2)
    output [31:0] HRDATAS7;        // Read data bus
    output        HREADYOUTS7;     // HREADY feedback
    output  [1:0] HRESPS7;         // Transfer response
    output [31:0] HRUSERS7;        // Read-data USER signals

    // Input port SI3 (outputs to master 3)
    output [31:0] HRDATAS8;        // Read data bus
    output        HREADYOUTS8;     // HREADY feedback
    output  [1:0] HRESPS8;         // Transfer response
    output [31:0] HRUSERS8;        // Read-data USER signals

    // Input port SI4 (outputs to master 4)
    output [31:0] HRDATAS9;        // Read data bus
    output        HREADYOUTS9;     // HREADY feedback
    output  [1:0] HRESPS9;         // Transfer response
    output [31:0] HRUSERS9;        // Read-data USER signals

    // Scan test dummy signals; not connected until scan insertion
    output        SCANOUTHCLK;     // Scan Chain Output


// -----------------------------------------------------------------------------
// Wire declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    wire         HCLK;            // AHB System Clock
    wire         HRESETn;         // AHB System Reset

    // System address remapping control
    wire   [3:0] REMAP;           // REMAP signal

    // Input Port SI0
    wire         HSELS5;          // Slave Select
    wire  [31:0] HADDRS5;         // Address bus
    wire   [1:0] HTRANSS5;        // Transfer type
    wire         HWRITES5;        // Transfer direction
    wire   [2:0] HSIZES5;         // Transfer size
    wire   [2:0] HBURSTS5;        // Burst type
    wire   [3:0] HPROTS5;         // Protection control
    wire   [3:0] HMASTERS5;       // Master select
    wire  [31:0] HWDATAS5;        // Write data
    wire         HMASTLOCKS5;     // Locked Sequence
    wire         HREADYS5;        // Transfer done

    wire  [31:0] HRDATAS5;        // Read data bus
    wire         HREADYOUTS5;     // HREADY feedback
    wire   [1:0] HRESPS5;         // Transfer response
    wire  [31:0] HAUSERS5;        // Address USER signals
    wire  [31:0] HWUSERS5;        // Write-data USER signals
    wire  [31:0] HRUSERS5;        // Read-data USER signals

    // Input Port SI1
    wire         HSELS6;          // Slave Select
    wire  [31:0] HADDRS6;         // Address bus
    wire   [1:0] HTRANSS6;        // Transfer type
    wire         HWRITES6;        // Transfer direction
    wire   [2:0] HSIZES6;         // Transfer size
    wire   [2:0] HBURSTS6;        // Burst type
    wire   [3:0] HPROTS6;         // Protection control
    wire   [3:0] HMASTERS6;       // Master select
    wire  [31:0] HWDATAS6;        // Write data
    wire         HMASTLOCKS6;     // Locked Sequence
    wire         HREADYS6;        // Transfer done

    wire  [31:0] HRDATAS6;        // Read data bus
    wire         HREADYOUTS6;     // HREADY feedback
    wire   [1:0] HRESPS6;         // Transfer response
    wire  [31:0] HAUSERS6;        // Address USER signals
    wire  [31:0] HWUSERS6;        // Write-data USER signals
    wire  [31:0] HRUSERS6;        // Read-data USER signals

    // Input Port SI2
    wire         HSELS7;          // Slave Select
    wire  [31:0] HADDRS7;         // Address bus
    wire   [1:0] HTRANSS7;        // Transfer type
    wire         HWRITES7;        // Transfer direction
    wire   [2:0] HSIZES7;         // Transfer size
    wire   [2:0] HBURSTS7;        // Burst type
    wire   [3:0] HPROTS7;         // Protection control
    wire   [3:0] HMASTERS7;       // Master select
    wire  [31:0] HWDATAS7;        // Write data
    wire         HMASTLOCKS7;     // Locked Sequence
    wire         HREADYS7;        // Transfer done

    wire  [31:0] HRDATAS7;        // Read data bus
    wire         HREADYOUTS7;     // HREADY feedback
    wire   [1:0] HRESPS7;         // Transfer response
    wire  [31:0] HAUSERS7;        // Address USER signals
    wire  [31:0] HWUSERS7;        // Write-data USER signals
    wire  [31:0] HRUSERS7;        // Read-data USER signals

    // Input Port SI3
    wire         HSELS8;          // Slave Select
    wire  [31:0] HADDRS8;         // Address bus
    wire   [1:0] HTRANSS8;        // Transfer type
    wire         HWRITES8;        // Transfer direction
    wire   [2:0] HSIZES8;         // Transfer size
    wire   [2:0] HBURSTS8;        // Burst type
    wire   [3:0] HPROTS8;         // Protection control
    wire   [3:0] HMASTERS8;       // Master select
    wire  [31:0] HWDATAS8;        // Write data
    wire         HMASTLOCKS8;     // Locked Sequence
    wire         HREADYS8;        // Transfer done

    wire  [31:0] HRDATAS8;        // Read data bus
    wire         HREADYOUTS8;     // HREADY feedback
    wire   [1:0] HRESPS8;         // Transfer response
    wire  [31:0] HAUSERS8;        // Address USER signals
    wire  [31:0] HWUSERS8;        // Write-data USER signals
    wire  [31:0] HRUSERS8;        // Read-data USER signals

    // Input Port SI4
    wire         HSELS9;          // Slave Select
    wire  [31:0] HADDRS9;         // Address bus
    wire   [1:0] HTRANSS9;        // Transfer type
    wire         HWRITES9;        // Transfer direction
    wire   [2:0] HSIZES9;         // Transfer size
    wire   [2:0] HBURSTS9;        // Burst type
    wire   [3:0] HPROTS9;         // Protection control
    wire   [3:0] HMASTERS9;       // Master select
    wire  [31:0] HWDATAS9;        // Write data
    wire         HMASTLOCKS9;     // Locked Sequence
    wire         HREADYS9;        // Transfer done

    wire  [31:0] HRDATAS9;        // Read data bus
    wire         HREADYOUTS9;     // HREADY feedback
    wire   [1:0] HRESPS9;         // Transfer response
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
    wire   [3:0] HMASTERM0;       // Master select
    wire  [31:0] HWDATAM0;        // Write data
    wire         HMASTLOCKM0;     // Locked Sequence
    wire         HREADYMUXM0;     // Transfer done

    wire  [31:0] HRDATAM0;        // Read data bus
    wire         HREADYOUTM0;     // HREADY feedback
    wire   [1:0] HRESPM0;         // Transfer response
    wire  [31:0] HAUSERM0;        // Address USER signals
    wire  [31:0] HWUSERM0;        // Write-data USER signals
    wire  [31:0] HRUSERM0;        // Read-data USER signals


// -----------------------------------------------------------------------------
// Signal declarations
// -----------------------------------------------------------------------------

    // Bus-switch input SI0
    wire         i_sel0;            // HSEL signal
    wire  [31:0] i_addr0;           // HADDR signal
    wire   [1:0] i_trans0;          // HTRANS signal
    wire         i_write0;          // HWRITE signal
    wire   [2:0] i_size0;           // HSIZE signal
    wire   [2:0] i_burst0;          // HBURST signal
    wire   [3:0] i_prot0;           // HPROTS signal
    wire   [3:0] i_master0;         // HMASTER signal
    wire         i_mastlock0;       // HMASTLOCK signal
    wire         i_active0;         // Active signal
    wire         i_held_tran0;       // HeldTran signal
    wire         i_readyout0;       // Readyout signal
    wire   [1:0] i_resp0;           // Response signal
    wire  [31:0] i_auser0;          // HAUSER signal

    // Bus-switch input SI1
    wire         i_sel1;            // HSEL signal
    wire  [31:0] i_addr1;           // HADDR signal
    wire   [1:0] i_trans1;          // HTRANS signal
    wire         i_write1;          // HWRITE signal
    wire   [2:0] i_size1;           // HSIZE signal
    wire   [2:0] i_burst1;          // HBURST signal
    wire   [3:0] i_prot1;           // HPROTS signal
    wire   [3:0] i_master1;         // HMASTER signal
    wire         i_mastlock1;       // HMASTLOCK signal
    wire         i_active1;         // Active signal
    wire         i_held_tran1;       // HeldTran signal
    wire         i_readyout1;       // Readyout signal
    wire   [1:0] i_resp1;           // Response signal
    wire  [31:0] i_auser1;          // HAUSER signal

    // Bus-switch input SI2
    wire         i_sel2;            // HSEL signal
    wire  [31:0] i_addr2;           // HADDR signal
    wire   [1:0] i_trans2;          // HTRANS signal
    wire         i_write2;          // HWRITE signal
    wire   [2:0] i_size2;           // HSIZE signal
    wire   [2:0] i_burst2;          // HBURST signal
    wire   [3:0] i_prot2;           // HPROTS signal
    wire   [3:0] i_master2;         // HMASTER signal
    wire         i_mastlock2;       // HMASTLOCK signal
    wire         i_active2;         // Active signal
    wire         i_held_tran2;       // HeldTran signal
    wire         i_readyout2;       // Readyout signal
    wire   [1:0] i_resp2;           // Response signal
    wire  [31:0] i_auser2;          // HAUSER signal

    // Bus-switch input SI3
    wire         i_sel3;            // HSEL signal
    wire  [31:0] i_addr3;           // HADDR signal
    wire   [1:0] i_trans3;          // HTRANS signal
    wire         i_write3;          // HWRITE signal
    wire   [2:0] i_size3;           // HSIZE signal
    wire   [2:0] i_burst3;          // HBURST signal
    wire   [3:0] i_prot3;           // HPROTS signal
    wire   [3:0] i_master3;         // HMASTER signal
    wire         i_mastlock3;       // HMASTLOCK signal
    wire         i_active3;         // Active signal
    wire         i_held_tran3;       // HeldTran signal
    wire         i_readyout3;       // Readyout signal
    wire   [1:0] i_resp3;           // Response signal
    wire  [31:0] i_auser3;          // HAUSER signal

    // Bus-switch input SI4
    wire         i_sel4;            // HSEL signal
    wire  [31:0] i_addr4;           // HADDR signal
    wire   [1:0] i_trans4;          // HTRANS signal
    wire         i_write4;          // HWRITE signal
    wire   [2:0] i_size4;           // HSIZE signal
    wire   [2:0] i_burst4;          // HBURST signal
    wire   [3:0] i_prot4;           // HPROTS signal
    wire   [3:0] i_master4;         // HMASTER signal
    wire         i_mastlock4;       // HMASTLOCK signal
    wire         i_active4;         // Active signal
    wire         i_held_tran4;       // HeldTran signal
    wire         i_readyout4;       // Readyout signal
    wire   [1:0] i_resp4;           // Response signal
    wire  [31:0] i_auser4;          // HAUSER signal

    // Bus-switch SI0 to MI0 signals
    wire         i_sel0to0;         // Routing selection signal
    wire         i_active0to0;      // Active signal

    // Bus-switch SI1 to MI0 signals
    wire         i_sel1to0;         // Routing selection signal
    wire         i_active1to0;      // Active signal

    // Bus-switch SI2 to MI0 signals
    wire         i_sel2to0;         // Routing selection signal
    wire         i_active2to0;      // Active signal

    // Bus-switch SI3 to MI0 signals
    wire         i_sel3to0;         // Routing selection signal
    wire         i_active3to0;      // Active signal

    // Bus-switch SI4 to MI0 signals
    wire         i_sel4to0;         // Routing selection signal
    wire         i_active4to0;      // Active signal

    wire         i_hready_mux_m0;    // Internal HREADYMUXM for MI0


// -----------------------------------------------------------------------------
// Beginning of main code
// -----------------------------------------------------------------------------

  // Input stage for SI0
  cmsdk_MyInputName u_cmsdk_MyInputName_0 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS5),
    .HADDRS     (HADDRS5),
    .HTRANSS    (HTRANSS5),
    .HWRITES    (HWRITES5),
    .HSIZES     (HSIZES5),
    .HBURSTS    (HBURSTS5),
    .HPROTS     (HPROTS5),
    .HMASTERS   (HMASTERS5),
    .HMASTLOCKS (HMASTLOCKS5),
    .HREADYS    (HREADYS5),
    .HAUSERS    (HAUSERS5),

    // Internal Response
    .active_ip     (i_active0),
    .readyout_ip   (i_readyout0),
    .resp_ip       (i_resp0),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS5),
    .HRESPS     (HRESPS5),

    // Internal Address/Control Signals
    .sel_ip        (i_sel0),
    .addr_ip       (i_addr0),
    .auser_ip      (i_auser0),
    .trans_ip      (i_trans0),
    .write_ip      (i_write0),
    .size_ip       (i_size0),
    .burst_ip      (i_burst0),
    .prot_ip       (i_prot0),
    .master_ip     (i_master0),
    .mastlock_ip   (i_mastlock0),
    .held_tran_ip   (i_held_tran0)

    );


  // Input stage for SI1
  cmsdk_MyInputName u_cmsdk_MyInputName_1 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS6),
    .HADDRS     (HADDRS6),
    .HTRANSS    (HTRANSS6),
    .HWRITES    (HWRITES6),
    .HSIZES     (HSIZES6),
    .HBURSTS    (HBURSTS6),
    .HPROTS     (HPROTS6),
    .HMASTERS   (HMASTERS6),
    .HMASTLOCKS (HMASTLOCKS6),
    .HREADYS    (HREADYS6),
    .HAUSERS    (HAUSERS6),

    // Internal Response
    .active_ip     (i_active1),
    .readyout_ip   (i_readyout1),
    .resp_ip       (i_resp1),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS6),
    .HRESPS     (HRESPS6),

    // Internal Address/Control Signals
    .sel_ip        (i_sel1),
    .addr_ip       (i_addr1),
    .auser_ip      (i_auser1),
    .trans_ip      (i_trans1),
    .write_ip      (i_write1),
    .size_ip       (i_size1),
    .burst_ip      (i_burst1),
    .prot_ip       (i_prot1),
    .master_ip     (i_master1),
    .mastlock_ip   (i_mastlock1),
    .held_tran_ip   (i_held_tran1)

    );


  // Input stage for SI2
  cmsdk_MyInputName u_cmsdk_MyInputName_2 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS7),
    .HADDRS     (HADDRS7),
    .HTRANSS    (HTRANSS7),
    .HWRITES    (HWRITES7),
    .HSIZES     (HSIZES7),
    .HBURSTS    (HBURSTS7),
    .HPROTS     (HPROTS7),
    .HMASTERS   (HMASTERS7),
    .HMASTLOCKS (HMASTLOCKS7),
    .HREADYS    (HREADYS7),
    .HAUSERS    (HAUSERS7),

    // Internal Response
    .active_ip     (i_active2),
    .readyout_ip   (i_readyout2),
    .resp_ip       (i_resp2),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS7),
    .HRESPS     (HRESPS7),

    // Internal Address/Control Signals
    .sel_ip        (i_sel2),
    .addr_ip       (i_addr2),
    .auser_ip      (i_auser2),
    .trans_ip      (i_trans2),
    .write_ip      (i_write2),
    .size_ip       (i_size2),
    .burst_ip      (i_burst2),
    .prot_ip       (i_prot2),
    .master_ip     (i_master2),
    .mastlock_ip   (i_mastlock2),
    .held_tran_ip   (i_held_tran2)

    );


  // Input stage for SI3
  cmsdk_MyInputName u_cmsdk_MyInputName_3 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS8),
    .HADDRS     (HADDRS8),
    .HTRANSS    (HTRANSS8),
    .HWRITES    (HWRITES8),
    .HSIZES     (HSIZES8),
    .HBURSTS    (HBURSTS8),
    .HPROTS     (HPROTS8),
    .HMASTERS   (HMASTERS8),
    .HMASTLOCKS (HMASTLOCKS8),
    .HREADYS    (HREADYS8),
    .HAUSERS    (HAUSERS8),

    // Internal Response
    .active_ip     (i_active3),
    .readyout_ip   (i_readyout3),
    .resp_ip       (i_resp3),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS8),
    .HRESPS     (HRESPS8),

    // Internal Address/Control Signals
    .sel_ip        (i_sel3),
    .addr_ip       (i_addr3),
    .auser_ip      (i_auser3),
    .trans_ip      (i_trans3),
    .write_ip      (i_write3),
    .size_ip       (i_size3),
    .burst_ip      (i_burst3),
    .prot_ip       (i_prot3),
    .master_ip     (i_master3),
    .mastlock_ip   (i_mastlock3),
    .held_tran_ip   (i_held_tran3)

    );


  // Input stage for SI4
  cmsdk_MyInputName u_cmsdk_MyInputName_4 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS9),
    .HADDRS     (HADDRS9),
    .HTRANSS    (HTRANSS9),
    .HWRITES    (HWRITES9),
    .HSIZES     (HSIZES9),
    .HBURSTS    (HBURSTS9),
    .HPROTS     (HPROTS9),
    .HMASTERS   (HMASTERS9),
    .HMASTLOCKS (HMASTLOCKS9),
    .HREADYS    (HREADYS9),
    .HAUSERS    (HAUSERS9),

    // Internal Response
    .active_ip     (i_active4),
    .readyout_ip   (i_readyout4),
    .resp_ip       (i_resp4),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS9),
    .HRESPS     (HRESPS9),

    // Internal Address/Control Signals
    .sel_ip        (i_sel4),
    .addr_ip       (i_addr4),
    .auser_ip      (i_auser4),
    .trans_ip      (i_trans4),
    .write_ip      (i_write4),
    .size_ip       (i_size4),
    .burst_ip      (i_burst4),
    .prot_ip       (i_prot4),
    .master_ip     (i_master4),
    .mastlock_ip   (i_mastlock4),
    .held_tran_ip   (i_held_tran4)

    );


  // Matrix decoder for SI0
  cmsdk_MyDecoderNameS5 u_cmsdk_mydecodernames5 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( REMAP[0] ),

    // Signals from Input stage SI0
    .HREADYS    (HREADYS5),
    .sel_dec        (i_sel0),
    .decode_addr_dec (i_addr0[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans0),

    // Control/Response for Output Stage MI0
    .active_dec0    (i_active0to0),
    .readyout_dec0  (i_hready_mux_m0),
    .resp_dec0      (HRESPM0),
    .rdata_dec0     (HRDATAM0),
    .ruser_dec0     (HRUSERM0),

    .sel_dec0       (i_sel0to0),

    .active_dec     (i_active0),
    .HREADYOUTS (i_readyout0),
    .HRESPS     (i_resp0),
    .HRUSERS    (HRUSERS5),
    .HRDATAS    (HRDATAS5)

    );


  // Matrix decoder for SI1
  cmsdk_MyDecoderNameS6 u_cmsdk_mydecodernames6 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( REMAP[0] ),

    // Signals from Input stage SI1
    .HREADYS    (HREADYS6),
    .sel_dec        (i_sel1),
    .decode_addr_dec (i_addr1[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans1),

    // Control/Response for Output Stage MI0
    .active_dec0    (i_active1to0),
    .readyout_dec0  (i_hready_mux_m0),
    .resp_dec0      (HRESPM0),
    .rdata_dec0     (HRDATAM0),
    .ruser_dec0     (HRUSERM0),

    .sel_dec0       (i_sel1to0),

    .active_dec     (i_active1),
    .HREADYOUTS (i_readyout1),
    .HRESPS     (i_resp1),
    .HRUSERS    (HRUSERS6),
    .HRDATAS    (HRDATAS6)

    );


  // Matrix decoder for SI2
  cmsdk_MyDecoderNameS7 u_cmsdk_mydecodernames7 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( REMAP[0] ),

    // Signals from Input stage SI2
    .HREADYS    (HREADYS7),
    .sel_dec        (i_sel2),
    .decode_addr_dec (i_addr2[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans2),

    // Control/Response for Output Stage MI0
    .active_dec0    (i_active2to0),
    .readyout_dec0  (i_hready_mux_m0),
    .resp_dec0      (HRESPM0),
    .rdata_dec0     (HRDATAM0),
    .ruser_dec0     (HRUSERM0),

    .sel_dec0       (i_sel2to0),

    .active_dec     (i_active2),
    .HREADYOUTS (i_readyout2),
    .HRESPS     (i_resp2),
    .HRUSERS    (HRUSERS7),
    .HRDATAS    (HRDATAS7)

    );


  // Matrix decoder for SI3
  cmsdk_MyDecoderNameS8 u_cmsdk_mydecodernames8 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( REMAP[0] ),

    // Signals from Input stage SI3
    .HREADYS    (HREADYS8),
    .sel_dec        (i_sel3),
    .decode_addr_dec (i_addr3[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans3),

    // Control/Response for Output Stage MI0
    .active_dec0    (i_active3to0),
    .readyout_dec0  (i_hready_mux_m0),
    .resp_dec0      (HRESPM0),
    .rdata_dec0     (HRDATAM0),
    .ruser_dec0     (HRUSERM0),

    .sel_dec0       (i_sel3to0),

    .active_dec     (i_active3),
    .HREADYOUTS (i_readyout3),
    .HRESPS     (i_resp3),
    .HRUSERS    (HRUSERS8),
    .HRDATAS    (HRDATAS8)

    );


  // Matrix decoder for SI4
  cmsdk_MyDecoderNameS9 u_cmsdk_mydecodernames9 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( REMAP[0] ),

    // Signals from Input stage SI4
    .HREADYS    (HREADYS9),
    .sel_dec        (i_sel4),
    .decode_addr_dec (i_addr4[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans4),

    // Control/Response for Output Stage MI0
    .active_dec0    (i_active4to0),
    .readyout_dec0  (i_hready_mux_m0),
    .resp_dec0      (HRESPM0),
    .rdata_dec0     (HRDATAM0),
    .ruser_dec0     (HRUSERM0),

    .sel_dec0       (i_sel4to0),

    .active_dec     (i_active4),
    .HREADYOUTS (i_readyout4),
    .HRESPS     (i_resp4),
    .HRUSERS    (HRUSERS9),
    .HRDATAS    (HRDATAS9)

    );


  // Output stage for MI0
  cmsdk_MyOutputName u_cmsdk_myoutputname_0 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 0 Signals
    .sel_op0       (i_sel0to0),
    .addr_op0      (i_addr0),
    .auser_op0     (i_auser0),
    .trans_op0     (i_trans0),
    .write_op0     (i_write0),
    .size_op0      (i_size0),
    .burst_op0     (i_burst0),
    .prot_op0      (i_prot0),
    .master_op0    (i_master0),
    .mastlock_op0  (i_mastlock0),
    .wdata_op0     (HWDATAS5),
    .wuser_op0     (HWUSERS5),
    .held_tran_op0  (i_held_tran0),

    // Port 1 Signals
    .sel_op1       (i_sel1to0),
    .addr_op1      (i_addr1),
    .auser_op1     (i_auser1),
    .trans_op1     (i_trans1),
    .write_op1     (i_write1),
    .size_op1      (i_size1),
    .burst_op1     (i_burst1),
    .prot_op1      (i_prot1),
    .master_op1    (i_master1),
    .mastlock_op1  (i_mastlock1),
    .wdata_op1     (HWDATAS6),
    .wuser_op1     (HWUSERS6),
    .held_tran_op1  (i_held_tran1),

    // Port 2 Signals
    .sel_op2       (i_sel2to0),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS7),
    .wuser_op2     (HWUSERS7),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to0),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS8),
    .wuser_op3     (HWUSERS8),
    .held_tran_op3  (i_held_tran3),

    // Port 4 Signals
    .sel_op4       (i_sel4to0),
    .addr_op4      (i_addr4),
    .auser_op4     (i_auser4),
    .trans_op4     (i_trans4),
    .write_op4     (i_write4),
    .size_op4      (i_size4),
    .burst_op4     (i_burst4),
    .prot_op4      (i_prot4),
    .master_op4    (i_master4),
    .mastlock_op4  (i_mastlock4),
    .wdata_op4     (HWDATAS9),
    .wuser_op4     (HWUSERS9),
    .held_tran_op4  (i_held_tran4),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM0),

    .active_op0    (i_active0to0),
    .active_op1    (i_active1to0),
    .active_op2    (i_active2to0),
    .active_op3    (i_active3to0),
    .active_op4    (i_active4to0),

    // Slave Address/Control Signals
    .HSELM      (HSELM0),
    .HADDRM     (HADDRM0),
    .HAUSERM    (HAUSERM0),
    .HTRANSM    (HTRANSM0),
    .HWRITEM    (HWRITEM0),
    .HSIZEM     (HSIZEM0),
    .HBURSTM    (HBURSTM0),
    .HPROTM     (HPROTM0),
    .HMASTERM   (HMASTERM0),
    .HMASTLOCKM (HMASTLOCKM0),
    .HREADYMUXM (i_hready_mux_m0),
    .HWUSERM    (HWUSERM0),
    .HWDATAM    (HWDATAM0)

    );

  // Drive output with internal version
  assign HREADYMUXM0 = i_hready_mux_m0;


endmodule

// --================================= End ===================================--
