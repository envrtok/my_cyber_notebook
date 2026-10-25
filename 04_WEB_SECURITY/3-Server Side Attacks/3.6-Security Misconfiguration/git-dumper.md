**Tanım:** Açıkta bırakılmış bir `.git` dizinini, sunucuda dizin listeleme (directory listing) kapalı olsa bile internet üzerinden indirmeyi sağlayan bir araçtır.

**Sonuç / Temel İşlev:** Kaynak kod ifşası (Source Code Disclosure) zafiyetini sömürerek uygulamanın kaynak kodunun ve commit geçmişinin elde edilmesini sağlar.

## Kullanım

```bash
# Temel Kullanım
git-dumper http://hedef-site.com/.git/ /yerel/hedef/klasor/
```

İndirme işlemi bittikten sonra hedeflenen klasöre gidip `git status` veya `git log` komutlarıyla depo incelenebilir. Kodların güncel halini görmek için `git checkout -- .` kullanılabilir.

## Kurulum

```bash
pip install git-dumper
```

## Çalışma Mantığı (Neden ve Nasıl Çalışır?)

Sunucuda dizin listeleme kapalı olduğunda, `.git` klasörünün içeriği standart bir web tarayıcısı ile doğrudan görülemez. `git-dumper` bu engeli şu mantıkla aşar:

1. **Bilinen Dosyaları Çekme:** Önce isimleri standart ve bilinen dosyaları (`.git/HEAD`, `.git/config`, `.git/index` vb.) indirir.
    
2. **Referansları Çözümleme:** İndirdiği bu temel dosyalardan, özellikle `.git/index` (stating area) dosyasından projedeki dosyaların hash (SHA-1) değerlerini okur.
    
3. **Objeleri İndirme:** Elde ettiği hash değerlerini kullanarak eksik olan Git objelerini (`.git/objects/` altındaki blob, tree ve commit nesneleri) brute-force veya doğrudan tahmin yoluyla tek tek web üzerinden indirir.
    
4. **Yeniden İnşa:** Tüm objeler indirildiğinde yerel diskte tam fonksiyonel bir Git deposu oluşturur.
    

## Savunma (Önlem)

Bu zafiyetin sebebi uygulamanın dağıtımı (deployment) sırasında `.git` klasörünün canlı sunucuda bırakılmasıdır. Çözüm, web sunucusu (Nginx, Apache vb.) yapılandırmasında bu dizine erişimi tamamen engellemektir.

**Nginx Örneği:**

Nginx

```
location ~ /\.git { 
    deny all; 
}
```

**Apache Örneği:**

Apache

```
RedirectMatch 404 /\.git
```