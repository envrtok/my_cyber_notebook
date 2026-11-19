## 📌 Protocol & Port Reference

Ağ servislerinin yaygın portlarını, kullanım amaçlarını ve veri aktarım güvenliğini gösteren referans tablosu.

|Protocol|TCP Port|Usage|Data Security|
|---|---|---|---|
|FTP|21|File Transfer|Cleartext|
|FTPS|990|File Transfer|Encrypted (Implicit TLS)|
|HTTP|80|Web|Cleartext|
|HTTPS|443|Web|Encrypted (TLS)|
|IMAP|143|Email (MDA)|Cleartext by default|
|IMAPS|993|Email (MDA)|Encrypted (Implicit TLS)|
|POP3|110|Email (MDA)|Cleartext by default|
|POP3S|995|Email (MDA)|Encrypted (Implicit TLS)|
|SFTP|22|Secure File Transfer|Encrypted (SSH)|
|SMTP|25|Email (MTA)|Cleartext by default|
|SMTP Submission|587|Email submission|STARTTLS commonly used|
|SMTPS|465|Email submission|Encrypted (Implicit TLS)|
|SSH|22|Remote Access & File Transfer|Encrypted|
|Telnet|23|Remote Access|Cleartext|

## 🧠 Önemli Ayrımlar

- **FTP vs. SFTP:** FTP varsayılan olarak şifreleme sağlamaz. SFTP, SSH üzerinden çalışır ve FTP'nin bir TLS sürümü değildir.
    
- **HTTP vs. HTTPS:** HTTP trafiği şifrelenmez; HTTPS, TLS ile koruma sağlar.
    
- **Telnet vs. SSH:** Telnet oturumu şifrelenmez; SSH şifreli uzaktan erişim sağlar.
    
- **IMAP vs. IMAPS:** IMAP genellikle `143`, IMAPS ise `993` portunu kullanır.
    
- **POP3 vs. POP3S:** POP3 genellikle `110`, POP3S ise `995` portunu kullanır.
    
- **SMTP:** `25` genellikle sunucular arası e-posta aktarımı; `587` istemcilerin e-posta göndermesi için kullanılır. `465`, TLS ile korunan e-posta gönderiminde kullanılır.
    

## ⚠️ Dikkat Edilecekler

- Bir port numarası tek başına servisin şifreli olduğunu garanti etmez.
    
- `STARTTLS`, mevcut bağlantıyı TLS ile şifrelemeye yükseltir; bağlantının güvenliği yapılandırmaya bağlıdır.
    
- Portlar varsayılan değerlerdir. Servisler farklı portlarda da çalışabilir.