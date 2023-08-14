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
//  Abstract            : BusMatrixLite is a wrapper module that wraps around
//                        the BusMatrix module to give AHB Lite compliant
//                        slave and master interfaces.
//
//-----------------------------------------------------------------------------

`timescale 1ns/1ps

module cmsdk_MyBusMatrixName_lite (

    // Common AHB signals
    HCLK,
    HRESETn,

    // System Address Remap control
    REMAP,

    // Input port SI0 (inputs from master 0)
    HADDRS5,
    HTRANSS5,
    HWRITES5,
    HSIZES5,
    HBURSTS5,
    HPROTS5,
    HWDATAS5,
    HMASTLOCKS5,
    HAUSERS5,
    HWUSERS5,

    // Input port SI1 (inputs from master 1)
    HADDRS6,
    HTRANSS6,
    HWRITES6,
    HSIZES6,
    HBURSTS6,
    HPROTS6,
    HWDATAS6,
    HMASTLOCKS6,
    HAUSERS6,
    HWUSERS6,

    // Input port SI2 (inputs from master 2)
    HADDRS7,
    HTRANSS7,
    HWRITES7,
    HSIZES7,
    HBURSTS7,
    HPROTS7,
    HWDATAS7,
    HMASTLOCKS7,
    HAUSERS7,
    HWUSERS7,

    // Input port SI3 (inputs from master 3)
    HADDRS8,
    HTRANSS8,
    HWRITES8,
    HSIZES8,
    HBURSTS8,
    HPROTS8,
    HWDATAS8,
    HMASTLOCKS8,
    HAUSERS8,
    HWUSERS8,

    // Input port SI4 (inputs from master 4)
    HADDRS9,
    HTRANSS9,
    HWRITES9,
    HSIZES9,
    HBURSTS9,
    HPROTS9,
    HWDATAS9,
    HMASTLOCKS9,
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
    HWDATAM0,
    HMASTLOCKM0,
    HREADYMUXM0,
    HAUSERM0,
    HWUSERM0,

    // Input port SI0 (outputs to master 0)
    HRDATAS5,
    HREADYS5,
    HRESPS5,
    HRUSERS5,

    // Input port SI1 (outputs to master 1)
    HRDATAS6,
    HREADYS6,
    HRESPS6,
    HRUSERS6,

    // Input port SI2 (outputs to master 2)
    HRDATAS7,
    HREADYS7,
    HRESPS7,
    HRUSERS7,

    // Input port SI3 (outputs to master 3)
    HRDATAS8,
    HREADYS8,
    HRESPS8,
    HRUSERS8,

    // Input port SI4 (outputs to master 4)
    HRDATAS9,
    HREADYS9,
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

    // System Address Remap control
    input   [3:0] REMAP;           // System Address REMAP control

    // Input port SI0 (inputs from master 0)
    input  [31:0] HADDRS5;         // Address bus
    input   [1:0] HTRANSS5;        // Transfer type
    input         HWRITES5;        // Transfer direction
    input   [2:0] HSIZES5;         // Transfer size
    input   [2:0] HBURSTS5;        // Burst type
    input   [3:0] HPROTS5;         // Protection control
    input  [31:0] HWDATAS5;        // Write data
    input         HMASTLOCKS5;     // Locked Sequence
    input  [31:0] HAUSERS5;        // Address USER signals
    input  [31:0] HWUSERS5;        // Write-data USER signals

    // Input port SI1 (inputs from master 1)
    input  [31:0] HADDRS6;         // Address bus
    input   [1:0] HTRANSS6;        // Transfer type
    input         HWRITES6;        // Transfer direction
    input   [2:0] HSIZES6;         // Transfer size
    input   [2:0] HBURSTS6;        // Burst type
    input   [3:0] HPROTS6;         // Protection control
    input  [31:0] HWDATAS6;        // Write data
    input         HMASTLOCKS6;     // Locked Sequence
    input  [31:0] HAUSERS6;        // Address USER signals
    input  [31:0] HWUSERS6;        // Write-data USER signals

    // Input port SI2 (inputs from master 2)
    input  [31:0] HADDRS7;         // Address bus
    input   [1:0] HTRANSS7;        // Transfer type
    input         HWRITES7;        // Transfer direction
    input   [2:0] HSIZES7;         // Transfer size
    input   [2:0] HBURSTS7;        // Burst type
    input   [3:0] HPROTS7;         // Protection control
    input  [31:0] HWDATAS7;        // Write data
    input         HMASTLOCKS7;     // Locked Sequence
    input  [31:0] HAUSERS7;        // Address USER signals
    input  [31:0] HWUSERS7;        // Write-data USER signals

    // Input port SI3 (inputs from master 3)
    input  [31:0] HADDRS8;         // Address bus
    input   [1:0] HTRANSS8;        // Transfer type
    input         HWRITES8;        // Transfer direction
    input   [2:0] HSIZES8;         // Transfer size
    input   [2:0] HBURSTS8;        // Burst type
    input   [3:0] HPROTS8;         // Protection control
    input  [31:0] HWDATAS8;        // Write data
    input         HMASTLOCKS8;     // Locked Sequence
    input  [31:0] HAUSERS8;        // Address USER signals
    input  [31:0] HWUSERS8;        // Write-data USER signals

    // Input port SI4 (inputs from master 4)
    input  [31:0] HADDRS9;         // Address bus
    input   [1:0] HTRANSS9;        // Transfer type
    input         HWRITES9;        // Transfer direction
    input   [2:0] HSIZES9;         // Transfer size
    input   [2:0] HBURSTS9;        // Burst type
    input   [3:0] HPROTS9;         // Protection control
    input  [31:0] HWDATAS9;        // Write data
    input         HMASTLOCKS9;     // Locked Sequence
    input  [31:0] HAUSERS9;        // Address USER signals
    input  [31:0] HWUSERS9;        // Write-data USER signals

    // Output port MI0 (inputs from slave 0)
    input  [31:0] HRDATAM0;        // Read data bus
    input         HREADYOUTM0;     // HREADY feedback
    input         HRESPM0;         // Transfer response
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
    output [31:0] HWDATAM0;        // Write data
    output        HMASTLOCKM0;     // Locked Sequence
    output        HREADYMUXM0;     // Transfer done
    output [31:0] HAUSERM0;        // Address USER signals
    output [31:0] HWUSERM0;        // Write-data USER signals

    // Input port SI0 (outputs to master 0)
    output [31:0] HRDATAS5;        // Read data bus
    output        HREADYS5;     // HREADY feedback
    output        HRESPS5;         // Transfer response
    output [31:0] HRUSERS5;        // Read-data USER signals

    // Input port SI1 (outputs to master 1)
    output [31:0] HRDATAS6;        // Read data bus
    output        HREADYS6;     // HREADY feedback
    output        HRESPS6;         // Transfer response
    output [31:0] HRUSERS6;        // Read-data USER signals

    // Input port SI2 (outputs to master 2)
    output [31:0] HRDATAS7;        // Read data bus
    output        HREADYS7;     // HREADY feedback
    output        HRESPS7;         // Transfer response
    output [31:0] HRUSERS7;        // Read-data USER signals

    // Input port SI3 (outputs to master 3)
    output [31:0] HRDATAS8;        // Read data bus
    output        HREADYS8;     // HREADY feedback
    output        HRESPS8;         // Transfer response
    output [31:0] HRUSERS8;        // Read-data USER signals

    // Input port SI4 (outputs to master 4)
    output [31:0] HRDATAS9;        // Read data bus
    output        HREADYS9;     // HREADY feedback
    output        HRESPS9;         // Transfer response
    output [31:0] HRUSERS9;        // Read-data USER signals

    // Scan test dummy signals; not connected until scan insertion
    output        SCANOUTHCLK;     // Scan Chain Output

// -----------------------------------------------------------------------------
// Wire declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    wire         HCLK;            // AHB System Clock
    wire         HRESETn;         // AHB System Reset

    // System Address Remap control
    wire   [3:0] REMAP;           // System REMAP signal

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


// -----------------------------------------------------------------------------
// Signal declarations
// -----------------------------------------------------------------------------
    wire   [3:0] tie_hi_4;
    wire         tie_hi;
    wire         tie_low;
    wire   [1:0] i_hrespS5;
    wire   [1:0] i_hrespS6;
    wire   [1:0] i_hrespS7;
    wire   [1:0] i_hrespS8;
    wire   [1:0] i_hrespS9;

    wire   [3:0]        i_hmasterM0;
    wire   [1:0] i_hrespM0;

// -----------------------------------------------------------------------------
// Beginning of main code
// -----------------------------------------------------------------------------

    assign tie_hi   = 1'b1;
    assign tie_hi_4 = 4'b1111;
    assign tie_low  = 1'b0;


    assign HRESPS5  = i_hrespS5[0];

    assign HRESPS6  = i_hrespS6[0];

    assign HRESPS7  = i_hrespS7[0];

    assign HRESPS8  = i_hrespS8[0];

    assign HRESPS9  = i_hrespS9[0];

    assign i_hrespM0 = {tie_low, HRESPM0};

// BusMatrix instance
  cmsdk_MyBusMatrixName ucmsdk_MyBusMatrixName (
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),
    .REMAP      (REMAP),

    // Input port SI0 signals
    .HSELS5       (tie_hi),
    .HADDRS5      (HADDRS5),
    .HTRANSS5     (HTRANSS5),
    .HWRITES5     (HWRITES5),
    .HSIZES5      (HSIZES5),
    .HBURSTS5     (HBURSTS5),
    .HPROTS5      (HPROTS5),
    .HWDATAS5     (HWDATAS5),
    .HMASTLOCKS5  (HMASTLOCKS5),
    .HMASTERS5    (tie_hi_4),
    .HREADYS5     (HREADYS5),
    .HAUSERS5     (HAUSERS5),
    .HWUSERS5     (HWUSERS5),
    .HRDATAS5     (HRDATAS5),
    .HREADYOUTS5  (HREADYS5),
    .HRESPS5      (i_hrespS5),
    .HRUSERS5     (HRUSERS5),

    // Input port SI1 signals
    .HSELS6       (tie_hi),
    .HADDRS6      (HADDRS6),
    .HTRANSS6     (HTRANSS6),
    .HWRITES6     (HWRITES6),
    .HSIZES6      (HSIZES6),
    .HBURSTS6     (HBURSTS6),
    .HPROTS6      (HPROTS6),
    .HWDATAS6     (HWDATAS6),
    .HMASTLOCKS6  (HMASTLOCKS6),
    .HMASTERS6    (tie_hi_4),
    .HREADYS6     (HREADYS6),
    .HAUSERS6     (HAUSERS6),
    .HWUSERS6     (HWUSERS6),
    .HRDATAS6     (HRDATAS6),
    .HREADYOUTS6  (HREADYS6),
    .HRESPS6      (i_hrespS6),
    .HRUSERS6     (HRUSERS6),

    // Input port SI2 signals
    .HSELS7       (tie_hi),
    .HADDRS7      (HADDRS7),
    .HTRANSS7     (HTRANSS7),
    .HWRITES7     (HWRITES7),
    .HSIZES7      (HSIZES7),
    .HBURSTS7     (HBURSTS7),
    .HPROTS7      (HPROTS7),
    .HWDATAS7     (HWDATAS7),
    .HMASTLOCKS7  (HMASTLOCKS7),
    .HMASTERS7    (tie_hi_4),
    .HREADYS7     (HREADYS7),
    .HAUSERS7     (HAUSERS7),
    .HWUSERS7     (HWUSERS7),
    .HRDATAS7     (HRDATAS7),
    .HREADYOUTS7  (HREADYS7),
    .HRESPS7      (i_hrespS7),
    .HRUSERS7     (HRUSERS7),

    // Input port SI3 signals
    .HSELS8       (tie_hi),
    .HADDRS8      (HADDRS8),
    .HTRANSS8     (HTRANSS8),
    .HWRITES8     (HWRITES8),
    .HSIZES8      (HSIZES8),
    .HBURSTS8     (HBURSTS8),
    .HPROTS8      (HPROTS8),
    .HWDATAS8     (HWDATAS8),
    .HMASTLOCKS8  (HMASTLOCKS8),
    .HMASTERS8    (tie_hi_4),
    .HREADYS8     (HREADYS8),
    .HAUSERS8     (HAUSERS8),
    .HWUSERS8     (HWUSERS8),
    .HRDATAS8     (HRDATAS8),
    .HREADYOUTS8  (HREADYS8),
    .HRESPS8      (i_hrespS8),
    .HRUSERS8     (HRUSERS8),

    // Input port SI4 signals
    .HSELS9       (tie_hi),
    .HADDRS9      (HADDRS9),
    .HTRANSS9     (HTRANSS9),
    .HWRITES9     (HWRITES9),
    .HSIZES9      (HSIZES9),
    .HBURSTS9     (HBURSTS9),
    .HPROTS9      (HPROTS9),
    .HWDATAS9     (HWDATAS9),
    .HMASTLOCKS9  (HMASTLOCKS9),
    .HMASTERS9    (tie_hi_4),
    .HREADYS9     (HREADYS9),
    .HAUSERS9     (HAUSERS9),
    .HWUSERS9     (HWUSERS9),
    .HRDATAS9     (HRDATAS9),
    .HREADYOUTS9  (HREADYS9),
    .HRESPS9      (i_hrespS9),
    .HRUSERS9     (HRUSERS9),


    // Output port MI0 signals
    .HSELM0       (HSELM0),
    .HADDRM0      (HADDRM0),
    .HTRANSM0     (HTRANSM0),
    .HWRITEM0     (HWRITEM0),
    .HSIZEM0      (HSIZEM0),
    .HBURSTM0     (HBURSTM0),
    .HPROTM0      (HPROTM0),
    .HWDATAM0     (HWDATAM0),
    .HMASTERM0    (i_hmasterM0),
    .HMASTLOCKM0  (HMASTLOCKM0),
    .HREADYMUXM0  (HREADYMUXM0),
    .HAUSERM0     (HAUSERM0),
    .HWUSERM0     (HWUSERM0),
    .HRDATAM0     (HRDATAM0),
    .HREADYOUTM0  (HREADYOUTM0),
    .HRESPM0      (i_hrespM0),
    .HRUSERM0     (HRUSERM0),


    // Scan test dummy signals; not connected until scan insertion
    .SCANENABLE            (SCANENABLE),
    .SCANINHCLK            (SCANINHCLK),
    .SCANOUTHCLK           (SCANOUTHCLK)
  );


endmodule
