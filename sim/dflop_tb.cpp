
#include <cstdlib>
#include <stdio.h>
#include "Vdflop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#define NUM_CYCLES 100

int num_errors = 0;

#define ASSERT(condition) \
    if (!condition) { \
        printf("Error at line %d; cycle %d\n", __LINE__, cycle); \
        num_errors++; \
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
    printf("\tErrors: %d\n", num_errors);

    delete top;
    return 0;
}
