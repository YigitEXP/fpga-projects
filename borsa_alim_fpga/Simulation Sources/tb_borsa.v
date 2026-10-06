`timescale 1ns / 1ps

module tb_borsa();

    reg [9:0] tb_no1, tb_no2, tb_no3;
    reg [31:0] tb_deger1, tb_deger2, tb_deger3;
    reg [63:0] tb_bakiye;
    wire [1:0] tb_karar;
    wire [9:0] tb_karar_no;
    wire [63:0] tb_kagit_sayisi;

    borsa uut1(.hisse_no1(tb_no1),
        .hisse_no2(tb_no2),
        .hisse_no3(tb_no3),
        .hisse_degeri1(tb_deger1),
        .hisse_degeri2(tb_deger2),
        .hisse_degeri3(tb_deger3),
        .bakiye(tb_bakiye),
        .karar(tb_karar),
        .karar_no(tb_karar_no),
        .kagit_sayisi(tb_kagit_sayisi)
    );

    initial begin
        tb_no1=506; 
        tb_no2=704;
        tb_no3=125;
        
        tb_dgr1=10;
        tb_dgr2=20;
        tb_dgr3=30;
        tb_bakiye=150000;
        
        
        #5;
        tb_no1=506;
        tb_no2=205;
        tb_no3=125;
        
        tb_dgr1=250;
        tb_dgr2=100;
        tb_dgr3=300;
        tb_bakiye=150000;
        
        
        #5;
        tb_no1=506;
        tb_no2=205;
        tb_no3=125;
        
        tb_dgr1=250;
        tb_dgr2=100;
        tb_dgr3=300;
        tb_bakiye=8000;
        #5;
    end
    
endmodule