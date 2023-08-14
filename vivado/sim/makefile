## VCS
#VCS = vcs -full64 -LDFLAGS -Wl,--no-as-needed 
#DEFINE_VCD = +define+DUMP_VCD
#DEFINE_FSDB = +define+DUMP_FSDB
#PLI_TAB = ${VERDI_HOME}/share/PLI/VCS/LINUXAMD64/novas.tab
#PLI_A = ${VERDI_HOME}/share/PLI/VCS/LINUXAMD64/pli.a
#FSDB = -fsdb -P $(PLI_TAB) $(PLI_A) $(DEFINE_FSDB)
## DVE
#DVE = dve -full64
#
## Simulation Timescale
#TIMESCALE = timescale1ns/1ps
#
#all: gen_flist com sim wave
#	
#gen_flist: 
#	find -wholename "./rtl/*.v" > filelist.f
#
#com:	
#	$(VCS) +v2k -sverilog -f filelist.f -debug_all -$(TIMESCALE) -l com.log $(FSDB) 
#
#sim:
#	./simv -l sim.log
#
#verdi:
#	verdi +v2k -sverilog -f filelist.f -ssf wave.fsdb &
#
#clean_com:
#	rm -rf csrc simv.daidir simv com.log
#
#clean_sim:
#	rm -rf *.key *.fsdb *.vcd *.vpd DVEfiles NOVAS_dump.log sim.log
#
#clean: clean_com clean_sim
#	rm -rf *.log
#
#wave:
#	vcd2vpd -full64 wave.vcd wave.vpd
#	$(DVE) -vpd wave.vpd
#
#cover:
#	urg -dir simv.vdb
#
#clean:
#	rm -rf csrc simv.daidir simv com.log *.h
#	rm -rf *.key *.fsdb* *.vcd *.vpd DVEfiles 
#	rm -rf verdiLog novas*
#	rm -rf *.log
#	rm -rf urgReport simv.vdb
#
#cln_result:
#	rm -rf ../result/*
# VCS
#VCS = vcs -full64 -LDFLAGS -Wl,--no-as-needed
#DEFINE_VCD = +define+DUMP_VCD
#
## DVE
#DVE = dve -full64
#
## Simulation Timescale
#TIMESCALE = timescale1ns/1ps
#
#all: 
#	gen_flist com sim wave
#
#gen_flist:
#	find -wholename "./rtl/*.v" > filelist.f
#
#com:
#	$(VCS) +v2k -sverilog -f filelist.f -debug_all -$(TIMESCALE) -l com.log $(DEFINE_VCD) 
#
#sim:
#	./simv -l sim.log
#
#clean_com:
#	rm -rf csrc simv.daidir simv com.log
#
#clean_sim:
#	rm -rf *.key *.fsdb *.vcd *.vpd DVEfiles NOVAS_dump.log sim.log
#
#clean: clean_com clean_sim
#	rm -rf *.log
#
#wave:
#	vcd2vpd -full64 wave.vcd wave.vpd
#	$(DVE) -vpd wave.vpd
# VCS
VCS = vcs -full64 -LDFLAGS -Wl,-no-as-needed
DEFINE_VPD = +define+DUMP_VPD
DEFINE_DSDB = +define+DUMP_FSDB

# Verdi
PLI_TAB = $(VERDI_HOME)/share/PLI/VCS/linux64/novas.tab
PLI_A = $(VERDI_HOME)/share/PLI/VCS/linux64/pli.a
FSDB = -fsdb -P $(PLI_TAB) $(PLI_A) $(DEFINE_DSDB)

# DVE
DVE = dve -full64

# Simulation Timescale
TIMESCALE = timescale1ns/1ps

all: gen_flist com sim verdi

#gen_flist: 
#	find -wholename "./rtl/*.v" > filelist.f

com:
	$(VCS) +v2k -sverilog -f filelist.f -debug_all -$(TIMESCALE) -l com.log $(FSDB) 

sim:
	./simv -l sim.log

clean_com:
	rm -rf csrc simv.daidir simv com.log

clean_sim:
	rm -rf *.key *.fsdb *.vcd *.vpd DVEfiles NOVAS_dump.log sim.log

clean:
	rm -rf csrc simv.daidir simv com.log *.h
	rm -rf *.key *.fsdb* *.vcd *.vpd DVEfiles 
	rm -rf verdiLog novas*
	rm -rf *.log
	rm -rf urgReport simv.vdb

open_dve :
	$(DVE) -vpd ./sim_output_pluson.vpd &

verdi:
	verdi +v2k -sverilog -f filelist.f -ssf ./wave.fsdb -sswr ./signal.rc &
