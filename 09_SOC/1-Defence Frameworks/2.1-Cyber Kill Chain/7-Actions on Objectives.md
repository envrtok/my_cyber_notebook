Cyber Kill Chain'in son aşaması olan **Hedef Üzerindeki Eylemler (Actions on Objectives)**, saldırganın tüm çabalarının sonucuna ulaştığı noktadır. Saldırgan artık ağın içindedir, kalıcılığı sağlamıştır, komuta merkezine bağlıdır ve asıl amacını gerçekleştirmeye hazırdır.

Saldırının amacı politik, finansal veya askeri olabilir. Bu amaç, bu aşamada yapılan eylemleri belirler.

## Olası Eylemler ve Hedefler

### 1. Veri Hırsızlığı (Data Exfiltration)

En yaygın hedeftir. Hassas verilerin (müşteri bilgileri, kredi kartları, kaynak kodlar, devlet sırları) kurum dışına çıkarılmasıdır.

**Yöntemler:**

- Veriyi şifreleyip (RAR/ZIP) parçalara bölerek dışarı taşıma.
- DNS Tunneling, ICMP veya HTTPS üzerinden veri kaçırma.
- Bulut depolama servislerine (Dropbox, Google Drive) yükleme.

### 2. Şifreleme ve Fidye (Ransomware)

Saldırgan verileri çalmak yerine (veya çaldıktan sonra) tüm sistemleri şifreler ve şifreyi çözmek için fidye (Bitcoin vb.) talep eder.

- **Double Extortion (Çifte Şantaj):** Hem verileri şifrelemek hem de "Fidyeyi ödemezseniz verileri halka açıklarız" diye tehdit etmek.

### 3. Veri Tahribatı ve Sabotaj (Destruction)

Amaç kuruma zarar vermekse, saldırganlar verileri silebilir (Wiper malware) veya sistemleri kullanılamaz hale getirebilir (SCADA sistemlerine saldırı, diskleri formatlama).

### 4. Kaynak Sömürüsü (Resource Hijacking)

Sistemin işlemci gücünü kullanarak kripto para madenciliği (Cryptomining) yapmak veya sistemi bir Botnet'in parçası haline getirerek başka hedeflere DDoS saldırısı düzenlemek.

### 5. Veri Manipülasyonu (Data Manipulation)

Verilerin bütünlüğünü bozmak. Örneğin bir banka hesabındaki bakiyeyi değiştirmek veya bir hastanedeki hasta kan grubunu değiştirmek. Bu, fark edilmesi en zor ve potansiyel olarak en tehlikeli saldırı türüdür.

## Lateral Movement (Yanal Hareket)

Genellikle saldırganın ilk ele geçirdiği makine (Patient Zero), asıl hedefin (örneğin Veritabanı Sunucusu) bulunduğu makine değildir. Bu nedenle saldırgan ağ içinde diğer makinelere sıçramak zorundadır. Bu sürece **Lateral Movement** denir.

**Kullanılan Teknikler:**

- **Pass the Hash:** Kullanıcının parolasını bilmeden, bellekteki parola özetiyle (NTLM Hash) kimlik doğrulama yapmak.
- **RDP / SSH:** Ele geçirilen parolalarla diğer sunuculara uzaktan bağlanmak.
- **WMI / PowerShell Remoting:** Windows yönetim araçlarını kullanarak diğer makinelerde komut çalıştırmak.
## Tespit ve Savunma

Saldırgan bu aşamaya geldiyse, "savunma hattı kırılmış" demektir. Ancak zarar hala minimize edilebilir.

1. **DLP (Data Loss Prevention):** Hassas verilerin (TC Kimlik No, Kredi Kartı) ağ dışına çıkışını izleyen ve engelleyen sistemler.
2. **Anomali Tespiti (UEBA):**
    - Bir kullanıcının normalde erişmediği dosyalara erişmesi.
    - Gece yarısı yüksek miktarda veri transferi (Upload).
    - Kısa sürede çok sayıda dosyanın isminin değişmesi (Ransomware belirtisi).
3. **Ağ Segmentasyonu:** Sunucular arasındaki gereksiz erişimleri kısıtlayarak Yanal Hareketi (Lateral Movement) zorlaştırmak.
4. **Yedekleme (Backup):** Ransomware saldırılarına karşı en etkili savunma, çevrimdışı (offline) ve güncel yedeklere sahip olmaktır.