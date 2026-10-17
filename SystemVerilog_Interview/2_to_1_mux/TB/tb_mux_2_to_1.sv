`timescale 1ns / 1ps

module tb_mux_2_to_1 ();
    logic in0, in1, sel;
    logic y;

    mux_2_to_1 dut (
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .y(y)
    );

    initial begin
        // Test case 1: sel = 0, expect y = in0
        in0 = 1'b0; in1 = 1'b1; sel = 1'b0;
        #10;
        $display("Test case 1: sel=%b, in0=%b, in1=%b, y=%b", sel, in0, in1, y);

        // Test case 2: sel = 1, expect y = in1
        in0 = 1'b0; in1 = 1'b1; sel = 1'b1;
        #10;
        $display("Test case 2: sel=%b, in0=%b, in1=%b, y=%b", sel, in0, in1, y);
        
        // Test case 3: sel = 0, expect y = in0
        in0 = 1'b1; in1 = 1'b0; sel = 1'b0;
        #10;
        $display("Test case 3: sel=%b, in0=%b, in1=%b, y=%b", sel, in0, in1, y);

        // Test case 4: sel = 1, expect y = in1
        in0 = 1'b1; in1 = 1'b0; sel = 1'b1;
        #10;
        $display("Test case 4: sel=%b, in0=%b, in1=%b, y=%b", sel, in0, in1, y);

        $finish;
    end
endmodule