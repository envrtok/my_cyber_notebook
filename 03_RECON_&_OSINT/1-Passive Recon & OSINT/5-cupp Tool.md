**CUPP**, hedef kişi hakkında toplanan bilgilere (isim, soyisim, doğum tarihi, evcil hayvan adı vb.) dayanarak kişiselleştirilmiş ve hedef odaklı şifre listeleri (wordlist) oluşturan etkili bir sosyal mühendislik ve sızma testi aracıdır.

## Temel Komutlar

* **İnteraktif Mod (Profil Oluşturma):**
    Hedef hakkında sorular sorarak adım adım kişiselleştirilmiş kelime listesi oluşturur. En sık kullanılan moddur.
    ```bash
    cupp -i
    ```
    *Not: Karşınıza çıkan isim, doğum tarihi, eş/çocuk adı gibi sorularda bilmediğiniz alanları `Enter` tuşuna basarak boş geçebilirsiniz.*

* **Mevcut Listeyi Geliştirme:**
    Elinizdeki hazır bir şifre listesini CUPP kuralları ve permütasyonlarıyla zenginleştirmek için kullanılır:
    ```bash
    cupp -w mevcut_liste.txt
    ```

* **Hazır Büyük Listeleri İndirme:**
    Uzak sunucudan büyük kelime listelerini indirmek için:
    ```bash
    cupp -l
    ```

* **Yardım Menüsü:**
    Tüm parametreleri ve açıklamalarını görmek için:
    ```bash
    cupp -h
    ```

## Önemli İpuçları
- İnteraktif modun sonunda size sorulan özel karakter ekleme (`special chars`), rastgele sayı ekleme (`random numbers`) ve **Leet mode** (harfleri sayılarla değiştirme, örn: e yerine 3, a yerine 4) seçeneklerine **Y (Yes)** diyerek listenizin başarı oranını artırabilirsiniz.