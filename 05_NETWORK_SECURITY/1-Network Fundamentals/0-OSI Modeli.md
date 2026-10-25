> [!summary] Özet
> OSI (Open Systems Interconnection) modeli, ağ iletişimini **7 katmana** bölen bir **referans modelidir** (ISO, 1984). Her katmanın tek bir görevi vardır: altındaki katmanın hizmetini kullanır, üstündekine hizmet verir.
> Gerçek internet [[0-TCP-IP Modeli|TCP/IP]] ile çalışır. OSI ise bir sorunu ya da saldırıyı **"hangi katmanda?"** diye konuşmanın ortak dilidir.

## 7 Katman

| # | Katman | Görevi | Veri birimi (PDU) | Adres |
|---|---|---|---|---|
| 7 | **Uygulama** (Application) | Kullanıcının uygulamasına ağ hizmeti sunar | Veri (data) | – |
| 6 | **Sunum** (Presentation) | Veriyi ortak biçime çevirir: kodlama, sıkıştırma, şifreleme | Veri | – |
| 5 | **Oturum** (Session) | İki uygulama arasındaki oturumu kurar, sürdürür, kapatır | Veri | – |
| 4 | **Taşıma** (Transport) | Uçtan uca iletim, portlarla doğru uygulamaya teslim, güvenilirlik | Segment (TCP) / Datagram (UDP) | Port |
| 3 | **Ağ** (Network) | Mantıksal adresleme ve farklı ağlar arasında yönlendirme | Paket (packet) | IP adresi |
| 2 | **Veri Bağlantısı** (Data Link) | Aynı yerel ağdaki cihazlar arası iletim, hata tespiti | Çerçeve (frame) | MAC adresi |
| 1 | **Fiziksel** (Physical) | Bitleri elektrik, ışık veya radyo sinyaline çevirir | Bit | – |

> [!tip] Ezber cümleleri
> - **Aşağıdan yukarı (1→7):** **P**lease **D**o **N**ot **T**hrow **S**ausage **P**izza **A**way → Physical, Data Link, Network, Transport, Session, Presentation, Application
> - **Yukarıdan aşağı (7→1):** **A**ll **P**eople **S**eem **T**o **N**eed **D**ata **P**rocessing

## Protokoller ve Cihazlar

| # | Örnek protokol / teknoloji | Bu katmanda çalışan cihaz |
|---|---|---|
| 7 | HTTP, DNS, FTP, SMTP, SSH, SNMP | Proxy, WAF, L7 yük dengeleyici |
| 6 | TLS/SSL, ASCII / UTF-8, JPEG, gzip | – |
| 5 | NetBIOS, RPC | – |
| 4 | TCP, UDP | Stateful firewall, L4 yük dengeleyici |
| 3 | IPv4, IPv6, ICMP, IPsec | Router, L3 switch |
| 2 | Ethernet (802.3), Wi-Fi (802.11), VLAN (802.1Q), ARP | Switch, bridge, ağ kartı (NIC) |
| 1 | UTP kablo, fiber, radyo sinyali | Hub, repeater, kablo |

- **Üst katmanlar (5–7)** uygulamayla ilgilenir ve sadece uç cihazlarda (host) çalışır.
- **Alt katmanlar (1–4)** verinin taşınmasıyla ilgilenir. L4 uçtan uca çalışır. L1–3 ise yol üzerindeki her cihazda işlenir.
- Bir cihaz, çalıştığı katmana kadar olan başlıkları okur: **hub** sadece sinyali tekrarlar (L1), **switch** MAC adresine bakar (L2), **router** IP adresine bakar (L3).

> [!important] Router'dan geçerken ne değişir?
> Router paketi L3'e kadar açar, L2 başlığını (MAC adreslerini) **yeniden yazar**, IP adreslerine dokunmaz (NAT yoksa). Ayrıntı: [[2-Farklı Ağlar Arası Ping ve ARP|Farklı Ağlar Arası Ping ve ARP]]

## Kapsülleme (Encapsulation)

Gönderen tarafta veri yukarıdan aşağı iner ve **her katman kendi başlığını ekler**. Alıcı tarafta veri aşağıdan yukarı çıkar ve her katman kendi başlığını okuyup çıkarır (decapsulation).

```
L7–5   [                 Veri                 ]
L4     [TCP]  [                 Veri          ]   → Segment
L3     [IP] [TCP]  [            Veri          ]   → Paket
L2     [Eth] [IP] [TCP]  [      Veri    ] [FCS]   → Çerçeve
L1     0110100101110010100101...                  → Bit
```

- L2 başlığın yanında sona bir de **FCS** (Frame Check Sequence) ekler. Alıcı bununla çerçevenin bozulup bozulmadığını kontrol eder.
- Her katman yalnızca karşı taraftaki **aynı katmanla** konuşur: gönderenin TCP'si alıcının TCP'si için başlık yazar, aradaki switch ve router'lar bu başlığa bakmaz.

