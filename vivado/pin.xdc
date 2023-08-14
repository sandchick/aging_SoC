##UART

#set_property PACKAGE_PIN Y22 [get_ports o_pad_txd]
set_property PACKAGE_PIN AB22 [get_ports o_pad_txd]

set_property IOSTANDARD LVCMOS33 [get_ports o_pad_txd]

#set_property PACKAGE_PIN AB22 [get_ports o_pad_txdl]
set_property PACKAGE_PIN Y22 [get_ports o_pad_txdl]

set_property IOSTANDARD LVCMOS33 [get_ports o_pad_txdl]

set_property PACKAGE_PIN Y21 [get_ports i_pad_RXD]

set_property IOSTANDARD  LVCMOS33 [get_ports i_pad_RXD]

##rst

set_property PACKAGE_PIN B16 [get_ports i_pad_rst_b]

set_property IOSTANDARD LVCMOS33 [get_ports i_pad_rst_b]
##led

set_property PACKAGE_PIN R19 [get_ports o_pad_led]

set_property IOSTANDARD LVCMOS33 [get_ports o_pad_led]

set_property PACKAGE_PIN T20 [get_ports o_pad_ledsp]

set_property IOSTANDARD LVCMOS33 [get_ports o_pad_ledsp]

set_property PACKAGE_PIN T21 [get_ports o_pad_led_iu]

set_property IOSTANDARD LVCMOS33 [get_ports o_pad_led_iu]
# v ctrl

set_property PACKAGE_PIN J19      [get_ports o_pad_scl]

set_property IOSTANDARD  LVCMOS33 [get_ports o_pad_scl]

set_property PACKAGE_PIN H19      [get_ports o_pad_sda]

set_property IOSTANDARD  LVCMOS33 [get_ports o_pad_sda]

##clk 50MHz

set_property PACKAGE_PIN K18 [get_ports i_pad_clk_net_clk50M]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_clk_net_clk50M] 
# cpu pad

set_property PACKAGE_PIN E14 [get_ports i_pad_jtg_nrst_b]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_nrst_b] 
set_property PACKAGE_PIN J20 [get_ports i_pad_jtg_tclk]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_tclk] 
set_property PACKAGE_PIN J21 [get_ports i_pad_jtg_tms]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_tms] 
set_property PACKAGE_PIN M15 [get_ports i_pad_jtg_trst_b]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_jtg_trst_b] 
set_property PACKAGE_PIN M16 [get_ports i_pad_uart0_sin]
set_property IOSTANDARD LVCMOS33 [get_ports i_pad_uart0_sin] 
set_property PACKAGE_PIN M13 [get_ports o_pad_uart0_sout]
set_property IOSTANDARD LVCMOS33 [get_ports o_pad_uart0_sout] 

##loop

#set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

##ALU PBLOCK

