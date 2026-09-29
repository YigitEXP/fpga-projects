## << ve >> sola sağa kaydırma operatörleridir
### assign shifted = 3'b110 << 2 işleminin sonucunda 2 kere sola kayar ve shifted = 000 olarak kalır
### assign shifted = 3'b110 >> 2 işleminin sonucunda 2 kere sağa kayar ve shifted = 011 olarak kalır
-----------------------------------------------------------------------------------------------------------------------
## Bir a değişkeninde b+3 ile b aralığını seçmek için a[b+3 : b] yazamayız bunu kabul etmez
### a[b +: 4] veya a[(b+3) -: 4] yapılmalıdır -> b'nin üzerine 4 aralık veya b+3 ten aşağı 4 aralık
-----------------------------------------------------------------------------------------------------------------------
## ilk değerler initial bloğuyla atanır
### initial begin
###     outp = 3'b000;
###     counter = 16'd0
### end 
-----------------------------------------------------------------------------------------------------------------------
