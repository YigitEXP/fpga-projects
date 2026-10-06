`timescale 1ns / 1ps

module borsa_sec(
    input [9:0] hisse_no1,
    input [9:0] hisse_no2,
    input [9:0] hisse_no3,
    input [31:0] hisse_degeri1,
    input [31:0] hisse_degeri2,
    input [31:0] hisse_degeri3,
    input [63:0] bakiye,
    input reg [1:0] karar,
    input reg [63:0] kagit_sayisi,
    input [36:0] yatirimci_kimlik_no,
    output reg [63:0] sifre_cikis,
    output reg [63:0] sifre_anahtar
);

    reg [9:0] karar_no;
    initial begin
        karar_no = 0;
        karar = 0; 
        kagit_sayisi = 0;
    end
    
    always @(*) begin
        if(hisse_degeri1 <= hisse_degeri2 && hisse_degeri1 <= hisse_degeri3) begin
            karar_no = hisse_no1;
            kagit_sayisi = bakiye / hisse_degeri1;
            
        end else if(hisse_degeri2 <= hisse_degeri1 && hisse_degeri2 <= hisse_degeri3) begin
            karar_no = hisse_no2;
            kagit_sayisi = bakiye / hisse_degeri2;
        end else begin
            karar_no = hisse_no3;
            kagit_sayisi = bakiye / hisse_degeri3;
        end
    
        if(kagit_sayisi > 1000) begin
            karar = 2'b01;
        end else begin
            karar = 2'b00; 
        end

    sifre_anahtar = (((hisse_no1) ^ (hisse_no2)) << 6) + (hisse_no3);
    sifre_cikis = {yatirimci_kimlik_no, karar_no}*sifre_anahtar;
    
    $display("Karar No: %d, Karar: %b, Kağıt Sayısı: %d", karar_no, karar, kagit_sayisi);
    end

    
    
endmodule 