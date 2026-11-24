Linux, Windows'taki `C:\`, `D:\` gibi sürücü harfleri yerine, `/` (root) dizininden başlayan tek bir ağaç yapısı kullanır. Bu yapı **Filesystem Hierarchy Standard (FHS)** ile standartlaştırılmıştır.

|Dizin|Açıklama|İçerik Örneği|
|---|---|---|
|`/` (Root)|Dosya sisteminin başlangıç noktasıdır.|Tüm sistem.|
|`/bin`|Temel kullanıcı komutlarını barındırır. (Binary)|`ls`, `cp`, `cat`, `bash`|
|`/boot`|Sistemin açılması için gereken dosyaları içerir.|`vmlinuz` (Kernel), `initrd`, GRUB|
|`/dev`|Donanım aygıt dosyalarını içerir. (Devices)|`/dev/sda` (Disk), `/dev/tty` (Terminal)|
|`/etc`|Sistemin yapılandırma dosyalarının bulunduğu merkezdir.|`/etc/passwd`, `/etc/ssh/sshd_config`|
|`/home`|Kullanıcıların kişisel dosyalarının saklandığı yerdir.|`/home/mehmet`, `/home/ali`|
|`/lib`|Programların ihtiyaç duyduğu kütüphane dosyaları.|`libc.so`, Kernel modülleri|
|`/mnt` & `/media`|Geçici bağlanan diskler ve USB bellekler.|`/media/usb-disk`|
|`/opt`|Elle kurulan 3. parti uygulamalar.|Google Chrome, TeamViewer vb.|
|`/proc`|Sanal dosya sistemi. Sistem bilgisini tutar.|`/proc/cpuinfo`, `/proc/meminfo`|
|`/root`|Sistem yöneticisinin (root) ev dizinidir.|Root'un özel dosyaları.|
|`/sbin`|Sadece yöneticinin kullandığı kritik komutlar.|`iptables`, `fdisk`, `reboot`|
|`/tmp`|Geçici dosyalar içindir.|Uygulama önbellekleri.|
|`/usr`|İkincil hiyerarşi. Kullanıcı araçları buradadır.|`/usr/bin/python`, `/usr/share`|
|`/var`|Boyutu sürekli değişen dosyalar.|Loglar (`/var/log`), Web sitesi (`/var/www`)|