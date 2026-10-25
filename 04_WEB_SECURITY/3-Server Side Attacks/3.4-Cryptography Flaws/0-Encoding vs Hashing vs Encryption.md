> [!summary] Özet
> Üçü de veriyi başka bir biçime çevirir ama **amaçları bambaşkadır**. En sık karıştırılan üç kavramdır:
> - **Encoding (Kodlama):** Veriyi taşınabilir/uyumlu bir biçime sokar. **Güvenlik sağlamaz**, anahtar yoktur, herkes geri çevirebilir.
> - **Hashing (Özetleme):** **Tek yönlüdür**, geri döndürülemez. Veriyi doğrulamak veya parmak izini almak için.
> - **Encryption (Şifreleme):** **İki yönlüdür**, anahtarla geri açılır. Gizliliği korumak için.

## Karşılaştırma

| | Encoding | Hashing | Encryption |
|---|---|---|---|
| **Amaç** | Uyumluluk / taşıma | Bütünlük & doğrulama | Gizlilik |
| **Geri döndürülebilir mi?** | Evet (herkes) | Hayır (tek yönlü) | Evet (anahtarla) |
| **Anahtar gerekir mi?** | Hayır | Hayır | Evet |
| **Çıktı boyutu** | Girdiyle orantılı | Sabit | Girdiyle orantılı |
| **Örnekler** | Base64, URL encoding, Hex, ASCII | MD5, SHA-1, SHA-256, bcrypt | AES, RSA, ChaCha20 |
| **CIA hedefi** | – (güvenlik değil) | Bütünlük | Gizlilik |

> [!warning] En sık yapılan hata
> **Base64 şifreleme değildir.** `dXNlcjpwYXNz` gibi bir metin "şifreli" değil, sadece kodlanmıştır — anahtar olmadan anında geri çözülür. Bir veri Base64 diye güvenli sanılmamalıdır.

## 1. Encoding (Kodlama)

Veriyi bir ortamın güvenle taşıyabileceği karakter kümesine çevirir. Amaç gizlilik değil, **uyumluluktur**.

- **Base64:** İkili veriyi (resim, dosya) metin olarak taşımak için. `A–Z a–z 0–9 + /` karakterleri ve sonda `=` dolgusu kullanılır → bu görüntü onu tanımanı sağlar.
- **URL encoding (percent-encoding):** URL'de özel karakterleri taşımak için. Boşluk → `%20`, `/` → `%2F`.
- **Hex:** Baytları `0–9 a–f` ile gösterir.

> [!tip] Tanıma
> Sonu `=` veya `==` ile biten, sadece harf-rakam-`+`-`/` içeren blok → büyük ihtimalle **Base64**. `%` dolu bir string → **URL encoding**.

## 2. Hashing (Özetleme)

Girdiyi **sabit uzunlukta**, geri döndürülemez bir özete çevirir. Aynı girdi her zaman aynı özeti verir; girdide tek bitlik değişiklik özeti baştan sona değiştirir (avalanche etkisi).

| Algoritma | Özet uzunluğu (hex) | Durum |
|---|---|---|
| MD5 | 32 karakter | **Kırık** — çakışma (collision) üretilebilir, kullanma |
| SHA-1 | 40 karakter | **Kırık** — terk edildi |
| SHA-256 | 64 karakter | Bütünlük için güvenli |
| bcrypt / argon2 | (kendi biçimi) | **Parola saklama** için önerilir (kasıtlı yavaş) |

**Kullanım alanları:**
- **Dosya bütünlüğü:** İndirilen dosyanın SHA-256'sını yayınlanan değerle karşılaştırmak.
- **Parola saklama:** Sunucu parolanın kendisini değil, **hash'ini** tutar. Giriş sırasında gelen parolanın hash'i karşılaştırılır.

> [!important] Salt neden şart?
> Aynı parola aynı hash'i verir → saldırgan önceden hesaplanmış tablolarla (rainbow table) eşleştirir. Her parolaya özel rastgele bir **salt** eklenince aynı parolalar bile farklı hash üretir ve bu tablolar işe yaramaz. Bu yüzden modern sistemler **salt'lı + kasıtlı yavaş** algoritmalar (bcrypt, argon2) kullanır. Ayrıntı: [[Hydra]] ve [[3-CIA Üçlüsü (CIA Triad)\|CIA Üçlüsü]].

## 3. Encryption (Şifreleme)

Veriyi bir **anahtarla** okunamaz hale getirir; doğru anahtarla geri açılır. Amaç **gizliliktir**.

| Tür | Anahtar | Örnek | Not |
|---|---|---|---|
| **Simetrik** | Şifreleme ve çözme aynı anahtar | AES, ChaCha20 | Hızlı; anahtarı güvenle paylaşmak zor |
| **Asimetrik** | Açık (public) + özel (private) anahtar çifti | RSA, ECC | Yavaş; anahtar paylaşımı ve imza için ideal |

> [!note] Gerçek dünyada ikisi birlikte
> TLS (HTTPS) hız için **simetrik** şifreleme kullanır, ama simetrik anahtarı güvenle paylaşmak için önce **asimetrik** şifrelemeden yararlanır. Bkz. [[0-TCP-IP Modeli\|TCP/IP Modeli]] içindeki TLS akışı.

## Hızlı Ayrım

> [!question] Hangisi?
> - Anahtar yok, herkes geri çevirebiliyor → **Encoding**
> - Geri çevrilemiyor, sabit uzunlukta → **Hashing**
> - Anahtarla geri açılabiliyor → **Encryption**

## İlgili Notlar

- [[3-CIA Üçlüsü (CIA Triad)\|CIA Üçlüsü]]: gizlilik (şifreleme) ve bütünlük (hash) hedefleri
- [[Heartbleed (CVE-2014-0160)]] ve [[Padding Oracle]]: şifreleme yanlış uygulandığında doğan açıklar
- [[Hydra]]: parolaların test edilmesi ve hash saklama bağlamı
- [[0-TCP-IP Modeli\|TCP/IP Modeli]]: TLS'in simetrik + asimetrik şifrelemeyi birlikte kullanması
