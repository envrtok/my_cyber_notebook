> [!summary] Özet
> **Actions on Objectives (Hedef Üzerindeki Eylemler)**, Cyber Kill Chain'in son aşamasıdır ve saldırganın tüm çabalarının sonuca ulaştığı noktadır. Saldırgan artık ağın içindedir, kalıcılığı sağlamıştır, komuta merkezine bağlıdır ve asıl amacını gerçekleştirmeye hazırdır.
> Saldırının amacı politik, finansal veya askeri olabilir; bu amaç, bu aşamada yapılacak eylemleri belirler.

## Olası Eylemler ve Hedefler

| Eylem | Bozduğu hedef ([[3-CIA Üçlüsü (CIA Triad)\|CIA]]) |
|---|---|
| Veri Hırsızlığı (Data Exfiltration) | Gizlilik |
| Şifreleme ve Fidye (Ransomware) | Erişilebilirlik (çifte şantajda Gizlilik de) |
| Veri Tahribatı ve Sabotaj | Erişilebilirlik |
| Kaynak Sömürüsü (Resource Hijacking) | Erişilebilirlik |
| Veri Manipülasyonu | Bütünlük |

### 1. Veri Hırsızlığı (Data Exfiltration)

En yaygın hedeftir. Hassas verilerin (müşteri bilgileri, kredi kartları, kaynak kodları, devlet sırları) kurum dışına çıkarılmasıdır.

**Yöntemler:**
- Veriyi parolalı arşivlere (RAR/ZIP) koyup parçalara bölerek dışarı taşımak
- DNS Tunneling, ICMP veya HTTPS üzerinden veri kaçırmak
- Bulut depolama servislerine (Dropbox, Google Drive) yüklemek

### 2. Şifreleme ve Fidye (Ransomware)

Saldırgan verileri çalmak yerine (veya çaldıktan sonra) sistemleri şifreler ve çözmek için fidye (Bitcoin vb.) talep eder.
- **Double Extortion (Çifte Şantaj):** Hem verileri şifrelemek hem de "fidyeyi ödemezseniz verileri yayımlarız" diye tehdit etmek.

### 3. Veri Tahribatı ve Sabotaj (Destruction)

Amaç kuruma zarar vermekse saldırgan verileri silebilir (Wiper malware) veya sistemleri kullanılamaz hale getirebilir (SCADA sistemlerine saldırı, diskleri formatlama).

### 4. Kaynak Sömürüsü (Resource Hijacking)

Sistemin işlemci gücünü kripto para madenciliği (Cryptomining) için kullanmak veya sistemi bir Botnet'in parçası yaparak başka hedeflere DDoS saldırısı düzenlemek.

### 5. Veri Manipülasyonu (Data Manipulation)

Verilerin bütünlüğünü bozmak; örneğin bir banka hesabındaki bakiyeyi veya bir hastanedeki hastanın kan grubunu değiştirmek.

> [!warning]
> Veri manipülasyonu fark edilmesi en zor ve potansiyel olarak en tehlikeli eylemdir; çünkü sistemler çalışmaya devam eder ve kimse verinin değiştiğini bilmez.

## Lateral Movement (Yanal Hareket)

Saldırganın ilk ele geçirdiği makine (Patient Zero) genellikle asıl hedefin (ör. veritabanı sunucusu) bulunduğu makine değildir. Bu nedenle saldırgan ağ içinde diğer makinelere sıçramak zorundadır. Bu sürece **Lateral Movement** denir.

**Kullanılan teknikler:**
- **Pass the Hash:** Parolayı bilmeden, bellekteki parola özetiyle (NTLM hash) kimlik doğrulama yapmak
- **RDP / SSH:** Ele geçirilen parolalarla diğer sunuculara uzaktan bağlanmak
- **WMI / PowerShell Remoting:** Windows yönetim araçlarıyla diğer makinelerde komut çalıştırmak → bkz. [[1-Arazidekiyle Yaşamak (Living off the Land)|Living off the Land]]

> [!note]
> CKC'de yanal hareket ayrı bir aşama değildir ve modelin zayıf noktalarından biridir. [[2-Cyber & Unified Kill Chain|Unified Kill Chain]] bunu "Through" fazında ayrıntılı olarak ele alır.

## Tespit ve Savunma

Saldırgan bu aşamaya geldiyse savunma hattı kırılmış demektir; ancak zarar hâlâ en aza indirilebilir.

1. **DLP (Data Loss Prevention):** Hassas verilerin (TC kimlik no, kredi kartı) ağ dışına çıkışını izleyen ve engelleyen sistemler
2. **Anomali Tespiti (UEBA):**
    - Bir kullanıcının normalde erişmediği dosyalara erişmesi
    - Gece yarısı yüksek miktarda veri transferi (upload)
    - Kısa sürede çok sayıda dosyanın adının veya uzantısının değişmesi (ransomware belirtisi)
3. **Ağ Segmentasyonu:** Sunucular arasındaki gereksiz erişimleri kısıtlayarak yanal hareketi zorlaştırmak
4. **Yedekleme (Backup):** Ransomware'e karşı en etkili savunma, çevrimdışı (offline) ve güncel yedeklere sahip olmaktır

## İlgili Notlar

- Önceki aşama: [[6-Command and Control|Command and Control]]
- [[0-Cyber Kill Chain|Cyber Kill Chain]]
- [[8-Savunma ve Tespit Mekanizmaları|Savunma ve Tespit Mekanizmaları]]