> [!example] Wireshark'ta katmanlar
> Bir pakete tıklayınca ayrıntı panelinde katmanlar alttan üste sıralı görünür:
> `Frame` (yakalama bilgisi: zaman, uzunluk) → `Ethernet II` (L2) → `Internet Protocol Version 4` (L3) → `Transmission Control Protocol` (L4) → `Hypertext Transfer Protocol` (L7)

## Katmanlara Göre Saldırılar ve Savunmalar

| Katman | Örnek saldırılar | Savunma |
|---|---|---|
| 7 Uygulama | SQL injection, XSS, komut enjeksiyonu, DNS spoofing, HTTP flood | Girdi doğrulama, WAF, güncel yazılım |
| 6 Sunum | SSL stripping, TLS downgrade, zayıf şifreleme ([[Padding Oracle]], [[Heartbleed (CVE-2014-0160)]]) | Güncel TLS sürümü, güçlü şifre takımları, HSTS |
| 5 Oturum | Oturum ele geçirme (session hijacking) | Oturum zaman aşımı, girişten sonra oturum kimliğini yenileme |
| 4 Taşıma | SYN flood, UDP flood, port taraması | Stateful firewall, SYN cookies, hız sınırlama (rate limiting) |
| 3 Ağ | IP spoofing, ICMP flood / Smurf, ping sweep ile keşif | ACL'ler, sahte kaynak IP filtreleme (anti-spoofing), IPsec |
| 2 Veri Bağlantısı | ARP spoofing, MAC flooding, VLAN hopping, MAC spoofing, sahte DHCP sunucusu | Port security, Dynamic ARP Inspection, DHCP snooping, 802.1X |
| 1 Fiziksel | Kablo dinleme (tapping), sinyal karıştırma (jamming), kötü amaçlı USB, fiziksel erişim | Fiziksel güvenlik, kilitli kabinler, kullanılmayan portları kapatma |

> [!info] L2 neden kritik?
> ARP ve Ethernet kimlik doğrulama yapmaz; yerel ağdaki herkes birbirine güvenir.
> - **ARP spoofing:** Saldırgan kendini gateway gibi tanıtır, trafik onun üzerinden geçer (MITM).
> - **MAC flooding:** Switch'in MAC tablosu (CAM) sahte adreslerle doldurulur. Switch trafiği tüm portlara basmaya başlar ve dinlenebilir hale gelir.
>
> Bir katmanda düşen güvenlik üst katmanları da açıkta bırakır: L2'de araya giren saldırgan şifrelenmemiş L7 trafiğini okuyabilir.

> [!warning] Katman eşleştirmeleri her zaman kesin değil
> - TLS bazı kaynaklarda L6, bazılarında L5 ya da L7 olarak geçer.
> - ARP, IP adresini (L3) MAC adresine (L2) çevirdiği için "L2.5" diye de anılır.
> - Web oturumları (cookie) pratikte L7'de yönetilir.
>
> OSI bir **referans** modelidir. Gerçek protokoller katmanlara her zaman birebir oturmaz.

## Katmanlara Göre Araçlar

| Katman | Araç | Ne için |
|---|---|---|
| 7 | `curl`, Burp Suite, `dig`, `gobuster` | HTTP istekleri, web testleri, DNS sorguları, dizin keşfi |
| 4 | `nmap -sS` / `-sT` / `-sU`, `nc` (netcat) | Port taraması, TCP/UDP bağlantısı |
| 3 | `ping`, `traceroute`, `nmap -sn` | Erişilebilirlik, yol keşfi, host keşfi |
| 2 | `ip neigh`, `arp-scan`, `macchanger` | ARP tablosu, yerel ağ keşfi, MAC adresi değiştirme |
| Hepsi | Wireshark, `tcpdump` | Trafik yakalama ve analiz |

## Sorun Giderme: Aşağıdan Yukarı

> [!tip] "Site açılmıyor" → katman katman kontrol
> 1. **L1:** Kablo takılı mı, Wi-Fi bağlı mı?
> 2. **L2:** Arayüz ayakta mı, gateway'in MAC adresi ARP tablosunda var mı? (`ip link`, `ip neigh`)
> 3. **L3:** IP adresi ve gateway doğru mu, gateway'e ping gidiyor mu? (`ip a`, `ip route`, `ping`)
> 4. **L4:** Hedef port açık mı? (`nc -zv site.com 443`)
> 5. **L7:** Alan adı çözülüyor mu, sunucu ne cevap veriyor? (`dig site.com`, `curl -v https://site.com`)

## İlgili Notlar

- [[0-TCP-IP Modeli|TCP/IP Modeli]]: internetin gerçekte kullandığı 4 katmanlı model ve gerçek başlık alanları
- [[1-CIDR Gösterimi|CIDR Gösterimi]]: L3 adreslemesi, ağ ve host bitleri
- [[2-Farklı Ağlar Arası Ping ve ARP|Farklı Ağlar Arası Ping ve ARP]]: L2 ile L3'ün birlikte çalışması
- [[3-Common Network Protocols and Ports|Common Network Protocols and Ports]]: L7 protokolleri ve kullandıkları L4 portları
- [[2-Nmap Scans and TCP Flags|Nmap Scans and TCP Flags]]: L4'te TCP bayraklarıyla port taraması
