
module dflop_tb;

reg in_1, clk, reset;
wire out_1;

dflop dut(clk, reset, in_1, out_1);

always #10 clk = ~clk;

initial
begin
    in_1 = 1'b0;
    clk = 1'b0;
	reset = 1'b0;
    #10;
	reset = 1'b1;
    #11 ;
    reset = 1'b0;
    in_1 = 1'b1;
    #20;
    in_1 = 1'b0;
    #40;
	$finish;
end

initial begin
    $monitor("[%d] clk=%1d, reset=%1d, in=%1d, out=%1d",
        $time, clk, reset, in_1, out_1
    );
end

endmodule
