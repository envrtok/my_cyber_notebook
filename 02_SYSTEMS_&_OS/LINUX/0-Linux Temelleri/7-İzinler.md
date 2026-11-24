# İzinler

> [!summary] Özet
> Linux çok kullanıcılı olduğu için her dosyanın sahibi ve erişim kuralları vardır. İzinler **r/w/x** olarak üç kitleye (**sahip/grup/diğer**) verilir; sembolik (`rwx`) veya sayısal (oktal) gösterilir ve `chmod` ile değiştirilir.

İzinler gizlilik, bütünlük ve güvenlik sağlar: yetkisiz kullanıcının dosya okumasını, değiştirmesini veya zararlının yayılmasını engeller.

## İzin Dizisini Okuma

```
-rwxr-xr-- 1 mehmet yazilim 450 Aug 01 14:00 script.sh
```

İlk karakter **tür** (`-` dosya, `d` dizin), kalan 9 karakter üçerli üç kitledir:

```
rwx       r-x      r--
sahip(u)  grup(g)  diğer(o)
```

| İzin | Dosyada | Dizinde |
|---|---|---|
| **r** (read=4) | İçeriği okuma | İçindekileri listeleme (`ls`) |
| **w** (write=2) | İçeriği değiştirme | İçine dosya ekleme/silme |
| **x** (execute=1) | Çalıştırma (script/program) | İçine girme (`cd`) |
| **-** | İzin yok | İzin yok |

Örnek `-rwxr-xr--`: sahip tam yetki (`rwx`), grup okur+çalıştırır (`r-x`), diğerleri sadece okur (`r--`).

## Oktal (Sayısal) Gösterim

Her kitle için izinler toplanır: **r=4, w=2, x=1**.

| Sembolik | Oktal | Anlam |
|---|---|---|
| `rwx` | 7 | Tam yetki |
| `rw-` | 6 | Oku/yaz |
| `r-x` | 5 | Oku/çalıştır |
| `r--` | 4 | Sadece oku |

Örnek: `rwxr-xr--` → **754**.

## İzin Değiştirme (`chmod`)

**Sayısal:**
```bash
chmod 755 script.sh     # rwxr-xr-x (çalıştırılabilir script)
chmod 600 ozel.txt      # rw------- (sadece sahip)
chmod 777 dosya         # rwxrwxrwx (herkese açık — güvensiz)
```

**Sembolik:** `u/g/o/a` + `+/-/=` + `rwx`
```bash
chmod o+w notes.txt      # diğerlerine yazma ekle
chmod ugo+rwx notes.txt  # herkese tam yetki
```

## Özel İzinler

| Ad | Oktal | Nerede | Ne yapar | Örnek |
|---|---|---|---|---|
| **SUID** | 4000 | Dosya | Çalıştıran, **dosya sahibinin** yetkisiyle çalıştırır | `passwd` |
| **SGID** | 2000 | Dizin | İçinde oluşan dosyalar dizinin **grubunu** alır | Ortak projeler |
| **Sticky** | 1000 | Dizin | Dosyayı **sadece sahibi** silebilir | `/tmp` |

```bash
chmod 4755 dosya    # -rwsr-xr-x : x yerine 's' = SUID
chmod 1777 /tmp     # drwxrwxrwt : sonda 't' = Sticky
```

> [!warning] Güvenlik: SUID
> Root'a ait SUID binary'ler yetki yükseltmenin klasik yoludur. Beklenmedik SUID dosyaları bir risktir. Bkz. [[1-Linux Sudo -l Zafiyetleri]].

## Umask

Yeni dosya/dizinlerin varsayılan izinlerinden düşülür (standart `022`):
- Dosya: `666 - 022 = 644` (`rw-r--r--`)
- Dizin: `777 - 022 = 755` (`rwxr-xr-x`)

Görüntüleme: `umask` → `0022`.

## Dosya Öznitelikleri (`chattr`)

İzinlerden güçlü koruma. `chattr +i` ile dosya **değiştirilemez (immutable)** olur — root bile silemez:

```bash
sudo chattr +i kritik.conf      # kilitle (lsattr ile görüntüle)
sudo chattr -i kritik.conf      # kilidi aç
```

## İlgili Notlar

- [[8-Kullanıcı Yönetimi]] · [[9-Grup Yönetimi]]: sahiplik ve grup atama
- [[1-Linux Sudo -l Zafiyetleri]]: SUID/sudo ile yetki yükseltme
