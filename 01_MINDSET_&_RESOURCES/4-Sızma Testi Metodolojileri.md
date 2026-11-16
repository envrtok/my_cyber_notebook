> [!summary] Özet
> **Sızma testi metodolojileri**, bir testin hangi adımlarla, hangi kapsamda yapılacağını ve nasıl raporlanacağını standartlaştıran çerçevelerdir. Metodoloji kullanmak testi **tekrarlanabilir**, **ölçülebilir** ve müşteriyle **ortak bir dilde** konuşulabilir hale getirir.

## Başlıca Metodolojiler

| Metodoloji | Yayımlayan | Odak | Ne zaman tercih edilir |
|---|---|---|---|
| **OWASP WSTG** | OWASP Vakfı | Web uygulamaları ve API'ler | Web uygulaması sızma testleri |
| **OSSTMM** | ISECOM | Operasyonel güvenlik: bilgi ve ağ güvenliği, insan, fiziksel, kablosuz ve telekom | Altyapı/ağ testleri, kapsamlı ve ölçülebilir güvenlik denetimi |
| **NIST SP 800-115** | NIST (ABD) | Bilgi güvenliği testi ve değerlendirmesi için teknik rehber | Kamu kurumları, uyum (compliance) gereksinimi olan büyük kurumlar |
| **PTES** | Güvenlik topluluğu | Uçtan uca sızma testi süreci (7 aşama) | Genel amaçlı sızma testleri |

## OWASP

- OWASP bir vakıftır; sızma testi metodolojisi **Web Security Testing Guide (WSTG)** adıyla yayımlanır.
- Web uygulamalarındaki güvenlik zafiyetlerinin nasıl test edileceğini kategori kategori tanımlar (kimlik doğrulama, oturum yönetimi, girdi doğrulama vb.).

> [!note] OWASP Top 10 ≠ Metodoloji
> **OWASP Top 10** bir test metodolojisi değil, en kritik web risklerinin **farkındalık listesidir**. Test adımları için WSTG kullanılır.

## OSSTMM

- **Open Source Security Testing Methodology Manual**, ISECOM tarafından yayımlanır.
- Bilgi ve ağ güvenliğine odaklanır; ancak kapsamı yalnızca teknik değildir, insan ve fiziksel güvenliği de içerir.
- Bulguları sayısal olarak ölçmeye (operasyonel güvenlik metrikleri) önem verir.

## NIST SP 800-115

- **Technical Guide to Information Security Testing and Assessment**.
- Devlet kurumları ve büyük ölçekli kurumların güvenlik değerlendirmelerinde referans alınır.
- Sızma testini 4 aşamada tanımlar:

```
Planning ──► Discovery ──► Attack ──► Reporting
 (Planlama)   (Keşif)     (Saldırı)  (Raporlama)
                 ▲            │
                 └────────────┘
       (saldırıda yeni bilgi çıkarsa keşfe geri dönülür)
```

## PTES

**Penetration Testing Execution Standard**, bir testi baştan sona 7 aşamada ele alır:

1. **Pre-engagement Interactions:** Kapsam, kurallar, izinler ve sözleşme
2. **Intelligence Gathering:** Bilgi toplama → bkz. `03_RECON_&_OSINT`
3. **Threat Modeling:** Varlıkların ve olası tehditlerin belirlenmesi
4. **Vulnerability Analysis:** Zafiyet analizi
5. **Exploitation:** Zafiyetin sömürülmesi → bkz. `06_EXPLOITATION_&_SHELLS`
6. **Post Exploitation:** Yetki yükseltme, kalıcılık, yanal hareket → bkz. `07_PRIVILEGE_ESCALATION`, `08_POST_EXPLOITATION`
7. **Reporting:** Bulguların ve önerilerin raporlanması

> [!tip] Metodoloji vs Kill Chain
> Sızma testi metodolojisi **test eden tarafın iş akışıdır** (nasıl test ederim?). [[0-Cyber Kill Chain|Cyber Kill Chain]] ise **saldırganın davranış modelidir** ve savunmacının bakış açısıyla kullanılır (saldırı nasıl ilerler, nerede kırarım?).

## İlgili Notlar

- [[3-CIA Üçlüsü (CIA Triad)|CIA Üçlüsü]]: testte bulunan her zafiyetin hangi hedefi tehdit ettiği
- [[0-Cyber Kill Chain|Cyber Kill Chain]]: saldırının aşamaları
- [[1-Sahte Yemler (Rabbit Holes)|Sahte Yemler (Rabbit Holes)]]: test sırasında zaman kaybettiren tuzaklar
