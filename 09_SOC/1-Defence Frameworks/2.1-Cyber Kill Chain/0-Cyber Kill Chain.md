> [!summary] Özet
> **Cyber Kill Chain (CKC)**, Lockheed Martin'in 2011'de yayımladığı ve bir siber saldırının anatomisini **7 ardışık aşamaya** ayıran modeldir.
> Saldırının başarılı olması için her aşamanın eksiksiz tamamlanması ve fark edilmemesi gerekir. Savunmanın başarılı olması için ise **zincirin tek bir halkasını kırmak yeterlidir**.

## Aşamalar

```
Reconnaissance ─► Weaponization ─► Delivery ─► Exploitation ─► Installation ─► Command & Control ─► Actions on Objectives
```

| # | Aşama | Saldırgan ne yapar? |
|---|---|---|
| 1 | **Reconnaissance** (Keşif) | Hedef hakkında bilgi toplar |
| 2 | **Weaponization** (Silahlanma) | Tespit edilen zafiyete uygun zararlı yazılımı (exploit + payload) hazırlar |
| 3 | **Delivery** (İletim) | Hazırlanan zararlı içeriği hedefe ulaştırır |
| 4 | **Exploitation** (Sömürü) | Zararlı kod, hedefteki zafiyeti (vulnerability) tetikler |
| 5 | **Installation** (Kurulum) | Hedefte kalıcılık (persistence) sağlar |
| 6 | **Command and Control** (C2) | Ele geçirilen sistemi uzaktan yönetilebilir hale getirir |
| 7 | **Actions on Objectives** (Hedef Üzerindeki Eylemler) | Asıl amacını gerçekleştirir (veri hırsızlığı, fidye, sabotaj vb.) |

> [!important] Savunmacı için anlamı
> Saldırı ne kadar erken bir aşamada kırılırsa maliyeti o kadar düşük olur. Delivery aşamasında engellenen bir phishing e-postası, Actions on Objectives aşamasında fark edilen bir veri sızıntısından çok daha ucuzdur.

> [!warning] Sınırlılıklar
> CKC dış perimetreden içeriye doğru ilerleyen, **doğrusal** saldırıları modeller. İç ağda yanal hareket (lateral movement), içeriden gelen tehditler (insider threat) ve tekrar eden döngüleri iyi modelleyemez. Bu boşluğu [[2-Cyber & Unified Kill Chain|Unified Kill Chain]] doldurur.

## Aşama Notları

- [[1-Recon|Reconnaissance]]
- [[2-Weaponization|Weaponization]]
- [[3-Delivery|Delivery]]
- [[4-Exploitation|Exploitation]]
- [[5-Installation|Installation]]
- [[6-Command and Control|Command and Control]]
- [[7-Actions on Objectives|Actions on Objectives]]
- [[8-Savunma ve Tespit Mekanizmaları|Savunma ve Tespit Mekanizmaları]]: her aşamaya karşı savunma ve tespit

## İlgili Notlar

- [[2-Cyber & Unified Kill Chain|Cyber & Unified Kill Chain]]: CKC ile UKC'nin karşılaştırması
- [[4-Cyber Kill Chain vs MITRE ATT&CK|Cyber Kill Chain vs MITRE ATT&CK]]: CKC aşamalarının ATT&CK taktikleriyle eşleşmesi
- [[1-Pyramid of Pain|Pyramid of Pain]]: tespit edilen göstergelerin saldırgana verdiği zarar
