#### **1. In-Band (Aynı Kanal Üzerinden) SQL Injection**

Bu türde saldırgan, saldırıyı gerçekleştirdiği kanal üzerinden sonuçları doğrudan görebilir. En kolay tespit edilen türdür.

- **Error-Based (Hata Tabanlı):** Veritabanını teknik hata mesajları vermeye zorlayarak veritabanı yapısı hakkında bilgi toplanır.
    
- **Union-Based (Birleştirme Tabanlı):** SQL'in `UNION` operatörü kullanılarak, orijinal sorgunun sonuçlarına ek olarak saldırganın istediği veriler (şifreler, kullanıcı adları vb.) aynı sayfada listelenir.
    

#### **2. Blind (Kör) SQL Injection**

Uygulama, SQL sorgusunun sonuçlarını veya veritabanı hatalarını ekrana yansıtmaz. Bilgi almak için daha karmaşık teknikler gerekir:

- **Boolean-based:** Veritabanına "Evet/Hayır" soruları sorulur. Uygulamanın yanıtındaki değişikliğe (örneğin sayfanın yüklenmesi veya hata mesajı vermemesi) bakılarak karakterler tek tek tahmin edilir.
    
- **Time-based (Zaman Tabanlı):** Eğer bir koşul doğruysa veritabanına belirli bir süre (örneğin 10 saniye) beklemesi komutu verilir. Yanıtın geç gelmesi, koşulun doğru olduğunu kanıtlar.
    
- **Out-of-band (OAST):** Veritabanı, saldırganın kontrolündeki dış bir sunucuya (örneğin bir DNS sorgusu ile) veri göndermeye zorlanır. Diğer yöntemlerin çalışmadığı durumlarda çok güçlüdür.
    

#### **3. Birinci ve İkinci Derece (Second-Order) SQL Injection**

- **Birinci Derece (First-Order):** Saldırı kodu doğrudan HTTP isteğiyle gönderilir ve o anki sorguda çalıştırılır.
    
- **İkinci Derece (Second-Order / Stored):** Uygulama zararlı girdiyi önce veritabanına güvenliymiş gibi kaydeder. Asıl saldırı, bu veri daha sonra başka bir işlem için veritabanından çekilip "güvenilir" kabul edilerek başka bir sorgunun içine kontrolsüzce yerleştirildiğinde gerçekleşir.