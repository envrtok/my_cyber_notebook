- Ele geçirilen sistem ile saldırgan arasında bir iletişim kanalı kurulması
- HTTP/S istekleri
- DNS tunneling
- Diğer protokollerin kullanımı
- Beaconing belirli aralıklarla kurulan bağlantıdır, bu örüntüyü bozmak için random bağlantılara jitter denir

## C2 Aşamasında Tespit ve Savunma

C2, ağ trafiği analizinin en kritik olduğu yerdir.

1. **Proxy ve Firewall Log Analizi:**
    
    - Bilinmeyen veya yeni kaydedilmiş domainlere giden trafik.
    - Mesai saatleri dışında (gece 3) oluşan düzenli trafik.
    - Uzun bağlantı süreleri (Long duration connections).
    - User-Agent anormallikleri (Örn: PowerShell User-Agent'ı ile web'e çıkış).
2. **DNS Analizi:**
    
    - Aşırı uzun subdomain sorguları (DNS Tunneling belirtisi).
    - NXDOMAIN (Bulunamadı) cevaplarının yüksek sayısı (DGA belirtisi).
3. **Tehdit İstihbaratı (Threat Intelligence):**
    
    - Bilinen C2 IP adreslerinin ve domainlerinin (IOC) güvenlik cihazlarına (SIEM, Firewall) entegre edilmesi ve engellenmesi.
4. **Ağ Segmentasyonu:**
    
    - Kritik sunucuların internete doğrudan erişiminin kesilmesi. C2 kanalının kurulmasını fiziksel olarak engeller.