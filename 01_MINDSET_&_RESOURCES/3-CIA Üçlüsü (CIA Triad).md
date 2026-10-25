> [!summary] Özet
> **CIA üçlüsü**, bilgi güvenliğinin üç temel hedefidir: **Gizlilik (Confidentiality)**, **Bütünlük (Integrity)** ve **Erişilebilirlik (Availability)**. Her güvenlik önlemi en az birini *korumaya*, her saldırı en az birini *bozmaya* çalışır.
> Bir açığı değerlendirirken "bu hangi hedefi tehdit ediyor?" diye sormak, riski anlamanın en hızlı yoludur.

## Üç Hedef

| Hedef | Anlamı | Nasıl sağlanır | Bozulduğunda ne olur |
|---|---|---|---|
| **Gizlilik** (Confidentiality) | Veriye yalnızca yetkili kişiler erişebilir | Şifreleme, erişim kontrolü, en az yetki (least privilege) | Veri sızıntısı, yetkisiz okuma |
| **Bütünlük** (Integrity) | Veri izinsiz değiştirilemez; değişiklik fark edilir | Hash, dijital imza, MAC, sürüm kontrolü | Verinin sessizce değiştirilmesi, sahtecilik |
| **Erişilebilirlik** (Availability) | Veri ve servis gerektiğinde ulaşılabilir | Yedekleme, yük dengeleme, DoS koruması, bakım | Hizmet kesintisi, veri kaybı |

```
            Gizlilik
               /\
              /  \
             /    \
            / CIA  \
           /        \
          /__________\
    Bütünlük      Erişilebilirlik
```

> [!important] Denge meselesi
> Üç hedef çoğu zaman birbiriyle çekişir. Veriyi iki kez şifreleyip yedi kata kilitlemek **gizliliği** artırır ama **erişilebilirliği** düşürür. Güvenlik, bu üçü arasında doğru dengeyi kurmaktır — hepsini sonuna kadar açmak değil.

## Her Hedefin Karşılığı: Bu Defterdeki Örnekler

| Saldırı / durum | Öncelikle bozduğu hedef |
|---|---|
| [[3-Introduction to IDOR\|IDOR]] — başkasının kaydını okuma | Gizlilik |
| [[Heartbleed (CVE-2014-0160)]] — sunucu belleğinin sızması | Gizlilik |
| Cleartext protokoller (bkz. [[3-Common Network Protocols and Ports\|Protocols and Ports]]) | Gizlilik |
| Web sayfası tahrifi (defacement), veri manipülasyonu | Bütünlük |
| Eksik/yanlış hash doğrulaması | Bütünlük |
| DoS / DDoS, fidye yazılımı ile kilitleme | Erişilebilirlik |
| SQL Injection | Duruma göre üçü de |

## Genişletmeler

Üçlüye pratikte sık eklenen kavramlar:

- **Kimlik Doğrulama (Authentication):** "Sen gerçekten kim olduğunu söylediğin kişi misin?"
- **Yetkilendirme (Authorization):** "Bunu yapmaya iznin var mı?"
- **İnkâr edememe (Non-repudiation):** Bir işlemi yapanın sonradan "ben yapmadım" diyememesi (dijital imzalarla sağlanır).
- **Hesap verebilirlik (Accountability):** Her eylemin bir kimliğe kadar izlenebilmesi (loglar).

> [!tip] AAA
> Authentication + Authorization + Accounting birlikte **AAA** olarak anılır ve erişim kontrolünün temelidir.

## İlgili Notlar

- [[0-Encoding vs Hashing vs Encryption]]: gizlilik (şifreleme) ve bütünlük (hash) için kullanılan temel araçlar
- [[1-Pyramid of Pain\|Pyramid of Pain]] ve [[2-Cyber & Unified Kill Chain\|Kill Chain]]: saldırganın bu hedefleri bozma yolculuğu
- [[3-Common Network Protocols and Ports\|Common Network Protocols and Ports]]: cleartext vs şifreli protokoller ve gizlilik
