
Kara kutu (black-box) sızma testlerinde dosya yükleme (file upload) zafiyetlerini tespit etmek ve adım adım ilerlemek için kullanabileceğin ideal metodoloji özeti:

---

## 1. Keşif ve Bilgi Toplama (Reconnaissance)

- **Teknoloji Tespiti:** Hedef web uygulamasının hangi diller ve framework'ler ile yazıldığını anlamak için **Wappalyzer** (tarayıcı eklentisi) kullanın.
    
- **Manuel Doğrulama:** Wappalyzer her zaman %100 doğru olmayabilir. Güvenilir bilgi için isteği **Burp Suite** ile yakalayıp dönen yanıttaki `Server` veya `X-Powered-By` header bilgilerini inceleyin.
    
- **Giriş Noktası:** Sitedeki potansiyel saldırı vektörlerini (profil resmi yükleme, döküman yükleme alanları vb.) tespit edin.
    

## 2. İstemci Tarafı İnceleme (Client-Side Inspection)

- **Kaynak Kod Kontrolü:** Dosya yükleme sayfasının kaynak kodundaki JavaScript filtrelerini inceleyin. Bu filtreler tamamen bizim kontrolümüzde (istemci tarafında) olduğu için bypass edilmesi en kolay engellerdir.
    

## 3. Zararsız Dosya Yükleme (Baseline & Path Enumeration)

- **Temel Çizgi (Baseline) Oluşturma:** İlk olarak tamamen zararsız ve geçerli bir dosya (örn: normal bir `.jpg`) yükleyin.
    
- **Erişim ve İsimlendirme Şeması:** Yüklenen dosyanın nereye gittiğini çözün:
    
    - Doğrudan bir `/uploads/` klasöründen erişilebiliyor mu?
        
    - Sayfa içinde bir yerlere gömülüyor mu?
        
    - Sunucu dosya ismini değiştiriyor mu (rastgele hash, tarih vb.)?
        
- **Dizin Tarama (Gobuster):** Dosyanın yüklendiği konum bariz değilse **Gobuster** kullanın.
- [[5-Directory Enumeration]]
    
    - > 💡 **Önemli Gobuster İpucu:** `-x` parametresini kullanarak kelime listesindeki her kelimenin sonuna uzantı ekleyebilirsiniz. (Örn: `-x php,txt,html`). Sunucu dosya ismini değiştirse bile doğru uzantıya sahip dosyayı avlamak için hayat kurtarır.
        

## 4. Zararlı Dosya ve Filtre Tespiti (Server-Side Enumeration)

Client-side filtreleri bypass ederek zararlı dosyayı yüklemeyi deneyin. Sunucunun bu dosyayı durdurmasını bekleriz; ancak dönen **hata mesajları** içeride ne tür bir koruma olduğunu anlamamızı sağlar.

### Sunucu Tarafı Filtre Türünü Parmak İzleme (Fingerprinting)

- **Uzantı Kara Liste mi, Beyaz Liste mi? (Extension Blacklist vs Whitelist):**
    
    - Tamamen geçersiz/uydurma bir uzantı (`test.invalidfileextension`) yükleyin.
        
    - **Başarılı olursa:** Sunucu **Kara Liste (Blacklist)** kullanıyordur (sadece belirli tehlikeli uzantıları engelliyordur, aradan kaçırmak kolaydır).
        
    - **Başarısız olursa:** Sunucu **Beyaz Liste (Whitelist)** kullanıyordur (sadece izin verilen uzantıları kabul ediyordur, bypass etmesi daha zordur).
        
- **Sihirli Sayı Filtresi (Magic Number / File Signatures):**
    
    - Başarıyla yüklenen zararsız dosyanın hex (magic number) değerini, engellenmesini beklediğiniz tehlikeli bir dosya türünün imzasıyla değiştirip tekrar yükleyin. Yükleme başarısız olursa, sunucu dosya içerik imzalarını kontrol ediyordur.
        
- **Content-Type Filtresi:**
    
    - Zararsız dosya yükleme isteğini Burp Suite ile yakalayın ve header'daki `Content-Type` değerini yasaklı/zararlı bir türle (örn: `application/x-php`) değiştirin. İstek reddedilirse Content-Type filtresi aktiftir.
        
- **Dosya Boyutu Filtresi (File Length):**
    
    - Küçük bir dosyadan başlayarak kademeli olarak daha büyük dosyalar yükleyin. Filtre sınırına ulaştığınızda limiti öğrenirsiniz (bazen hata mesajı limiti doğrudan söyler).
        
    - _Dikkat:_ Çok küçük dosya boyutu limitleri, standart reverse shell script'lerinin yüklenmesini engelleyebilir. Payload'u optimize etmek gerekebilir.