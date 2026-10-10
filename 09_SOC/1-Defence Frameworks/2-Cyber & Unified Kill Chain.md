![](../../99_MEDIA/Pasted%20image%2020260811164514.png)![](../../99_MEDIA/Pasted%20image%2020260811163715.png)
![](../../99_MEDIA/Pasted%20image%2020260811163949.png)
![](../../99_MEDIA/Pasted%20image%2020260811164010.png)
![](../../99_MEDIA/Pasted%20image%2020260811164021.png)

Unified Kill Chain'in (UKC) varlığı Cyber Kill Chain'i (CKC) gereksiz kılmaz; çünkü bu iki model farklı **soyutlama seviyelerine** ve farklı **hedef kitlelere** hizmet eder. CKC yüksek seviyeli, stratejik iletişim için kullanılan pratik bir özet modeliyken; UKC operasyonel ve teknik düzeyde derinlemesine analiz sağlayan detaylı bir çerçevedir.

  

### CKC'nin Hâlâ Kullanılma Nedenleri

1. **Yönetimsel İletişim (C-Level ve Teknik Olmayan Ekipler):** Executive yönetime, yönetim kuruluna veya teknik olmayan birimlere bir saldırının anatomisini anlatırken 18 aşamalı UKC veya yüzlerce teknik içeren MITRE ATT&CK matrisini sunmak kafa karışıklığı yaratır. CKC'nin 7 adımı, saldırının genel durumunu özetlemek için idealdir.
    
      
    
2. **Operasyonel Yük ve Hız:** Her güvenlik ihlalinde veya SOC uyarısında 18 farklı aşamayı tek tek haritalandırmak gereksiz zaman ve kaynak kaybına yol açar. Basit oltalama veya bilinen zararlı yazılım vakalarında CKC'nin doğrusal yapısı hızlı karar almak için yeterlidir.
    
      
    
3. **Saldırı Odak Alanı:** CKC, kurum perimetresinden (dışarıdan) içeriye doğru gerçekleşen geleneksel saldırıları modellemeye odaklanır. İç ağdaki yatay ilerlemeleri (Lateral Movement) modellemekte yetersiz kalsa da, çevre güvenliği ve ilk temas analizi için pratikliğini korur.
    
      
    
4. **Mevcut Altyapı ve Standart Uyumu:** Birçok SIEM kuralı, SOC süreç dokümanı ve güvenlik standardı tarihsel olarak CKC aşamaları üzerine inşa edilmiştir.
    
      
    

### Model Karşılaştırması

|**Kriter**|**Cyber Kill Chain (CKC)**|**Unified Kill Chain (UKC)**|
|---|---|---|
|**Aşama Sayısı**|7 Aşama|18 Taktiğe Yayılmış 3 Ana Faz (_In, Through, Out_)|
|**Odak**|Dış perimetreden içeriye doğrusal giriş|İç ağda yayılma, yetki yükseltme, veri sızdırma ve APT davranışları|
|**Hedef Kitle**|C-Level, L1 SOC Analistleri, Genel Güvenlik Eğitimi|L2/L3 SOC Analistleri, Tehdit Avcıları, Olay Müdahale (IR)|
|**Karmaşıklık**|Düşük (Yüksek seviyeli özet)|Yüksek (Ayrıntılı teknik haritalama)|

Özetle; teknik derinlik gerektiğinde UKC, hızlı ve net iletişim gerektiğinde ise CKC kullanılır.