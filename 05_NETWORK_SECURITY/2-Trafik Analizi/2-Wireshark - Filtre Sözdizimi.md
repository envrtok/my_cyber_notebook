# Wireshark — Filtre Sözdizimi

> [!summary] Özet
> Wireshark'ta iki ayrı filtre türü vardır: **Capture Filter** (yakalama sırasında, BPF sözdizimi — neyi yakalayacağını sınırlar) ve **Display Filter** (yakalama sonrası, bellekteki veride detaylı arama — çok daha güçlü). İkisinin sözdizimi farklıdır.

## Capture Filter (Yakalama Filtresi — BPF)

Yakalama *sırasında* uygulanır; sadece eşleşen paketler belleğe alınır. [[1-tcpdump|tcpdump]] ile aynı BPF dilini kullanır.

- **Primitives:** `host 192.168.1.10` · `ether src 00:11:22:33:44:55` · `port 80` · `tcp` / `udp` / `icmp`
- **Operatörler:** `and` (`&&`), `or` (`||`), `not` (`!`); öncelik için parantez.

| Amaç | Filtre |
|---|---|
| Sadece HTTP | `tcp port 80` |
| Belirli IP | `host 192.168.1.10` |
| DNS veya HTTP | `port 53 or port 80` |
| Bir IP'ye giden TCP dışındaki her şey | `not tcp dst host 192.168.1.10` |

## Display Filter (Görüntüleme Filtresi)

Yakalama *sonrası*, belleğe yüklenmiş veride uygulanır. Genişletilmiş sözdizimi; alan bazlı ve çok daha ayrıntılıdır.

- **Alan adları:** `ip.addr`, `tcp.port`, `http.request.method` (her protokolün kendi alanları).
- **Karşılaştırma:** `==` `!=` `>` `<` `>=` `<=`
- **Mantıksal:** `and` (`&&`), `or` (`||`), `not` (`!`); parantez.

| Amaç | Filtre |
|---|---|
| Sadece HTTP POST | `http.request.method == POST` |
| Alt ağdaki trafik | `ip.addr >= 192.168.1.0 and ip.addr <= 192.168.1.255` |
| HTTP hataları (4xx/5xx) | `http.response.code >= 400 and http.response.code <= 599` |
| Büyük paketler | `frame.len > 1000` |

### Protokol kısayolları

Filtre çubuğuna protokol adı yazmak yeterli: `tcp`, `udp`, `http`, `dns`.
- `http.request` / `http.response` — sadece istekler / yanıtlar
- `dns.qry.name == example.com` — belirli DNS sorgusu

### Gelişmiş Operatörler

| Operatör | Ne yapar | Örnek |
|---|---|---|
| `contains` | Alt dize içerir (harf duyarlı) | `http contains "example.com"` |
| `matches` | Regex eşleşmesi | `http.request.uri matches "[0-9]{4}$"` |
| `in` | Değer listede mi | `tcp.port in {80, 443, 53}` |

## İlgili Notlar

- [[1-tcpdump|tcpdump]]: CLI karşılığı ve BPF
- [[3-Wireshark - İstatistikler|İstatistikler]] · [[4-Wireshark - Analiz|Analiz]]: yakalama sonrası inceleme
- [[15-Domain Name System (DNS)]] · [[14-Common Network Protocols and Ports]]
