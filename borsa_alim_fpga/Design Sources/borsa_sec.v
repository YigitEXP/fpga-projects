`timescale 1ns / 1ps

module borsa_sec(
    input  wire [9:0]  hisse_no1,
    input  wire [9:0]  hisse_no2,
    input  wire [9:0]  hisse_no3,
    input  wire [31:0] hisse_degeri1,
    input  wire [31:0] hisse_degeri2,
    input  wire [31:0] hisse_degeri3,
    input  wire [63:0] bakiye,
    input  wire [36:0] yatirimci_kimlik_no,
    output reg  [9:0]  karar_no,
    output reg  [1:0]  karar,
    output reg  [63:0] kagit_sayisi,
    output reg  [63:0] sifre_cikis,
    output reg  [63:0] sifre_anahtar
);

    always @(*) begin
        // 1. En ucuz hisse tespiti
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
    
        // 2. Eşik kararı
        if (kagit_sayisi > 1000) begin
            karar = 2'b01;
        end else begin
            karar = 2'b00; 
        end

        // 3. Şifreleme / Karma işlemleri
        sifre_anahtar = (((hisse_no1) ^ (hisse_no2)) << 6) + (hisse_no3);
        sifre_cikis   = {yatirimci_kimlik_no, karar_no} ^ sifre_anahtar;
    end

endmodule