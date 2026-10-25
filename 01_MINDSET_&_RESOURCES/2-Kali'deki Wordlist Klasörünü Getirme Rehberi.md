---
tags:
---
Kali'deki `/usr/share/wordlists` klasörünün birebir aynısını Pardus'a (veya Debian tabanlı başka bir sisteme) taşıma adımları.

> [!info] Neden direkt kopyalanmıyor?
> Kali'deki `wordlists` klasörü çoğunlukla **kısayollardan (symlink)** oluşur. Listelerin çoğu dirb, metasploit, john gibi araçların kendi klasörlerinde durur; `wordlists` klasörü sadece onları gösterir. Normal kopyalarsan kırık kısayollar gelir. **Çözüm:** `tar` komutuna `-h` vererek kısayolları gerçek dosyalara çevirmek.

---

## Yöntem 1: Elinde Kali varsa

Sanal makine, live USB veya başka bir bilgisayardaki Kali olabilir.

### 1. Kali'de klasörü paketle

```bash
sudo tar -czhf ~/wordlists.tar.gz -C /usr/share wordlists
```

### 2. Dosyayı Pardus'a taşı

USB ile ya da ağ üzerinden:

```bash
scp ~/wordlists.tar.gz kullanici@PARDUS_IP:~
```

### 3. Pardus'ta aç

```bash
sudo tar -xzf ~/wordlists.tar.gz -C /usr/share
```

Bitti. Aşağıdaki [[#Son adımlar]] bölümüne geç.

---

## Yöntem 2: Elinde Kali yoksa (Docker ile)

Pardus'ta geçici bir Kali container'ı açıp klasörü oradan çıkarırsın.

> [!note] Komutlar root olarak yazıldı
> Normal kullanıcıyla çalışıyorsan Pardus'taki komutların başına `sudo` ekle.

### 1. Docker'ı kur ve başlat — _Pardus'ta_

```bash
apt install docker.io
systemctl enable --now docker
```

### 2. Kali container'ını aç — _Pardus'ta_

```bash
docker run --name kali -it kalilinux/kali-rolling bash
```

Komut satırı `┌──(root㉿...)` şekline dönüşürse Kali'nin içindesin.

### 3. Araçları kur ve klasörü paketle — _Kali container'ının içinde_

```bash
apt update
DEBIAN_FRONTEND=noninteractive apt install -y kali-linux-default
tar -czhf /tmp/wordlists.tar.gz -C /usr/share wordlists
exit
```

> [!tip] Neden `kali-linux-default`?
> Standart bir Kali kurulumunda gelen araçların hepsini kurar. Klasörün birebir aynı çıkmasının sebebi bu. Birkaç GB indirir, bitmesini bekle.

`exit` yazınca Pardus'a dönersin (`root@pardus` görürsün).

### 4. Dosyayı çıkar ve yerine koy — _Pardus'ta_

```bash
docker cp kali:/tmp/wordlists.tar.gz ~/
tar -xzf ~/wordlists.tar.gz -C /usr/share
```

### 5. Temizlik — _Pardus'ta_

```bash
docker rm kali
docker rmi kalilinux/kali-rolling
rm ~/wordlists.tar.gz
```

Docker'ı başka bir iş için kullanmayacaksan servisi de kapatabilirsin (isteğe bağlı):

```bash
systemctl disable --now docker
```

---

## Son adımlar

### Kontrol et

```bash
ls /usr/share/wordlists
```

### rockyou'yu aç (isteğe bağlı)

Kali'de olduğu gibi `.gz` olarak gelir. Açmak için:

```bash
gunzip /usr/share/wordlists/rockyou.txt.gz
```

---

## Sorun giderme

|Hata|Sebep|Çözüm|
|---|---|---|
|`Cannot connect to the Docker daemon at unix:///var/run/docker.sock`|Docker servisi çalışmıyor|Pardus'ta `systemctl enable --now docker`|
|Container içinde `systemctl: command not found`|Container'larda systemd olmaz, normaldir|Görmezden gel; `systemctl` komutlarını Pardus'ta çalıştır|
|`The container name "/kali" is already in use`|Önceki denemeden kalan container var|Kaldığın yerden devam: `docker start -ai kali`<br>Sıfırdan başla: `docker rm kali`|
|`tar` adımından önce yanlışlıkla `exit` yazdın|Container durdu ama silinmedi|`docker start -ai kali` ile geri gir, kurulum yerinde duruyor|

---

> [!warning] Kali depolarını Pardus'a ekleme
> `sources.list` dosyasına Kali depolarını ekleyip `apt install wordlists` yapmak Pardus'un paket bağımlılıklarını ve güncellemelerini bozabilir. Bu rehberdeki yöntemler sistemi kurcalamadan sadece dosyaları getirir.