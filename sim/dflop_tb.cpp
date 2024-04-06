
#include <cstdlib>
#include <stdio.h>
#include "Vdflop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#define NUM_CYCLES 100

int main(int argc, char** argv) {

    srand (time(NULL));
    Verilated::commandArgs(argc, argv);
    Vdflop* top = new Vdflop;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    top->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    for (int cycle = 0; cycle < NUM_CYCLES; cycle++) {
        top->clk ^= 1;
        top->eval();
        m_trace->dump(cycle);
    }

    m_trace->close();
    printf("DFLOP SIM DONE!\n");

    delete top;
    return 0;
}
