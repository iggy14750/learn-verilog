
SRCS = \
	src/wait_fsm.v \
	src/sr_flop_and_counter.v \
	src/dflop.v

VER_CXX = $(SRCS:v=cpp)

TBS = \
	test/wait_fsm_tb.v \
	test/dflop_tb.v \
	test/sr_flop_and_counter_tb.v \
	test/hello.v
INCLUDES = 
#EXES = $(patsubst %.v, $(basename %.vvp), $(TBS))
EXES = \
	wait_fsm_tb.vvp \
	dflop_tb.vvp \
	sr_flop_and_counter_tb.vvp \
	hello.vvp
IVERILOG_OPTS = 

VER_OPTS = \
	--cc \
	--hierarchical \


ver_build: $(VER_CXX)
build: $(EXES)

$(VER_CXX): $(SRCS)
	verilator --cc --exe --build -Wall ver_sim/sim_main.cpp src/our.v
	#verilator $(VER_OPTS) $<
	#touch $@

$(EXES): $(SRCS) $(TBS)
	iverilog $(IVERILOG_OPTS) $(SRCS) $(TBS) -o $@ -s $(basename $@)

clean:
	@rm -rf *.vvp src/*.cpp obj_dir

