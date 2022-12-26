
module dflop (
    input  wire                clk,
    input  wire                reset,
    input  wire                in_1,
    output reg                 out_1
);

always @(posedge clk or posedge reset)
begin
    if (reset)
        out_1 <= 1'b0;
    else
        out_1 <= in_1;
end

endmodule
