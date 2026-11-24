# Filtreler

> [!summary] Özet
> Filtreler, standart girdiyi alıp işleyen ve standart çıktı üreten programlardır. Pipe (`|`) ile zincirlenerek basit komutlardan karmaşık işler çıkar. Bu not: yönlendirme (redirection) + temel metin işleme araçları.

## Pipe (`|`) ve Yönlendirme

Bir komutun çıktısı (`|`) başka bir komutun girdisi olur — üretim bandı gibi: `cat dosya | grep "aranan" | sort`.

Her programın 3 kapısı vardır: **STDIN (0)** klavye, **STDOUT (1)** ekran, **STDERR (2)** hata. Bunlar dosyalara yönlendirilebilir:

| Operatör | Açıklama |
|---|---|
| `>` | Çıktıyı dosyaya yazar (**üzerine yazar**) |
| `>>` | Çıktıyı dosyanın **sonuna ekler** |
| `2>` | Sadece hataları dosyaya yazar |
| `<` | Dosyayı komuta girdi olarak verir |
| `\|` | Çıktıyı sonraki komuta aktarır (pipe) |

> [!tip] Hataları gizleme
> `find / -name x 2> /dev/null` → "Permission denied" hatalarını kara deliğe (`/dev/null`) atar, ekranda sadece sonuç kalır.

## Görüntüleme

| Araç | Ne yapar |
|---|---|
| `cat dosya` | Dosya(ları) içeriğini ekrana basar |
| `head -n 3 dosya` | İlk 3 satır (varsayılan 10) |
| `tail -n 3 dosya` | Son 3 satır (varsayılan 10) |
| `tail -f dosya` | Dosyayı **canlı izler** (log takibi); çıkış Ctrl+C |

## Sıralama ve Sayma

- **`sort`**: Satırları alfabetik sıralar.
- **`uniq`**: **Ardışık** tekrarları teker. Bu yüzden genelde `sort | uniq` birlikte kullanılır. `-c` tekrar sayısını yazar.

```bash
sort isimler.txt | uniq -c      # her satırdan kaç tane var
```

- **`wc dosya`**: satır, kelime, karakter sayısı (`wc -l` sadece satır).

## Metin Ayıklama

- **`grep "desen" dosya`**: Deseni içeren satırları süzer. `-i` harf duyarsız, `-v` eşleşmeyenler, `-r` özyineli.
- **`cut -d ":" -f 1 dosya`**: Satırları ayırıcıya (`-d`) göre böler, istenen sütunu (`-f`) alır.

```bash
cut -d ":" -f 1 /etc/passwd      # sadece kullanıcı adları
```

- **`awk '{print $1}' dosya`**: Satırları alanlara (sütun) böler, istenenleri işler. Sütun bazlı veri için güçlüdür.

```bash
ps aux | awk '{print $1, $11}'   # kullanıcı + komut sütunları
```

- **`sed 's/eski/yeni/' dosya`**: Akış düzenleyici; değiştirir/siler/ekler. Varsayılan olarak ekrana basar, dosyayı **kalıcı** değiştirmek için `-i`.

```bash
sed 's/Alice/George/' names.txt  # Alice -> George (ekranda)
```

## Diğer

| Araç | Ne yapar |
|---|---|
| `tee dosya` | Çıktıyı **hem ekrana hem dosyaya** yazar (`... \| tee log.txt`) |
| `diff d1 d2` | İki dosyanın farkını gösterir (`<` eski, `>` yeni) |
| `tr "a-z" "A-Z"` | Karakter çevirir (ör. küçük→büyük harf) |

## İlgili Notlar

- [[5-Linux'ta Dosya ve Dizinleri Bulma Yöntemleri]]: `find` / `locate` / `grep`
- [[5-Directory Enumeration]], [[Discovery with Curl]]: bu araçların keşifte kullanımı
