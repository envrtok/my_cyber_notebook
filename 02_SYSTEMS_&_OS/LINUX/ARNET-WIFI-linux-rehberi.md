# ARNET_WIFI'ye Linux'tan (NextDNS ile) bağlanma rehberi

> [!summary] Özet
> Katı DNS-over-TLS (NextDNS) kurulu bir Linux'tan `ARNET_WIFI` captive portal'ına bağlanma sorunu: ağ dış DNS'leri engellediği için portal açılmıyor. Çözüm — bu ağa bağlıyken geçici olarak ağın kendi DNS'ine düşen, başka ağda NextDNS'e dönen bir NetworkManager dispatcher betiği.

Bu rehber şu durum içindir:

- Arnavutköy Belediyesi'nin `ARNET_WIFI` ağına telefondan sorunsuz bağlanabiliyorsun,
- ama Linux bilgisayarda giriş bildirimi gelmiyor, `https://arnet.arnavutkoy.bel.tr` açılmıyor ya da girişten sonra internet çalışmıyor,
- ve bilgisayarında NextDNS (veya başka bir şifreli DNS) `systemd-resolved` üzerinden DNS-over-TLS ile ayarlı.

Pardus 25 (Debian 13 tabanlı), GNOME, NetworkManager ve systemd-resolved üzerinde denendi.

---

## Sorunun nedeni

1. **Portal adresi internette yok.** `arnet.arnavutkoy.bel.tr` genel DNS'te kayıtlı değil (NXDOMAIN); yalnızca ARNET'in kendi DNS sunucusu bu adı çözebiliyor.
2. **Katı DNS-over-TLS, ağın DNS'ini devre dışı bırakıyor.** `resolved.conf` içindeki `DNSOverTLS=yes` ayarı, ağın DHCP'den verdiği DNS sunucusuna da şifreli bağlanmaya çalışıyor. ARNET'in DNS'i bunu desteklemediği için hiçbir ad çözülemiyor.
3. **ARNET dış DNS servislerini engelliyor.** Giriş yaptıktan sonra bile NextDNS, Cloudflare (1.1.1.1), Google (8.8.8.8), Quad9 (9.9.9.9), AdGuard gibi servislerin IP adreslerine hem 443 hem 853 portundan ulaşılamıyor. `nextdns.io` alan adları da `0.0.0.0`'a yönlendiriliyor. Yani NextDNS bu ağda hiçbir yoldan (DoT ya da DoH) çalışmaz.
4. **Telefon neden çalışıyor?** Android, Private DNS'e ulaşamayınca sessizce ağın DNS'ine geçiyor. Yani telefonda da ARNET'teyken NextDNS kullanılmıyor.
5. **GNOME bildirimi neden bir şey açmıyor?** Debian/Pardus'un `gnome-shell` paketinde GNOME'un portal giriş penceresi (`gnome-shell-portal-helper`) yok.

**Çözümün özeti:** ARNET'e bağlıyken ağın kendi DNS'ini kullanmak, başka ağlarda NextDNS'e dönmek. Bu işlemi bir NetworkManager dispatcher betiği otomatik yapıyor.

---

## Ön koşul: durumun sana uyduğunu kontrol et

```bash
resolvectl status | head -12
```

`Global` bölümünde NextDNS (veya başka) sunucular ve `+DNSOverTLS` görüyorsan bu rehber sana uyuyor.

> Aşağıdaki komutlarda kablosuz arayüzün adı ya da bağlantı profilinin adı farklıysa kendi değerlerini yaz. Profil adını görmek için: `nmcli -t -f NAME connection show`

---

## Kurulum (başka bir ağdayken, internet varken yap)

### 1. NextDNS'i genel olarak tek DNS yap

Bu ayar sayesinde ağların DNS'i genel sorgulara karışmaz; ARNET dışındaki ağlarda bütün sorgular NextDNS'e gider.

```bash
sudo mkdir -p /etc/systemd/resolved.conf.d && printf '[Resolve]\nDomains=~.\n' | sudo tee /etc/systemd/resolved.conf.d/10-nextdns-default.conf
```

### 2. ARNET profilinde ağın DNS'ine şifresiz erişime izin ver

```bash
nmcli connection modify ARNET_WIFI connection.dns-over-tls 0 ipv4.dns-search "~arnavutkoy.bel.tr"
```

`ARNET_WIFI` profili henüz yoksa bu adımı ağa ilk kez bağlandıktan sonra yap.

### 3. Bağlantı kontrolünü aç (isteğe bağlı)

NetworkManager'ın internet erişimini denetlemesini sağlar.

```bash
sudo apt install network-manager-config-connectivity-debian
```

### 4. Dispatcher betiğini kur

Aşağıdaki içeriği bir dosyaya (ör. `~/90-arnet-dns`) kaydet:

```sh
#!/bin/sh
# ARNET_WIFI için DNS ayarı (NetworkManager dispatcher betiği).
# ARNET dış DNS servislerini (NextDNS dahil) engellediği için, bu ağa bağlıyken
# global NextDNS ayarı geçici olarak kaldırılır ve ağın kendi DNS'i kullanılır
# (portal girişi dahil). Başka bir ağa geçince NextDNS'e geri dönülür.

CONN=ARNET_WIFI
DROPIN=/run/systemd/resolved.conf.d/90-captive-portal.conf

arnet_active() {
    nmcli -t -f NAME connection show --active | grep -qx "$CONN"
}

local_dns_on() {
    [ -f "$DROPIN" ] && return 0
    mkdir -p "${DROPIN%/*}"
    printf '[Resolve]\nDNS=\nDomains=\n' > "$DROPIN"
    systemctl reload systemd-resolved
    logger -t arnet-portal "ARNET: ağın DNS'i kullanılıyor"
}

local_dns_off() {
    [ -f "$DROPIN" ] || return 0
    rm -f "$DROPIN"
    systemctl reload systemd-resolved
    logger -t arnet-portal "ARNET dışı: NextDNS'e dönüldü"
}

case "$2" in
    up)
        [ "$CONNECTION_ID" = "$CONN" ] && local_dns_on
        ;;
    down)
        [ "$CONNECTION_ID" = "$CONN" ] && local_dns_off
        ;;
    connectivity-change)
        # Kaçırılan up/down olaylarına karşı durumu eşitle
        if arnet_active; then
            local_dns_on
        else
            local_dns_off
        fi
        ;;
esac
exit 0
```

