# Wireshark Pratik — pcap Analiz Senaryoları

> [!summary] Özet
> Bir `.pcap` dosyasında sık sorulan soruların adım adım çözümü ve bu sırada en çok yapılan hatalar. Filtre sözdizimi için bkz. [[2-Wireshark - Filtre Sözdizimi]]; menü özellikleri için [[4-Wireshark - Analiz]] ve [[3-Wireshark - İstatistikler]].

## Senaryo 1 — HTTP'de aktarılan dosyanın adını bulma

Bir pakette taşınan dosyanın adı, HTTP **istek satırında** ve **yanıt başlığında** açıkça yazar.

1. İlgili pakete sağ tıkla → **Follow → TCP Stream**.
2. Akışın başındaki istek satırına bak: `GET /dvwa/dvwa/images/login_logo.png HTTP/1.1` → dosya adı **`login_logo.png`**.
3. Sunucu yanıtı türü/boyutu doğrular: `Content-Type: image/png`, `Content-Length: 9088`.

> [!warning] keep-alive = tek akışta birden çok dosya
> `Connection: keep-alive` varsa aynı TCP akışında sırayla birçok dosya (ör. `index.php`, `main.css`, `logo.png`) taşınır. Soru "Paket 41'de başlayan" diyorsa, o akıştaki **ilk** transferi al — sonraki dosyalar seni şaşırtmasın.

## Senaryo 2 — Bir alan adının IP'sini bulma (A vs CNAME)

Alan adı → IP eşleşmesi **DNS yanıt paketindedir**. Dikkat: modern alan adları genelde doğrudan değil, **CNAME zinciriyle** bir A kaydına bağlanır.

1. Filtre çubuğuna `dns` yaz.
2. İlgili **Standard query response** (yanıt) paketine tıkla.
3. Orta panelde **Domain Name System (response) → Answers**'ı genişlet.
4. Varsa CNAME yönlendirmelerinin **en altındaki `type A` kaydının `Addr` değeri** aradığın IP'dir.

Hedefe göre filtre seç:

| Durum | Filtre |
|---|---|
| Alan adı **sorgu** olarak soruldu | `dns.qry.name == "ornek.com"` |
| Alan adı yanıtta sadece **CNAME hedefi** olarak geçiyor | `dns.cname == "ornek.com"` |

> [!warning] Katman karışıklığı: yerel IP ≠ sunucu IP
> Paket listesindeki **Destination** sütunu, DNS yanıtının gönderildiği **senin yerel makinenin** IP'sidir (ör. `172.16.16.154`) — aradığın cevap değil. Aradığın IP, yanıtın **Answers → type A** kısmındaki adrestir (ör. `68.71.212.158`). Hangi bilginin hangi katmanda olduğunu bil: `Frame → Ethernet → IPv4 → TCP/UDP → HTTP/DNS`.

## Senaryo 3 — Trafikten dosya çıkarma (Export Objects)

Ağda taşınan bir görseli/belgeyi diske kaydedip açmak için:
- **File → Export Objects → HTTP…** → listeden dosyayı (ör. `quote.jpg`) seç → **Save**. Veya
- Paketin dissector satırına (ör. *JPEG File Interchange Format*) sağ tıkla → **Export Packet Bytes…**.

## Sık Yapılan Hatalar

> [!tip] Metin araması DNS'te çalışmaz → protokol filtresi kullan
> `frame contains "alanadi.com"` veya Ctrl+F metin araması DNS paketlerinde **eşleşmez**: DNS, alan adını metin olarak değil, uzunluk baytları + **isim sıkıştırması (pointer, `c0 xx`)** ile saklar. Çözüm: `dns.qry.name`, `dns.cname`, `http.request` gibi protokole özel filtreler.

> [!tip] Açık kalan filtreyi kontrol et
> Bir TCP akışını izledikten sonra filtre çubuğunda `tcp.stream eq N` **açık kalır**; bu durumda Protokol Hiyerarşisi veya paket sayısı tüm dosyanın değil, sadece o akışın değerini gösterir. Alttaki durum çubuğunda **Packets / Displayed** oranını alışkanlık olarak kontrol et; yanlış sayı alıyorsan filtreyi (sağdaki ✕) temizle.

> [!note] Ad çözümlemeyi açma
> IP↔alan adı çözümlemesi varsayılan **kapalıdır**; bu yüzden **Resolved Addresses** başta sadece MAC üreticilerini gösterir. Aç: **View → Name Resolution → Resolve Network Addresses**, sonra pencereyi kapatıp yeniden aç. Yine de CNAME-only veya "unsolicited" yanıtlar tabloda görünmeyebilir — kesin sonuç için paketin içindeki A kaydına bak.

## Öğrenme Hedefleri (bu alıştırmadan)

- **HTTP başlık yapısı:** istek satırı (metot + yol), `Content-Type`, `Content-Length`, durum kodları.
- **DNS kayıt türleri:** A, AAAA, **CNAME** (yönlendirme) farkı → bkz. [[15-Domain Name System (DNS)]].
- **Display filter > Ctrl+F:** protokol filtrelerini metin aramasına tercih et.
- **Export Objects:** trafikten dosya/zararlı ayıklamanın temel yolu.

## İlgili Notlar

- [[2-Wireshark - Filtre Sözdizimi]] · [[3-Wireshark - İstatistikler]] · [[4-Wireshark - Analiz]]
- [[1-tcpdump]]: CLI ile yakalama
- [[15-Domain Name System (DNS)]]: A/CNAME ve çözümleme mantığı