#create_pblock ALU_AGING01
#add_cells_to_pblock [get_pblocks ALU_AGING01] [get_cells InstLM/ALURegion/ALUAgingR01/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING01] [get_cells InstLM/ALURegion/ALUAgingR01/u_alu]
#resize_pblock [get_pblocks ALU_AGING01] -add {SLICE_X0Y0:SLICE_X15Y7}
#
#create_pblock ALU_AGING03
#add_cells_to_pblock [get_pblocks ALU_AGING03] [get_cells InstLM/ALURegion/ALUAgingR03/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING03] [get_cells InstLM/ALURegion/ALUAgingR03/u_alu]
#resize_pblock [get_pblocks ALU_AGING03] -add {SLICE_X10Y42:SLICE_X25Y49}
#
#create_pblock ALU_AGING05
#add_cells_to_pblock [get_pblocks ALU_AGING05] [get_cells InstLM/ALURegion/ALUAgingR05/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING05] [get_cells InstLM/ALURegion/ALUAgingR05/u_alu]
#resize_pblock [get_pblocks ALU_AGING05] -add {SLICE_X16Y17:SLICE_X31Y24}
#
#create_pblock ALU_AGING07
#add_cells_to_pblock [get_pblocks ALU_AGING07] [get_cells InstLM/ALURegion/ALUAgingR07/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING07] [get_cells InstLM/ALURegion/ALUAgingR07/u_alu]
#resize_pblock [get_pblocks ALU_AGING07] -add {SLICE_X36Y0:SLICE_X51Y7}
#
#create_pblock ALU_AGING11
#add_cells_to_pblock [get_pblocks ALU_AGING11] [get_cells InstLM/ALURegion/ALUAgingR11/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING11] [get_cells InstLM/ALURegion/ALUAgingR11/u_alu]
#resize_pblock [get_pblocks ALU_AGING11] -add {SLICE_X66Y0:SLICE_X81Y7}
#
#create_pblock ALU_AGING13
#add_cells_to_pblock [get_pblocks ALU_AGING13] [get_cells InstLM/ALURegion/ALUAgingR13/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING13] [get_cells InstLM/ALURegion/ALUAgingR13/u_alu]
#resize_pblock [get_pblocks ALU_AGING13] -add {SLICE_X74Y34:SLICE_X81Y49}
#
#create_pblock ALU_AGING15
#add_cells_to_pblock [get_pblocks ALU_AGING15] [get_cells InstLM/ALURegion/ALUAgingR15/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING15] [get_cells InstLM/ALURegion/ALUAgingR15/u_alu]
#resize_pblock [get_pblocks ALU_AGING15] -add {SLICE_X0Y59:SLICE_X15Y66}
#
#create_pblock ALU_AGING17
#add_cells_to_pblock [get_pblocks ALU_AGING17] [get_cells InstLM/ALURegion/ALUAgingR17/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING17] [get_cells InstLM/ALURegion/ALUAgingR17/u_alu]
#resize_pblock [get_pblocks ALU_AGING17] -add {SLICE_X28Y59:SLICE_X43Y66}
#
#create_pblock ALU_AGING21
#add_cells_to_pblock [get_pblocks ALU_AGING21] [get_cells InstLM/ALURegion/ALUAgingR21/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING21] [get_cells InstLM/ALURegion/ALUAgingR21/u_alu]
#resize_pblock [get_pblocks ALU_AGING21] -add {SLICE_X8Y84:SLICE_X15Y99}
#
#create_pblock ALU_AGING23
#add_cells_to_pblock [get_pblocks ALU_AGING23] [get_cells InstLM/ALURegion/ALUAgingR23/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING23] [get_cells InstLM/ALURegion/ALUAgingR23/u_alu]
#resize_pblock [get_pblocks ALU_AGING23] -add {SLICE_X52Y50:SLICE_X67Y57}
#
#create_pblock ALU_AGING25
#add_cells_to_pblock [get_pblocks ALU_AGING25] [get_cells InstLM/ALURegion/ALUAgingR25/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING25] [get_cells InstLM/ALURegion/ALUAgingR25/u_alu]
#resize_pblock [get_pblocks ALU_AGING25] -add {SLICE_X74Y67:SLICE_X89Y74}
#
#create_pblock ALU_AGING27
#add_cells_to_pblock [get_pblocks ALU_AGING27] [get_cells InstLM/ALURegion/ALUAgingR27/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING27] [get_cells InstLM/ALURegion/ALUAgingR27/u_alu]
#resize_pblock [get_pblocks ALU_AGING27] -add {SLICE_X74Y87:SLICE_X89Y94}
#
#create_pblock ALU_AGING31
#add_cells_to_pblock [get_pblocks ALU_AGING31] [get_cells InstLM/ALURegion/ALUAgingR31/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING31] [get_cells InstLM/ALURegion/ALUAgingR31/u_alu]
#resize_pblock [get_pblocks ALU_AGING31] -add {SLICE_X0Y109:SLICE_X15Y116}
#
#create_pblock ALU_AGING33
#add_cells_to_pblock [get_pblocks ALU_AGING33] [get_cells InstLM/ALURegion/ALUAgingR33/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING33] [get_cells InstLM/ALURegion/ALUAgingR33/u_alu]
#resize_pblock [get_pblocks ALU_AGING33] -add {SLICE_X8Y134:SLICE_X15Y149}
#
#create_pblock ALU_AGING35
#add_cells_to_pblock [get_pblocks ALU_AGING35] [get_cells InstLM/ALURegion/ALUAgingR35/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING35] [get_cells InstLM/ALURegion/ALUAgingR35/u_alu]
#resize_pblock [get_pblocks ALU_AGING35] -add {SLICE_X28Y109:SLICE_X43Y116}
#
#create_pblock ALU_AGING37
#add_cells_to_pblock [get_pblocks ALU_AGING37] [get_cells InstLM/ALURegion/ALUAgingR37/u_alu/*]
#add_cells_to_pblock [get_pblocks ALU_AGING37] [get_cells InstLM/ALURegion/ALUAgingR37/u_alu]
#resize_pblock [get_pblocks ALU_AGING37] -add {SLICE_X52Y100:SLICE_X67Y107}
#
## create_pblock ALU_AGING41
## add_cells_to_pblock [get_pblocks ALU_AGING41] [get_cells InstLM/ALURegion/ALUAgingR41/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING41] [get_cells InstLM/ALURegion/ALUAgingR41/u_alu]
## resize_pblock [get_pblocks ALU_AGING41] -add {SLICE_X74Y117:SLICE_X89Y124}
#
## create_pblock ALU_AGING43
## add_cells_to_pblock [get_pblocks ALU_AGING43] [get_cells InstLM/ALURegion/ALUAgingR43/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING43] [get_cells InstLM/ALURegion/ALUAgingR43/u_alu]
## resize_pblock [get_pblocks ALU_AGING43] -add {SLICE_X82Y134:SLICE_X89Y149}
#
## create_pblock ALU_AGING45
## add_cells_to_pblock [get_pblocks ALU_AGING45] [get_cells InstLM/ALURegion/ALUAgingR45/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING45] [get_cells InstLM/ALURegion/ALUAgingR45/u_alu]
## resize_pblock [get_pblocks ALU_AGING45] -add {SLICE_X0Y159:SLICE_X15Y166}
#
## create_pblock ALU_AGING47
## add_cells_to_pblock [get_pblocks ALU_AGING47] [get_cells InstLM/ALURegion/ALUAgingR47/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING47] [get_cells InstLM/ALURegion/ALUAgingR47/u_alu]
## resize_pblock [get_pblocks ALU_AGING47] -add {SLICE_X12Y184:SLICE_X19Y199}
#
## create_pblock ALU_AGING51
## add_cells_to_pblock [get_pblocks ALU_AGING51] [get_cells InstLM/ALURegion/ALUAgingR51/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING51] [get_cells InstLM/ALURegion/ALUAgingR51/u_alu]
## resize_pblock [get_pblocks ALU_AGING51] -add {SLICE_X36Y150:SLICE_X51Y157}
#
## create_pblock ALU_AGING53
## add_cells_to_pblock [get_pblocks ALU_AGING53] [get_cells InstLM/ALURegion/ALUAgingR53/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING53] [get_cells InstLM/ALURegion/ALUAgingR53/u_alu]
## resize_pblock [get_pblocks ALU_AGING53] -add {SLICE_X52Y167:SLICE_X73Y174}
#
## create_pblock ALU_AGING55
## add_cells_to_pblock [get_pblocks ALU_AGING55] [get_cells InstLM/ALURegion/ALUAgingR55/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING55] [get_cells InstLM/ALURegion/ALUAgingR55/u_alu]
## resize_pblock [get_pblocks ALU_AGING55] -add {SLICE_X60Y150:SLICE_X81Y157}
#
## create_pblock ALU_AGING57
## add_cells_to_pblock [get_pblocks ALU_AGING57] [get_cells InstLM/ALURegion/ALUAgingR57/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING57] [get_cells InstLM/ALURegion/ALUAgingR57/u_alu]
## resize_pblock [get_pblocks ALU_AGING57] -add {SLICE_X74Y184:SLICE_X81Y199}
#
#create_pblock InstL3AAA
#add_cells_to_pblock [get_pblocks InstL3AAA] [get_cells InstMNOC/InstL3AAA/*]
#add_cells_to_pblock [get_pblocks InstL3AAA] [get_cells InstMNOC/InstL3AAA]
#resize_pblock [get_pblocks InstL3AAA] -add {SLICE_X0Y18:SLICE_X7Y24}
#
#create_pblock InstL3AAB
#add_cells_to_pblock [get_pblocks InstL3AAB] [get_cells InstMNOC/InstL3AAB/*]
#add_cells_to_pblock [get_pblocks InstL3AAB] [get_cells InstMNOC/InstL3AAB]
#resize_pblock [get_pblocks InstL3AAB] -add {SLICE_X44Y17:SLICE_X51Y24}
#
#create_pblock InstL3ABA
#add_cells_to_pblock [get_pblocks InstL3ABA] [get_cells InstMNOC/InstL3ABA/*]
#add_cells_to_pblock [get_pblocks InstL3ABA] [get_cells InstMNOC/InstL3ABA]
#resize_pblock [get_pblocks InstL3ABA] -add {SLICE_X62Y18:SLICE_X69Y24}
#
#create_pblock InstL3ABB
#add_cells_to_pblock [get_pblocks InstL3ABB] [get_cells InstMNOC/InstL3ABB/*]
#add_cells_to_pblock [get_pblocks InstL3ABB] [get_cells InstMNOC/InstL3ABB]
#resize_pblock [get_pblocks InstL3ABB] -add {SLICE_X74Y18:SLICE_X81Y24}
#
#create_pblock InstL3BAA
#add_cells_to_pblock [get_pblocks InstL3BAA] [get_cells InstMNOC/InstL3BAA/*]
#add_cells_to_pblock [get_pblocks InstL3BAA] [get_cells InstMNOC/InstL3BAA]
#resize_pblock [get_pblocks InstL3BAA] -add {SLICE_X12Y175:SLICE_X19Y181}
#
#create_pblock InstL3BAB
#add_cells_to_pblock [get_pblocks InstL3BAB] [get_cells InstMNOC/InstL3BAB/*]
#add_cells_to_pblock [get_pblocks InstL3BAB] [get_cells InstMNOC/InstL3BAB]
#resize_pblock [get_pblocks InstL3BAB] -add {SLICE_X28Y168:SLICE_X35Y174}
#
#create_pblock InstL3BBA
#add_cells_to_pblock [get_pblocks InstL3BBA] [get_cells InstMNOC/InstL3BBA/*]
#add_cells_to_pblock [get_pblocks InstL3BBA] [get_cells InstMNOC/InstL3BBA]
#resize_pblock [get_pblocks InstL3BBA] -add {SLICE_X52Y193:SLICE_X59Y199}
#
#create_pblock InstL3BBB
#add_cells_to_pblock [get_pblocks InstL3BBB] [get_cells InstMNOC/InstL3BBB/*]
#add_cells_to_pblock [get_pblocks InstL3BBB] [get_cells InstMNOC/InstL3BBB]
#resize_pblock [get_pblocks InstL3BBB] -add {SLICE_X52Y182:SLICE_X59Y192}
#
#create_pblock InstL1A
#add_cells_to_pblock [get_pblocks InstL1A] [get_cells InstMNOC/InstL1A/*]
#add_cells_to_pblock [get_pblocks InstL1A] [get_cells InstMNOC/InstL1A]
#resize_pblock [get_pblocks InstL1A] -add {SLICE_X8Y75:SLICE_X15Y82}
#
#create_pblock InstL1B
#add_cells_to_pblock [get_pblocks InstL1B] [get_cells InstMNOC/InstL1B/*]
#add_cells_to_pblock [get_pblocks InstL1B] [get_cells InstMNOC/InstL1B]
#resize_pblock [get_pblocks InstL1B] -add {SLICE_X36Y92:SLICE_X43Y99}
#
#create_pblock InstL2AA
#add_cells_to_pblock [get_pblocks InstL2AA] [get_cells InstMNOC/InstL2AA/*]
#add_cells_to_pblock [get_pblocks InstL2AA] [get_cells InstMNOC/InstL2AA]
#resize_pblock [get_pblocks InstL2AA] -add {SLICE_X52Y74:SLICE_X59Y87}
#
#create_pblock InstL2AB
#add_cells_to_pblock [get_pblocks InstL2AB] [get_cells InstMNOC/InstL2AB/*]
#add_cells_to_pblock [get_pblocks InstL2AB] [get_cells InstMNOC/InstL2AB]
#resize_pblock [get_pblocks InstL2AB] -add {SLICE_X82Y50:SLICE_X89Y56}
#
#create_pblock InstL2BA
#add_cells_to_pblock [get_pblocks InstL2BA] [get_cells InstMNOC/InstL2BA/*]
#add_cells_to_pblock [get_pblocks InstL2BA] [get_cells InstMNOC/InstL2BA]
#resize_pblock [get_pblocks InstL2BA] -add {SLICE_X8Y125:SLICE_X15Y131}
#
#create_pblock InstL2BB
#add_cells_to_pblock [get_pblocks InstL2BB] [get_cells InstMNOC/InstL2BB/*]
#add_cells_to_pblock [get_pblocks InstL2BB] [get_cells InstMNOC/InstL2BB]
#resize_pblock [get_pblocks InstL2BB] -add {SLICE_X82Y100:SLICE_X89Y127}
#
#
## create_pblock ALU_AGING61
## add_cells_to_pblock [get_pblocks ALU_AGING61] [get_cells InstLM/ALURegion/ALUAgingR61/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING61] [get_cells InstLM/ALURegion/ALUAgingR61/u_alu]
## resize_pblock [get_pblocks ALU_AGING61] -add {SLICE_X18Y159:SLICE_X33Y166}
#
## create_pblock ALU_AGING63
## add_cells_to_pblock [get_pblocks ALU_AGING63] [get_cells InstLM/ALURegion/ALUAgingR63/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING63] [get_cells InstLM/ALURegion/ALUAgingR63/u_alu]
## resize_pblock [get_pblocks ALU_AGING63] -add {SLICE_X36Y184:SLICE_X43Y199}
#
## create_pblock ALU_AGING65
## add_cells_to_pblock [get_pblocks ALU_AGING65] [get_cells InstLM/ALURegion/ALUAgingR65/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING65] [get_cells InstLM/ALURegion/ALUAgingR65/u_alu]
## resize_pblock [get_pblocks ALU_AGING65] -add {SLICE_X0Y100:SLICE_X15Y107}
#
## create_pblock ALU_AGING67
## add_cells_to_pblock [get_pblocks ALU_AGING67] [get_cells InstLM/ALURegion/ALUAgingR67/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING67] [get_cells InstLM/ALURegion/ALUAgingR67/u_alu]
## resize_pblock [get_pblocks ALU_AGING67] -add {SLICE_X52Y125:SLICE_X59Y140}
#
## create_pblock ALU_AGING71
## add_cells_to_pblock [get_pblocks ALU_AGING71] [get_cells InstLM/ALURegion/ALUAgingR71/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING71] [get_cells InstLM/ALURegion/ALUAgingR71/u_alu]
## resize_pblock [get_pblocks ALU_AGING71] -add {SLICE_X28Y50:SLICE_X43Y57}
#
## create_pblock ALU_AGING73
## add_cells_to_pblock [get_pblocks ALU_AGING73] [get_cells InstLM/ALURegion/ALUAgingR73/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING73] [get_cells InstLM/ALURegion/ALUAgingR73/u_alu]
## resize_pblock [get_pblocks ALU_AGING73] -add {SLICE_X64Y59:SLICE_X71Y74}
#
## create_pblock ALU_AGING75
## add_cells_to_pblock [get_pblocks ALU_AGING75] [get_cells InstLM/ALURegion/ALUAgingR75/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING75] [get_cells InstLM/ALURegion/ALUAgingR75/u_alu]
## resize_pblock [get_pblocks ALU_AGING75] -add {SLICE_X10Y31:SLICE_X25Y38}
#
## create_pblock ALU_AGING77
## add_cells_to_pblock [get_pblocks ALU_AGING77] [get_cells InstLM/ALURegion/ALUAgingR77/u_alu/*]
## add_cells_to_pblock [get_pblocks ALU_AGING77] [get_cells InstLM/ALURegion/ALUAgingR77/u_alu]
## resize_pblock [get_pblocks ALU_AGING77] -add {SLICE_X52Y25:SLICE_X59Y40}