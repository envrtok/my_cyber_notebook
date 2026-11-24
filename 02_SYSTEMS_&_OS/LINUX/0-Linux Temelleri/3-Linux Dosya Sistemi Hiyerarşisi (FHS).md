	# Linux Dosya Sistemi Hiyerarşisi (FHS)

> [!summary] Özet
> Linux, sürücü harfleri yerine `/` (root) dizininden başlayan **tek bir ağaç** kullanır. Bu yapı **Filesystem Hierarchy Standard (FHS)** ile standartlaştırılmıştır; her üst dizinin belirli bir görevi vardır.

| Dizin | Açıklama | İçerik örneği |
|---|---|---|
| `/` | Dosya sisteminin kökü | Tüm sistem |
| `/bin` | Temel kullanıcı komutları (binary) | `ls`, `cp`, `cat`, `bash` |
| `/boot` | Açılış için gereken dosyalar | `vmlinuz` (kernel), GRUB |
| `/dev` | Donanım aygıt dosyaları | `/dev/sda`, `/dev/tty` |
| `/etc` | Sistem yapılandırma dosyaları | `/etc/passwd`, `sshd_config` |
| `/home` | Kullanıcıların kişisel dizinleri | `/home/mehmet` |
| `/lib` | Programların kütüphaneleri | `libc.so`, kernel modülleri |
| `/mnt`, `/media` | Geçici bağlanan disk/USB | `/media/usb-disk` |
| `/opt` | Elle kurulan 3. parti uygulamalar | Chrome, TeamViewer |
| `/proc` | Sanal FS; canlı sistem bilgisi | `/proc/cpuinfo`, `/proc/meminfo` |
| `/root` | root kullanıcısının ev dizini | Root'un dosyaları |
| `/sbin` | Yönetici (root) komutları | `iptables`, `fdisk`, `reboot` |
| `/tmp` | Geçici dosyalar | Önbellekler |
| `/usr` | İkincil hiyerarşi; kullanıcı araçları | `/usr/bin/python`, `/usr/share` |
| `/var` | Boyutu değişen dosyalar | Loglar (`/var/log`), web (`/var/www`) |

## İlgili Notlar

- [[1-Critical System Folders]]: güvenlik/analizde hedeflenen kritik dosyalar (`/etc/passwd`, loglar vb.)
- [[2-Dizinlerde Gezinti]]: bu ağaçta dolaşma komutları
