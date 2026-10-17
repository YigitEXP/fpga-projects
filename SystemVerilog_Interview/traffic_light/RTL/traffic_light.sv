// File : traffic_light_sv.sv
typedef enum logic [1:0] {ALL_RED, RED, GREEN, YELLOW} state_t;

module traffic_light_sv (
    input  logic  clk, rst,
    output state_t state
);
    always_ff @ (posedge clk) begin
        if (rst)
            state <= ALL_RED;
        else case (state)
            ALL_RED: state <= RED;
            RED    : state <= GREEN;
            GREEN  : state <= YELLOW;
            YELLOW : state <= ALL_RED;
            default : state <= ALL_RED;
        endcase
    end
endmodule