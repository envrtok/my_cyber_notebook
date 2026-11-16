> [!summary] Özet
> **Delivery (İletim)**, silahlandırılmış payload'ın (weaponized payload) hedefe ulaştırıldığı aşamadır. Saldırının dış dünyadan kurum içine ilk kez temas ettiği nokta olduğu için savunmacılar açısından **en kritik engelleme fırsatlarından** biridir.

## İletim Yöntemleri

### 1. Phishing (Oltalama)

Zararlı e-postalar ile hedef kullanıcının bir eki açması veya bir linke tıklaması sağlanır.
- **Zararlı ekler:** Makrolu Office dosyaları, PDF, arşiv dosyaları
- **Zararlı linkler:** Sahte giriş sayfaları, zararlı dosya indiren siteler

### 2. Web Yoluyla İletim

- **Drive-by Download:** Kullanıcı yalnızca zararlı veya ele geçirilmiş bir siteyi ziyaret ettiğinde, haberi olmadan zararlı içerik indirilir veya tarayıcı açığı tetiklenir.
- **Watering Hole:** Saldırgan, hedef kitlenin sık ziyaret ettiği meşru bir siteyi ele geçirir ve kurbanların oraya gelmesini bekler.

### 3. USB / Harici Medya (Baiting)

- Zararlı USB bellekler hedefin bulabileceği yerlere bırakılır.
- **USB Rubber Ducky:** Bilgisayara klavye (HID cihazı) olarak tanıtılır ve önceden yazılmış tuş vuruşlarını insanüstü bir hızla göndererek zararlı komutları çalıştırır. Klavye olarak göründüğü için çoğu antivirüs tarafından fark edilmez.

## E-posta Kimlik Doğrulama: SPF, DKIM, DMARC

| Mekanizma | Ne yapar? |
|---|---|
| **SPF** (Sender Policy Framework) | Domain sahibinin, kendi domaini adına e-posta göndermeye **yetkili sunucuların IP'lerini** DNS'te yayınlamasıdır. Alıcı, gönderen IP'nin bu listede olup olmadığını kontrol eder. |
| **DKIM** (DomainKeys Identified Mail) | E-postaya kriptografik bir **dijital imza** ekler. Alıcı, DNS'teki açık anahtarla imzayı doğrulayarak e-postanın **yolda değiştirilmediğini** (bütünlük) ve gerçekten o domainden geldiğini anlar. |
| **DMARC** | SPF ve DKIM sonuçlarına göre, doğrulamayı geçemeyen e-postaya **ne yapılacağına** karar verir (`none`, `quarantine`, `reject`) ve domain sahibine rapor gönderir. |

```
Gelen e-posta ──► SPF kontrolü ──┐
                                  ├──► DMARC politikası ──► Teslim / Karantina / Reddet
               ──► DKIM kontrolü ─┘
```

## İletim Aşamasında Savunma

- E-posta eklerini sandbox'ta analiz etmek, link analizi yapmak
- SPF, DKIM ve DMARC'ı zorunlu hale getirmek
- Zararlı veya yeni kaydedilmiş (newly registered) domainlere ve IP'lere erişimi engellemek
- Kullanıcı farkındalık eğitimleri (phishing simülasyonları)
- USB ve harici medya kullanımını kısıtlamak

## İlgili Notlar

- Önceki aşama: [[2-Weaponization|Weaponization]] · Sonraki aşama: [[4-Exploitation|Exploitation]]
- [[0-Cyber Kill Chain|Cyber Kill Chain]]
