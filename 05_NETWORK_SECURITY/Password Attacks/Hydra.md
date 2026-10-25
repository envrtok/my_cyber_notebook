## 🎯 Genel Bakış

**Hydra**, ağ servislerine (SSH, FTP, HTTP vb.) yönelik parola denemelerini (brute-force) otomatikleştirmek için kullanılan hızlı bir araçtır. Kullanıcı adı ve parola listeleriyle kimlik bilgilerini test edebilir.

## 🧾 Temel Sözdizimi

```bash
hydra -l <kullanıcı_adı> -P <parola_listesi> <hedef_ip> <servis>
```

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
|`-s <PORT>`|Varsayılan olmayan servis portunu belirtir (örn: `-s 2222`).|

### Deneme davranışı ve çıktı

|Parametre|Açıklama|
|---|---|
|`-V` veya `-vV`|Denenen kullanıcı adı ve parola kombinasyonlarını gösterir.|
|`-t <n>`|Paralel bağlantı sayısını belirtir (thread sayısı, varsayılan 16).|
|`-w <n>`|Bağlantılar için beklenecek süreyi saniye cinsinden belirtir.|
|`-f`|İlk geçerli kimlik bilgisi bulunduğunda durur.|
|`-d`|Hata ayıklama (debug) çıktısını gösterir.|

## 🧪 Örnekler

**SSH** (tek kullanıcı, parola listesi):

```bash
hydra -l admin -P rockyou.txt 192.168.1.50 ssh
```

**FTP** (kullanıcı listesi, parola listesi):

```bash
hydra -L users.txt -P passwords.txt 192.168.1.50 ftp
```

**Web giriş formu** (HTTP-POST):

```bash
hydra -l admin -P passwords.txt 192.168.1.50 http-post-form "/login.php:user=^USER^&pass=^PASS^:F=Login failed"
```

> [!tip] `http-post-form` biçimi
> `"<sayfa yolu>:<POST gövdesi>:F=<başarısız girişte dönen metin>"`. Hydra `^USER^` ve `^PASS^` yerine listedeki değerleri koyar. Yanıtta `F=` ile verilen metin yoksa giriş başarılı sayılır.

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

## İlgili Notlar

- [[2-Basic Login Enumeration|Basic Login Enumeration]]: web giriş formunda aynı işi `ffuf` ile yapmak
- [[5-cupp Tool|cupp Tool]]: hedefe özel parola listesi oluşturmak
- [[2-Kali'deki Wordlist Klasörünü Getirme Rehberi|Wordlist Klasörünü Getirme Rehberi]]: `rockyou.txt` gibi listeleri edinmek
