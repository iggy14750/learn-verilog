
SRCS = \
	src/dflop.v
TBS = \
	test/dflop_tb.v \
	test/hello.v
INCLUDES = 
#EXES = $(patsubst %.v, $(basename %.vvp), $(TBS))
EXES = \
	dflop_tb.vvp \
	hello.vvp
IVERILOG_OPTS = 

build: $(EXES)

$(EXES): $(SRCS) $(TBS)
	iverilog $(IVERILOG_OPTS) $(SRCS) $(TBS) -o $@ -s $(basename $@)

clean:
	@rm -rf *.vvp

