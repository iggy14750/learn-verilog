
module sr_flop_and_counter_tb;

// Signals
reg clk, reset, start, stop;
wire [3:0] count;
wire stop_d2;

// Drive the clock signal
always #10 clk = ~clk;

// The DUT
sr_flop_and_counter dut(clk, reset, start, stop, count, stop_d2);

// Test sequence
initial
begin
    clk = 1'b0;
    reset = 1'b0;
    start = 1'b0;
    stop = 1'b0;
    #11;
    reset = 1'b1;
    #20;
    reset = 1'b0;
    #40;
    start = 1'b1;
    #20;
    start = 1'b0;
    #400;
    stop = 1'b1;
    #20;
    stop = 1'b0;
    #40;

    #40;
    $finish;
end

// Monitor signals
initial
begin
    $monitor("[%08d] dut(%1d, %1d, %1d, %1d, %2d, %1d)",
        $time, clk, reset, start, stop, count, stop_d2
    );
end

endmodule
