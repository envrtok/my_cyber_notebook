> [!summary] Özet
> **ARP (Address Resolution Protocol / Adres Çözümleme Protokolü)**, bilinen bir **IP adresinden (L3)** o cihazın **fiziksel MAC adresini (L2)** bulmak için kullanılır. İki katman arasında köprü kurduğu için çoğu zaman **"L2.5"** olarak anılır; yalnızca aynı yerel ağ (broadcast domain) içinde çalışır.

## Nasıl Çalışır?

| Terim | Açıklama |
|---|---|
| **ARP Request** | Gönderici, hedef IP'nin MAC'ini öğrenmek için ağa **broadcast** yayınlar: "`192.168.1.1` kimde?" |
| **ARP Reply** | İsteği ağdaki tüm cihazlar alır ama yalnızca **IP'si eşleşen** cihaz kendi MAC adresiyle cevap verir. Gönderici bu eşleşmeyi ARP önbelleğine (cache) kaydeder. |

> [!note] RARP
> ARP "IP → MAC" çözer. Tersi (MAC → IP) için eski **RARP** protokolü vardı; günümüzde yerini DHCP almıştır.

## Komut

```bash
arp -a          # ARP önbelleğini göster (klasik)
ip neigh        # modern Linux karşılığı (IP ↔ MAC eşleşmeleri)
```

> [!warning] Güvenlik: ARP Spoofing
> ARP kimlik doğrulama yapmaz; yerel ağdaki herkes birbirine güvenir. Saldırgan sahte ARP yanıtlarıyla kendini gateway gibi tanıtıp trafiği üzerinden geçirebilir (MITM). Bkz. [[0-OSI Modeli|OSI Modeli]] → L2 saldırıları.

## İlgili Notlar

- [[2-Farklı Ağlar Arası Ping ve ARP|Farklı Ağlar Arası Ping ve ARP]]: ARP'ın farklı ağlar arası ping sırasında adım adım çalışması
- [[5-IP|IP]]: çözülen mantıksal adres
- [[0-OSI Modeli|OSI Modeli]]: L2/L3 ilişkisi
