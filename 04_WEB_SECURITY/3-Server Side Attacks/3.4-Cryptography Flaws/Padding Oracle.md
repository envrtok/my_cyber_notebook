## 🧠 1. Temel Mantık (Nedir Bu?)

Padding Oracle, şifrelenmiş bir verinin içeriğini **anahtarı bilmeden** görmemizi ve değiştirmemizi sağlayan bir kriptografi zafiyetidir.

- **Neden Var?** Yazılımcılar, kullanıcının müdahale etmesini istemedikleri verileri (komutlar, kullanıcı rolleri, ID'ler) şifreleyerek URL'ye veya Cookie'ye koyarlar.
    
- **Zafiyet Nerede?** Sunucunun "geveze" olmasında. Sunucuya bozuk bir şifre gönderdiğimizde, eğer sunucu bize "Şifreyi çözdüm ama dolgusu (padding) hatalı" ile "Şifre doğru ama yetkisizsin" gibi **iki farklı tepki** veriyorsa, bu bir Oracle'dır (kahin).
    
- **Sonuç:** Bu tepki farklarını ölçerek, deneme-yanılma yoluyla şifreli metni blok blok (genelde 8 veya 16 byte) çözebiliriz.
    

---

## 🛠️ 2. Kurulum & Kolaylaştırma

GitHub'dan indirilen scripti her yerden çalıştırmak için:

1. **Yetki Ver:** `chmod +x padbuster.pl`
    
2. **Kısayol Oluştur (PATH):**
    ```bash
    sudo ln -s $(pwd)/padbuster.pl /usr/local/bin/padbuster
    ```
    
3. **Eksik Kütüphaneleri Kur:**
    
    ```bash
    sudo apt install liblwp-useragent-determined-perl libcrypt-ssleay-perl
    ```
    

---

## 🚀 3. Saldırı Adımları

### Aşama 1: Şifreyi Çözme (Decryption)

Elimizdeki şifreli metnin içinde ne yazdığını okumak için kullanılır.

```bash
padbuster [URL] [Şifreli_Metin] [Blok_Boyutu] -encoding 0 -cookies "PHPSESSID=xxx"
```

- **Blok Boyutu:** Genelde 8 veya 16.
    
- **-encoding 0:** Verinin Base64 formatında olduğunu belirtir.
    
- **-cookies:** Sunucu bizi login olmuş sansın diye tarayıcıdaki kimliğimizi veririz.
    

> **Kritik:** Araç başında `**` olan "Recommended" hata imzasını seçmeni isteyecektir. Genelde frekansı (Freq) en yüksek olanı seçip devam et.

---

### Aşama 2: Kendi Verini Şifreleme (Encryption/Forging)

İçeride ne yazdığını öğrendikten sonra, sistemde kendi komutumuzu çalıştırmak için sahte bir şifreli metin üretiriz.

```bash
padbuster [URL] [Şifreli_Metin] [Blok_Boyutu] -encoding 0 -cookies "PHPSESSID=xxx" -plaintext "whoami"
```

- **-plaintext:** Sunucunun çözmesini istediğin asıl komut (Örn: `whoami`, `id` veya bir reverse shell kodu).
    

---

## 🌍 4. Gerçek Dünyada Nerelerde Kullanılır?

1. **RCE (Uzaktan Kod Çalıştırma):** Şifrelenmiş sistem komutlarını değiştirerek.
    
2. **Yetki Yükseltme (Privilege Escalation):** Cookie içindeki `role=user` bilgisini `role=admin` yaparak.
    
3. **Dosya Okuma:** Şifrelenmiş dosya yollarını (Örn: `fatura.pdf`) sistem dosyalarıyla (Örn: `/etc/passwd`) değiştirerek.
    

---

## 💡 5. Altın İpuçları

- Eğer araç sürekli **302** hatası veriyorsa: Cookie (çerez) eksiktir veya yanlıştır.
    
- Eğer araç hata bulamıyorsa: Blok boyutunu değiştirmeyi (8 yerine 16) dene.
    
- Üretilen **Encrypted Value** içindeki `%3D` gibi karakterler URL Encode edilmiş halidir, tarayıcıda doğrudan çalışır.