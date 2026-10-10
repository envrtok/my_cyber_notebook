## 🎯 Genel Bakış

**Hydra**, ağ servislerine yönelik parola denemelerini otomatikleştirmek için kullanılan bir araçtır. Kullanıcı adı ve parola listeleriyle kimlik bilgilerini test edebilir.

## ⚙️ Temel Parametreler

### Kullanıcı adı ve parola

|Parametre|Açıklama|
|---|---|
|`-l <username>`|Tek bir kullanıcı adı belirtir.|
|`-L <users.txt>`|Kullanıcı adlarını içeren dosyayı belirtir.|
|`-p <password>`|Tek bir parola belirtir.|
|`-P <wordlist.txt>`|Parola listesini içeren dosyayı belirtir.|

### Hedef ve servis

|Parametre|Açıklama|
|---|---|
|`server service`|Hedef sunucuyu ve test edilecek servisi belirtir.|
|`-s <PORT>`|Varsayılan olmayan servis portunu belirtir.|

### Deneme davranışı ve çıktı

|Parametre|Açıklama|
|---|---|
|`-V` veya `-vV`|Denenen kullanıcı adı ve parola kombinasyonlarını gösterir.|
|`-t <n>`|Paralel bağlantı sayısını belirtir (thread sayısı).|
|`-w <n>`|Bağlantılar için beklenecek süreyi saniye cinsinden belirtir.|
|`-f`|İlk geçerli kimlik bilgisi bulunduğunda durur.|
|`-d`|Hata ayıklama (debug) çıktısını gösterir.|

## 🧠 Hatırlanması Gerekenler

- `-l` / `-p` → Tek bir kullanıcı adı / parola.
    
- `-L` / `-P` → Dosyadan kullanıcı adı / parola listesi.
    
- `-s` → Özel port.
    
- `-t` → Paralellik.
    
- `-f` → İlk başarılı sonuçta dur.
    
- `-V` → Denenen kombinasyonları göster.
    

## ⚠️ Dikkat

- `-t` değerini artırmak daha fazla paralel bağlantı açar; ancak hedef servis üzerindeki yükü de artırabilir.
    
- `-w` bağlantı davranışını yavaşlatmak için kullanılabilir.
    
- Hydra'yı yalnızca izinli laboratuvarlarda, CTF ortamlarında veya test etme yetkinin bulunduğu sistemlerde kullan.