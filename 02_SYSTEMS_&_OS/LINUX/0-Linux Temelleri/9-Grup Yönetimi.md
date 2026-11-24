# Grup Yönetimi

> [!summary] Özet
> Grup, aynı izinleri paylaşan kullanıcı topluluğudur. Dosya iznini tek tek kullanıcılara değil gruba vererek yetki yönetimi toplulaştırılır: yeni biri geldiğinde sadece gruba eklemek yeterlidir.

## Temel Komutlar

| Komut | Açıklama |
|---|---|
| `groupadd <grup>` | Grup oluşturur |
| `groupdel <grup>` | Grubu siler |
| `groups` | Üye olunan grupları gösterir |
| `getent group <grup>` | Grubun detayını gösterir |

## `/etc/group` Dosyası

```
yazilim:x:1002:mehmet,ali
```

| Alan | Örnek | Açıklama |
|---|---|---|
| Grup adı | `yazilim` | Grubun ismi |
| Parola | `x` | Genelde kullanılmaz |
| GID | `1002` | Grup kimlik no |
| Üyeler | `mehmet,ali` | Gruba dahil kullanıcılar |

## Üye Ekleme / Çıkarma

```bash
sudo usermod -aG yazilim mehmet      # ekle (-a şart! yoksa diğer grupları siler)
sudo gpasswd -d mehmet yazilim       # çıkar
```

`id mehmet` ile kontrol: çıktıda `groups=...,1002(yazilim)` görünmeli.

## Pratik: Ortak Proje Dizini

Sadece `proje` grubundakiler erişsin:

```bash
sudo groupadd proje
sudo usermod -aG proje ali
sudo mkdir /opt/proje
sudo chown :proje /opt/proje      # dizinin grubunu değiştir
sudo chmod 770 /opt/proje          # sahip+grup tam yetki, diğerleri giremez
```

## İlgili Notlar

- [[8-Kullanıcı Yönetimi]]: kullanıcı oluşturma ve yönetme
- [[7-İzinler]]: `chown`, `chmod` ve grup izinleri
