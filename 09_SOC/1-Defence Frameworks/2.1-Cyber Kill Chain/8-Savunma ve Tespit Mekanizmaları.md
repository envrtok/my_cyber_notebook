> [!summary] Özet
> Cyber Kill Chain modelinin en büyük gücü, savunmacılara **her aşamada** saldırıyı tespit etme veya durdurma fırsatı sunmasıdır. Bu not, zincirin her halkasına karşı uygulanabilecek savunma stratejilerini, gerekli log kaynaklarını ve IoC kavramını bir araya getirir.

## Savunma Eylemleri: 6D

| Eylem | Anlamı | Örnek |
|---|---|---|
| **Detect** (Tespit Et) | Saldırganın varlığını görmek | IDS alarmı, SIEM korelasyonu |
| **Deny** (Engelle) | Saldırının gerçekleşmesini önlemek | Firewall kuralı, yama |
| **Disrupt** (Boz) | Devam eden saldırı akışını kesmek | Zararlı prosesi sonlandırmak |
| **Degrade** (Zayıflat) | Saldırının etkisini veya hızını azaltmak | Bant genişliği kısıtlama, izolasyon |
| **Deceive** (Aldat) | Saldırganı yanlış yönlendirmek | Honeypot, sahte banner |
| **Destroy** (Yok Et) | Saldırganın altyapısını etkisiz kılmak | Siber dünyada karşı saldırı anlamına gelir ve yasal olarak sınırlıdır; pratikte **Contain (İzole Et)** olarak düşünülür |

## Aşamaya Göre Savunma Stratejileri

| Aşama | Tespit | Engelleme | Diğer |
|---|---|---|---|
| [[1-Recon\|Reconnaissance]] | Web log analizi (tarayıcı User-Agent'ları), Nmap tarama imzaları | Firewall kuralları, gereksiz servislerin kapatılması | **Aldat:** Sahte banner bilgileri |
| [[2-Weaponization\|Weaponization]] | Yok (saldırganın tarafında olur) | Yok | **Analiz:** Malware analizi ile araçları anlamak ve IoC üretmek |
| [[3-Delivery\|Delivery]] | E-posta gateway analizleri, kullanıcı ihbarları | SPF/DKIM/DMARC, zararlı ek engelleme, URL filtreleme | **Eğitim:** Farkındalık eğitimleri |
| [[4-Exploitation\|Exploitation]] | EDR alarmları, WAF logları | Yama yönetimi, ASLR/DEP, güvenli kodlama (input validation) | **Zayıflat:** Eski işletim sistemlerini ağdan izole etmek |
| [[5-Installation\|Installation]] | FIM, registry değişiklik alarmları | Least Privilege, AppLocker (yalnızca izinli uygulamalar) | **Boz:** Zararlı proseslerin sonlandırılması |
| [[6-Command and Control\|C2]] | DNS trafik analizi (uzun domainler), proxy loglarında şüpheli IP'ler, beaconing analizi | DNS Sinkhole, egress (giden trafik) filtreleme | **Aldat:** C2 trafiğini honeypot'a yönlendirmek |
| [[7-Actions on Objectives\|Actions on Objectives]] | DLP alarmları, UEBA | Veri şifreleme (data at rest encryption), ağ segmentasyonu | **Müdahale:** Etkilenen sistemleri ağdan koparmak (isolation) |

> [!tip] DNS Sinkhole
> Zararlı domainlere yapılan DNS sorgularına gerçek IP yerine kurumun kontrolündeki zararsız bir IP döndürmektir. Bağlantı kurulamaz, üstelik sinkhole'a gelen istekler hangi makinelerin enfekte olduğunu gösterir.

## Tespit İçin Kritik Veri Kaynakları

Bir SOC analistinin Kill Chain tabanlı tespit yapabilmesi için şu log kaynaklarına ihtiyacı vardır:

| Log Kaynağı | İlgili Kill Chain Aşaması | Örnek Tespit |
|---|---|---|
| **Web Proxy / Firewall** | Delivery, C2 | Zararlı domain ziyareti, C2 beaconing |
| **Email Gateway** | Delivery | Phishing e-postası, zararlı ek |
| **EDR / Antivirüs** | Exploitation, Installation | Bellek taşması, registry değişikliği |
| **DNS Server** | Recon, Delivery, C2, Actions | DGA domainleri, DNS Tunneling |
| **Active Directory** | Recon, Actions | Brute force, Pass the Hash, yetki yükseltme |

## Indicators of Compromise (IoC) - Uzlaşma Göstergeleri

Her saldırı arkasında iz bırakır; bu izlere **IoC** denir.

- **Hash:** Zararlı dosyanın MD5/SHA256 özeti
- **IP Adresi:** C2 sunucusunun veya saldırganın IP'si
- **Domain:** Phishing veya C2 domaini
- **Network/Host Artifacts:** Kayıt defteri anahtarı, dosya adı, mutex değeri

Savunmacılar tespit ettikleri IoC'leri güvenlik cihazlarına (SIEM, firewall) girerek otomatik engelleme sağlar.

> [!important]
> Tüm IoC'ler aynı değerde değildir. Hash'i engellemek saldırgan için önemsizken (dosyayı bir bayt değiştirmesi yeter), davranışını (TTP) engellemek onu yöntemini değiştirmeye zorlar. Bkz. [[1-Pyramid of Pain|Pyramid of Pain]]

## İlgili Notlar

- [[0-Cyber Kill Chain|Cyber Kill Chain]]
- [[1-Pyramid of Pain|Pyramid of Pain]]
- [[4-Cyber Kill Chain vs MITRE ATT&CK|Cyber Kill Chain vs MITRE ATT&CK]]
