
module sr_flop_and_counter (
    input  wire                clk,
    input  wire                reset,
    input  wire                start,
    input  wire                stop,
    output reg           [3:0] count,
    output reg                 stop_d2
);

// Drive enable_count
reg enable_count;
always @(posedge clk or posedge reset)
begin
    if (reset)
        enable_count <= 1'b0;
    else if (start)
        enable_count <= 1'b1;
    else if (stop)
        enable_count <= 1'b0;
end

// Counter
always @(posedge clk or posedge reset)
begin
    if (reset)
        count <= 4'd0;
    else if (enable_count) begin
        if (count == 4'd13)
            count <= 4'd0;
        else
            count <= count + 1;
    end
end

// Latch the stop signal 2 cycles back
reg stop_d1;
always @(posedge clk) begin
    stop_d1 <= stop;
    stop_d2 <= stop_d1;
end

endmodule
