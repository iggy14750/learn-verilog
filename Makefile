
SRCS = 
TBS = \
	test/hello.v
INCLUDES = 
#EXES = $(patsubst %.v, $(basename %.vvp), $(TBS))
EXES = \
	hello.vvp

build: $(EXES)

$(EXES): $(SRCS) $(TBS)
	iverilog $(SRCS) $(TBS) -o $@ -s $(basename $@)

clean:
	@rm -rf *.vvp

