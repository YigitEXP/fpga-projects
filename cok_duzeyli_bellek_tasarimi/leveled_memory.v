`timescale 1ns / 1ps

module seviyelihafiza (
    input  wire clk,
    input  wire [5:0] adress,
    input  wire write_read,
    input  wire [7:0] value,
    output reg [7:0] result,
    output reg [1:0] error_count
);
    reg [1:0] level1_memory  [0:1];   // 2 elemanlı, her biri 2-bit
    reg [2:0] level2_memory1 [0:3];   // 4 elemanlı, her biri 3-bit
    reg [2:0] level2_memory2 [0:3];   // 4 elemanlı, her biri 3-bit
    reg [7:0] memory [0:63];  // 64 elemanlı, her biri 8-bit

    integer i;

    wire level1_index;
    wire [3:0] level2_index;
    assign level1_index = adress[5]; // 6-bit adresin en yüksek biti
    assign level2_index = adress[4:3]; // 6-bit adresin orta 2 biti

    localparam LEVEL1 = 3'b001;
    localparam LEVEL2 = 3'b010;
    localparam MEMORY = 3'b100;
    initial begin
        for(i = 0; i < 2; i = i + 1) begin
            level1_memory[i] = 2'b00;
        end
        for(i = 0; i < 4; i = i + 1) begin
            level2_memory1[i] = 3'b000;
            level2_memory2[i] = 3'b000;
        end
        for (i = 0; i < 64; i = i + 1) begin
            memory[i] = 8'b00000000;
        end
        error_count = 2'b00;
    end

    always @(*) begin
        if (write_read == 1'b0) begin // Write operation
            memory[adress] = value;
            result = 8'b00000000; // No result for write operation
        end else begin // Read operation
            result = memory[adress];
        end
    end

    always @(posedge clk) begin
        
    end
endmodule