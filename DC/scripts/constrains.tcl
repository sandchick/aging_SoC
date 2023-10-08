#--------------------------- wire ---------------------------
#线性负载模型
set_wire_load_mode  top
set_app_var auto_wire_load_selection true

#--------------------------- clock ---------------------------
create_clock -name clk -period 10 [get_ports i_pad_clk]

#DC不会综合时钟树，时钟树综合由后端完成
set_dont_touch_network [get_clocks i_pad_clk]
set_ideal_network [get_clocks i_pad_clk]
set_drive 0 [get_clocks i_pad_clk]

#设置时钟电平转换的时间
set_clock_transition -max 0.1 [get_clocks i_pad_clk]

#无时钟树的情况下，hold time没有意义，所以DC只分析setup time
#时钟到达各个寄存器的时间不同，被称为skew; 时钟在各个周期到达的时间不同，被称为jitter; 为后续设计留下一定时序余量，称为margin; skew jitter margin共同组成了uncertainty
set_clock_uncertainty -setup 0.1 [get_clocks i_pad_clk]

#源到时钟port的延迟
set_clock_latency -source -max 0 [get_clocks i_pad_clk]
#时钟port到内部cell的延迟
set_clock_latency -max 0.1 [get_clocks i_pad_clk]

#如果对时钟进行了分频，需要指定分频后的时钟;将FF1的输出Q作为分频后的时钟,分频系数是4,分频时钟不会继承原时钟的约束，需要额外约束分频时钟
#creat_generated_clock -divied_by 4 -name CLK_DIV -source [get_ports clk] [get_pins FF1/Q]



create_clock -name i_pad_clk_net -period 2 [get_ports i_pad_clk_net]

set_dont_touch_network [get_clocks i_pad_clk_net]
set_ideal_network [get_clocks i_pad_clk_net]
set_drive 0 [get_clocks i_pad_clk_net]

set_clock_transition -max 0.1 [get_clocks i_pad_clk_net]
set_clock_uncertainty -setup 0.1 [get_clocks i_pad_clk_net]
set_clock_latency -source -max 0 [get_clocks i_pad_clk_net]
set_clock_latency -max 0.1 [get_clocks i_pad_clk_net]

create_clock -name i_pad_clk_net -period 33 [get_ports i_pad_jtg_tclk]

set_dont_touch_network [get_clocks i_pad_jtg_tclk]
set_ideal_network [get_clocks i_pad_jtg_tclk]
set_drive 0 [get_clocks i_pad_jtg_tclk]

set_clock_transition -max 0.1 [get_clocks i_pad_jtg_tclk]
set_clock_uncertainty -setup 0.1 [get_clocks i_pad_jtg_tclk]
set_clock_latency -source -max 0 [get_clocks i_pad_jtg_tclk]
set_clock_latency -max 0.1 [get_clocks i_pad_jtg_tclk]


#如果设计内存在异步时钟，其异步接口应该在设计时保证功能正确,所以综合时不需要约束异步接口,这时可以将异步路径false掉，让DC不分析异步时钟之间的路径
set_false_path -from [get_clocks i_pad_clk] -to [get_clocks i_pad_clk_net]
set_false_path -from [get_clocks i_pad_clk] -to [get_clocks i_pad_jtg_tclk]
set_false_path -from [get_clocks i_pad_clk_net] -to [get_clocks i_pad_clk]
set_false_path -from [get_clocks i_pad_clk_net] -to [get_clocks i_pad_jtg_tclk]
set_false_path -from [get_clocks i_pad_jtg_tclk] -to [get_clocks i_pad_clk]
set_false_path -from [get_clocks i_pad_jtg_tclk] -to [get_clocks i_pad_clk_net]
#更加便捷的方式是，直接将它们指定为异步时钟
set_clock_groups -asynchronous -group i_pad_clk -group i_pad_clk_net
set_clock_groups -asynchronous -group i_pad_clk -group i_pad_jtg_tclk
set_clock_groups -asynchronous -group i_pad_clk_net -group i_pad_jtg_tclk

#---------------------- input & output ----------------------
#输入输出port延迟约束
#set_input_delay -max 60 -clock clk [remove_from_collection [all_inputs][get_ports clk]]
set_input_delay -max 6 -clock clk  [remove_from_collection [all_inputs][get_ports i_pad_clk][get_ports i_pad_clk_net]]
#set_input_delay -max 100 -clock clk [get_ports i_pc]
#set_input_delay -max 100 -clock clk [get_ports i_rs1idx]
#set_input_delay -max 100 -clock clk [get_ports i_rs2idx]
#set_output_delay -max 50 -clock clk [get_ports disp_o_alu_rs1]
#set_output_delay -max 50 -clock clk [get_ports disp_o_alu_rs2]
#set_output_delay -max 50 -clock clk [get_ports disp_o_alu_rdwen]
#set_output_delay -max 50 -clock clk [get_ports disp_o_alu_rdidx]
#set_output_delay -max 50 -clock clk [get_ports disp_o_alu_info]
#set_output_delay -max 50 -clock clk [get_ports disp_o_alu_pc]
#set_output_delay -max 6  -clock clk [get_ports sp_out]
set_output_delay -max 6  -clock clk [all_outputs]
remove_input_delay [get_ports i_pad_clk]
remove_input_delay [get_ports i_pad_clk_net]
remove_input_delay [get_ports i_pad_jtg_tclk]

set_dont_touch_network [get_ports i_pad_rst_b]
set_ideal_network [get_ports i_pad_rst_b]
set_drive 0 [get_ports i_pad_rst_b]
set_dont_touch_network [get_ports i_pad_jtag_rst_b]
set_ideal_network [get_ports i_pad_jtag_nrst_b]
set_drive 0 [get_ports i_pad_jtag_nrst_b]
#
##指定驱动input port信号的transition
#set_input_transition 0.1 {TestBoot}

#指定输出port的load
set_load 0.05 [all_outputs]

#如果design中有需要执行多个cycle的组合逻辑,可以设置multiple cycle path来约束
#指定path执行的周期是6,工具会在第6个时钟上升沿检查setup time，在第5个周期上升沿检查hold time
#set_multicycle_path -setup 6 -from {A_reg[*] B_reg[*]} -to C_reg[*]
#为了将hold time检查移至第0个周期上升沿，需要使用：
#set_multicycle_path -hold 5 -from {A_reg[*] B_reg[*]} -to C_reg[*]

#-------------------------- DRC ---------------------------
#set_max_transition 0.2 [current_design]
#set_max_fanout 200 [current_design]

#一般指定最大面积为0，以得到尽可能小的面积
set_max_area 0
