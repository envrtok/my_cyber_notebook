# Dizinlerde Gezinti

> [!summary] Özet
> Terminalde dosya sisteminde dolaşmanın temelleri: yol (path) kavramı, `pwd` / `cd` / `ls` ve yardımcı araçlar (`tree`, `pushd`/`popd`).

## Dizin ve Yol (Path)

Linux'ta her şey tek bir **kök dizinden (`/`)** başlayan ağaçta düzenlenir (Windows'taki `C:\` gibi ama tek kök).

- **Mutlak Yol (Absolute):** Kökten (`/`) başlar → `/home/mehmet/resimler/tatil.jpg`
- **Göreceli Yol (Relative):** Bulunduğun yerden başlar → `resimler/tatil.jpg`

## `pwd` — Neredeyim?

Bulunulan dizini (Print Working Directory) yazar. İlgili yardımcılar:

| Komut | Ne verir |
|---|---|
| `pwd` | Mevcut dizinin tam yolu |
| `realpath dosya` | Dosyanın mutlak yolu |
| `basename /yol/dosya.txt` | Sadece dosya adı → `dosya.txt` |
| `dirname /yol/dosya.txt` | Sadece dizin kısmı → `/yol` |

## `cd` — Dizin Değiştir

| Komut | Etki |
|---|---|
| `cd /tam/yol` | Mutlak yola gider |
| `cd dizin` | Alt dizine girer |
| `cd ..` | Bir üst dizine çıkar |
| `cd ~` | Ev dizinine döner (nerede olursan ol) |
| `cd -` | Bir önceki bulunulan dizine döner |

## `ls` — Listele

Parametresiz az bilgi verir; bayraklarla kullanılır (birleştirilebilir, ör. `ls -lah`).

| Bayrak | Anlamı |
|---|---|
| `-l` | Uzun liste: izin, sahip, boyut, tarih |
| `-a` | Gizli dosyalar dahil (`.` ile başlayanlar) |
| `-h` | Boyutu okunabilir göster (K, M, G) |
| `-t` | Değiştirilme tarihine göre sırala (yeni üstte) |
| `-r` | Sıralamayı ters çevir |
| `-R` | Alt dizinleri de özyineli listele |
| `-S` | Boyuta göre sırala (büyük üstte) |

**`ls -l` çıktısının sütunları:**

```
-rwxr-xr-x 1 user users 500 Aug 01 11:00 script.sh
```

| Alan | Anlamı |
|---|---|
| `-rwxr-xr-x` | Tür + izinler (`d`: dizin, `-`: dosya) |
| `1` | Hard link sayısı |
| `user` | Sahip kullanıcı |
| `users` | Sahip grup |
| `500` | Boyut (byte) |
| `Aug 01 11:00` | Son değişiklik tarihi |
| `script.sh` | İsim |

`ls -la` gizli ayar dosyalarını (`.bashrc`) ve `.` (bu dizin) / `..` (üst dizin) girişlerini de gösterir. İzin ayrıntısı için bkz. [[7-İzinler]].

## Yardımcılar

- **`tree -L 2`**: Dizin yapısını ağaç olarak gösterir (`-L 2` = 2 seviye derinlik).
- **`pushd /yol` / `popd`**: Mevcut yeri hafızaya atıp başka dizine gider (`pushd`), sonra tam kaldığın yere döner (`popd`). Geçici sapmalar için pratiktir.

## İlgili Notlar

- [[4-Dosya ve Dizin İşlemleri]]: oluşturma, kopyalama, taşıma, silme
- [[3-Linux Dosya Sistemi Hiyerarşisi (FHS)]]: `/`, `/etc`, `/var` gibi dizinler ne işe yarar
