
module wait_fsm_tb;

// Signals
reg clk, reset, go, kill;
wire idle, done;

// Drive the clock signal
always #10 clk = ~clk;

// The DUT
wait_fsm fsm_i (clk, reset, go, kill, idle, done);

// Test sequence
initial
begin
    clk = 1'b0;
    reset = 1'b0;
    #20;
    reset = 1'b1;
    #20;
    reset = 1'b0;
    #60;

    // Kill test
    go = 1'b1;
    #20;
    go = 1'b0;
    #60;
    kill = 1'b1;
    #40;
    kill = 1'b0;
    #60;

    // Sucessful wait test
    go = 1'b1;
    #20;
    go = 1'b0;
    #220;

    #40;
    $finish;
end

// Monitor signals
initial
begin
    $monitor("[%08d] dut(clk=%1d, reset=%1d, go=%1d, kill=%1d, idle=%1d, done=%1d)",
        $time, clk, reset, go, kill, idle, done
    );
end

endmodule

