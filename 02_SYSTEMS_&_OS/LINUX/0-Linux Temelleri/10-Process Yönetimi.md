# Process Yönetimi

> [!summary] Özet
> Çalışan her program bir **process**'tir ve benzersiz bir **PID**'si, sahibi ve ebeveyni vardır. Bu not: ön plan/arka plan işleri, listeleme (`ps`, `top`), sonlandırma (`kill` + sinyaller), öncelik (`nice`) ve servisler (`systemctl`).

- **PID:** Process'in benzersiz kimlik numarası.
- **Sahip (User):** Process'i başlatan kullanıcı.
- **Ebeveyn (Parent):** Onu başlatan process (terminalden Firefox açarsan terminal "baba", Firefox "çocuk").

## Ön Plan / Arka Plan

- **Ön plan (foreground):** Varsayılan. Bitene kadar terminali kilitler.
- **Arka plan (background):** Komut sonuna `&` → terminal serbest kalır.

```bash
ping 127.0.0.1 &     # [1] 54017  → [1] iş no, 54017 PID
jobs                 # arka plan işlerini listele
fg %1                # 1 numaralı işi ön plana al
```

Ön planda: `Ctrl+C` durdurur, `Ctrl+Z` duraklatıp arka plana atar.

## Listeleme (`ps`, `top`)

- **`ps aux`**: Tüm process'lerin anlık fotoğrafı.
- **`top`** (veya `htop`): Canlı izleme (çıkış `q`).

`ps aux` sütunları: **USER** (sahip) · **PID** · **%CPU** · **%MEM** · **STAT** (R çalışıyor, S uyuyor, Z zombi) · **START** · **COMMAND**.

```bash
ps aux | grep python      # belirli process'i bul
```

## Sonlandırma (`kill`)

Process'e **sinyal** gönderir; PID gerekir (`kill` varsayılan 15 gönderir).

| No | Ad | Anlamı |
|---|---|---|
| 15 | **SIGTERM** | Nazikçe kapan (varsayılan); kaydetmeye izin verir |
| 9 | **SIGKILL** | Derhal öl; kaydetmez, zorla kapatır |
| 1 | **SIGHUP** | Yeniden başla / config'i tekrar oku |
| 2 | **SIGINT** | Kesme (`Ctrl+C`) |
| 19 | **SIGSTOP** | Duraklat (`Ctrl+Z`) |
| 18 | **SIGCONT** | Duraklatılmışı devam ettir |

```bash
kill 5432          # SIGTERM
kill -9 5432       # SIGKILL (kapanmıyorsa)
pkill python       # isme göre
killall firefox    # isme göre (tümü)
```

## Öncelik (`nice`, `renice`)

Öncelik -20 (en yüksek) ile 19 (en düşük) arası; varsayılan 0.

```bash
nice -n 10 tar -czf yedek.tar.gz /home    # düşük öncelikle başlat
renice -n -5 -p 5432                        # çalışan process'in önceliğini değiştir
```

## Servisler (`systemctl`)

Modern Linux'ta arka plan servislerini **systemd** yönetir:

```bash
systemctl status nginx     # durum
sudo systemctl start nginx # başlat (stop: durdur)
sudo systemctl enable nginx # açılışta otomatik başlat
```

## İlgili Notlar

- [[systemctl & crontab]]: servisler ve zamanlanmış görevler ayrıntısı
- [[7-İzinler]]: SUID ve process'in hangi yetkiyle çalıştığı
