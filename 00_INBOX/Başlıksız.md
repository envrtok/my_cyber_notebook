# nmap new infos
We mentioned the different techniques we can use for scanning in Task 1. Before we explain each in detail and test it against a live target, we need to specify the targets we want to scan. Generally speaking, you can provide a list, a range, or a subnet. Examples of target specification are:

- list: `MACHINE_IP scanme.nmap.org example.com` will scan 3 IP addresses.
- range: `10.11.12.15-20` will scan 6 IP addresses: `10.11.12.15`, `10.11.12.16`,… and `10.11.12.20`.
- subnet: `MACHINE_IP/30` will scan 4 IP addresses.
---
**Yetkili kullanıcı, iç ağda (aynı yerel subnet):**

- **Host keşfi:** ARP request paketleri (`-PR`). ARP cevabı gelen cihaz ayakta sayılır. Bu durumda ICMP veya TCP keşif paketi gönderilmez, çünkü ARP hem daha hızlı hem de güvenilirdir. Güvenlik duvarları genelde ARP’yi engelleyemez.
- **Port taraması:** SYN tarama (`-sS`, yarı açık tarama). SYN gönderilir. SYN/ACK gelirse port açıktır ve bağlantı RST ile kesilir, yani el sıkışma tamamlanmaz. RST gelirse port kapalıdır.

**Yetkili kullanıcı, dış ağda:**

- **Host keşfi:** ICMP echo request, 443'e TCP SYN, 80'e TCP ACK ve ICMP timestamp request.
- **Port taraması:** Yine SYN tarama.

**Yetkisiz kullanıcı (iç veya dış fark etmez):**  
Raw socket açamadığı için işletim sisteminin `connect()` çağrısını kullanır. Bu, tam üçlü el sıkışma demektir (SYN → SYN/ACK → ACK), yani TCP connect taraması (`-sT`). Host keşfinde de 80 ve 443 portlarına bu şekilde bağlanmayı dener.

||Host keşfi|Port taraması|
|---|---|---|
|Yetkili, iç ağ|ARP|SYN (yarı açık)|
|Yetkili, dış ağ|ICMP echo, SYN/443, ACK/80, ICMP timestamp|SYN (yarı açık)|
|Yetkisiz|TCP connect (80, 443)|TCP connect (tam el sıkışma)|

Ek bilgi: Yetkili kullanıcı da iç ağda ARP yerine IP tabanlı keşif isterse `--send-ip`, tam el sıkışmayla tarama isterse `-sT` kullanabilir.

---
- nmap -sn parametresi port taraması yapmaksızın sadece host taraması yapılmasını sağlar
- -PR parametresi de özellikle ARP taraması yapılmasını sağlıyor
- 