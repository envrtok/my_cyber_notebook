> [!summary] Özet
> **Çift bükümlü kablo (twisted pair)**, elektromanyetik paraziti ve komşu tellerdeki sinyal karışmasını (crosstalk) azaltmak için birbirine bükülmüş yalıtımlı bakır tel çiftlerinden oluşur. Ethernet/LAN'ların en yaygın kablosudur. Fiziksel katman ([[3-OSI Modeli|OSI]] L1).

## Nasıl Çalışır?

- İki yalıtımlı bakır tel belirli bir düzende birbirine sarılır.
- Bu büküm, tellerin ürettiği ve dışarıdan gelen elektromanyetik girişimi (EMI) dengeler.
- Çiftler arası sinyal sızıntısını (crosstalk) en aza indirir.

## Başlıca Türleri

| Tür | Ekran | Kullanım |
|---|---|---|
| **UTP** (Unshielded Twisted Pair) | Yok | Ev ve standart ofis ağları (en yaygın) |
| **FTP / STP / S/FTP** | Folyo/örgü ekran | Parazitin yoğun olduğu endüstriyel ortamlar |

## Kategori (Cat) Standartları

Her kategori belirli bir maksimum frekans ve iletim hızı sunar:

| Kategori | Hız | Frekans | Not |
|---|---|---|---|
| **Cat5e** | 1 Gbps | 100 MHz | Günümüzde taban standart |
| **Cat6** | 1 Gbps (10 Gbps ≤55 m) | 250 MHz | Yaygın modern seçim |
| **Cat6a** | 10 Gbps | 500 MHz | 100 m'de 10 Gbps |
| **Cat7** | 10 Gbps | 600 MHz | Ekranlı (S/FTP) |

## Konnektörler

| Konnektör | Pin | Kullanım |
|---|---|---|
| **RJ-11** | 4 | Telefon bağlantıları |
| **RJ-45** | 8 | Bilgisayar ve yerel ağ (Ethernet) bağlantısı |
| **DB-9** | 9 | Seri (serial) bağlantılar |

## TIA/EIA 568A ve 568B Kablolama Standartları

RJ-45 konnektörlerinde tellerin renk/pin düzenini belirleyen endüstri standartlarıdır.

- İki standart vardır: **568A** ve **568B**. İkisi de kullanılabilir; **568B** daha yeni ve önerilen olandır.
- Cihazların birbiriyle uyumlu çalışması için geliştirilmiştir.
- Kablo içindeki tellerin renk sırasına göre pinlenir.

### Düz (Straight-through) ve Çapraz (Crossover) Bağlantı

| | Düz Bağlantı | Çapraz Bağlantı |
|---|---|---|
| **Pin düzeni** | Her iki uç aynı (1→1, 2→2...) | Bir uçta bazı teller farklı pine (TX↔RX) |
| **Ne için?** | **Farklı** tür cihazları bağlamak | **Aynı** tür cihazları bağlamak |
| **Örnek** | PC ↔ switch/router, hub ↔ switch | PC ↔ PC, switch ↔ switch, router ↔ router |

> [!note] Auto-MDIX
> Modern cihazların çoğu **Auto-MDIX** özelliğiyle düz/çapraz ihtiyacını otomatik algılar. Bu nedenle çapraz kablonun pratikteki önemi büyük ölçüde azalmıştır.

## İlgili Notlar

- [[2-Koaksiyel Kablo|Koaksiyel Kablo]] ve [[3-Fiber Optik Kablo|Fiber Optik Kablo]]: diğer iletim ortamları
- [[3-OSI Modeli|OSI Modeli]]: fiziksel (L1) ve veri bağlantı (L2) katmanları
