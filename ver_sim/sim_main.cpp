#include "Vour.h"
#include "verilated.h"

#define NUM_CYCLES 100

int main(int argc, char** argv) {
    //VerilatedContext* contextp = new VerilatedContext;
    //contextp->commandArgs(argc, argv);
    Vour* top = new Vour;
    //while (!contextp->gotFinish()) { top->eval(); }
    //top->eval();
    for (int cycle = 0; cycle < NUM_CYCLES; cycle++) {
        //top->clk ^= 1;
        top->eval();
    }
    delete top;
    //delete contextp;
    return 0;
}
