# tcpdump

> [!summary] Özet
> `tcpdump`, komut satırından paket yakalama ve inceleme aracıdır. Trafiği canlı gösterir veya `.pcap` dosyasına kaydeder (sonra Wireshark'ta açılır). Yakalama/okuma genelde root/sudo ister. Filtreleri [[2-Wireshark - Filtre Sözdizimi|BPF]] sözdizimine dayanır.

## Kurulum ve Kontrol

```bash
sudo apt install tcpdump      # Debian/Ubuntu (RHEL/Fedora: dnf install)
tcpdump --version
```

## Yakalama

```bash
tcpdump -D                    # kullanılabilir arayüzleri listele
sudo tcpdump -i eth0          # eth0'da yakalamaya başla
```

## Çıktıyı Okuma

Her satır bir pakettir. Örnek:

```
13:38:45.232106 IP 192.168.122.59.58774 > 93.184.216.34.http: Flags [.], ack 1021, win 501, length 0
```

| Alan | Örnek | Anlamı |
|---|---|---|
| Zaman damgası | `13:38:45.232106` | Paketin yakalanma anı |
| Kaynak | `192.168.122.59.58774` | Kaynak IP + port |
| Hedef | `93.184.216.34.http` | Hedef IP + port (http = 80) |
| Flags | `[.]` | TCP bayrakları (aşağıda) |
| `ack` / `win` | `ack 1021`, `win 501` | Onay no / pencere boyutu |
| `length` | `0` | Veri kısmının uzunluğu (byte) |

**TCP bayrak kısaltmaları:** `.` = ACK · `S` = SYN · `F` = FIN · `R` = RST · `P` = PSH · `U` = URG. Ayrıntı: [[2-Nmap Scans and TCP Flags|TCP Flags]].

## Filtreleme (BPF)

```bash
tcpdump 'tcp'                 # sadece TCP
tcpdump 'host 192.168.1.100'  # belirli IP'ye gelen/giden
tcpdump 'port 80'             # 80. port (HTTP)
tcpdump 'tcp and port 22'     # and / or ile birleştir (TCP VE SSH)
```

## Dosyaya Kaydetme / Okuma

```bash
sudo tcpdump -i eth0 -w output.pcap   # yakalananları dosyaya yaz
tcpdump -r output.pcap                # dosyadan oku (Wireshark'ta da açılır)
```

## İlgili Notlar

- [[2-Wireshark - Filtre Sözdizimi|Wireshark Filtre Sözdizimi]]: aynı BPF + görüntüleme filtreleri
- [[12-TCP]] · [[14-Common Network Protocols and Ports]]: yakalanan trafiğin yorumu
