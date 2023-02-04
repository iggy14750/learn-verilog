
SRCS = \
	src/wait_fsm.v \
	src/sr_flop_and_counter.v \
	src/dflop.v
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

build: $(EXES)

$(EXES): $(SRCS) $(TBS)
	iverilog $(IVERILOG_OPTS) $(SRCS) $(TBS) -o $@ -s $(basename $@)

clean:
	@rm -rf *.vvp

