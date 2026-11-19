> [!summary] Özet
> **UDP (User Datagram Protocol)**, bağlantısız ve "en iyi çaba" (best-effort) bir taşıma katmanı protokolüdür. Önceden bağlantı kurmaz, teslimatı garanti etmez, akış kontrolü yoktur. Buna karşılık **hızlı ve düşük ek yüklüdür**; ses, video ve DNS gibi gecikmenin önemli olduğu yerlerde kullanılır.

## Özellikleri

- Paketleri taşımak için önceden bağlantı kurulmasına gerek yoktur (bağlantısız).
- Verinin karşı tarafa ulaşıp ulaşmadığı kontrol edilmez.
- Kaybolan veri yeniden gönderilmez; akış/tıkanıklık kontrolü yoktur.
- Genellikle ses, video, DNS, DHCP, oyun trafiğinde kullanılır.

## UDP Segment (Datagram) Formatı

Başlık yalnızca **8 bayttır** (TCP'nin aksine çok sade):

| Alan | Açıklama |
|---|---|
| **Source Port** | İletişimi başlatan cihazın portu; hangi uygulamanın gönderdiğini belirtir |
| **Destination Port** | Hedef cihazdaki alıcı uygulamanın portu |
| **Length** | Başlık + veri toplam uzunluğu (bayt) |
| **Checksum** | Hata kontrolü — IPv4'te opsiyonel, **IPv6'da zorunludur** |

> [!tip] TCP mi, UDP mi?
> Güvenilirlik gerekiyorsa (web, dosya, e-posta) → [[9-TCP|TCP]]. Hız/gecikme kritikse ve küçük kayıplar tolere edilebiliyorsa (canlı ses/video, DNS) → UDP. Ayrıntılı karşılaştırma: [[0-TCP-IP Modeli|TCP/IP Modeli]].

## İlgili Notlar

- [[9-TCP|TCP]]: güvenilir, bağlantı yönelimli alternatif
- [[0-TCP-IP Modeli|TCP/IP Modeli]]: TCP/UDP karşılaştırması ve port aralıkları
- [[2-Nmap Scans and TCP Flags|Nmap Scans and TCP Flags]]: UDP taramasının neden yavaş ve belirsiz olduğu
