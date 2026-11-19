> [!summary] Özet
> **Subnet mask**, bir IP adresinin hangi kısmının **ağı**, hangi kısmının **cihazı (host)** temsil ettiğini belirler. **Ağ adresi** ise o ağın kimliğidir — host kısmının tamamı `0` yapılmış halidir. Bu iki kavram, [[8-CIDR Gösterimi|CIDR]] ve subnetting'in temelidir.

## 1. IP Adresi

Diyelim ki bilgisayarının IP adresi:

`192.168.1.35`

Bu adres ağdaki cihazını tanımlar. Ama tek başına bu IP'ye bakarak cihazın **hangi ağa ait** olduğunu anlayamayız; bunun için subnet mask gerekir.

## 2. Subnet Mask Nedir?

Örnek bir subnet mask:

`255.255.255.0`

IP adresinin hangi bölümünün ağ, hangi bölümünün cihaz olduğunu söyler. İkisini yan yana koyalım:

| | İlk 3 oktet | Son oktet |
|---|---|---|
| **IP adresi** | 192.168.1 | 35 |
| **Subnet mask** | 255.255.255 | 0 |
| **Anlamı** | Ağ kısmı | Cihaz kısmı |

Yani:
- `192.168.1` → **ağın kimliği**
- `35` → o ağdaki **cihazın numarası**

Bu subnet mask'in [[8-CIDR Gösterimi|CIDR]] gösterimi `/24`'tür (ilk 24 bit ağ).

## 3. Ağ Adresi (Network Address)

Ağ adresi, bir subnet'i tanımlayan özel IP'dir. Örneğimizde:

- IP adresi: `192.168.1.35`
- Subnet mask: `255.255.255.0`
- **Ağ adresi: `192.168.1.0`**

Neden `.0`? Çünkü maskeye göre son 8 bit cihazlara ayrılmıştır ve ağ adresinde **cihaz kısmının tamamı `0` yapılır**.

| `192.168.1.0/24` ağı | Adres |
|---|---|
| Ağ adresi | 192.168.1.0 |
| Kullanılabilir IP'ler | 192.168.1.1 – 254 |
| Broadcast | 192.168.1.255 |

Toplam 256 adres; geleneksel kullanımda 254'ü cihazlara verilebilir.

## 4. Ne İşe Yarıyor?

Üç cihaz düşünelim (hepsinin maskesi `255.255.255.0`):

| Cihaz | IP adresi | Ağı |
|---|---|---|
| Bilgisayar A | 192.168.1.35 | 192.168.1.0 |
| Bilgisayar B | 192.168.1.70 | 192.168.1.0 |
| Bilgisayar C | 192.168.2.10 | 192.168.2.0 |

- **A ve B aynı ağda** (`192.168.1.0`) → doğrudan yerel ağ üzerinden haberleşirler.
- **C farklı ağda** (`192.168.2.0`) → onunla haberleşmek için **router** gerekir.

> [!question]- `192.168.10.45/24` adresinin ağ adresi nedir?  _(192.168.10.45 / 192.168.10.0 / 192.168.10.255 / 192.168.0.0)_
> **`192.168.10.0`** — `/24`'te son oktet cihaz (host) kısmıdır; ağ adresinde sıfırlanır.

> [!note] Sırada ne var?
> Subnet mask ve ağ adresi oturduktan sonra sıradaki adım `/24`, `/25`, `/26`, `/27` gibi [[8-CIDR Gösterimi|CIDR]] değerleri ve bunların üstüne kurulan **subnetting** (bir ağı daha küçük ağlara bölme).

## İlgili Notlar

- [[6-IP|IP]]: bölünen mantıksal adresin kendisi
- [[8-CIDR Gösterimi|CIDR Gösterimi]]: `/n` gösterimi ve ağ/host bit ayrımı
