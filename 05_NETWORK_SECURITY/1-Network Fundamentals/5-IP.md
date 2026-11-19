> [!summary] Özet
> **IP (Internet Protocol)**, ağdaki her cihazı **mantıksal bir adresle** tanımlayan ve veri paketlerini kaynaktan hedefe **yönlendiren** ağ (internet) katmanı protokolüdür. Taşıma katmanından gelen segmenti IP başlığıyla kapsülleyip datagram'a dönüştürür. Güvenilirlik sağlamaz (o iş [[9-TCP|TCP]]'nindir); görevi adresleme ve yönlendirmedir.

![Internet Protocol (IP) kapsülleme](https://storage.hackviser.com/file/hackviser-prod/trainings/sections/images/e46b2dee-f6fa-44de-86f2-a1e0c105d4e2/ipencap-fda5fc6c1.webp)

## Temel İşlevleri

- **IP adresleme:** Her cihaza mantıksal bir adres atar; bu adres, cihazın tanımlanması ve ağlar arası yönlendirme için kullanılır.
- **Host-to-host iletişim:** Verinin izleyeceği yolu belirler.
- **Kapsülleme:** Taşıma katmanından gelen veriyi alır ve IP datagramı olarak paketler.
- **Parçalama ve yeniden birleştirme (fragmentation):** Datagram, yerel ağın **MTU** (Maximum Transmission Unit) sınırından büyükse daha küçük parçalara bölünür. Parçalama gönderici veya ara yönlendirici tarafından yapılabilir; alıcıda parçalar yeniden birleştirilir.
- **Yönlendirme:** Kaynak ve hedef aynı yerel ağdaysa **doğrudan dağıtım**, uzak ağdaysa yönlendiriciler üzerinden **dolaylı dağıtım** yapılır.

> [!tip] Atanan IP'yi görme
> `ifconfig` artık eski kabul edilir; modern Linux'ta `ip a` (veya `ip addr`) kullanılır.

![IP ile yönlendirme](https://storage.hackviser.com/file/hackviser-prod/trainings/sections/images/e46b2dee-f6fa-44de-86f2-a1e0c105d4e2/iprouting-fabbe7be8.webp)

Yönlendirme, RIP, OSPF, BGP gibi yönlendirme protokolleriyle en uygun yol seçilerek yapılır.

## IP Datagram Formatı

![IP Datagram Formatı](https://storage.hackviser.com/file/hackviser-prod/trainings/sections/images/e46b2dee-f6fa-44de-86f2-a1e0c105d4e2/ipsegment-511c069cc.webp)

| Alan | Açıklama |
|---|---|
| **Version** | IP sürümü (IPv4, IPv6) |
| **IHL** (Internet Header Length) | Başlığın gerçek uzunluğu |
| **Type of Service (TOS)** | Paketin önceliklendirilmesi (gecikme, bant genişliği, güvenilirlik). Bugün DSCP ve ECN alanları için kullanılır |
| **Total Length** | Datagramın bayt cinsinden toplam uzunluğu |
| **Identification** | Aynı datagrama ait **tüm parçalarda aynı** olan 16 bitlik değer; alıcı parçaları bununla gruplayıp birleştirir |
| **Flags** | 3 bitlik alan. **DF** (Don't Fragment): "parçalama" = yönlendiriciye bölme yapma der. **MF** (More Fragments): son parça dışındaki tüm parçalarda `1`'dir |
| **Fragment Offset** | Bu parçadaki verinin, orijinal mesajdaki konumunu **8 baytlık birimler** halinde gösterir |
| **Time To Live (TTL)** | Datagramın ağda yaşayabileceği süre; her yönlendirici 1 azaltır, `0`'a düşünce paket yok edilir |
| **Protocol** | Üst katman protokolü (TCP=6, UDP=17, ICMP=1); alıcı IP katmanı paketi hangi protokole ileteceğini bu alandan anlar |
| **Header Checksum** | Başlıkta bozulma olup olmadığını denetler |
| **Source Address** | Gönderici IP adresi |
| **Destination Address** | Alıcı IP adresi |
| **Options** | Opsiyonel; güvenlik, hata raporlama vb. amaçlar |
| **Data** | Üst katmandan (taşıma katmanı) gelen veri |

> [!warning] Düzeltme: Flags ≠ Fragment Offset
> **Flags** yalnızca 3 bittir (Reserved, DF, MF). "8 baytlık birimler halinde konum" bilgisini veren alan **Fragment Offset**'tir — ikisi karıştırılmamalı.

## İlgili Notlar

- [[0-TCP-IP Modeli|TCP/IP Modeli]]: IP'nin katmanlar içindeki yeri ve gerçek başlık alanları
- [[1-CIDR Gösterimi|CIDR Gösterimi]] ve [[6-IP Subneting|IP Subneting]]: IP adres bloklarının bölünmesi
- [[7-ARP|ARP]]: IP adresinin MAC adresine çözülmesi
- [[8-ICMP|ICMP]]: IP üzerinde taşınan kontrol protokolü
