# Vim

> [!summary] Özet
> Vim modal bir editördür: **Normal** modda komut verilir, **Insert** modda yazı yazılır. `ESC` her zaman Normal moda döndürür. Açılışta Normal moddadır.

## Modlar

- **Normal** (varsayılan): Gezinme, silme, kopyalama. `ESC` ile buraya dönülür.
- **Insert** (`i`): Yazı yazma. Sol altta `-- INSERT --` görünür.
- **Visual** (`v`): Metin/blok seçme.

## Kısayollar

| Tuş | Eylem |
|---|---|
| `i` | Insert moduna geç |
| `ESC` | Normal moda dön |
| `:w` | Kaydet |
| `:q` | Çık |
| `:wq` | Kaydet ve çık |
| `:q!` | Kaydetmeden zorla çık |
| `dd` | Satırı sil (kes) |
| `yy` | Satırı kopyala |
| `p` | Yapıştır |
| `u` | Geri al (undo) |
| `/kelime` | Ara (`n` ile sonraki eşleşme) |
