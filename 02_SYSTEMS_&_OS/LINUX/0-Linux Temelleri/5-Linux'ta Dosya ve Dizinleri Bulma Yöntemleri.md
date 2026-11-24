# Linux'ta Dosya ve Dizinleri Bulma Yöntemleri

> [!summary] Özet
> Dosya/dizin bulma: `find` (kriter bazlı, canlı tarama), `locate` (hızlı, veritabanından), `which` (komutun yolu); dosya **içinde** metin aramak için `grep`.

## `find` — Kriter Bazlı Arama

Genel kullanım: `find [NEREDE] [KRİTER] [EYLEM]`. Diski canlı tarar, güçlü ama yavaştır.

| Kriter | Örnek | Bulur |
|---|---|---|
| `-name` / `-iname` | `find / -name "notlar.txt"` | İsme göre (`-iname` harf duyarsız) |
| `-type` | `find /home -type d` | Tür: `d` dizin, `f` dosya |
| `-size` | `find / -size +100M` | 100 MB'tan büyük (`+1G` vb.) |
| `-user` | `find /var -user www-data` | Sahibine göre |

```bash
find . -name "*.txt"                 # alt dizinler dahil tüm .txt
find /etc -type d -name "ssh"         # sadece "ssh" adlı dizin
```

**Mantıksal operatörler:** `-a` (VE, varsayılan), `-o` (VEYA), `-not` (DEĞİL).

```bash
find . -name "*.jpg" -o -name "*.png"   # jpg veya png
find . -not -user root                  # sahibi root olmayanlar
```

**Bulunana komut uygula:** `-exec` veya `xargs` (çok dosyada daha hızlı).

```bash
find . -name "*.tmp" -exec rm {} \;     # {}: bulunan dosya, \;: komut sonu
find . -name "*.log" | xargs rm
```

## `locate` — Hızlı Arama

`updatedb` ile oluşturulan veritabanından arar; `find`'dan çok hızlıdır ama **veritabanı eskiyse çok yeni dosyaları bulamaz**. Elle güncelleme: `sudo updatedb`.

```bash
locate notlar.txt
```

## `which` — Komutun Yolu

Bir komutun hangi yoldan çalıştığını gösterir (birden çok sürüm varsa hangisinin kullanıldığını anlamak için).

```bash
which python      # /usr/bin/python
```

## `grep` — Dosya İÇİNDE Arama

Dosya adını değil, **içindeki metni** arar.

```bash
grep "Error" server.log
grep -r -i "error" /var/log/     # -r: özyineli, -i: harf duyarsız
```

Temel regex: `^` satır başı · `$` satır sonu · `.` herhangi bir karakter · `*` öncekinin tekrarı. Ayrıntı ve diğer filtreler için bkz. [[6-Filtreler]].

## İlgili Notlar

- [[6-Filtreler]]: `grep`, `cut`, `awk`, `sed` ve pipe mantığı
- [[1-Critical System Folders]]: saldırı/analizde aranan kritik dosyalar
