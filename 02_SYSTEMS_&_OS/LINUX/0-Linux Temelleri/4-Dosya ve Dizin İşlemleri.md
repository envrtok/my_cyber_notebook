# Dosya ve Dizin İşlemleri

> [!summary] Özet
> Dosya/dizin oluşturma, kopyalama, taşıma, silme ve bağlantılar (link). Temel kavram: dosya adı yalnızca bir etikettir, asıl üstbilgi **inode**'da tutulur.

## Inode Nedir?

"Her şey bir dosyadır." Bir dosya oluşunca diskte iki şey olur:
- **Veri:** İçindeki gerçek bilgi.
- **Inode:** Sahip, boyut, izinler, disk adresi gibi üstbilgiyi tutan kayıt.

Dosya ismi, bu inode'u işaret eden bir etikettir. Inode numarasını görmek: `ls -i`.

## Oluşturma

| Komut | Ne yapar |
|---|---|
| `touch dosya.txt` | Boş dosya oluşturur; varsa tarihini günceller |
| `touch dosya{1..3}.txt` | Süslü parantezle toplu oluşturur (`dosya1..3.txt`) |
| `mkdir dizin` | Dizin oluşturur |
| `mkdir -p a/b/c` | İç içe tüm yolu oluşturur (`a`, `b` yoksa da hata vermez) |

## Kopyalama (`cp`)

| Komut | Açıklama |
|---|---|
| `cp dosya.txt yedek.txt` | Dosyayı kopyalar |
| `cp -r dizin/ hedef/` | Dizini **içeriğiyle** kopyalar (recursive) |
| `cp -i dosya hedef/` | Üzerine yazmadan önce sorar (interactive) |
| `cp --backup dosya hedef/` | Hedefteki eskiyi `dosya~` olarak yedekler |

## Taşıma / Yeniden Adlandırma (`mv`)

Ayrı bir "rename" komutu yoktur; ikisini de `mv` yapar.
- İsim değiştirme: `mv eski.txt yeni.txt`
- Taşıma: `mv dosya.txt /tmp/`

## Silme (`rm`)

> [!warning] Geri dönüşüm kutusu yoktur
> Silinen dosya gider. `rm -rf` sormadan ve zorla siler — en tehlikeli komuttur.

| Komut | Açıklama |
|---|---|
| `rm dosya` | Dosyayı siler |
| `rm -i dosya` | Silmeden önce sorar (güvenli) |
| `rm -r dizin/` | Dizini içeriğiyle siler |
| `rm -rf dizin/` | Zorla, sormadan siler (dikkat!) |
| `rmdir dizin/` | Sadece **boş** dizini siler (en güvenli) |

## Dosya Bilgisi

- **`file dosya`**: İçeriğine bakarak gerçek türünü söyler (uzantıdan bağımsız) → `ELF 64-bit...`, `ASCII text`.
- **`stat dosya`**: Inode, boyut ve zaman damgalarını (Access/Modify/Change) ayrıntılı gösterir.

## Bağlantılar (Links)

| | Hard Link (`ln`) | Soft/Sembolik Link (`ln -s`) |
|---|---|---|
| Ne gösterir | Aynı inode'u (veriyi) | Orijinalin **yolunu** (kısayol) |
| Orijinal silinirse | Veri durur, erişilebilir | Link **kırılır** |
| Disk bölümü | Sadece aynı bölümde | Farklı diskler arası çalışır |
| Inode no | Orijinalle **aynı** | Orijinalden **farklı** |

```bash
ln notlar.txt sert_link.txt     # hard: ls -li ile aynı inode no görünür
ln -s /var/www/html kisayol     # soft: kisayol -> /var/www/html
```

## Düşük Seviye Kopyalama (`dd`)

Disk imajı almak/yazmak için (ör. ISO'yu USB'ye):

```bash
sudo dd if=linux.iso of=/dev/sdb bs=4M status=progress
```

`if`: kaynak · `of`: hedef · `bs`: blok boyutu (hız) · `status=progress`: ilerleme. Yanlış `of` tüm diski siler, dikkatli ol.

## İlgili Notlar

- [[5-Linux'ta Dosya ve Dizinleri Bulma Yöntemleri]]: `find`, `locate`, `which`
- [[7-İzinler]]: dosya izinleri ve sahiplik
