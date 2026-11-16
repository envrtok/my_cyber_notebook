> [!summary] Özet
> **Command and Control (C2)**, ele geçirilen sistem ile saldırgan arasında bir **iletişim kanalının** kurulduğu aşamadır. Bu kanal üzerinden saldırgan komut gönderir, araç yükler ve veri alır. C2, ağ trafiği analizinin en kritik olduğu aşamadır.

## İletişim Kanalları

- **HTTP/HTTPS istekleri:** Normal web trafiğinin arasına karışır; en yaygın yöntemdir
- **DNS Tunneling:** Veri ve komutlar DNS sorgularının içine (subdomain'lere) gömülür
- **Diğer protokoller:** ICMP, SMB, meşru bulut servisleri vb.

## Beaconing ve Jitter

- **Beaconing:** Zararlının C2 sunucusuna **belirli aralıklarla** bağlanıp "yeni komut var mı?" diye sormasıdır (ör. her 60 saniyede bir).
- **Jitter:** Beaconing aralığına eklenen **rastgele sapmadır** (ör. 60 sn ± %20). Amaç, düzenli bağlantı örüntüsünü bozarak tespiti zorlaştırmaktır.

```
Jitter yok :  |----60s----|----60s----|----60s----|   → kolay tespit
Jitter var :  |---52s---|-----68s-----|----61s----|   → örüntü bulanık
```

## C2 Aşamasında Tespit ve Savunma

### 1. Proxy ve Firewall Log Analizi
- Bilinmeyen veya yeni kaydedilmiş domainlere giden trafik
- Mesai saatleri dışında (ör. gece 3'te) oluşan düzenli trafik
- Uzun süreli bağlantılar (long duration connections)
- User-Agent anormallikleri (ör. PowerShell User-Agent'ı ile internete çıkış)

### 2. DNS Analizi
- Aşırı uzun subdomain sorguları → **DNS Tunneling** belirtisi
- Yüksek sayıda NXDOMAIN (bulunamadı) cevabı → **DGA** (Domain Generation Algorithm) belirtisi

> [!note] DGA
> Zararlı yazılımın, C2 sunucusunu bulmak için algoritmayla her gün yüzlerce rastgele domain üretip denemesidir. Saldırgan bunlardan yalnızca birini kaydeder; diğerleri NXDOMAIN döner.

### 3. Tehdit İstihbaratı (Threat Intelligence)
- Bilinen C2 IP adreslerinin ve domainlerinin (IoC) SIEM ve firewall'a entegre edilip engellenmesi

### 4. Ağ Segmentasyonu
- Kritik sunucuların internete doğrudan erişiminin kesilmesi; C2 kanalının kurulmasını baştan engeller

## İlgili Notlar

- Önceki aşama: [[5-Installation|Installation]] · Sonraki aşama: [[7-Actions on Objectives|Actions on Objectives]]
- [[0-Cyber Kill Chain|Cyber Kill Chain]]
- [[2-nslookup & dig|nslookup & dig]]: DNS sorgularını incelemek için
