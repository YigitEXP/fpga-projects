`timescale 1ns / 1ps

module tb_borsa_sec_3_mux();
    reg [36:0] yatirimci_kimlik_no;
    reg [9:0]  hisse_no1, hisse_no2, hisse_no3;
    reg [9:0]  hisse_no4, hisse_no5, hisse_no6;
    reg [9:0]  hisse_no7, hisse_no8, hisse_no9;
    reg [31:0] hisse_degeri1, hisse_degeri2, hisse_degeri3;
    reg [31:0] hisse_degeri4, hisse_degeri5, hisse_degeri6;
    reg [31:0] hisse_degeri7, hisse_degeri8, hisse_degeri9;
    reg [63:0] bakiye;
    
    wire [9:0]  karar_no;
    wire [1:0]  karar;
    wire [63:0] kagit1, kagit2, kagit3;
    wire [63:0] sifre1, sifre2, sifre3;
    wire [63:0] anahtar1, anahtar2, anahtar3;

    borsa_sec_3_mux_2 uut3 (
        .hisse_no1(hisse_no1), .hisse_no2(hisse_no2), .hisse_no3(hisse_no3),
        .hisse_no4(hisse_no4), .hisse_no5(hisse_no5), .hisse_no6(hisse_no6),
        .hisse_no7(hisse_no7), .hisse_no8(hisse_no8), .hisse_no9(hisse_no9),
        .hisse_degeri1(hisse_degeri1), .hisse_degeri2(hisse_degeri2), .hisse_degeri3(hisse_degeri3),
        .hisse_degeri4(hisse_degeri4), .hisse_degeri5(hisse_degeri5), .hisse_degeri6(hisse_degeri6),
        .hisse_degeri7(hisse_degeri7), .hisse_degeri8(hisse_degeri8), .hisse_degeri9(hisse_degeri9),
        .bakiye(bakiye),
        .yatirimci_kimlik_no(yatirimci_kimlik_no),
        .karar_no(karar_no),
        .karar(karar),
        .kagit_sayisi_1(kagit1), .kagit_sayisi_2(kagit2), .kagit_sayisi_3(kagit3),
        .sifre_cikis_1(sifre1),   .sifre_cikis_2(sifre2),   .sifre_cikis_3(sifre3),
        .sifre_anahtar_1(anahtar1), .sifre_anahtar_2(anahtar2), .sifre_anahtar_3(anahtar3)
    );

    initial begin
        yatirimci_kimlik_no = 37'd12345;
        hisse_no1 = 10'd1; hisse_no2 = 10'd2; hisse_no3 = 10'd3;
        hisse_no4 = 10'd4; hisse_no5 = 10'd5; hisse_no6 = 10'd6;
        hisse_no7 = 10'd7; hisse_no8 = 10'd8; hisse_no9 = 10'd9;

        hisse_degeri1 = 32'd100; hisse_degeri2 = 32'd200; hisse_degeri3 = 32'd300;
        hisse_degeri4 = 32'd400; hisse_degeri5 = 32'd500; hisse_degeri6 = 32'd600;
        hisse_degeri7 = 32'd700; hisse_degeri8 = 32'd800; hisse_degeri9 = 32'd900;
        bakiye = 64'd10000;

        #20;
        $display("Secilen Karar No: %d, Karar: %b", karar_no, karar);

        $finish;
    end
endmodule