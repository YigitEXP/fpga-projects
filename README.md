# SystemVerilog Notları & İpuçları

Bu doküman, SystemVerilog ile donanım tasarımı (RTL) ve doğrulama yaparken sıkça karşılaşılan kuralları, modern sözdizimi standartlarını, veri yapılarını ve sık yapılan hataları (Common Mistakes) içermektedir.

---

### 1. Kaydırma Operatörleri (`<<` ve `>>`)

`<<` (sola kaydırma) ve `>>` (sağa kaydırma) operatörleri bitleri belirtilen miktar kadar kaydırır; boşalan basamaklar `0` ile doldurulur.

- **Sola Kaydırma (`<<`):**

```systemverilog
logic [2:0] shifted;
assign shifted = 3'b110 << 2; // Sonuç: 3'b000 (Taşan bitler kırpılır)
```

- **Sağa Kaydırma (`>>`):**

```systemverilog
logic [2:0] shifted;
assign shifted = 3'b110 >> 2; // Sonuç: 3'b001
```

---

### 2. Değişken İndeksli Aralık Seçimi (Indexed Part-Select)

SystemVerilog'da bit aralığı seçilirken sınır değerlerinin donanım sentezlenebilirliği açısından genişliğinin sabit kalması gerekir. Bu nedenle değişken içeren aralıklarda `a[b+3 : b]` kullanımı **geçersizdir** ve derleme hatası verir.

Bunun yerine **Indexed Part-Select** sözdizimi kullanılır:

- **Yukarı Doğru Seçim (`+:`):** `a[b +: 4]` $\rightarrow$ `b` indeksinden başlayarak yukarı doğru **4 bit** seçer (`a[b+3 : b]`).
- **Aşağı Doğru Seçim (`-:`):** `a[(b+3) -: 4]` $\rightarrow$ `b+3` indeksinden başlayarak aşağı doğru **4 bit** seçer (`a[b+3 : b]`).

---

### 3. Başlangıç Değerleri ve Dolgu Literalları (`'0`, `'1`)

SystemVerilog'da bit genişliğini elle saymak yerine dolgu (fill) operatörleri kullanılır.

```systemverilog
logic [63:0] bakiye;

initial begin
    bakiye = '0; // 64 bitin tamamını 0 yapar
    // bakiye = '1; // 64 bitin tamamını 1 (FF...FF) yapar
end
```

---

### 4. Parametrik Tasarım ve Amaca Özel Bloklar (`always_comb`, `always_ff`)

SystemVerilog'da belirsiz `always @(*)` veya `always @(posedge clk)` yerine niyet belirten özel bloklar tercih edilir:

```systemverilog
module AdderNBit #(
    parameter int N = 8
)(
    input  logic [N-1:0] number1,
    input  logic [N-1:0] number2,
    output logic [N:0]   result
);

    // Kombinazyonel Mantık için always_comb
    always_comb begin
        result = number1 + number2;
    end

endmodule
```

---

### 5. Dizi (Array) ve Yapı (Struct) Mimarisi

Dizilerde **Unpacked** (Eleman Sayısı) ve **Packed** (Bit Genişliği/Vector) ayrımı kritik önem taşır:

- **Paketlenmemiş Dizi (Unpacked Array):**
```systemverilog
int myFIFO [0:7]; // 8 elemanlı, her elemanı 32-bit olan dizi
```

- **Veri Paketleme (Packed Struct - RTL Dostu):**
```systemverilog
typedef struct packed {
    logic [9:0]  hisse_no;
    logic [31:0] hisse_degeri;
} hisse_t; // Donanımda 42-bitlik kesintisiz bir otobüs oluşturur
```

---

### 6. Sık Yapılan Hatalar (Common Mistakes)

#### Mistake #1: `logic` Değişkeninin Çoklu Sürücüsü (Multiple Drivers) Olabileceğini Sanmak
Düz bir `logic data;` tanımı arka planda **değişkendir (variable)** ve yalnızca **tek bir kaynaktan** (Single Driver) sürülebilir.

```systemverilog
// YASAK (ILLEGAL):
logic data;
assign data = 1'b1;
initial data = 1 me; // HATA: Değişken hem assign hem prosedürel sürülemez!

// ÇÖZÜM (Tri-state / Shared Bus İçin):
wire logic data; // 'wire' eklendiği an Net (Kablo) olur ve çoklu sürücüyü destekler.
assign data = 1'b1;
assign data = 1'b0; // YASAL (Legal)
```

#### Mistake #2: `logic` ve `reg` Türlerinin Farklı Olduğunu Sanmak
`logic` ve `reg` veri tipi seviyesinde **birebir aynıdır** (ikisi de 4-state: `0, 1, X, Z`). `logic` tipi hem `assign` hem de `always_comb/ff` bloklarında kullanılabilme esnekliğine sahiptir.

#### Mistake #3: Sürülmeyen Bir Hattın `0` Olacağını Varsaymak
Atama yapılmayan sinyaller asla varsayılan olarak `0` başlamaz:
- `logic` / `reg` (Değişkenler) $\rightarrow$ İlk anda **`X` (Unknown / Bilinmeyen)** değerini alır.
- `wire` (Kablosal Hatlar) $\rightarrow$ İlk anda **`Z` (High-Impedance / Kopuk Hat)** değerini alır.

#### Mistake #4: `logic` İle 2-State (2 Durumlu) Tipleri Karıştırmak
- **`logic` = 4-State (`0, 1, X, Z`):** Sentezlenebilir RTL tasarımları için zorunludur.
- **`bit` / `byte` / `int` = 2-State (`0, 1`):** Sadece simülasyonu hızlandırmak için Testbench tarafında tercih edilmelidir.