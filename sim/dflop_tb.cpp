
#include <cstdlib>
#include <stdio.h>
#include "Vdflop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#define NUM_CYCLES 100

int num_errors = 0;
int num_passes = 0;

#define ASSERT(condition) \
    if (!condition) { \
        printf("ERROR at line %d; cycle %d\n", __LINE__, cycle); \
        printf("\tclk=%d in=%d out=%d exp_out=%d\n", \
                top->clk, top->in_1, top->out_1, last); \
        num_errors++; \
    } else { \
        num_passes++; \
    }

int random_bit() {
    return rand() & 1;
}

int main(int argc, char** argv) {

    srand (time(NULL));
    Verilated::commandArgs(argc, argv);
    Vdflop* top = new Vdflop;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    top->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    // Begin with reset
    // Hold reset for 2 clock cycles
    // Each actual DUT clock cycle is taken by 2 evals here.
    top->reset = 1;
    for (int cycle=0; cycle<4; cycle++) {
        top->clk ^= 1;
        top->eval();
        m_trace->dump(cycle);
    }

    // Let's leave reset low for a couple cycles after that.
    top->reset = 0;
    for (int cycle=0; cycle<4; cycle++) {
        top->clk ^= 1;
        top->eval();
        m_trace->dump(cycle);
    }

    // Now begins actual test data.
    int last = 0;
    for (int cycle = 0; cycle < NUM_CYCLES; cycle++) {
        top->clk ^= 1;
        top->reset = 0;

        // The following only on a rising edge
        if (top->clk == 1) {
            top->in_1 = random_bit();
            ASSERT(top->out_1 == last);
            last = top->in_1;
        }
        top->eval();
        m_trace->dump(cycle);
    }

    m_trace->close();
    printf("DFLOP SIM DONE!\n");
    printf("\tErrors: %d Passes: %d\n", num_errors, num_passes);

    delete top;
    return 0;
}
