# Terminal: Komutlar, Değişkenler, Operatörler

> [!summary] Özet
> Terminalin günlük temelleri: komut geçmişi ve türü, çevre değişkenleri (`$PATH` vb.), komut zincirleme operatörleri (`;`, `&&`, `||`) ve betik başlangıcı (shebang).

## Faydalı Komutlar

| Komut | Ne yapar |
|---|---|
| `clear` | Ekranı temizler (Ctrl+L de aynı işi yapar) |
| `history` | Çalıştırılan komutları numaralı listeler; `!4` → 4. komutu tekrar çalıştırır |
| `type <komut>` | Komutun ne olduğunu söyler: alias / shell builtin / diskteki program |

```bash
$ type ls      # ls is aliased to `ls --color=auto'
$ type cd      # cd is a shell builtin
$ type grep    # grep is /usr/bin/grep
```

## Çevre Değişkenleri (Environment Variables)

İşletim sisteminin ve programların davranışını etkileyen dinamik değerler. `echo $DEGISKEN` ile değeri, `printenv` ile tümü görülür.

| Değişken | Açıklama |
|---|---|
| `$HOME` | Kullanıcının ev dizini |
| `$USER` | O anki kullanıcı adı |
| `$PWD` | Bulunulan dizin |
| `$SHELL` | Kullanılan kabuk |
| `$PATH` | Komutların arandığı dizinler (`:` ile ayrılır) |

> [!note] `$PATH` neden önemli?
> Bir komut yazınca kabuk onu `$PATH`'teki dizinlerde **sırayla** arar. Komut bu dizinlerde yoksa "command not found" alırsın.

## Komut Zincirleme

| Operatör | Davranış |
|---|---|
| `;` | İlkini bitirir, **hata verse bile** ikinciyi çalıştırır |
| `&&` | İlki **başarılıysa** ikinciyi çalıştırır (`mkdir d && cd d`) |
| `\|\|` | İlki **hata verirse** ikinciyi çalıştırır (`cd yok \|\| echo "yok"`) |

## Shebang (`#!`)

Bir metin dosyasının hangi yorumlayıcıyla çalıştırılacağını ilk satırda belirtir:

```bash
#!/bin/bash
echo "Merhaba Dünya"
```

> Sisteme "bu dosyayı `/bin/bash` ile çalıştır" der.
