> [!summary] Özet Hosttan gelen **herhangi bir cevap** (ARP, ICMP, TCP ya da UDP) onun ayakta olduğunu gösterir. Hangi hostların açık olduğunu bilmek, kapsamı doğru belirlemenin ve sonraki taramaları verimli yapmanın temelidir.

## 1. Hedef Belirleme

|Yöntem|Örnek|Taranan IP sayısı|
|---|---|---|
|Liste|`MACHINE_IP scanme.nmap.org example.com`|3|
|Aralık|`10.11.12.15-20`|6 (`.15`, `.16`, … `.20`)|
|Subnet|`MACHINE_IP/30`|4|

> [!tip]
> 
> - Hedefleri dosyadan okumak için: `nmap -iL hedefler.txt`
> - Tarama yapmadan, hangi hostların taranacağını listelemek için: `nmap -sL -n 10.10.12.13/29`

## 2. Nmap'in Varsayılan Davranışı

Nmap, kullanıcının yetkisine (root/sudo olup olmamasına) ve hedefin aynı yerel ağda olup olmamasına göre farklı yöntem seçer.

|Durum|Host keşfi|Port taraması|
|---|---|---|
|Yetkili, iç ağ|ARP|SYN (yarı açık)|
|Yetkili, dış ağ|ICMP echo, SYN/443, ACK/80, ICMP timestamp|SYN (yarı açık)|
|Yetkisiz|TCP connect (80, 443)|TCP connect (tam el sıkışma)|

### Yetkili kullanıcı – iç ağ (aynı yerel subnet)

- **Host keşfi:** ARP request (`-PR`). ARP cevabı veren cihaz ayakta sayılır. ICMP veya TCP keşif paketi gönderilmez; ARP hem daha hızlı hem daha güvenilirdir. ARP 2. katmanda çalıştığı için güvenlik duvarları genelde onu engelleyemez.
- **Port taraması:** SYN tarama (`-sS`, yarı açık tarama).
    - SYN gönderilir.
    - SYN/ACK gelirse port **açık** → bağlantı RST ile kesilir, el sıkışma tamamlanmaz.
    - RST gelirse port **kapalı**.

### Yetkili kullanıcı – dış ağ

- **Host keşfi:** ICMP echo request, 443'e TCP SYN, 80'e TCP ACK ve ICMP timestamp request.
- **Port taraması:** Yine SYN tarama.

### Yetkisiz kullanıcı (iç/dış fark etmez)

- Raw socket açamadığı için işletim sisteminin `connect()` çağrısını kullanır → tam üçlü el sıkışma (SYN → SYN/ACK → ACK).
- **Port taraması:** TCP connect taraması (`-sT`).
- **Host keşfi:** 80 ve 443 portlarına aynı şekilde bağlanmayı dener.

> [!note] Varsayılanı değiştirmek
> 
> - Yetkili kullanıcı iç ağda ARP yerine IP tabanlı keşif isterse: `--send-ip`
> - Tam el sıkışmayla taramak isterse: `-sT`

## 3. Host Keşfi Parametreleri

> [!important] `-sn` Port taraması yapmadan **sadece host keşfi** yapar. `-sn` eklenmezse Nmap, ayakta bulduğu hostların portlarını da taramaya geçer.

### ARP – `-PR`

Sadece aynı yerel ağdaki hedeflerde çalışır. ARP cevabı gelen host ayaktadır.

### ICMP – `-PE`, `-PP`, `-PM`

|Parametre|Gönderilen paket|Beklenen cevap|
|---|---|---|
|`-PE`|ICMP Echo Request (Type 8)|Echo Reply (Type 0)|
|`-PP`|ICMP Timestamp Request (Type 13)|Timestamp Reply (Type 14)|
|`-PM`|ICMP Address Mask Request (Type 17)|Address Mask Reply (Type 18)|

> [!info] Neden üç farklı ICMP türü var? Birçok güvenlik duvarı klasik ping'i (echo request) engeller. Echo engellendiğinde timestamp veya address mask istekleri bazen hâlâ geçer ve cevap alınabilir. Amaç aynıdır, sadece farklı ICMP mesajı kullanılır.

### TCP – `-PS`, `-PA`

|Parametre|Ne gönderir|Host ayaktaysa|
|---|---|---|
|`-PS`|TCP SYN|Açık port → SYN/ACK, kapalı port → RST (ikisi de "ayakta" demek)|
|`-PA`|TCP ACK (kurulmamış bir bağlantıya)|RST döner|

- `-PS` için root gerekmez: yetkisiz kullanıcıda Nmap tam el sıkışma yapar.
- `-PA` için root gerekir: yetkisiz kullanıcıda Nmap tam el sıkışmaya döner.
- Varsayılan port 80'dir. Port, parametrenin hemen sonuna yazılır: `-PS25`, `-PS22,80,443`, `-PS80-90`

### UDP – `-PU`

- Hedef porta UDP paketi gönderilir.
- **Kapalı** port → ICMP Port Unreachable döner → host ayakta.
- **Açık** port çoğu zaman cevap vermez; bu yüzden genelde kapalı olması muhtemel portlar seçilir.
- Port belirtme TCP'deki gibi: `-PU53,161,162`

## 4. Komut Özeti

|Tarama Türü|Örnek Komut|
|---|---|
|ARP|`sudo nmap -PR -sn 10.200.6.0/24`|
|ICMP Echo|`sudo nmap -PE -sn 10.200.6.0/24`|
|ICMP Timestamp|`sudo nmap -PP -sn 10.200.6.0/24`|
|ICMP Address Mask|`sudo nmap -PM -sn 10.200.6.0/24`|
|TCP SYN Ping|`sudo nmap -PS22,80,443 -sn 10.200.6.0/30`|
|TCP ACK Ping|`sudo nmap -PA22,80,443 -sn 10.200.6.0/30`|
|UDP Ping|`sudo nmap -PU53,161,162 -sn 10.200.6.0/30`|

## 5. DNS Seçenekleri

|Parametre|Amaç|
|---|---|
|`-n`|DNS sorgusu yapma (daha hızlı ve sessiz)|
|`-R`|Kapalı olanlar dahil tüm hostlar için ters DNS (reverse-DNS) sorgusu yap|
|`-sn`|Sadece host keşfi|