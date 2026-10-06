`timescale 1ns / 1ps

module borsa_sec_3_mux_2(
    input  wire [9:0]  hisse_no1, hisse_no2, hisse_no3,
    input  wire [9:0]  hisse_no4, hisse_no5, hisse_no6,
    input  wire [9:0]  hisse_no7, hisse_no8, hisse_no9,
    input  wire [31:0] hisse_degeri1, hisse_degeri2, hisse_degeri3,
    input  wire [31:0] hisse_degeri4, hisse_degeri5, hisse_degeri6,
    input  wire [31:0] hisse_degeri7, hisse_degeri8, hisse_degeri9,
    input  wire [63:0] bakiye,
    input  wire [36:0] yatirimci_kimlik_no,
    output reg  [9:0]  karar_no,
    output reg  [1:0]  karar,
    output wire [63:0] kagit_sayisi_1, kagit_sayisi_2, kagit_sayisi_3,
    output wire [63:0] sifre_cikis_1,  sifre_cikis_2,  sifre_cikis_3,
    output wire [63:0] sifre_anahtar_1, sifre_anahtar_2, sifre_anahtar_3
);

    // Her alt modülün bağımsız karar çıkışları için ara sinyaller
    wire [9:0] mod_karar_no1, mod_karar_no2, mod_karar_no3;
    wire [1:0] mod_karar1, mod_karar2, mod_karar3;

    // 1. Grup
    borsa_sec sb1(
        .hisse_no1(hisse_no1),
        .hisse_no2(hisse_no2),
        .hisse_no3(hisse_no3),
        .hisse_degeri1(hisse_degeri1),
        .hisse_degeri2(hisse_degeri2),
        .hisse_degeri3(hisse_degeri3),
        .bakiye(bakiye),
        .yatirimci_kimlik_no(yatirimci_kimlik_no),
        .karar_no(mod_karar_no1),
        .karar(mod_karar1),
        .kagit_sayisi(kagit_sayisi_1),
        .sifre_cikis(sifre_cikis_1),
        .sifre_anahtar(sifre_anahtar_1)
    );

    // 2. Grup
    borsa_sec sb2(
        .hisse_no1(hisse_no4),
        .hisse_no2(hisse_no5),
        .hisse_no3(hisse_no6),
        .hisse_degeri1(hisse_degeri4),
        .hisse_degeri2(hisse_degeri5),
        .hisse_degeri3(hisse_degeri6),
        .bakiye(bakiye),
        .yatirimci_kimlik_no(yatirimci_kimlik_no),
        .karar_no(mod_karar_no2),
        .karar(mod_karar2),
        .kagit_sayisi(kagit_sayisi_2),
        .sifre_cikis(sifre_cikis_2),
        .sifre_anahtar(sifre_anahtar_2)
    );

    // 3. Grup (Düzeltilen kısım: sb3 ve hisse 7-8-9)
    borsa_sec sb3(
        .hisse_no1(hisse_no7),
        .hisse_no2(hisse_no8),
        .hisse_no3(hisse_no9),
        .hisse_degeri1(hisse_degeri7),
        .hisse_degeri2(hisse_degeri8),
        .hisse_degeri3(hisse_degeri9),
        .bakiye(bakiye),
        .yatirimci_kimlik_no(yatirimci_kimlik_no),
        .karar_no(mod_karar_no3),
        .karar(mod_karar3),
        .kagit_sayisi(kagit_sayisi_3),
        .sifre_cikis(sifre_cikis_3),
        .sifre_anahtar(sifre_anahtar_3)
    );

    // Seçim ve deşifre bloğu
    always @(*) begin
        if (kagit_sayisi_1 >= kagit_sayisi_2 && kagit_sayisi_1 >= kagit_sayisi_3) begin
            karar_no = (sifre_cikis_1 / sifre_anahtar_1);
            if (kagit_sayisi_1 > 1000)
                karar = 2'b01;
            else
                karar = 2'b00;

        end else if (kagit_sayisi_2 >= kagit_sayisi_1 && kagit_sayisi_2 >= kagit_sayisi_3) begin
            karar_no = (sifre_cikis_2 / sifre_anahtar_2);
            if (kagit_sayisi_2 > 1000)
                karar = 2'b01;
            else
                karar = 2'b00;

        end else begin
            karar_no = (sifre_cikis_3 / sifre_anahtar_3);
            if (kagit_sayisi_3 > 1000)
                karar = 2'b01;
            else
                karar = 2'b00;
        end
    end

endmodule