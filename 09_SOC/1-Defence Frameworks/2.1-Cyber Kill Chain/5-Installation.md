> [!summary] Özet
> **Installation (Kurulum)**, saldırganın hedefte **kalıcılık (persistence)** sağladığı aşamadır. Amaç, sistem yeniden başlatılsa veya ilk erişim yolu kapatılsa bile erişimin devam etmesidir. Bunun için arka kapı (backdoor) yerleştirilir veya sistem konfigürasyonları değiştirilir.

## Kalıcılık Teknikleri

| Teknik | Açıklama |
|---|---|
| **Registry Run Keys** (Windows) | Zararlı programın her oturum açılışında çalışması için kayıt defterine eklenmesi |
| **Scheduled Tasks / Cron** | Zamanlanmış görevle zararlının belirli aralıklarla çalıştırılması → bkz. [[systemctl & crontab]] |
| **Servis oluşturma** | Zararlının sistem servisi olarak kurulup açılışta otomatik başlaması |
| **Web Shell** | Ele geçirilen web sunucusuna komut çalıştırmayı sağlayan bir script yüklenmesi |
| **Backdoor** | Saldırgana sonradan tekrar giriş sağlayacak gizli erişim yolu (yeni kullanıcı, SSH anahtarı vb.) |

> [!note]
> Saldırganlar kalıcılık için çoğu zaman sistemde zaten bulunan meşru araçları kullanır. Bkz. [[1-Arazidekiyle Yaşamak (Living off the Land)|Living off the Land]]

## Kurulum Aşamasında Savunma

- **FIM** (File Integrity Monitoring): Kritik sistem dosyalarındaki ve konfigürasyonlardaki değişiklikleri izler
- **Kayıt defteri (Registry) izleme:** Run key'lere ve servis kayıtlarına yapılan eklemeler için alarm üretmek
- **Yetki yönetimi:** En az yetki prensibi (Least Privilege); kullanıcıların servis kuramaması
- **Application Allowlisting:** Yalnızca onaylı uygulamaların çalışmasına izin vermek (AppLocker, WDAC)

## İlgili Notlar

- Önceki aşama: [[4-Exploitation|Exploitation]] · Sonraki aşama: [[6-Command and Control|Command and Control]]
- [[0-Cyber Kill Chain|Cyber Kill Chain]]
