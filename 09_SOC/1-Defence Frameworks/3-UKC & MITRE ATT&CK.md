Unified Kill Chain (UKC) ile MITRE ATT&CK arasındaki temel ilişki şudur: **MITRE ATT&CK teknik ve taktiklerden oluşan zamandan bağımsız bir kütüphane (sözlük) sunarken, UKC bu taktikleri 18 aşamalı kronolojik bir hikâyeye (süreç akışına) oturtur.**

  

Paul Pols, UKC’yi tasarlarken MITRE ATT&CK taktiklerini doğrudan temel almış, ancak bir saldırının operasyonel mantığını yansıtacak şekilde 18 aşamaya genişletmiş ve bunları **In (Sızma)**, **Through (İlerleme)** ve **Out (Sonuç)** olmak üzere 3 ana fazda gruplamıştır.

  

### 18 UKC Aşamasının MITRE ATT&CK Taktikleri ile Birebir Eşleşmesi

#### Faz 1: IN (İlk Tutunma Noktası / Sızma)

Saldırganın dış ağdan kurum perimetresine sızması ve ilk erişimi sağlaması aşamasıdır.

  

|**Unified Kill Chain (UKC) Aşaması**|**Karşılık Gelen MITRE ATT&CK Taktiği**|**Açıklama / Kapsam**|
|---|---|---|
|**1. Reconnaissance**|Reconnaissance (TA0043)|Hedef hakkında bilgi toplama.|
|**2. Resource Development**|Resource Development (TA0042)|Altyapı, alan adı veya zararlı yazılım hazırlama.|
|**3. Delivery**|Initial Access (TA0001)|Zararlı içeriğin hedefe iletilmesi (E-posta, USB vb.).|
|**4. Social Engineering**|Initial Access / Reconnaissance|Oltalama (Phishing) ve insanı kandırmaya yönelik teknikler.|
|**5. Exploitation**|Execution / Initial Access|Zafiyetlerin kötüye kullanılması (Exploit kullanımı).|
|**6. Persistence**|Persistence (TA0003)|İlk sistemde kalıcılık sağlama (Zamanlanmış görevler vb.).|
|**7. Defense Evasion**|Defense Evasion (TA0005)|Antivirüs ve EDR atlatma, izleri gizleme.|
|**8. Command & Control**|Command and Control (TA0011)|Dışarıdaki C2 sunucusu ile komut-kontrol kanalı kurma.|

#### Faz 2: THROUGH (İç Ağda Yayılma)

Saldırganın ilk sızdığı makineden çıkıp kurum iç ağında yetki yükselterek ve yatayda ilerleyerek ana hedefe yaklaşmasıdır.

  

|**Unified Kill Chain (UKC) Aşaması**|**Karşılık Gelen MITRE ATT&CK Taktiği**|**Açıklama / Kapsam**|
|---|---|---|
|**9. Pivoting**|Lateral Movement / C2|Ele geçirilen sistemi diğer iç ağ sistemlerine erişmek için köprü olarak kullanma.|
|**10. Discovery**|Discovery (TA0007)|İç ağ haritasını çıkarma, Active Directory ve kullanıcı taraması yapma.|
|**11. Privilege Escalation**|Privilege Escalation (TA0004)|SYSTEM veya Domain Admin yetkisi elde etme.|
|**12. Execution**|Execution (TA0002)|İç sistemlerde komut veya zararlı kod çalıştırma (PowerShell, PsExec vb.).|
|**13. Credential Access**|Credential Access (TA0006)|Kullanıcı parolalarını veya biletlerini ele geçirme (LSASS dump, Kerberoasting).|
|**14. Lateral Movement**|Lateral Movement (TA0008)|Ağ üzerindeki diğer sunuculara ve kritik sistemlere sıçrama.|

#### Faz 3: OUT (Eylemler ve Hedefe Ulaşma)

Saldırganın nihai amacını gerçekleştirdiği (veri çalma, sistemi çökertme, fidye yazılımı çalıştırma) aşamadır.

  

|**Unified Kill Chain (UKC) Aşaması**|**Karşılık Gelen MITRE ATT&CK Taktiği**|**Açıklama / Kapsam**|
|---|---|---|
|**15. Collection**|Collection (TA0009)|Çalınacak hassas verileri bir araya getirme ve arşivleme.|
|**16. Exfiltration**|Exfiltration (TA0010)|Toplanan veriyi kurum dışına çıkarma.|
|**17. Impact**|Impact (TA0040)|Veri şifreleme (Ransomware), veriyi silme veya hizmeti durdurma.|
|**18. Objectives**|_Taktik Ötesi (Stratejik Hedef)_|Saldırganın nihai amacı (fidyeden para kazanma, casusluk, itibar kaybı verme).|

### Eşleşmedeki Temel Fark Nerede Doğar?

1. **Zaman Sıralaması:** MITRE ATT&CK matrisinde taktikler soldan sağa dizilse de doğrusal bir sıra zorunlu değildir (bir saldırgan kalıcılık sağlamadan doğrudan _Discovery_ yapabilir). UKC ise bu taktikleri operasyonel bir **kronolojiye** zorlar.
    
      
    
2. **Aşama Ayrımı:** UKC, MITRE'ın _Initial Access_ veya _Execution_ gibi geniş taktiklerini **Delivery**, **Social Engineering** ve **Exploitation** gibi adımlara bölerek, saldırının tam olarak HANGİ aşamada durdurulabileceğini belirlemeyi kolaylaştırır.
    
      
    
3. **Tekrarlayan Döngüler (Loops):** UKC'de **Through** fazı döngüseldir. Saldırgan yeni bir makineye sıçradığında (Lateral Movement), o makinede tekrar _Discovery -> Privilege Escalation -> Credential Access_ adımlarını yineler. MITRE bu döngüsel yapıyı göstermez, sadece kullanılan teknikleri listeler.