Cyber Kill Chain modelinin en büyük gücü, savunmacılara her aşamada saldırıyı durdurma veya tespit etme fırsatı sunmasıdır. Bu bölümde, saldırı zincirinin her halkasına karşı uygulanabilecek savunma stratejilerini ve tespit yöntemlerini inceleyeceğiz.

## Savunma Matrisi

Savunma eylemleri temel olarak 6 kategoriye (6D) ayrılır:

1. **Detect (Tespit Et):** Saldırganın varlığını görmek.
2. **Deny (Engelle):** Saldırının gerçekleşmesini önlemek.
3. **Disrupt (Boz):** Saldırı akışını kesmek veya durdurmak.
4. **Degrade (Zayıflat):** Saldırının etkisini veya hızını azaltmak.
5. **Deceive (Aldat):** Saldırganı yanlış yönlendirmek (Honeypot).
6. **Destroy (Yok Et):** (Siber dünyada genellikle karşı saldırı anlamına gelir ve yasal olarak sınırlıdır, bu nedenle "Contain/İzole Et" olarak da düşünülebilir).

## Aşamaya Göre Savunma Stratejileri

### 1. Keşif (Reconnaissance)

- **Tespit:** Web log analizi (tarayıcı User-Agent'ları), Nmap tarama imzaları.
- **Engelle:** Firewall kuralları, gereksiz servislerin kapatılması.
- **Aldat:** Sahte banner bilgileri göstermek.

### 2. Silahlanma (Weaponization)

- **Tespit:** N/A (Saldırganın tarafında olur).
- **Analiz:** Malware analizi yaparak kullanılan araçları anlamak ve IoC üretmek.

### 3. İletim (Delivery)

- **Tespit:** Email Gateway analizleri, kullanıcı ihbarları.
- **Engelle:** SPF/DKIM/DMARC, zararlı eklerin engellenmesi, URL filtreleme.
- **Eğitim:** Kullanıcı farkındalık eğitimleri.

### 4. Sömürü (Exploitation)

- **Tespit:** EDR (Endpoint Detection Response) alarmları, WAF logları.
- **Engelle:** Yama yönetimi (Patching), ASLR/DEP, Güvenli kodlama (Input validation).
- **Zayıflat:** Eski işletim sistemlerinin ağdan izole edilmesi.

### 5. Kurulum (Installation)

- **Tespit:** FIM (Dosya Bütünlük İzleme), Registry değişiklik alarmları.
- **Engelle:** Yetki kısıtlaması (Least Privilege), AppLocker (Sadece izinli uygulamalar çalışsın).
- **Boz:** Zararlı proseslerin kill edilmesi.

### 6. Komuta ve Kontrol (C2)

- **Tespit:** DNS trafiği analizi (Uzun domainler), Proxy loglarında şüpheli IP'ler, Beaconing analizi.
- **Engelle:** DNS Sinkhole (Zararlı domainleri boşa düşürme), Egress (Giden trafik) filtreleme.
- **Aldat:** Saldırganın C2 trafiğini bir Honeypot'a yönlendirmek.

### 7. Hedef Üzerindeki Eylemler (Actions)

- **Tespit:** DLP (Veri Sızıntısı Önleme) alarmları, UEBA (Kullanıcı Davranış Analizi).
- **Engelle:** Veri şifreleme (Data at Rest Encryption), Ağ segmentasyonu.
- **Müdahale:** Etkilenen sistemlerin ağdan koparılması (Isolation).

## Tespit İçin Kritik Veri Kaynakları

Bir SOC (Güvenlik Operasyon Merkezi) analistinin Kill Chain tabanlı tespit yapabilmesi için aşağıdaki log kaynaklarına ihtiyacı vardır:

|Log Kaynağı|İlgili Kill Chain Aşaması|Örnek Tespit|
|---|---|---|
|**Web Proxy / Firewall**|Delivery, C2|Zararlı domain ziyareti, C2 beaconing.|
|**Email Gateway**|Delivery|Phishing maili, zararlı ek.|
|**EDR / Antivirus**|Exploitation, Installation|Bellek taşması, Registry değişikliği.|
|**DNS Server**|Recon, Delivery, C2, Actions|DGA domainleri, DNS Tunneling.|
|**Active Directory**|Recon, Actions|Brute Force, Pass the Hash, Yetki yükseltme.|

## Indicators of Compromise (IoC) - Uzlaşma Göstergeleri

Her saldırı arkasında iz bırakır. Bu izlere IoC denir.

- **Hash:** Zararlı dosyanın MD5/SHA256 özeti.
- **IP Adresi:** C2 sunucusu veya saldırganın IP'si.
- **Domain:** Phishing veya C2 domaini.
- **Network/Host Artifacts:** Kayıt defteri anahtarı, dosya ismi, Mutex değeri.

Savunmacılar, tespit ettikleri bu IoC'leri güvenlik cihazlarına (SIEM, Firewall) girerek otomatik engelleme sağlarlar.