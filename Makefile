
RTL = \
	rtl/wait_fsm.v \

	#rtl/sr_flop_and_counter.v \
	#rtl/dflop.v

VER_CXX = $(SRCS:v=cpp)

TB_CXX = sim/sim_main.cpp

INCLUDES = 

VER_OPTS = \
	-Wall \
	--trace \
	--x-assign unique \
	--x-initial unique \

	#--hierarchical \

#VER_MK = obj_dir/Vour.mk
#
#default: $(SRCS) $(VER_MK) Vour
#build: $(EXES)
#
#$(VER_MK): $(SRCS) ver_sim/sim_main.cpp
#	verilator --cc --exe -Wall ver_sim/sim_main.cpp src/our.v
#
#$(EXES): $(SRCS) $(TBS)
#	iverilog $(IVERILOG_OPTS) $(SRCS) $(TBS) -o $@ -s $(basename $@)
#
#Vour: $(VER_MK)
#	make -C obj_dir -f Vour.mk Vour
#
#clean:
#	@rm -rf *.vvp src/*.cpp obj_dir

# Verilator example makefile
# Norbertas Kremeris 2021
MODULE=wait_fsm

.PHONY:sim
sim: waveform.vcd

.PHONY:verilate
verilate: .stamp.verilate

.PHONY:build
build: obj_dir/Valu

.PHONY:waves
waves: waveform.vcd
	@echo
	@echo "### WAVES ###"
	gtkwave waveform.vcd

waveform.vcd: ./obj_dir/V$(MODULE)
	@echo
	@echo "### SIMULATING ###"
	./obj_dir/V$(MODULE) +verilator+rand+reset+2 

./obj_dir/V$(MODULE): .stamp.verilate
	@echo
	@echo "### BUILDING SIM ###"
	make -C obj_dir -f V$(MODULE).mk V$(MODULE)

.stamp.verilate: $(RTL) $(TB_CXX)
	@echo
	@echo "### VERILATING ###"
	verilator $(VER_OPTS) -cc $(RTL) --exe $(TB_CXX)
	@touch .stamp.verilate

.PHONY:lint
lint: $(RTL)
	verilator --lint-only $(RTL)

.PHONY: clean
clean:
	rm -rf .stamp.*;
	rm -rf ./obj_dir
	rm -rf waveform.vcd
