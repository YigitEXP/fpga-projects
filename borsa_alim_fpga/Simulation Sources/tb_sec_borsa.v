module tb_sec_borsa();
    reg [9:0] tb_no1, tb_no2, tb_no3;
    reg [31:0] tb_degeri1, tb_degeri2, tb_degeri3;
    reg [63:0] tb_bakiye;
    reg [36:0] tb_yatirimci_kimlik_no;
    wire [1:0] tb_karar;

    wire [63:0] tb_sifre_anahtari;
    wire [63:0] tb_sifre_cikisi;
    wire [63:0] tb_kagit_sayisi;

    borsa_sec uut2 (.hisse_no1(tb_no1),
        .hisse_no2(tb_no2),
        .hisse_no3(tb_no3),
        .hisse_degeri1(tb_degeri1),
        .hisse_degeri2(tb_degeri2),
        .hisse_degeri3(tb_degeri3),
        .bakiye(tb_bakiye),
        .karar(tb_karar),
        .kagit_sayisi(tb_kagit_sayisi),
        .yatirimci_kimlik_no(tb_yatirimci_kimlik_no),
        .sifre_cikis(tb_sifre_cikisi),
        .sifre_anahtar(tb_sifre_anahtari)
    );


    initial begin
        tb_no1 = 10'd1;
        tb_no2 = 10'd2;
        tb_no3 = 10'd3;
        tb_degeri1 = 32'd100;
        tb_degeri2 = 32'd200;
        tb_degeri3 = 32'd300;
        tb_bakiye = 64'd10000;
        tb_yatirimci_kimlik_no = 37'd1234567890123456789;
    
        #10;
    
        tb_no1 = 10'd4;
        tb_no2 = 10'd5;
        tb_no3 = 10'd6;
        tb_degeri1 = 32'd400;
        tb_degeri2 = 32'd500;
        tb_degeri3 = 32'd600;
        tb_bakiye = 64'd20000;
        tb_yatirimci_kimlik_no = 37'd9876543210987654321;
    
        #10;
    
        $finish;
    end
endmodule