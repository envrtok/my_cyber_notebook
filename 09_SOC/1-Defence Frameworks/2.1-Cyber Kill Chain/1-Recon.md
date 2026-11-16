> [!summary] Özet
> **Reconnaissance (Keşif)**, Cyber Kill Chain'in ilk aşamasıdır. Saldırgan hedef hakkında olabildiğince çok bilgi toplar: alan adları, IP aralıkları, çalışanlar, e-posta adresleri, açık portlar, kullanılan teknolojiler. Bu aşamada toplanan bilgi, sonraki tüm aşamaların başarısını belirler.

## Pasif Keşif (Passive Recon)

- Hedefle **doğrudan etkileşime girmeden** bilgi toplanır.
- Hedefin sistemlerine paket gönderilmediği için firewall veya IDS/IPS loglarında **iz bırakmaz**.
- Genellikle OSINT (Open Source Intelligence) kaynaklarıyla yapılır.

**Kaynaklar ve araçlar:**
- Arama motorları ve Google Dorking
- WHOIS / RDAP kayıtları → [[1-WHOIS & RDAP]]
- DNS sorguları → [[2-nslookup & dig]]
- theHarvester → [[4-theHarvester Detailed]]
- Shodan
- Sosyal medya, iş ilanları, LinkedIn → [[3-Discovery with OSINT]]

## Aktif Keşif (Active Recon)

- Hedefle **doğrudan etkileşime geçilerek** bilgi toplanır ve **iz bırakılır**.
- Hedefin firewall, IDS/IPS ve web sunucusu loglarından **tespit edilebilir**.

**Araçlar:**
- Nmap (port ve servis taraması) → [[1-Nmap – Host Keşfi]]
- Gobuster, dirb (dizin ve subdomain keşfi) → [[5-Directory Enumeration]]

## Karşılaştırma

| Kriter | Pasif Keşif | Aktif Keşif |
|---|---|---|
| Hedefle temas | Yok | Var |
| Tespit edilebilirlik | Çok düşük | Yüksek (loglarda görünür) |
| Elde edilen bilgi | Genel (kişiler, domainler, teknolojiler) | Teknik ve güncel (açık portlar, servis sürümleri) |
| Örnek | Google Dorking, WHOIS, Shodan | Nmap, Gobuster |

## Keşif Aşamasında Savunma

- Kamuya açık bilgi sızıntısını olabildiğince azaltmak (iş ilanlarında teknoloji detayları, çalışan bilgileri vb.)
- Alan adı kayıt bilgilerini gizlemek (WHOIS privacy)
- Web uygulamalarının detaylı hata mesajı (stack trace, sürüm bilgisi) döndürmesini engellemek
- Nmap ve benzeri tarama girişimlerini firewall ve IDS/IPS loglarından tespit edip engellemek

> [!note]
> Pasif keşfe karşı doğrudan tespit neredeyse imkânsızdır; yapılabilecek en iyi şey **dışarıya verilen bilgiyi azaltmaktır**.

## İlgili Notlar

- [[0-Cyber Kill Chain|Cyber Kill Chain]] · Sonraki aşama: [[2-Weaponization|Weaponization]]
- [[8-Savunma ve Tespit Mekanizmaları|Savunma ve Tespit Mekanizmaları]]
