
module wait_fsm (
    input  wire    clk,
    input  wire    reset,
    input  wire    go,
    input  wire    kill,
    output reg     idle,
    output reg     done
);

reg [6:0] count;
reg [1:0] state;

parameter ST_IDLE   = 2'b00;
parameter ST_ACTIVE = 2'b01;
parameter ST_FINISH = 2'b10;
parameter ST_ABORT  = 2'b11;

localparam C_MAX_COUNT = 7'd10;

// State Machine
always @(posedge clk)
begin
    if (reset) begin
        state <= ST_IDLE;
        count <= 7'd0;
        done <= 1'b0;
        idle <= 1'b0;
    end else begin

        done <= (state == ST_FINISH) ? 1'b1 : 1'b0;
        idle <= (state == ST_IDLE)   ? 1'b1 : 1'b0;

        case (state)
            ST_IDLE: begin
                count <= 7'd0;
                if (go)
                    state <= ST_ACTIVE;
            end
            ST_ACTIVE: begin
                count <= count + 1;
                if (count == C_MAX_COUNT)
                    state <= ST_FINISH;
                if (kill)
                    state <= ST_ABORT;
            end
            ST_FINISH:
                state <= ST_IDLE;
            ST_ABORT:
                if (!kill)
                    state <= ST_IDLE;
            default:
                state <= ST_IDLE;
        endcase
    end
end

endmodule

