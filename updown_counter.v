// Up/down counter with synchronous reset, parallel load and enable.
// Priority (highest first): reset > load > count (when en=1).
module updown_counter #(parameter WIDTH = 4) (
    input  wire             clk,
    input  wire             rst,       // synchronous, active high
    input  wire             load,      // load load_val on next clock edge
    input  wire             en,        // count enable
    input  wire             up_down,   // 1 = count up, 0 = count down
    input  wire [WIDTH-1:0] load_val,
    output reg  [WIDTH-1:0] count
);
    always @(posedge clk) begin
        if (rst)
            count <= {WIDTH{1'b0}};
        else if (load)
            count <= load_val;
        else if (en) begin
            if (up_down) count <= count + 1'b1;   // wraps 15 -> 0
            else         count <= count - 1'b1;   // wraps 0 -> 15
        end
        // else: hold value
    end
endmodule
