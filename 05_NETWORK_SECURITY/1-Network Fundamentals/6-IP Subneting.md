> [!summary] Özet
> **Subnetting**, büyük bir IP ağını daha küçük parçalara (alt ağ / subnet) bölmektir. Mantık tek cümlede: bir IP adresinin bir kısmı **ağı**, geri kalanı **cihazları (host)** anlatır; subnetting, bu sınırı sağa kaydırıp **host kısmından biraz "ödünç alarak"** birden çok küçük ağ oluşturmaktır. Gösterim (`/24` gibi) için önce bkz. [[1-CIDR Gösterimi|CIDR Gösterimi]].

## 1. Neden bölüyoruz? (Benzetme)

Bir apartman düşün: tek koca bir salon yerine katlara ve dairelere bölünür. Böylece her daire ayrı, yönetilebilir ve komşular birbirinin içinde gezmez.

Ağda da aynısı: koca bir `/24` ağını olduğu gibi kullanmak yerine küçük alt ağlara bölersek:
- Her departman/kat kendi ağında olur (**segmentasyon**),
- Adresler boşa gitmez (**verimlilik**),
- Trafik ve güvenlik daha kolay yönetilir.

## 2. Bir IP iki parçadan oluşur

Bir IPv4 adresi 32 bittir ve iki bölümü vardır:

```
192.168.1.      10
└── AĞ kısmı ──┘ └ HOST ┘
   (sabit)      (değişir)
```

- **Ağ kısmı:** Aynı alt ağdaki herkeste **aynıdır**.
- **Host kısmı:** Her cihazda **farklıdır**.

Bu sınırın nerede olduğunu **alt ağ maskesi** söyler. `/24` = "ilk 24 bit ağ, kalan 8 bit host" demektir.

> [!important] Subnetting'in tek fikri
> Host kısmından **bit ödünç alıp** onları ağ kısmına katarsın. Ödünç aldığın her bit, ağ sayısını **2 katına** çıkarır ama her ağdaki cihaz sayısını **yarıya** indirir.

## 3. En kolay yöntem: "Blok boyutu"

Son oktetle (adresin son sayısı) uğraşırken tek bir sayı her şeyi çözer: **blok boyutu**.

$$\text{Blok boyutu} = 256 - (\text{maskenin son oktet değeri})$$

Alt ağlar bu blok boyutunun **katlarında** başlar: `0, blok, 2×blok, 3×blok …`

**Örnek:** `/26` maskesi → ondalık maske `255.255.255.192` → blok boyutu = `256 − 192 = 64`.
Yani alt ağlar: `.0`, `.64`, `.128`, `.192` adreslerinden başlar.

## 4. Adım adım örnek: `/24` ağını 4'e bölmek

**İstek:** `192.168.1.0/24` ağını 4 eşit alt ağa böl.

**Adım 1 — Kaç bit ödünç?**
4 alt ağ istiyoruz. `2^n ≥ 4` → `n = 2` bit ödünç alırız.
Yeni maske = `/24 + 2` = **`/26`**.

**Adım 2 — Blok boyutu?**
`/26` → maske `255.255.255.192` → blok = `256 − 192 = 64`.

**Adım 3 — Alt ağları 64'er 64'er yaz:**

| Alt ağ | Ağ adresi | Kullanılabilir cihazlar | Broadcast |
|---|---|---|---|
| 1 | 192.168.1.**0**/26 | .1 – .62 | .63 |
| 2 | 192.168.1.**64**/26 | .65 – .126 | .127 |
| 3 | 192.168.1.**128**/26 | .129 – .190 | .191 |
| 4 | 192.168.1.**192**/26 | .193 – .254 | .255 |

Her blok 64 adres içerir ve bir sonraki blok, öncekinin bittiği yerden başlar. Hepsi bu!

## 5. Her alt ağdaki 3 özel adres

Her alt ağda uç adresler ayrılmıştır, aradakiler cihazlara verilir:

| Adres | Nedir? | Örnek (`.0/26` bloğu) |
|---|---|---|
| **İlk adres** | Ağ adresi (ağın kimliği, cihaza verilemez) | 192.168.1.0 |
| **Ortadakiler** | Kullanılabilir host adresleri | 192.168.1.1 – .62 |
| **Son adres** | Broadcast (ağdaki herkese) | 192.168.1.63 |

> [!tip] Neden "−2"?
> Bir alt ağda kullanılabilir cihaz sayısı **2ⁿ − 2**'dir (n = host biti). İlk adres ağ adresine, son adres broadcast'e ayrıldığı için 2 adres düşülür.

## 6. Formüller (özet)

| Soru | Formül |
|---|---|
| Kaç alt ağ oluşur? | `2^(ödünç alınan bit)` |
| Alt ağ başına kaç cihaz? | `2^(kalan host biti) − 2` |
| Blok boyutu (adres aralığı) | `256 − maskenin son oktet değeri` |

## 7. Hızlı referans

| CIDR | Maske (son oktet) | Blok boyutu | Kullanılabilir host |
|---|---|---|---|
| /24 | 0 | 256 | 254 |
| /25 | 128 | 128 | 126 |
| /26 | 192 | 64 | 62 |
| /27 | 224 | 32 | 30 |
| /28 | 240 | 16 | 14 |
| /29 | 248 | 8 | 6 |
| /30 | 252 | 4 | 2 |

## 8. FLSM vs VLSM (bir cümlede)

- **FLSM (sabit boyut):** Tüm alt ağlar aynı boyutta (yukarıdaki örnek gibi). Basit ama adres israf edebilir.
- **VLSM (değişken boyut):** Her alt ağ ihtiyacı kadar büyük olur. En büyük ihtiyaçtan küçüğe doğru sırayla yerleştirilir; adresleri en verimli kullanan yöntemdir.

> [!example] VLSM mantığı
> 50 cihazlık ağa `/26` (62 host), 30 cihazlığa `/27` (30 host), 10 cihazlığa `/28` (14 host), 2 cihazlığa `/30` (2 host) verilir. Her ağ, bir öncekinin bittiği adresten devam eder.

## İlgili Notlar

- [[1-CIDR Gösterimi|CIDR Gösterimi]]: `/n` gösterimi ve blok başlangıcı mantığı
- [[5-IP|IP]]: bölünen mantıksal adresin yapısı
