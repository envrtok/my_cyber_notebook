# Kullanıcı Yönetimi

> [!summary] Özet
> Linux çok kullanıcılı bir sistemdir: her kullanıcının adı, benzersiz **UID**'si, ev dizini ve sınırlı yetkisi vardır (yalnızca `root`/UID 0 her şeyi yapar). Bu not: kullanıcı oluşturma, bilgi görme, değiştirme ve silme + kritik dosyalar.

İki tür kullanıcı vardır: **sistem kullanıcıları** (servisleri çalıştırır, kurulumda oluşur) ve **normal kullanıcılar** (yönetici tarafından açılır).

## Oluşturma

| Komut | Not |
|---|---|
| `sudo adduser mehmet` | **Önerilen.** Soru sorar, ev dizinini ve parolayı otomatik ayarlar |
| `sudo useradd -m -s /bin/bash ali` | Düşük seviye. `-m`: ev dizini oluştur, `-s`: shell belirle |

## Bilgi Görme

| Komut | Gösterir |
|---|---|
| `id mehmet` | UID, GID, üye olunan gruplar |
| `who` | O an bağlı kullanıcılar |
| `w` | Bağlı kullanıcılar + ne yaptıkları |
| `last` | Geçmiş giriş kayıtları |

## Kritik Dosyalar

**`/etc/passwd`** — tüm kullanıcıların temel bilgisi, herkes okuyabilir. `:` ile 7 alan:

```
mehmet:x:1001:1001:Mehmet Yilmaz,,,:/home/mehmet:/bin/bash
```

| # | Alan | Açıklama |
|---|---|---|
| 1 | Kullanıcı adı | Giriş adı |
| 2 | Parola | `x` → asıl hash `/etc/shadow`'da |
| 3 | UID | Kullanıcı no (root = 0) |
| 4 | GID | Birincil grup no |
| 5 | GECOS | Tam ad, ek bilgi |
| 6 | Ev dizini | Girişte düşülen dizin |
| 7 | Shell | Komut yorumlayıcısı |

**`/etc/shadow`** — parola hash'leri ve geçerlilik süreleri; **sadece root okur**. Hash `$6$` ile başlarsa SHA-512; `!` veya `*` → hesap kilitli.

**`/etc/skel`** — yeni kullanıcı açılınca ev dizinine kopyalanan şablon dosyalar (ör. `.bashrc`).

## Değiştirme (`usermod`)

```bash
sudo usermod -aG sudo mehmet    # 'sudo' grubuna ekle (yönetici yap)
sudo usermod -L mehmet          # hesabı kilitle (giriş yapamaz)
sudo usermod -U mehmet          # kilidi aç
```

> [!warning] `-a` şart
> Gruba eklerken `-aG` kullan. Sadece `-G` dersen kullanıcının **diğer tüm gruplarını siler**.

## Parola Süresi (`chage`)

```bash
sudo chage -l mehmet       # mevcut ayarları listele
sudo chage -M 90 mehmet    # parola 90 günde bir değişsin
```

## Silme

```bash
sudo userdel -r mehmet     # -r: ev dizinini ve dosyaları da sil
```

## İlgili Notlar

- [[9-Grup Yönetimi]]: kullanıcıları gruplara atama
- [[7-İzinler]]: sahiplik ve erişim yetkileri
