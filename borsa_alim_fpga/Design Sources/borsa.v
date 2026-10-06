`timescale 1ns / 1ps

module borsa(
    input  wire [9:0]  hisse_no1,
    input  wire [9:0]  hisse_no2,
    input  wire [9:0]  hisse_no3,
    input  wire [31:0] hisse_degeri1,
    input  wire [31:0] hisse_degeri2,
    input  wire [31:0] hisse_degeri3,
    input  wire [63:0] bakiye,
    output reg  [9:0]  karar_no,
    output reg  [1:0]  karar,
    output reg  [63:0] kagit_sayisi
);

    always @(*) begin
        if (hisse_degeri1 <= hisse_degeri2 && hisse_degeri1 <= hisse_degeri3) begin
            karar_no     = hisse_no1;
            kagit_sayisi = (hisse_degeri1 != 0) ? (bakiye / hisse_degeri1) : 64'd0;
        end else if (hisse_degeri2 <= hisse_degeri1 && hisse_degeri2 <= hisse_degeri3) begin
            karar_no     = hisse_no2;
            kagit_sayisi = (hisse_degeri2 != 0) ? (bakiye / hisse_degeri2) : 64'd0;
        end else begin
            karar_no     = hisse_no3;
            kagit_sayisi = (hisse_degeri3 != 0) ? (bakiye / hisse_degeri3) : 64'd0;
        end
    
        if (kagit_sayisi > 1000) begin
            karar = 2'b01;
        end else begin
            karar = 2'b00; 
        end
    end

endmodule