
# This Makefile now works on only ONE top-level Verilog module.
# We can see that it works on "wait_fsm" by default,
# but this can be changed on the command-line using the following syntax:
#
#     make MODULE=<ModuleName>
#
MODULE=wait_fsm
RTL = rtl/$(MODULE).v
VER_CXX = $(SRCS:v=cpp)
TB_CXX = sim/$(MODULE)_tb.cpp

INCLUDES = 

VER_OPTS = \
	-Wall \
	--trace \
	--x-assign unique \
	--x-initial unique \

	#--hierarchical \

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