Sonra tek satırla kur (dosyanın sahibi root olur ve 755 izni alır):

```bash
sudo install -m 755 ~/90-arnet-dns /etc/NetworkManager/dispatcher.d/90-arnet-dns
```

> **İpucu:** Betiği terminale heredoc ile yapıştırırsan Türkçe karakterler yüzünden ekran karışık görünebilir. Bu genelde yalnızca görüntü bozukluğudur, ama dosyayı bir metin düzenleyiciyle kaydedip `install` ile kopyalamak daha güvenli.

### 5. Servisleri yeniden başlat

```bash
sudo systemctl restart systemd-resolved NetworkManager
```

### 6. LibreWolf/Firefox: neverssl.com için HTTPS-Only istisnası ekle (isteğe bağlı)

LibreWolf'ta HTTPS-Only modu varsayılan olarak açık. Bu mod, portal yönlendirmesi için gereken `http://` adresini engeller.

**Ayarlar → Gizlilik ve Güvenlik → Yalnızca HTTPS modu → İstisnaları yönet** yolundan `http://neverssl.com` adresini ekle.

---

## Her seferinde ARNET'e bağlanmak

1. `ARNET_WIFI` ağına bağlan.
2. Tarayıcıda **`http://neverssl.com`** adresini aç.
   - Ağ geçidi seni, cihazını tanıtan parametrelerle portala yönlendirir.
   - `https://arnet.arnavutkoy.bel.tr` adresini elle yazarsan bu parametreler eksik kalır ve sayfa "Wi-Fi Ağına Bağlı Değilsiniz" der.
   - "Güvenli site kullanılamıyor" uyarısı çıkarsa **"HTTP sitesine devam et"** düğmesine bas.
3. Portaldan giriş yap. İnternet çalışır.

GNOME'un "ağda oturum aç" bildirimine basmak Pardus'ta bir şey açmaz; bildirimi görmezden gel.

---

## Kontrol

ARNET'teyken `Global` bölümünde DNS sunucusu **görünmemeli**; `wlo1` bölümünde ağın DNS'i (ör. `10.6.0.1`) ve `-DNSOverTLS` görünmeli:

```bash
resolvectl status | head -16
```

Başka bir ağdayken `Global` bölümünde NextDNS sunucuları yeniden görünmeli.

Betiğin kayıtlarını görmek için (`sudo` gerekebilir):

```bash
sudo journalctl -t arnet-portal -b
```

---

## Sorun giderme

| Belirti | Olası neden | Ne yapmalı |
|---|---|---|
| Portal adresi hiç açılmıyor | Ağın DNS'i kullanılmıyor | 2. ve 4. adımları kontrol et; `resolvectl query arnet.arnavutkoy.bel.tr` bir IP döndürmeli |
| Sayfa "fonts.googleapis.com aranıyor…" diye takılıyor | Diğer adlar NextDNS'e gidiyor, ona ulaşılamıyor | Dispatcher betiği kurulu ve 755 izinli mi kontrol et |
| "Wi-Fi Ağına Bağlı Değilsiniz" | Portal parametresiz açıldı | `http://neverssl.com` üzerinden git |
| Girişten sonra siteler açılmıyor | NextDNS ARNET'te engelli | Betiğin çalıştığını kontrol et; acil durumda aşağıdaki komutu kullan |

**Acil durum: ağın DNS'ine elle geç**

```bash
sudo mkdir -p /run/systemd/resolved.conf.d && printf '[Resolve]\nDNS=\nDomains=\n' | sudo tee /run/systemd/resolved.conf.d/90-captive-portal.conf >/dev/null && sudo systemctl reload systemd-resolved
```

**Elle NextDNS'e geri dön**

```bash
sudo rm -f /run/systemd/resolved.conf.d/90-captive-portal.conf && sudo systemctl reload systemd-resolved
```

Yeniden başlatınca `/run` temizlendiği için bu geçici ayar da kendiliğinden kalkar.

---

## Geri alma

```bash
sudo rm -f /etc/NetworkManager/dispatcher.d/90-arnet-dns /etc/systemd/resolved.conf.d/10-nextdns-default.conf
```

```bash
nmcli connection modify ARNET_WIFI connection.dns-over-tls -1 ipv4.dns-search ""
```

```bash
sudo systemctl restart systemd-resolved NetworkManager
```

---

## Bilinmesi gerekenler

- **Gizlilik:** ARNET'teyken DNS sorguların şifresiz olarak belediyenin DNS sunucusuna gider ve NextDNS filtrelemesi o ağda çalışmaz. Telefonda da durum aynı.
- **Başka halka açık ağlar:** NextDNS'i katı DoT moduyla kullandığın için, dış DNS'i engelleyen başka bir ağda da "bağlı ama internet yok" durumu yaşanabilir. Betik yalnızca `ARNET_WIFI` profiline göre ayarlı; başka bir ağ için `CONN=` satırını değiştirerek bir kopyasını kurabilirsin.
