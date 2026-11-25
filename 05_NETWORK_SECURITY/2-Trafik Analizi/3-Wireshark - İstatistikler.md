# Wireshark — İstatistikler Sekmesi

> [!summary] Özet
> Wireshark'ın **Statistics** menüsü, yakalanan trafiğin özetini çıkarır: hangi protokoller baskın, kim kiminle konuşuyor, en çok trafiği kim üretiyor. Pakete tek tek bakmadan "büyük resmi" görmek için ilk durak.

| Seçenek | Ne gösterir / ne işe yarar |
|---|---|
| **Resolved Addresses** | Trafikteki MAC/IP adreslerinin DNS ile çözülmüş hostname'leri; cihazları okunabilir adlarla hızlı tanımlama |
| **Protocol Hierarchy** | Protokollerin yüzdelik hiyerarşik dağılımı; trafiğin bileşimini (ör. %60 HTTP) bir bakışta görme |
| **Conversations** | İki uç arasındaki trafik akışları. Sekmeler: **Ethernet** (MAC), **IP**, **TCP**, **UDP** (port+IP çiftleri) |
| **Endpoints** | En çok trafik gönderen/alan cihazlar (Conversations gibi 4 sekmeli) |
| **DNS** | DNS sorgu/yanıt istatistikleri; yavaş çözümleme, başarısız sorgu, sorgulanan alan adları analizi |
| **HTTP** | İstek yöntemleri (GET/POST), durum kodları, URL'ler; web trafiği analizi ve saldırı tespiti |
| **IPv4 / IPv6 Statistics** | Toplam paket sayısı, kaynak/hedefe göre hacim, paket boyutu dağılımı |

> [!tip]
> **Protocol Hierarchy** olağandışı bir protokolü (ör. beklenmedik DNS/ICMP hacmi), **Conversations/Endpoints** ise anormal çok konuşan bir cihazı (olası C2 veya tarama) hızlıca ortaya çıkarır.

## İlgili Notlar

- [[2-Wireshark - Filtre Sözdizimi|Filtre Sözdizimi]] · [[4-Wireshark - Analiz|Analiz Sekmesi]]
- [[6-Command and Control|Command and Control]]: anormal/beaconing trafik tespiti
