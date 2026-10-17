module tb_traffic_light ();
    logic clk, rst;
    state_t state;

    traffic_light dut (
        .clk(clk),
        .rst(rst),
        .state(state)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        #20 rst = 0;
        repeat (4) begin
            @ (posedge clk);
            $display("time=%0t state=%s", $time, state.name());
        end
        #20 $finish;
    end