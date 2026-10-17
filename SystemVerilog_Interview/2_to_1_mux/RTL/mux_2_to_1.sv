`timescale 1ns/1ps

module mux_2_to_1 (
    input logic in0, in1, sel,
    output logic y
);

    typedef enum logic {
        SEL_IN0 = 1'b0,
        SEL_IN1 = 1'b1
    } sel_t;

    sel_t select_signal;
    assign select_signal = sel_t'(sel);

    always_comb begin
        case(select_signal)
            SEL_IN0: y = in0;
            SEL_IN1: y = in1;
            default: y = 1'b0;
        endcase
    end
endmodule