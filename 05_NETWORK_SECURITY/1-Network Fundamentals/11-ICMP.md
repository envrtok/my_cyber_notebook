> [!summary] Özet
> **ICMP (Internet Control Message Protocol)**, ağdaki hata ve durum bilgilerini raporlayan bir kontrol protokolüdür. Mesajları IP üzerinden taşınır. Sorunu **düzeltmez, yalnızca rapor eder**; düzeltme sorumluluğu göndericidedir. `ping` ve `traceroute` bu protokolü kullanır.

## Temel İşlev

- Alıcı cihaz aktif değilse veya ağ tıkanıklığı gibi olağandışı bir durum veriyi iletmeyi engelliyorsa, ICMP göndericiye verinin teslim edilemediğini bildirir.
- Başlıca iki mesaj türüyle çalışır:

| Mesaj | Açıklama |
|---|---|
| **Echo Request** | Hedefin ulaşılabilir olup olmadığını test etmek için gönderilir (ping'in gönderdiği) |
| **Echo Reply** | Hedef cihazın test isteğine verdiği yanıt |

## `ping` Çıktısını Okuma

![ICMP ping çıktısı](https://storage.hackviser.com/file/hackviser-prod/trainings/sections/images/e46b2dee-f6fa-44de-86f2-a1e0c105d4e2/ping-be9de99d9.webp)

- **İlk satır:** Ping'in hedefini ve gönderilen veri boyutunu gösterir.
- **Her Echo Reply satırı:**
    - **bytes:** Alınan yanıtın boyutu
    - **icmp_seq:** Paket sıra numarası
    - **ttl:** Paketin ağda yaşayabileceği maksimum hop sayısı (bkz. [[4-TCP-IP Modeli|TCP/IP Modeli]] → TTL ipucu)
    - **time:** Yanıtın geliş süresi (ms)
- **İstatistikler:** Gönderilen/alınan paket sayısı, paket kaybı yüzdesi, toplam süre ve **RTT** (Round Trip Time: min/ort/maks/standart sapma).

## Çıktının Önemi

| Gösterge | Ne anlatır |
|---|---|
| **Paket kaybı (%)** | Ağın güvenilirliği; yüksek kayıp = ağ problemi |
| **Süre (ms)** | Gecikme (latency); düşük süre = daha iyi performans |
| **TTL değeri** | Başlangıç TTL'i işletim sistemi hakkında ipucu verir (Linux 64, Windows 128) |

## İlgili Notlar

- [[2-ping & traceroute|ping & traceroute]]: ICMP'nin pratikte kullanımı ve TTL ile yol keşfi
- [[6-IP|IP]]: ICMP mesajlarını taşıyan protokol
- [[4-TCP-IP Modeli|TCP/IP Modeli]]: TTL alanının anlamı
