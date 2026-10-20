> [!summary] Özet
> `IP/n` yazımında `/n`, 32 bitlik IPv4 adresinin **ilk n bitinin sabit** (ağ kısmı) olduğunu söyler. Kalan bitler değişebilir. Nmap bu aralıktaki **tüm adresleri** tarar.
> Tarama verilen IP'den değil, **o IP'nin içinde bulunduğu bloğun başından** başlar.

## Formül

$$\text{Adres sayısı (blok boyutu)} = 2^{(32 - n)}$$

- `/n` **büyüdükçe** → aralık **küçülür**
- `/n` **küçüldükçe** → aralık **büyür**

## Hızlı Referans

| CIDR | Alt ağ maskesi  | Adres sayısı | Örnek aralık                   |
| ---- | --------------- | ------------ | ------------------------------ |
| /32  | 255.255.255.255 | 1            | 192.168.1.5 (tek host)         |
| /30  | 255.255.255.252 | 4            | 192.168.1.0 – 192.168.1.3      |
| /29  | 255.255.255.248 | 8            | 192.168.1.8 – 192.168.1.15     |
| /28  | 255.255.255.240 | 16           | 192.168.1.0 – 192.168.1.15     |
| /24  | 255.255.255.0   | 256          | 192.168.1.0 – 192.168.1.255    |
| /16  | 255.255.0.0     | 65.536       | 192.168.0.0 – 192.168.255.255  |
| /8   | 255.0.0.0       | 16.777.216   | 10.0.0.0 – 10.255.255.255      |

## Mantığı: /24 Örneği

```
192.168.1.0/24

11000000.10101000.00000001 . xxxxxxxx
└──────── 24 bit sabit ───┘   └ 8 bit ┘
         (ağ kısmı)          (değişken)

2^8 = 256 adres → 192.168.1.0 – 192.168.1.255
```

## Blok Başlangıcı: Neden Verdiğim IP'den Başlamıyor?

> [!question] Soru
> `10.10.12.13/29` yazdım ama tarama `10.10.12.8`'den başladı. Neden?

CIDR blokları **blok boyutunun katlarında** başlar. `/29` için blok boyutu 8'dir, dilimler şöyledir:

`0–7` · `8–15` · `16–23` · `24–31` · …

`13`, **8–15** dilimine düşer. Bu yüzden Nmap o dilimin tamamını tarar.

### Bit düzeyinde

`/29` → ilk 29 bit sabit, **son 3 bit değişken**. Nmap değişken bitleri sıfırlayarak bloğun başını bulur:

```
13  = 00001 101
          └ son 3 bit sıfırlanır
8   = 00001 000  → başlangıç
15  = 00001 111  → bitiş
```

### Pratik hesap

$$\text{Başlangıç} = \left\lfloor \frac{\text{IP'nin son kısmı}}{\text{blok boyutu}} \right\rfloor \times \text{blok boyutu}$$

$$\text{Bitiş} = \text{Başlangıç} + \text{blok boyutu} - 1$$

Örnek: $\lfloor 13 \div 8 \rfloor = 1$ → $1 \times 8 = 8$ → bitiş $8 + 8 - 1 = 15$

### Gerçek çıktı

```console
$ nmap -sL -n 10.10.12.13/29
Nmap scan report for 10.10.12.8
Nmap scan report for 10.10.12.9
Nmap scan report for 10.10.12.10
Nmap scan report for 10.10.12.11
Nmap scan report for 10.10.12.12
Nmap scan report for 10.10.12.13
Nmap scan report for 10.10.12.14
Nmap scan report for 10.10.12.15
Nmap done: 8 IP addresses (0 hosts up) scanned in 0.00 seconds
```

## Aralık Yazımı (CIDR'a Alternatif)

Tam olarak belirli bir IP'den başlamak istiyorsan CIDR yerine **tire ile aralık** yaz:

```bash
nmap -sL -n 10.10.12.13-20    # 10.10.12.13'ten 10.10.12.20'ye kadar
```

> [!tip] Ne zaman hangisi?
> - **CIDR (`/n`)** → bir ağın / alt ağın tamamını taramak için
> - **Aralık (`a-b`)** → tam olarak istediğin başlangıç ve bitişi belirlemek için

## Nmap Komutları

```bash
nmap 192.168.1.0/24          # /24 ağın tamamını tara
nmap -sL 192.168.1.0/24      # tarama yapmadan sadece hedef listesini göster
nmap -sL -n 10.10.12.13/29   # listele, DNS çözümlemesi yapma (-n)
nmap -sn 192.168.1.0/24      # port taramadan, sadece açık (canlı) hostları bul
nmap 10.10.12.13-20          # belirli bir aralığı tara
```

## Dikkat

> [!warning] Unutma
> - CIDR'da tarama **bloğun başından** başlar, yazdığın IP'den değil.
> - `/8` gibi geniş aralıklar saatlerce sürebilir.
> - Ağ adresi (bloğun ilk adresi) ve yayın adresi (bloğun son adresi) de aralığa dahildir.
> - Yalnızca **sahip olduğun** veya **izin aldığın** ağları tara.