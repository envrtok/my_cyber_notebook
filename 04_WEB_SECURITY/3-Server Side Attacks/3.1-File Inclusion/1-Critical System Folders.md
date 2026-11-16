> [!summary] Overview
> High-value files to target once you have a **file read** primitive such as [[2-Local File Inclusion Basics|LFI]], path traversal, or SSRF. These files reveal users, credentials, keys, kernel/OS details, and web server logs — useful both for information gathering and for escalating to RCE (e.g. log poisoning).

## Linux

| Location | Description |
|---|---|
| `/etc/passwd` | All registered users with access to the system (usernames, UIDs, shells) |
| `/etc/shadow` | Hashed user passwords (only readable as root — a successful read is a big win) |
| `/etc/issue` | Message / system identification printed before the login prompt |
| `/etc/profile` | System-wide default variables (exports, `umask`, terminal types, mail notice) |
| `/etc/hosts` | Static hostname-to-IP mappings; can reveal internal hosts |
| `/proc/version` | Linux kernel version (useful for finding a matching kernel exploit) |
| `/proc/self/environ` | Current process' environment variables (can enable LFI → RCE via injection) |
| `/root/.bash_history` | Command history for the `root` user (may contain passwords typed inline) |
| `/root/.ssh/id_rsa` | Private SSH key for `root` or any valid user → direct login |
| `/var/log/dmesg` | Kernel ring buffer messages, including boot-time hardware logs |
| `/var/mail/root` | All email for the `root` user |
| `/var/log/auth.log` | Authentication logs (Debian/Ubuntu); shows SSH/login activity |
| `/var/log/apache2/access.log` | Apache request log — target for **log poisoning** to turn LFI into RCE |

## Windows

| Location | Description |
|---|---|
| `C:\boot.ini` | Boot options on older BIOS/NTLDR-based Windows (pre-Vista) |
| `C:\Windows\System32\drivers\etc\hosts` | Static hostname-to-IP mappings |
| `C:\Windows\win.ini` | Legacy initialization file; handy existence check for traversal |
| `C:\inetpub\logs\LogFiles\` | IIS web server logs |

> [!tip] Log poisoning ile LFI → RCE
> Erişilebilen bir log dosyasına (ör. `access.log`), `User-Agent` başlığı üzerinden PHP kodu enjekte edip ardından o logu LFI ile dahil etmek, dosya okumayı **kod çalıştırmaya** dönüştürebilir.

## İlgili Notlar

- [[2-Local File Inclusion Basics|Local File Inclusion Basics]]: bu dosyalara ulaşmak için kullanılan teknikler
- [[1-Intro to SSRF|SSRF]]: sunucuyu dosya/kaynak okumaya zorlamanın bir diğer yolu
