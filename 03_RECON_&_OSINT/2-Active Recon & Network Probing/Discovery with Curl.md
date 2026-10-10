`curl`, web pentestinde manuel keşif (manual discovery) aşamasının temel araçlarından biridir. Farklı bayraklarla (flags) farklı amaçlara hizmet eder: header incelemesi, bağlantı detayları, veya doğrudan içerik/response body görüntüleme.

---

## 1. Düz `curl <URL>` — Response Body Görüntüleme

**Ne yapar:** Standart bir `GET` isteği gönderir ve sunucunun döndürdüğü içeriği (HTML, JSON, dosya vb.) doğrudan terminale basar.

```bash
curl http://target/api/
```

**Pentest değeri:**

- Bir API endpoint'ine düz istek atıldığında, sunucu bazen kendi route yapısını ifşa edebilir.
- Örnek: Gobuster ile `/api` endpoint'i bulunduktan sonra:

```bash
curl http://10.112.139.124/api/
# {"endpoints":["/api/user","/api/jobs","/api/applications"]}
```

- Bu, kimlik doğrulaması yapılmadan iç API route'larının keşfedilebilmesi anlamına gelir → **information disclosure** zafiyeti.
- Bulunan her endpoint (`/api/user`, `/api/jobs` vb.) tek tek test edilmeli: IDOR, eksik yetkilendirme, aşırı veri ifşası (excessive data exposure) gibi zafiyetler için.

---

## 2. `curl -I` — Sadece Header'ları Alma

**Ne yapar:** `GET` yerine `HEAD` isteği gönderir; sayfa içeriğini indirmeden sadece HTTP başlıklarını döner.

```bash
curl -I https://example.com
```

Örnek çıktı:

```
HTTP/2 200
content-type: text/html; charset=UTF-8
content-length: 1256
server: nginx
cache-control: max-age=600
```

**Pentest değeri:**

- **Hız:** İçerik indirilmediği için büyük ölçekli taramalarda (çok sayıda URL) zaman ve bant genişliği tasarrufu sağlar.
- **Durum kodu kontrolü:** Site ayakta mı, 200/404/301/302 dönüyor mu?
- **Sunucu/teknoloji bilgisi:** `Server`, `X-Powered-By` gibi başlıklardan altyapı bilgisi.
- **Cache/ETag analizi:** `cache-control`, `etag`, `last-modified`.
- **Content-Type kontrolü:** Dosyayı indirmeden tipini öğrenmek.

⚠️ **Not:** Bazı sunucular `HEAD` isteklerini düzgün desteklemez, yanıltıcı sonuç dönebilir. Bu durumda:

```bash
curl -sD - -o /dev/null <URL>   # GET isteği atar, body'yi çöpe atar, sadece header basar
```

---

## 3. `curl -v` — Verbose (Ayrıntılı) Mod

**Ne yapar:** İstek ve yanıtın tamamını, bağlantı kurulum sürecini (TLS handshake, redirect zinciri, gönderilen/gelen header'lar) ayrıntılı gösterir.

```bash
curl -v http://target
```

**Pentest değeri:**

- Header bilgisiyle birlikte **TLS/SSL detayları** ve **redirect zincirini** de görmek gerektiğinde `-I` yerine tercih edilir.
- `Server: Apache/2.4.41`, `X-Powered-By: PHP/7.4` gibi bilgiler burada da görülebilir → framework/versiyon tespiti, ardından CVE araştırması için kullanılır.

---

## 4. Favicon Hashing ile Framework Tespiti

**Ne yapar:** `curl` ile favicon dosyasını indirip hash'ini (genelde MurmurHash3) alarak, bilinen framework imzalarıyla (Shodan gibi veritabanlarında) eşleştirme yapılır.

```bash
curl -s http://target/favicon.ico -o favicon.ico
```

**Pentest değeri:**

- Geliştiriciler genelde framework'ün varsayılan favicon'unu değiştirmeyi unutur (Spring Boot, React, Tomcat vb.).
- Bu sayede sunucuda çalışan spesifik framework ve versiyon hızlıca tespit edilebilir.

---

## Hızlı Referans Tablosu

|Komut|Amaç|Ne zaman kullanılır|
|---|---|---|
|`curl <URL>`|Response body görüntüleme|API/endpoint içeriğini görmek, JSON/HTML çıktısını incelemek|
|`curl -I`|Sadece header'ları alma (HEAD isteği)|Hızlı durum kodu / server bilgisi kontrolü, toplu tarama|
|`curl -v`|Header + bağlantı detayları|TLS bilgisi, redirect zinciri, ayrıntılı debug|
|`curl -s`|Sessiz mod (progress bar gizli)|Script içinde temiz çıktı almak için diğer bayraklarla birlikte|
|`curl -sD - -o /dev/null`|GET atıp sadece header göster|`HEAD` isteğini desteklemeyen sunucularda `-I` alternatifi|

---

## İlgili Manuel Keşif Teknikleri (Bağlam)

- `robots.txt` → Arama motorlarından gizlenen dizinleri (`/admin`, `/dev-backup` vb.) ortaya çıkarır.
- `sitemap.xml` → Sitenin genel yapısını, unutulmuş sayfaları/eski API versiyonlarını gösterir.
- Favicon Hashing → Framework/versiyon tespiti (yukarıda detaylı).
- HTTP Response Headers → Sunucu/backend dil bilgisi ifşası.
- Wappalyzer vb. araçlar → Tüm teknoloji yığınının (stack) tespiti.