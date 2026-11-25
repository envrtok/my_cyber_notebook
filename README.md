# 🛡️ My Cyber Notebook

Siber güvenlik öğrenme yolculuğumda tuttuğum kişisel notlar. Hepsi [Obsidian](https://obsidian.md)'da yazılıyor ve buraya otomatik olarak senkronize ediliyor — yani bu depo, öğrendikçe büyüyen canlı bir defter.

**Odak alanları:** keşif & OSINT · web güvenliği · ağ güvenliği · exploitation & shell'ler · yetki yükseltme · post-exploitation · SOC & savunma çerçeveleri

Notların bir kısmı Türkçe, bir kısmı İngilizce; çoğu TryHackMe ve benzeri lab ortamlarında çalışırken alındı.

> [!WARNING]
> Bu notlar yalnızca eğitim amaçlıdır. Buradaki teknikleri sadece izinli ortamlarda (CTF'ler, lab'lar, yetkili testler) kullan.

## 🗂️ Not Dizini

<!-- INDEX:START -->

![Notlar](https://img.shields.io/badge/notlar-100-0f766e?style=flat-square)


### 📂 01 · MINDSET & RESOURCES <sub>(6)</sub>

- [0-New Hacking Tools](<01_MINDSET_&_RESOURCES/0-New Hacking Tools.md>)
- [0-Privacy Tools & Tips](<01_MINDSET_&_RESOURCES/0-Privacy Tools & Tips.md>)
- [1-Sahte Yemler (Rabbit Holes)](<01_MINDSET_&_RESOURCES/1-Sahte Yemler (Rabbit Holes).md>)
- [2-Kali'deki Wordlist Klasörünü Getirme Rehberi](<01_MINDSET_&_RESOURCES/2-Kali'deki Wordlist Klasörünü Getirme Rehberi.md>)
- [3-CIA Üçlüsü (CIA Triad)](<01_MINDSET_&_RESOURCES/3-CIA Üçlüsü (CIA Triad).md>)
- [4-Sızma Testi Metodolojileri](<01_MINDSET_&_RESOURCES/4-Sızma Testi Metodolojileri.md>)

### 📂 02 · SYSTEMS & OS <sub>(20)</sub>

- **LINUX**
  - [APT Package Management Cheatsheet](<02_SYSTEMS_&_OS/LINUX/APT Package Management Cheatsheet.md>)
  - [ARNET-WIFI-linux-rehberi](<02_SYSTEMS_&_OS/LINUX/ARNET-WIFI-linux-rehberi.md>)
  - [Python Virtual Environment Quick Guide](<02_SYSTEMS_&_OS/LINUX/Python Virtual Environment Quick Guide.md>)
  - [Snap & Flatpak](<02_SYSTEMS_&_OS/LINUX/Snap & Flatpak.md>)
  - [firefox-librewolf-gizli-dikey-sekmeler](<02_SYSTEMS_&_OS/LINUX/firefox-librewolf-gizli-dikey-sekmeler.md>)
  - [gnome-cokme-kurtarma](<02_SYSTEMS_&_OS/LINUX/gnome-cokme-kurtarma.md>)
  - [systemctl & crontab](<02_SYSTEMS_&_OS/LINUX/systemctl & crontab.md>)
  - [🧰 Linux Disk Commands Cheatsheet](<02_SYSTEMS_&_OS/LINUX/🧰 Linux Disk Commands Cheatsheet.md>)
- **LINUX › 0-Linux Temelleri**
  - [1-terminal](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/1-terminal.md>)
  - [10-Process Yönetimi](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/10-Process Yönetimi.md>)
  - [11-Vim](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/11-Vim.md>)
  - [12-Ağ Yönetimi](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/12-Ağ Yönetimi.md>)
  - [2-Dizinlerde Gezinti](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/2-Dizinlerde Gezinti.md>)
  - [3-Linux Dosya Sistemi Hiyerarşisi (FHS)](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/3-Linux Dosya Sistemi Hiyerarşisi (FHS).md>)
  - [4-Dosya ve Dizin İşlemleri](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/4-Dosya ve Dizin İşlemleri.md>)
  - [5-Linux'ta Dosya ve Dizinleri Bulma Yöntemleri](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/5-Linux'ta Dosya ve Dizinleri Bulma Yöntemleri.md>)
  - [6-Filtreler](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/6-Filtreler.md>)
  - [7-İzinler](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/7-İzinler.md>)
  - [8-Kullanıcı Yönetimi](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/8-Kullanıcı Yönetimi.md>)
  - [9-Grup Yönetimi](<02_SYSTEMS_&_OS/LINUX/0-Linux Temelleri/9-Grup Yönetimi.md>)

### 📂 03 · RECON & OSINT <sub>(18)</sub>

- **1-Passive Recon & OSINT**
  - [1-WHOIS & RDAP](<03_RECON_&_OSINT/1-Passive Recon & OSINT/1-WHOIS & RDAP.md>)
  - [2-nslookup & dig](<03_RECON_&_OSINT/1-Passive Recon & OSINT/2-nslookup & dig.md>)
  - [3-Discovery with OSINT](<03_RECON_&_OSINT/1-Passive Recon & OSINT/3-Discovery with OSINT.md>)
  - [4-theHarvester Detailed](<03_RECON_&_OSINT/1-Passive Recon & OSINT/4-theHarvester Detailed.md>)
  - [5-cupp Tool](<03_RECON_&_OSINT/1-Passive Recon & OSINT/5-cupp Tool.md>)
- **2-Active Recon & Network Probing**
  - [1-Developer Tools](<03_RECON_&_OSINT/2-Active Recon & Network Probing/1-Developer Tools.md>)
  - [2-ping & traceroute](<03_RECON_&_OSINT/2-Active Recon & Network Probing/2-ping & traceroute.md>)
  - [Discovery with Curl](<03_RECON_&_OSINT/2-Active Recon & Network Probing/Discovery with Curl.md>)
- **2-Active Recon & Network Probing › 3-Nmap**
  - [1-Nmap – Host Keşfi](<03_RECON_&_OSINT/2-Active Recon & Network Probing/3-Nmap/1-Nmap – Host Keşfi.md>)
  - [2-Nmap Scans and TCP Flags](<03_RECON_&_OSINT/2-Active Recon & Network Probing/3-Nmap/2-Nmap Scans and TCP Flags.md>)
  - [3-Nmap - Spoofing and Decoys](<03_RECON_&_OSINT/2-Active Recon & Network Probing/3-Nmap/3-Nmap - Spoofing and Decoys.md>)
  - [4-Nmap - Idle (Zombie) Scan](<03_RECON_&_OSINT/2-Active Recon & Network Probing/3-Nmap/4-Nmap - Idle (Zombie) Scan.md>)
- **2.1-Web & Content Discovery**
  - [0-Recon vs Content Discovery](<03_RECON_&_OSINT/2.1-Web & Content Discovery/0-Recon vs Content Discovery.md>)
  - [1-Manually Discovery](<03_RECON_&_OSINT/2.1-Web & Content Discovery/1-Manually Discovery.md>)
  - [2-Subdomain vs Directory](<03_RECON_&_OSINT/2.1-Web & Content Discovery/2-Subdomain vs Directory.md>)
  - [3-Finding Subdomains with OSINT](<03_RECON_&_OSINT/2.1-Web & Content Discovery/3-Finding Subdomains with OSINT.md>)
  - [4-Automated Subdomain Enumeration](<03_RECON_&_OSINT/2.1-Web & Content Discovery/4-Automated Subdomain Enumeration.md>)
  - [5-Directory Enumeration](<03_RECON_&_OSINT/2.1-Web & Content Discovery/5-Directory Enumeration.md>)

### 📂 04 · WEB SECURITY <sub>(16)</sub>

- **1-Access Control & Authentication**
  - [1-Basic Username Enumeration](<04_WEB_SECURITY/1-Access Control & Authentication/1-Basic Username Enumeration.md>)
  - [2-Basic Login Enumeration](<04_WEB_SECURITY/1-Access Control & Authentication/2-Basic Login Enumeration.md>)
  - [3-Introduction to IDOR](<04_WEB_SECURITY/1-Access Control & Authentication/3-Introduction to IDOR.md>)
- **2-Client Side Attacks › 1-XSS**
  - [1-XSS Payloads](<04_WEB_SECURITY/2-Client Side Attacks/1-XSS/1-XSS Payloads.md>)
  - [2-XSS Types](<04_WEB_SECURITY/2-Client Side Attacks/1-XSS/2-XSS Types.md>)
- **3-Server Side Attacks**
  - [File Upload Attack Methodology](<04_WEB_SECURITY/3-Server Side Attacks/File Upload Attack Methodology.md>)
- **3-Server Side Attacks › 3.1-File Inclusion**
  - [1-Critical System Folders](<04_WEB_SECURITY/3-Server Side Attacks/3.1-File Inclusion/1-Critical System Folders.md>)
  - [2-Local File Inclusion Basics](<04_WEB_SECURITY/3-Server Side Attacks/3.1-File Inclusion/2-Local File Inclusion Basics.md>)
- **3-Server Side Attacks › 3.2-SSRF**
  - [1-Intro to SSRF](<04_WEB_SECURITY/3-Server Side Attacks/3.2-SSRF/1-Intro to SSRF.md>)
- **3-Server Side Attacks › 3.3-SQL Injection**
  - [1-SQL Injection Türleri ve Farkları](<04_WEB_SECURITY/3-Server Side Attacks/3.3-SQL Injection/1-SQL Injection Türleri ve Farkları.md>)
  - [2-Taktikler](<04_WEB_SECURITY/3-Server Side Attacks/3.3-SQL Injection/2-Taktikler.md>)
- **3-Server Side Attacks › 3.4-Cryptography Flaws**
  - [0-Encoding vs Hashing vs Encryption](<04_WEB_SECURITY/3-Server Side Attacks/3.4-Cryptography Flaws/0-Encoding vs Hashing vs Encryption.md>)
  - [Heartbleed (CVE-2014-0160)](<04_WEB_SECURITY/3-Server Side Attacks/3.4-Cryptography Flaws/Heartbleed (CVE-2014-0160).md>)
  - [Padding Oracle](<04_WEB_SECURITY/3-Server Side Attacks/3.4-Cryptography Flaws/Padding Oracle.md>)
- **3-Server Side Attacks › 3.5-Command Injection**
  - [Command Injection Bypass](<04_WEB_SECURITY/3-Server Side Attacks/3.5-Command Injection/Command Injection Bypass.md>)
- **3-Server Side Attacks › 3.6-Security Misconfiguration**
  - [git-dumper](<04_WEB_SECURITY/3-Server Side Attacks/3.6-Security Misconfiguration/git-dumper.md>)

### 📂 05 · NETWORK SECURITY <sub>(22)</sub>

- **1-Network Fundamentals**
  - [1-Ağ Modellerine Giriş](<05_NETWORK_SECURITY/1-Network Fundamentals/1-Ağ Modellerine Giriş.md>)
  - [10-Farklı Ağlar Arası Ping ve ARP](<05_NETWORK_SECURITY/1-Network Fundamentals/10-Farklı Ağlar Arası Ping ve ARP.md>)
  - [11-ICMP](<05_NETWORK_SECURITY/1-Network Fundamentals/11-ICMP.md>)
  - [12-TCP](<05_NETWORK_SECURITY/1-Network Fundamentals/12-TCP.md>)
  - [13-UDP](<05_NETWORK_SECURITY/1-Network Fundamentals/13-UDP.md>)
  - [14-Common Network Protocols and Ports](<05_NETWORK_SECURITY/1-Network Fundamentals/14-Common Network Protocols and Ports.md>)
  - [15-Domain Name System (DNS)](<05_NETWORK_SECURITY/1-Network Fundamentals/15-Domain Name System (DNS).md>)
  - [2-İletişim Modları ve Türleri](<05_NETWORK_SECURITY/1-Network Fundamentals/2-İletişim Modları ve Türleri.md>)
  - [3-OSI Modeli](<05_NETWORK_SECURITY/1-Network Fundamentals/3-OSI Modeli.md>)
  - [4-TCP-IP Modeli](<05_NETWORK_SECURITY/1-Network Fundamentals/4-TCP-IP Modeli.md>)
  - [6-IP](<05_NETWORK_SECURITY/1-Network Fundamentals/6-IP.md>)
  - [7-Subnet Mask ve Ağ Adresi](<05_NETWORK_SECURITY/1-Network Fundamentals/7-Subnet Mask ve Ağ Adresi.md>)
  - [8-CIDR Gösterimi](<05_NETWORK_SECURITY/1-Network Fundamentals/8-CIDR Gösterimi.md>)
  - [9-ARP](<05_NETWORK_SECURITY/1-Network Fundamentals/9-ARP.md>)
- **1-Network Fundamentals › 5-Physical Layer & Cabling**
  - [1-Çift Bükümlü Kablo](<05_NETWORK_SECURITY/1-Network Fundamentals/5-Physical Layer & Cabling/1-Çift Bükümlü Kablo.md>)
  - [2-Koaksiyel Kablo](<05_NETWORK_SECURITY/1-Network Fundamentals/5-Physical Layer & Cabling/2-Koaksiyel Kablo.md>)
  - [3-Fiber Optik Kablo](<05_NETWORK_SECURITY/1-Network Fundamentals/5-Physical Layer & Cabling/3-Fiber Optik Kablo.md>)
- **2-Trafik Analizi**
  - [1-tcpdump](<05_NETWORK_SECURITY/2-Trafik Analizi/1-tcpdump.md>)
  - [2-Wireshark - Filtre Sözdizimi](<05_NETWORK_SECURITY/2-Trafik Analizi/2-Wireshark - Filtre Sözdizimi.md>)
  - [3-Wireshark - İstatistikler](<05_NETWORK_SECURITY/2-Trafik Analizi/3-Wireshark - İstatistikler.md>)
  - [4-Wireshark - Analiz](<05_NETWORK_SECURITY/2-Trafik Analizi/4-Wireshark - Analiz.md>)
- **Password Attacks**
  - [Hydra](<05_NETWORK_SECURITY/Password Attacks/Hydra.md>)

### 📂 06 · EXPLOITATION & SHELLS <sub>(3)</sub>

- [1-Shell Mimarisi](<06_EXPLOITATION_&_SHELLS/1-Shell Mimarisi.md>)
- [2-PyYAML Deserialization RCE](<06_EXPLOITATION_&_SHELLS/2-PyYAML Deserialization RCE.md>)
- [3-Web RCE & Payload Hassasiyetleri](<06_EXPLOITATION_&_SHELLS/3-Web RCE & Payload Hassasiyetleri.md>)

### 📂 07 · PRIVILEGE ESCALATION <sub>(1)</sub>

- [1-Linux Sudo -l Zafiyetleri](<07_PRIVILEGE_ESCALATION/1-Linux Sudo -l Zafiyetleri.md>)

### 📂 08 · POST EXPLOITATION <sub>(1)</sub>

- [1-Arazidekiyle Yaşamak (Living off the Land)](<08_POST_EXPLOITATION/1-Arazidekiyle Yaşamak (Living off the Land).md>)

### 📂 09 · SOC <sub>(13)</sub>

- **1-Defence Frameworks**
  - [1-Pyramid of Pain](<09_SOC/1-Defence Frameworks/1-Pyramid of Pain.md>)
  - [2-Cyber & Unified Kill Chain](<09_SOC/1-Defence Frameworks/2-Cyber & Unified Kill Chain.md>)
  - [3-UKC & MITRE ATT&CK](<09_SOC/1-Defence Frameworks/3-UKC & MITRE ATT&CK.md>)
  - [4-Cyber Kill Chain vs MITRE ATT&CK](<09_SOC/1-Defence Frameworks/4-Cyber Kill Chain vs MITRE ATT&CK.md>)
- **1-Defence Frameworks › 2.1-Cyber Kill Chain**
  - [0-Cyber Kill Chain](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/0-Cyber Kill Chain.md>)
  - [1-Recon](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/1-Recon.md>)
  - [2-Weaponization](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/2-Weaponization.md>)
  - [3-Delivery](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/3-Delivery.md>)
  - [4-Exploitation](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/4-Exploitation.md>)
  - [5-Installation](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/5-Installation.md>)
  - [6-Command and Control](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/6-Command and Control.md>)
  - [7-Actions on Objectives](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/7-Actions on Objectives.md>)
  - [8-Savunma ve Tespit Mekanizmaları](<09_SOC/1-Defence Frameworks/2.1-Cyber Kill Chain/8-Savunma ve Tespit Mekanizmaları.md>)

<!-- INDEX:END -->

---

<sub>Bu dizin `sync.sh` tarafından her senkronda otomatik güncellenir.</sub>
