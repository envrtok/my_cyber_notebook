# Wireshark — Analiz Sekmesi

> [!summary] Özet
> Wireshark'ın **Analyze** özellikleriyle tek tek paket yerine **akışın bütününü** incelersin: bir TCP konuşmasını okunabilir biçimde birleştirme, o akışı izole etme ve trafik içinden aktarılan dosyaları çıkarma.

## TCP Akışını Takip Etme (Follow TCP Stream)

Bir bağlantının tüm paketlerini tek pencerede, protokolce yorumlanmış konuşma olarak gösterir (ham byte yerine). Örneğin bir HTTP isteği/yanıtı düz metin olarak okunur.

1. Akışa ait bir pakete **sağ tıkla**.
2. **Follow → TCP Stream**.
3. Konuşmanın yorumlanmış içeriği açılır.

## Belirli Akışı Filtreleme

Kalabalık trafikte tek bir konuşmayı izole eder:

1. Akıştaki bir pakete sağ tıkla.
2. **Apply as Filter → Selected** (veya kalıcı buton için **Prepare as Filter**).
3. Wireshark yalnızca o akışın paketlerini gösterir.

## Aktarılan Dosyaları Çıkarma (Export Objects)

HTTP, FTP vb. ile taşınan dosyaları doğrudan yakalamadan çıkarır:

- **File → Export Objects → HTTP** (protokolü seç), veya
- İlgili pakete sağ tıkla → **Follow → HTTP Stream** → **Save As**.

> [!tip] Güvenlik
> Follow TCP Stream, şifresiz protokollerde (HTTP, FTP, Telnet) parola ve içeriği açıkça gösterir; Export Objects ise aktarılan zararlı dosyaları/ekleri analiz için çıkarmaya yarar.

## İlgili Notlar

- [[2-Wireshark - Filtre Sözdizimi|Filtre Sözdizimi]] · [[3-Wireshark - İstatistikler|İstatistikler Sekmesi]]
- [[12-TCP]]: takip edilen akışın altındaki protokol
