> [!summary] Özet
> **İletişim modu**, verinin hangi yön(ler)de aktığını tanımlar (Simpleks, Half Duplex, Full Duplex). **İletişim türü** ise verinin kaç alıcıya gittiğini tanımlar (Unicast, Multicast, Broadcast).

## İletişim Modları

Verinin akış yönünü belirler. Üç kategoriye ayrılır:

| Mod | Yön | Aynı anda çift yön? | Örnek |
|---|---|---|---|
| **Simpleks** | Tek yön | — | Klavye → bilgisayar, bilgisayar → monitör |
| **Half Duplex** | Çift yön | Hayır (sırayla) | Telsiz (konuşurken dinlenemez) |
| **Full Duplex** | Çift yön | Evet | Telefon görüşmesi, canlı sohbet |

- **Simpleks:** Veri yalnızca bir yönde akar. Gönderici sürekli veri aktarır, alıcı yalnızca alır ve geri veri göndermez.
- **Half Duplex:** Veri her iki yönde aktarılabilir ama **aynı anda değil**. Bir cihaz gönderirken diğeri alır, sonra roller değişir. Sınırlı bant genişliğine sahip ortamlarda etkilidir.
- **Full Duplex:** Veri her iki yönde **aynı anda** akar. En verimli modlardan biridir ve eş zamanlı iletişime olanak tanır.

## İletişim Türleri

Verinin kaç hedefe gönderildiğini belirler.

| Tür | Kimden → Kime | Örnek |
|---|---|---|
| **Unicast** | Tek → Tek | Web sunucusundan bilgisayarına sayfa yüklenmesi |
| **Multicast** | Tek → Belirli bir grup | Canlı video yayınının aynı anda birçok izleyiciye gitmesi |
| **Broadcast** | Tek → Ağdaki herkes | DHCP isteği, [[9-ARP|ARP]] isteği |

- **Unicast:** En yaygın iletim türüdür; internetteki trafiğin çoğu böyledir.
- **Multicast:** Aynı veri birden fazla (ama tüm değil) alıcıya ulaşacağında verimlidir.
- **Broadcast:** Verinin ağdaki **her** cihaza ulaşması gerektiğinde kullanılır. Broadcast trafiği router'ları geçmez; yerel ağ (broadcast domain) ile sınırlıdır.

## İlgili Notlar

- [[10-Farklı Ağlar Arası Ping ve ARP|Farklı Ağlar Arası Ping ve ARP]]: ARP broadcast'inin yerel ağda nasıl çalıştığı
- [[3-OSI Modeli|OSI Modeli]]
