# GNOME çökmesi / giriş döngüsü – kurtarma notu

**Belirti:** Ekran birden kararıp giriş ekranına atıyor, şifreyi girince tekrar giriş ekranı geliyor ya da şifre kutusu yazı kabul etmiyor.

## 1. Terminale (TTY) geç
`Ctrl + Alt + F3` → kullanıcı adı ve şifreyle gir (şifre yazarken görünmez).

> Şifre kutusu donmuşsa TTY'de: `sudo systemctl restart gdm3`

## 2. Sebebi kaydet (sıfırlamadan önce)
```bash
coredumpctl info gnome-shell | head -60
sudo journalctl -b -k | grep -iE "gnome-shell.*(segfault|protection)"
```
Çıktının fotoğrafını çek. `coredumpctl` yoksa aşağıdaki "Önlem" kısmına bak.

## 3. Ayarları yedekle ve sıfırla
```bash
cp ~/.config/dconf/user ~/dconf-user.yedek-$(date +%F)
rm ~/.config/dconf/user
sudo reboot
```
Dosyaların silinmez. Sadece masaüstü ayarları (tema, duvar kâğıdı, kısayollar) sıfırlanır.

## 4. Girişten sonra
- Görünümü Ayarlar'dan elle yap.
- Albert kısayolu: Ayarlar → Klavye → Özel Kısayollar → Ad `Albert`, Komut `albert toggle`, Kısayol `Ctrl + ,`

## Yapma
- Oturum açıkken `dconf reset -f /` çalıştırma. Çalışan oturumu çökertebilir.
- Yedeği (`dconf-user.yedek…`) olduğu gibi geri yükleme. Sorunlu ayar onun içinde.
- Elektrik tuşuyla kapatma son çare olsun. Önce `Alt + PrtSc` basılıyken sırayla **R S U B** dene.

## Önlem (bir kere yap)
```bash
sudo apt install systemd-coredump
```
Bundan sonra çökme olursa 2. adımdaki `coredumpctl` komutu sebebi doğrudan gösterir.

## İpuçları
- TTY'de "İ" harfi yazılamaz/görünmez: `~/İndirilenler` yerine `~/*ndirilenler` yaz.
- Claude Desktop kısayol izni isterse "İptal" de.
