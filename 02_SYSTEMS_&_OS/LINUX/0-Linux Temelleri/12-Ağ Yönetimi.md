# Ağ Yönetimi

> [!summary] Özet
> Linux'ta ağ araçları: eski set (`ifconfig`, `netstat`, `route`) yerini modern sete (`ip`, `ss`) bırakmıştır ama ikisi de birçok sistemde bulunur. Bu not arayüz/IP, port, yönlendirme, bağlantı testi, DNS, dosya transferi ve SSH'ı kapsar.

## Temel Kavramlar

- **IP Adresi:** Cihazın ağdaki mantıksal kimliği (`192.168.1.50`). Bkz. [[6-IP|IP]].
- **MAC Adresi:** Ağ kartının değişmez fiziksel adresi (`00:1A:2B:3C:4D:5E`). Bkz. [[9-ARP|ARP]].
- **Ağ Arayüzü:** Ağa bağlanılan kapı (`eth0` kablolu, `wlan0` kablosuz, `lo` loopback).
- **Gateway:** Yerel ağdan internete çıkış kapısı (genelde modem IP'si).

## 1. Arayüz ve IP (`ifconfig` → `ip`)

Arayüzleri listele:

```bash
ip addr          # modern; her arayüzün IP'si, MAC'i, durumu
ifconfig         # eski; ifconfig -a ile DOWN (IP almamış) arayüzler de görünür
```

`ip addr` çıktısında `inet 192.168.1.50/24` IP'yi, `link/ether 08:00:...` MAC'i, `state UP` arayüzün aktif olduğunu gösterir.

| İşlem | Eski (`ifconfig`) | Modern (`ip`) |
|---|---|---|
| Arayüzü kapat/aç | `ifconfig eth0 down` / `up` | `ip link set eth0 down` / `up` |
| IP ata (geçici) | `ifconfig eth0 172.20.1.110 netmask 255.255.255.0` | `ip addr add 172.20.1.110/24 dev eth0` |
| Promiscuous mod | `ifconfig eth0 promisc` | `ip link set eth0 promisc on` |
| MAC değiştir | `ifconfig eth0 hw ether AA:BB:CC:DD:EE:FF` | `ip link set eth0 address AA:BB:CC:DD:EE:FF` |

> [!note] Güvenlik
> **Promiscuous mod** kartı, kendine ait olmayan paketleri de işlemeye açar (sniffing). **MAC değiştirme** ağdaki ARP tablolarını karıştırabilir — dikkatli kullan. Geçici `ip`/`ifconfig` ayarları yeniden başlatınca sıfırlanır; kalıcı ayar NetworkManager/`netplan` ile yapılır.

## 2. Port ve Bağlantılar (`netstat` → `ss`)

Hangi portların açık ve kimin dinlediğini görmek güvenlik için kritiktir:

```bash
ss -tulpn          # modern (netstat -tulpn: eski)
```

Bayraklar: `-t` TCP · `-u` UDP · `-l` dinleyenler (LISTEN) · `-p` hangi process · `-n` sayısal (isim çözme yok).

Çıktıda ör. `0.0.0.0:22 LISTEN users:(("sshd",pid=950))` → sshd 22. portu dinliyor.

## 3. Yönlendirme Tablosu (`route` → `ip route`)

```bash
ip route           # route -n (eski)
# default via 192.168.1.1 dev eth0  → internet çıkışı (gateway) 192.168.1.1
```

`default via <gateway>` satırı internete çıkış kapısını gösterir.

## 4. Bağlantı Testi

| Komut | Ne yapar |
|---|---|
| `ping -c 3 google.com` | Erişim + gecikme testi (ICMP). Bkz. [[11-ICMP]] |
| `nc -zv 192.168.1.50 22` | Belirli portun açık olup olmadığını test eder (`-z` tarama, `-v` ayrıntı) |
| `tracepath google.com` | Paketin geçtiği router'ları gösterir (`traceroute` benzeri) |

## 5. DNS

```bash
dig google.com +short      # sade IP çıktısı (detaylı sorgu için dig)
nslookup google.com        # basit sorgu
```

**Kalıcı DNS ayarı** `/etc/resolv.conf` dosyasındadır (`nameserver` satırları):

```
nameserver 1.1.1.1
nameserver 1.0.0.1
```

> [!note]
> Modern sistemlerde `/etc/resolv.conf` genelde `systemd-resolved` veya NetworkManager tarafından otomatik yönetilir; elle düzenleme üzerine yazılabilir. DNS'in nasıl çalıştığı: [[15-Domain Name System (DNS)]].

## 6. Dosya Transferi

| Komut | Ne yapar |
|---|---|
| `wget https://.../dosya.zip` | Dosya indirir |
| `curl -I https://google.com` | Web isteği atar; `-I` sadece HTTP başlıklarını getirir |
| `scp rapor.pdf user@192.168.1.50:/home/user/` | SSH üzerinden güvenli kopyalama |

## 7. SSH (Secure Shell)

Ağ üzerinden uzak bir makineye şifreli bağlanma ve komut çalıştırma protokolü.

**Kurulum/servis (Debian tabanlı):**
```bash
sudo apt install openssh-server
sudo systemctl enable --now ssh      # başlat + açılışta otomatik
```

**Bağlanma:**
```bash
ssh user@192.168.1.100               # parola sorar
```

**Parolasız (anahtar tabanlı) bağlanma — daha güvenli:**
```bash
ssh-keygen                           # anahtar çifti üret (~/.ssh/id_*)
ssh-copy-id user@192.168.1.100       # açık anahtarı sunucuya kopyala
```

**Yapılandırma** `/etc/ssh/sshd_config` dosyasındadır; değişiklikten sonra `sudo systemctl restart ssh`:
```
Port 2222              # varsayılan 22'yi değiştir (küçük bir sıkılaştırma)
PermitRootLogin no     # root ile doğrudan girişi kapat (önerilir)
```

## İlgili Notlar

- [[10-Process Yönetimi]]: `ss -p` ile portu dinleyen process'i bulma
- [[2-nslookup & dig]] · [[2-ping & traceroute]]: keşifte DNS ve bağlantı testi
- [[14-Common Network Protocols and Ports]]: portların hangi servise ait olduğu
