Sisteme giriş yaptıktan sonra (düşük yetkili kullanıcı - örn: `www-data`) ilk kontrol edilmesi gereken yerlerden biri `sudo` yetkileridir.

- **Temel Komut:** `sudo -l`
    
- **Anlamı:** Kullanıcının şifre girmeden (`NOPASSWD`) hangi komutları `root` yetkisiyle çalıştırabileceğini gösterir.
    
- **Zafiyet:** Eğer çıktı `(ALL : ALL) NOPASSWD: ALL` ise, başına `sudo` eklediğin her komut en yüksek yetkiyle çalışır. Bu, sistemin anahtarını teslim almak demektir.