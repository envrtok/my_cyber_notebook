> [!SUMMARY] Ana Tanım ve Varoluş Amacı
> **Pyramid of Pain**, savunma ekiplerinin engellediği tehdit göstergelerinin (IoC) saldırgana ne kadar zaman, maliyet ve emek kaybı ("acı") yaşattığını ölçen modeldir. 
> **Temel Amacı:** Güvenlik operasyonlarının odağını kolayca değiştirilebilen verilerden (Hash, IP) saldırganın davranış biçimlerine (**TTP'ler**) kaydırmaktır.

---

## Piramit Katmanları ve Örnekler
```
         / \
        /   \          TTPs (Çok Zor / Tough)
       / TTP \
      /-------\        Tools (Zorlu / Challenging)
     /  Tools  \
    /-----------\      Network/Host Artifacts (Rahatsız Edici / Annoying)
   / Network/Host\
  /---------------\    Domain Names (Basit / Simple)
 /  Domain Names   \
/-------------------\  IP Addresses (Kolay / Easy)

/ IP Addresses

/-----------------------\ Hash Values (Önemsiz / Trivial)

/ Hash Values

/___________________________\

```

### 1. Hash Values (Hash Değerleri)
* **Saldırgana Etkisi:** Önemsiz (Trivial)
* **Açıklama:** Belirli bir dosyanın veya zararlı yazılımın kriptografik parmak izidir.
* **Neden Etkisiz?:** Dosya içeriğindeki 1 baytlık önemsiz bir değişim (örneğin boşluk ekleme) Hash değerini tamamen değiştirir.
* **Örnekler:**
  * `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (SHA-256)
  * `44d88612fea8a8f36de82e1278abb02f` (MD5)

---

### 2. IP Addresses (IP Adresleri)
* **Saldırgana Etkisi:** Kolay (Easy)
* **Açıklama:** Saldırganın komuta kontrol (C2) sunucusunun veya saldırı altyapısının ağ adresidir.
* **Neden Etkisiz?:** Saldırgan yeni bir VPN, Proxy, TOR çıkış düğümü veya ucuz bir VPS kiralayarak dakikalar içinde yeni IP'ye geçebilir.
* **Örnekler:**
  * `192.0.2.45` (Saldırgan C2 sunucusu IP'si)
  * `198.51.100.12` (Oltalama e-postasının gönderildiği sunucu IP'si)

---

### 3. Domain Names (Alan Adları)
* **Saldırgana Etkisi:** Basit (Simple)
* **Açıklama:** C2 iletişimi veya oltalama sayfaları için tescil edilen internet adresleridir.
* **Neden Etkisiz?:** Yeni bir alan adı satın almak ucuzdur. Ancak DNS yayılımı ve ödeme süreçleri IP değiştirmeye kıyasla bir tık daha fazla zaman alır.
* **Örnekler:**
  * **Typo-squatting:** `g00gle-login-verify.com`
  * **Dynamic DNS:** `malware-c2.ddns.net`
  * **Phishing:** `secure-update-bank.org`

---

### 4. Network & Host Artifacts (Ağ ve Sunucu Yapay Nesneleri)
* **Saldırgana Etkisi:** Rahatsız Edici (Annoying)
* **Açıklama:** Zararlı yazılımın veya aracın işletim sisteminde ya da ağ trafiğinde bıraktığı, kodlama yapısından kaynaklanan karakteristik izlerdir.
* **Neden Etkili?:** Saldırgan IP veya domain değiştirse bile bu izler değişmez. Saldırganın aracın kaynak kodunu düzenlemesi ve yeniden derlemesi gerekir.
* **Örnekler:**
  * **Host Artifacts:**
    * Özel Mutex adı: `Global\MyMalwareMutex_v2`
    * Kalıcılık için eklenen Registry anahtarı: `HKCU\Software\Microsoft\Windows\CurrentVersion\Run\EvilKey`
    * Bırakılan sabit dizin/dosya: `C:\Windows\Temp\debug_log.dll`
  * **Network Artifacts:**
    * Özel HTTP User-Agent: `MyCustomC2Client/1.0`
    * Sabit URI kalıbı: `http://<IP>/api/v1/checkin.php?id=`
    * TLS Parmak İzi (JA3 Hash): `771031a2e58428230136d2c16158229b`

---

### 5. Tools (Araçlar)
* **Saldırgana Etkisi:** Zorlu (Challenging)
* **Açıklama:** Saldırganın ağda ilerlemek, bilgi toplamak veya yetki yükseltmek için kullandığı yazılımlardır.
* **Neden Etkili?:** Savunma tarafı aracı imza veya davranış bazlı (EDR) tamamen engellediğinde; saldırgan yeni araç satın almalı, var olanı obfuscate etmeli (gizlemeli) veya sıfırdan araç geliştirmelidir.
* **Örnekler:**
  * **Mimikatz:** Bellekten parola dökümü alma aracı.
  * **Cobalt Strike:** Gelişmiş sızma ve C2 platformu.
  * **BloodHound:** Active Directory ilişki ve yetki haritalama aracı.
  * **PsExec:** Ağ içi uzaktan komut çalıştırma aracı.

---

### 6. TTPs (Taktik, Teknik ve Prosedürler)
* **Saldırgana Etkisi:** Çok Zor (Tough)
* **Açıklama:** Saldırganın hedefine ulaşırken kullandığı davranış kalıpları, alışkanlıkları ve metodolojisidir. (Bkz: [[MITRE ATT&CK]])
* **Neden En Etkili?:** Saldırganın düşünme ve iş yapma biçimini engellemektir. Saldırgan aracı değiştirse bile aynı tekniği kullanamaz; yeni bir strateji öğrenmek zorunda kalır.
* **Örnek Hiyerarşi:**
  * **Taktik (Ne yapacak?):** *Credential Access* (Kimlik Bilgisi Ele Geçirme)
  * **Teknik (Nasıl yapacak?):** *LSASS Memory Dumping* (T1003.001)
  * **Prosedür (Tam adımlar neler?):** Saldırganın `comsvcs.dll` kullanarak `lsass.exe` bellek dökümünü `rundll32.exe` üzerinden alması.

---

## Özet Karşılaştırma Tablosu

| Katman | Saldırgana Zorluğu | Savunmanın Odaklandığı Unsur | Örnek Aksiyon |
| :--- | :--- | :--- | :--- |
| **Hash Values** | Önemsiz | Dosya Kimliği | Anti-Virüs imzasına hash eklemek |
| **IP Addresses** | Kolay | Ağ Adresi | C2 IP'sini güvenlik duvarında engellemek |
| **Domain Names** | Basit | İnternet Adresi | DNS Sinkhole ile domain'i engellemek |
| **Artifacts** | Rahatsız Edici | Kod/Trafik İzleri | Özel User-Agent veya Mutex kuralı yazmak |
| **Tools** | Zorlu | Yazılım | EDR ile Mimikatz çalıştırılmasını engellemek |
| **TTPs** | Çok Zor | Davranış/Metodoloji | LSASS belleğine erişim tekniğini engellemek |
