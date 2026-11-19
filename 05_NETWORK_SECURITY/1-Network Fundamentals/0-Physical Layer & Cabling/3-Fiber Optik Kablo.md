> [!summary] Özet
> **Fiber optik kablo**, veriyi elektrik yerine **ışık sinyalleriyle** taşır. Yüksek hız, uzun mesafede düşük sinyal kaybı sağlar ve elektromanyetik parazitten **etkilenmez**. Fiziksel katman ([[0-OSI Modeli|OSI]] L1).

## Yapısı

İçten dışa: ışığı taşıyan **çekirdek (core)** → onu saran **kaplama (cladding)** → koruyucu dış **kılıf**. Işık, çekirdek ile kaplama arasındaki tam iç yansımayla ilerler.

## Türleri: MMF vs SMF

| Özellik | Çok Modlu (MMF) | Tek Modlu (SMF) |
|---|---|---|
| **Mesafe** | Kısa (LAN, binadan binaya) | Uzun (WAN, şehir içi/arası) |
| **Menzil** | ~2 km'ye kadar | ~200 km'ye kadar |
| **Maliyet** | Daha ucuz | Daha pahalı |
| **Çekirdek** | Geniş | Dar (ör. 9 mikron) |

> [!note]
> 9 mikronluk tek modlu fiber, 400 Gbps hızında yaklaşık 75 mil (~120 km) yol kat edebilir.

## Konnektörler

| Konnektör | Açılımı | Not |
|---|---|---|
| **LC** | Lucent Connector | MMF & SMF; gigabit ve 10-gigabit Ethernet'te yaygın |
| **SC** | Subscriber Connector | MMF & SMF; gigabit Ethernet'te yaygın |
| **MTRJ** | Mechanical Transfer Registered Jack | İki fiber barındırır; MMF için tasarlandı |

## İlgili Notlar

- [[2-Koaksiyel Kablo|Koaksiyel Kablo]] ve [[1-Çift Bükümlü Kablo|Çift Bükümlü Kablo]]: bakır tabanlı iletim ortamları
- [[0-OSI Modeli|OSI Modeli]]: fiziksel katman (L1)
