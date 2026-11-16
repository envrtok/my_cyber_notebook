Siber güvenlik operasyonlarında en sık kullanılan iki model **Lockheed Martin Cyber Kill Chain** ve **MITRE ATT&CK** çerçeveleridir. Her ikisi de saldırıları anlamak için kullanılır ancak yaklaşımları ve detay seviyeleri farklıdır. Bu bölümde, bu iki modelin farklarını, benzerliklerini ve birlikte nasıl kullanılabileceklerini inceleyeceğiz.

## Karşılaştırma Tablosu

|Özellik|Cyber Kill Chain|MITRE ATT&CK|
|---|---|---|
|**Yapı**|7 Doğrusal Aşama|Matris (Taktikler ve Teknikler)|
|**Odak**|Yüksek seviyeli süreç ve önleme|Davranışsal teknikler ve tespit|
|**Kapsam**|Dışarıdan içeriye sızma (Perimeter)|Sızma sonrası içerideki hareketler (Post-Exploitation)|
|**Esneklik**|Katı ve sıralı|Modüler ve sırasız|
|**Amaç**|Stratejik savunma planlaması|Taktiksel analiz ve Threat Hunting|

## MITRE ATT&CK Nedir?

MITRE ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge), gerçek dünyadaki gözlemlere dayanan, saldırgan davranışlarının küresel bir bilgi tabanıdır.

- **Tactics (Taktikler):** Saldırganın amacı (NEDEN?). Örn: Initial Access (İlk Erişim), Persistence (Kalıcılık).
- **Techniques (Teknikler):** Saldırganın amacına nasıl ulaştığı (NASIL?). Örn: Phishing, Registry Run Keys.
- **Procedures (Prosedürler):** Spesifik uygulama detayları (APT28 grubu bu tekniği şöyle kullanır).

## Birlikte Kullanım

Modern bir SOC, bu iki modeli birbirini tamamlayacak şekilde kullanmalıdır.

1. **Stratejik Bakış (Cyber Kill Chain):** Yöneticiler ve CISO seviyesi için uygundur. "Saldırıyı hangi aşamada durdurduk?" sorusuna basit cevap verir.
    
    - Örnek Rapor: "Geçen ay 50 saldırıyı İletim (Delivery) aşamasında, 2 saldırıyı C2 aşamasında engelledik."
2. **Operasyonel/Taktiksel Bakış (MITRE ATT&CK):** Analistler, Threat Hunter'lar ve Incident Responder'lar için uygundur.
    
    - Örnek Analiz: "Saldırgan 'Initial Access' taktiği için 'T1566 Phishing' tekniğini kullandı, ardından 'Privilege Escalation' için 'T1055 Process Injection' tekniğini uyguladı."

### Eşleştirme Örneği

Cyber Kill Chain'in aşamaları, MITRE ATT&CK Taktikleri ile kabaca şu şekilde eşleşir:

- **Reconnaissance** -> _Reconnaissance / Resource Development_
- **Weaponization** -> _Resource Development_
- **Delivery** -> _Initial Access_
- **Exploitation** -> _Execution_
- **Installation** -> _Persistence / Defense Evasion_
- **Command & Control** -> _Command and Control_
- **Actions on Objectives** -> _Exfiltration / Impact / Collection_

## Unified Kill Chain

Cyber Kill Chain'in modern saldırıları (özellikle bulut ve iç tehditler) kapsamakta yetersiz kalması ve "doğrusal" yapısının eleştirilmesi üzerine, Paul Pols tarafından **Unified Kill Chain (Birleşik Öldürme Zinciri)** modeli geliştirilmiştir. Bu model, MITRE ATT&CK ve Cyber Kill Chain'i birleştirerek 18 aşamalı daha kapsamlı bir döngü sunar.

Unified Kill Chain, saldırıyı üç ana faza ayırır:

1. **In (Giriş):** Hedef sisteme erişim sağlama.
2. **Through (İlerleme):** Ağ içinde yetki yükseltme ve yayılma.
3. **Out (Çıkış):** Amaca ulaşma ve izleri silme.

## Sonuç

Siber güvenlikte "tek bir doğru model" yoktur. Cyber Kill Chain, savunma mimarisini kurgulamak için mükemmel bir temeldir ("Defans derinliği oluşturmalıyız"). MITRE ATT&CK ise bu mimari üzerindeki boşlukları bulmak ve saldırgan davranışlarını detaylı analiz etmek için vazgeçilmez bir ansiklopedidir. Profesyonel bir analist, her iki modele de hakim olmalıdır.