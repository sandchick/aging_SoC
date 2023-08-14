#记录DC过程中对RTL做的修改，给后面形式验证等step提供
set_svf "read_rtl.svf"

#set TOP_LEVEL e203_cpu_top
set TOP_LEVEL aging_SoC_top

#读入RTL，语法分析
analyze -f sverilog {../rtl/aging_sensor/aging2uart.v
../rtl/aging_sensor/aging_sensor.v
../rtl/aging_sensor/aging_sensor_top.v
../rtl/aging_sensor/clkuart_gen.v
../rtl/aging_sensor/FIFO_Aging.v
../rtl/aging_sensor/mbit_counter.v
../rtl/aging_sensor/monitor.v
../rtl/aging_sensor/sig_extrator.v
../rtl/aging_sensor/timer.v
../rtl/aging_sensor/uart_rx.v
../rtl/aging_sensor/UART_TX.v
../rtl/ahb_matrix/cmsdk_MyArbiterName.v
../rtl/ahb_matrix/cmsdk_MyBusMatrixName.v
../rtl/ahb_matrix/cmsdk_MyBusMatrixName_default_slave.v
../rtl/ahb_matrix/cmsdk_MyBusMatrixName_lite.v
../rtl/ahb_matrix/cmsdk_MyDecoderNameS5.v
../rtl/ahb_matrix/cmsdk_MyDecoderNameS6.v
../rtl/ahb_matrix/cmsdk_MyDecoderNameS7.v
../rtl/ahb_matrix/cmsdk_MyDecoderNameS8.v
../rtl/ahb_matrix/cmsdk_MyDecoderNameS9.v
../rtl/ahb_matrix/cmsdk_MyInputName.v
../rtl/ahb_matrix/cmsdk_MyOutputName.v
../rtl/common/aging_SoC_top.v
../rtl/common/clk_aligner.v
../rtl/common/clk_divider.v
../rtl/common/cpu_sub_system_ahb.v
../rtl/common/pmu.v
../rtl/common/px_had_sync.v
../rtl/common/soc_gated_clk_cell.v
../rtl/common/sync.v
../rtl/common/tap2_sm.v
../rtl/cpu/biu/rtl/cr_ahbl_if.v
../rtl/cpu/biu/rtl/cr_ahbl_req_arb.v
../rtl/cpu/biu/rtl/cr_iahbl_top.v
../rtl/cpu/biu/rtl/cr_sahbl_top.v
../rtl/cpu/bmu/rtl/cr_bmu_dbus_if.v
../rtl/cpu/bmu/rtl/cr_bmu_ibus_if.v
../rtl/cpu/bmu/rtl/cr_bmu_top.v
../rtl/cpu/clic/rtl/cr_clic_arb.v
../rtl/cpu/clic/rtl/cr_clic_arb_kernel.v
../rtl/cpu/clic/rtl/cr_clic_busif.v
../rtl/cpu/clic/rtl/cr_clic_ctrl.v
../rtl/cpu/clic/rtl/cr_clic_ff1_onehot.v
../rtl/cpu/clic/rtl/cr_clic_kid.v
../rtl/cpu/clic/rtl/cr_clic_kid_dummy.v
../rtl/cpu/clic/rtl/cr_clic_sel.v
../rtl/cpu/clic/rtl/cr_clic_top.v
../rtl/cpu/clint/rtl/cr_clint_busif.v
../rtl/cpu/clint/rtl/cr_clint_regs.v
../rtl/cpu/clint/rtl/cr_clint_top.v
../rtl/cpu/clk/rtl/cr_clkrst_top.v
../rtl/cpu/clk/rtl/cr_clk_top.v
../rtl/cpu/clk/rtl/gated_clk_cell.v
../rtl/cpu/coretim/rtl/cr_coretim_top_dummy.v
../rtl/cpu/cp0/rtl/cr_cp0_iui.v
../rtl/cpu/cp0/rtl/cr_cp0_lpmd.v
../rtl/cpu/cp0/rtl/cr_cp0_oreg.v
../rtl/cpu/cp0/rtl/cr_cp0_randclk.v
../rtl/cpu/cp0/rtl/cr_cp0_srst.v
../rtl/cpu/cp0/rtl/cr_cp0_status.v
../rtl/cpu/cp0/rtl/cr_cp0_top.v
../rtl/cpu/cpu/rtl/clic_kid_golden_ports.v
../rtl/cpu/cpu/rtl/cr_core.v
../rtl/cpu/cpu/rtl/cr_core_top.v
../rtl/cpu/cpu/rtl/cr_sys_io.v
../rtl/cpu/cpu/rtl/openE902.v
../rtl/cpu/had/rtl/cr_had_bkpt.v
../rtl/cpu/had/rtl/cr_had_ctrl.v
../rtl/cpu/had/rtl/cr_had_ddc.v
../rtl/cpu/had/rtl/cr_had_inst_bkpt_lite.v
../rtl/cpu/had/rtl/cr_had_jtag2.v
../rtl/cpu/had/rtl/cr_had_pin.v
../rtl/cpu/had/rtl/cr_had_regs.v
../rtl/cpu/had/rtl/cr_had_sync.v
../rtl/cpu/had/rtl/cr_had_sync_level.v
../rtl/cpu/had/rtl/cr_had_top.v
../rtl/cpu/had/rtl/cr_had_trace.v
../rtl/cpu/ifu/rtl/cr_ifu_ibuf.v
../rtl/cpu/ifu/rtl/cr_ifu_ibuf_entry.v
../rtl/cpu/ifu/rtl/cr_ifu_ibusif.v
../rtl/cpu/ifu/rtl/cr_ifu_ifctrl.v
../rtl/cpu/ifu/rtl/cr_ifu_ifdp.v
../rtl/cpu/ifu/rtl/cr_ifu_randclk.v
../rtl/cpu/ifu/rtl/cr_ifu_top.v
../rtl/cpu/iu/rtl/cr_iu_alu.v
../rtl/cpu/iu/rtl/cr_iu_branch.v
../rtl/cpu/iu/rtl/cr_iu_ctrl.v
../rtl/cpu/iu/rtl/cr_iu_decd.v
../rtl/cpu/iu/rtl/cr_iu_gated_clk_reg.v
../rtl/cpu/iu/rtl/cr_iu_gated_clk_reg_timing.v
../rtl/cpu/iu/rtl/cr_iu_hs_split.v
../rtl/cpu/iu/rtl/cr_iu_lockup.v
../rtl/cpu/iu/rtl/cr_iu_mad.v
../rtl/cpu/iu/rtl/cr_iu_oper.v
../rtl/cpu/iu/rtl/cr_iu_oper_gpr.v
../rtl/cpu/iu/rtl/cr_iu_pcgen.v
../rtl/cpu/iu/rtl/cr_iu_randclk.v
../rtl/cpu/iu/rtl/cr_iu_rbus.v
../rtl/cpu/iu/rtl/cr_iu_retire.v
../rtl/cpu/iu/rtl/cr_iu_special.v
../rtl/cpu/iu/rtl/cr_iu_top.v
../rtl/cpu/iu/rtl/cr_iu_vector.v
../rtl/cpu/iu/rtl/cr_iu_wb.v
../rtl/cpu/lsu/rtl/cr_lsu_ctrl.v
../rtl/cpu/lsu/rtl/cr_lsu_dp.v
../rtl/cpu/lsu/rtl/cr_lsu_randclk.v
../rtl/cpu/lsu/rtl/cr_lsu_top.v
../rtl/cpu/lsu/rtl/cr_lsu_unalign.v
../rtl/cpu/pmp/rtl/cr_pmp_acc_arb.v
../rtl/cpu/pmp/rtl/cr_pmp_comp_hit.v
../rtl/cpu/pmp/rtl/cr_pmp_enc.v
../rtl/cpu/pmp/rtl/cr_pmp_regs.v
../rtl/cpu/pmp/rtl/cr_pmp_top.v
../rtl/cpu/pwrm/rtl/cr_pwrm_top_dummy.v
../rtl/cpu/rst/rtl/cr_rst_top.v
../rtl/cpu/tcipif/rtl/cr_tcipif_behavior_bus.v
../rtl/cpu/tcipif/rtl/cr_tcipif_dummy_bus.v
../rtl/cpu/tcipif/rtl/cr_tcipif_top.v
../rtl/head/define.v
../rtl/mem/iahb_mem_ctrl.v
../rtl/mem/mem_ctrl.v
../rtl/mem/soc_fpga_ram.v
../rtl/readoutnet/AutoBoot.v
../rtl/readoutnet/CounterControl.v
../rtl/readoutnet/DaughterBoard.v
../rtl/readoutnet/Emit.v
../rtl/readoutnet/iicm.v
../rtl/readoutnet/level_counter.v
../rtl/readoutnet/LogicMap.v
../rtl/readoutnet/LogicNI.v
../rtl/readoutnet/LogicNIALU.v
../rtl/readoutnet/LogicRegion.v
../rtl/readoutnet/LUT1.v
../rtl/readoutnet/MemoryNI.v
../rtl/readoutnet/MNoC.v
../rtl/readoutnet/NetworkInterface.v
../rtl/readoutnet/NetworkInterfaceALU.v
../rtl/readoutnet/OscSample.v
../rtl/readoutnet/RingOscillator.v
../rtl/readoutnet/RoutCalc.v
../rtl/readoutnet/Router2x1.v
../rtl/readoutnet/Router3x1.v
../rtl/readoutnet/SampleControl.v
../rtl/readoutnet/SoCRegion.v
../rtl/readoutnet/spcounter.v
../rtl/readoutnet/SRAM.v
../rtl/readoutnet/Stress.v
../rtl/readoutnet/SwAlloc2x1.v
../rtl/readoutnet/SwAlloc3x1.v
../rtl/readoutnet/UartClk.v
../rtl/readoutnet/UartNI.v
../rtl/readoutnet/UartRx.v
../rtl/readoutnet/UartTx.v
../rtl/readoutnet/VoltageCtrl.v
../rtl/readoutnet/VoltageDriver.v
../rtl/readoutnet/DW_fifo_s1_sf_inst.v
../rtl/readoutnet/DW_ram_r_w_s_dff_inst.v
../rtl/readoutnet/v_dec.v}
#构建层次关系
elaborate aging_SoC_top > ../rpt/elaborate.log

current_design aging_SoC_top 
#检查综合工程中是否缺少子模块
link
which sram.db
if {[link] == 0} {
    #echo "Link Error"
    exit
}

#例化模块的名字修改
uniquify

#网表中可能存在assign语句，这会对布局布线产生影响,可能原因有：1.多个输出port连接在一个内部net上; 2.从输入port不经过任何逻辑直接到输出port上; 3.三态门引起的assign
#为了解决1和2，可以在综合前使用如下语句
set_fix_multiple_port_nets -all -buffer_constants

check_design > ../rpt/check_design.log

#GTECH网表
write -f verilog -hier -output ../out/${TOP_LEVEL}_pre.v
write -f ddc -hier -output ../out/${TOP_LEVEL}_pre.ddc

