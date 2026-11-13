`timescale 1ns/1ps
module tb_updown_counter;
    parameter WIDTH = 4;

    reg              clk, rst, load, en, up_down;
    reg  [WIDTH-1:0] load_val;
    wire [WIDTH-1:0] count;

    reg  [WIDTH-1:0] expected;   // reference model
    reg              checking;
    integer          errors, i;

    updown_counter #(.WIDTH(WIDTH)) dut (
        .clk(clk), .rst(rst), .load(load), .en(en),
        .up_down(up_down), .load_val(load_val), .count(count)
    );

    // 10 ns clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Reference model: same rules, written independently
    always @(posedge clk) begin
        if (rst)          expected <= 0;
        else if (load)    expected <= load_val;
        else if (en)      expected <= up_down ? expected + 1 : expected - 1;
    end

    // Self-checker: compare on falling edge, when outputs are stable
    always @(negedge clk) begin
        if (checking && (count !== expected)) begin
            errors = errors + 1;
            $display("FAIL t=%0t count=%0d expected=%0d (rst=%b load=%b en=%b up=%b)",
                     $time, count, expected, rst, load, en, up_down);
        end
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_updown_counter);
        errors = 0; checking = 0;
        rst = 1; load = 0; en = 0; up_down = 1; load_val = 0;
        @(negedge clk); @(negedge clk);
        checking = 1;

        // 1. count up through wrap-around
        rst = 0; en = 1; up_down = 1;
        repeat (20) @(negedge clk);

        // 2. count down through wrap-around
        up_down = 0;
        repeat (20) @(negedge clk);

        // 3. parallel load, then continue down
        load = 1; load_val = 9; @(negedge clk);
        load = 0;
        repeat (3) @(negedge clk);

        // 4. hold when disabled
        en = 0;
        repeat (3) @(negedge clk);

        // 5. load has priority over enable
        en = 1; load = 1; load_val = 5; @(negedge clk);
        load = 0;
        repeat (2) @(negedge clk);

        // 6. reset has priority over load
        rst = 1; load = 1; load_val = 7; @(negedge clk);
        rst = 0; load = 0;
        repeat (2) @(negedge clk);

        // 7. random stimulus
        for (i = 0; i < 300; i = i + 1) begin
            rst      = (($random & 15) == 0);
            load     = (($random & 7) == 0);
            en       = $random;
            up_down  = $random;
            load_val = $random;
            @(negedge clk);
        end

        #1;
        if (errors == 0) $display("PASS: all checks passed");
        else             $display("FAIL: %0d mismatches", errors);
        $finish;
    end
endmodule
