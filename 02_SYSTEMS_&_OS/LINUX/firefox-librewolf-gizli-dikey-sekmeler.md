# Firefox / LibreWolf: Kenara Gelince Açılan Gizli Dikey Sekmeler

> [!summary] Özet
> Firefox/LibreWolf'un yerleşik dikey sekme panelini **tamamen gizleyip**, fare ekranın sol kenarına gelince **kayarak açılmasını** sağlayan `userChrome.css` yöntemi (Arc / Zen benzeri davranış).

Bu rehber, Firefox'un yerleşik dikey sekme panelini **tamamen gizleyip**, fare ekranın sol kenarına gelince **kayarak açılmasını** sağlar (Arc / Zen benzeri davranış).

Firefox'un kendi "üzerine gelince genişlet" seçeneği paneli tamamen gizlemez, ikonlardan oluşan ince bir şerit bırakır. Bu yöntemde şerit de yok olur.

> [!note] Test edildi
> Test edilen sürüm: **LibreWolf 159.0** (Linux). Firefox'ta da aynı şekilde çalışır. Firefox arayüzü sürümler arasında değiştiği için öğe adları ileride farklılaşabilir. Bu durumda [Sorun giderme](#sorun-giderme) bölümüne bakın.

---

## 1. Dikey sekmeleri ve kenar çubuğunu ayarlayın

1. **Ayarlar → Genel → Tarayıcı düzeni** bölümünden **Dikey sekmeler**'i seçin.
2. Kenar çubuğuna sağ tıklayın, **Kenar çubuğunu özelleştir**'e girin ve **Her zaman göster**'i seçin.
   - **"Fareyle üzerine gelince genişlet" seçili olmasın.** O mod ikonlu şeridi geri getirir ve CSS ile çakışır.
3. Kenar çubuğunu **genişletilmiş** hâle getirin, sekme adları görünsün. CSS paneli yalnızca kaydırır. Panel daraltılmış durumdaysa açıldığında sadece ikonlar görünür.

## 2. userChrome.css desteğini açın

`about:config` sayfasında şu ayarı `true` yapın:

```
toolkit.legacyUserProfileCustomizations.stylesheets = true
```

Bu ayar profil güncellemelerinde de kalsın istiyorsanız profil klasöründeki `user.js` dosyasına ekleyin:

```js
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
```

## 3. Profil klasörünü bulun

`about:support` sayfasını açın. **Profil Klasörü** satırındaki yol kullandığınız profilin yoludur.

| Kurulum | Tipik yol |
|---|---|
| LibreWolf (Linux, paket) | `~/.config/librewolf/librewolf/<profil>/` veya `~/.librewolf/<profil>/` |
| LibreWolf (Flatpak) | `~/.var/app/io.gitlab.librewolf-community/.librewolf/<profil>/` |
| Firefox (Linux) | `~/.mozilla/firefox/<profil>/` veya `~/.config/mozilla/firefox/<profil>/` |
| Firefox (Windows) | `%APPDATA%\Mozilla\Firefox\Profiles\<profil>\` |
| Firefox (macOS) | `~/Library/Application Support/Firefox/Profiles/<profil>/` |

> [!warning]
> Birden fazla profil olabilir. Yolu tahmin etmeyin, her zaman `about:support` sayfasındaki satıra bakın.

## 4. userChrome.css dosyasını oluşturun

Linux'ta tek komutla (önce `PROF` değişkenini kendi profil yolunuza göre ayarlayın):

```bash
PROF="$HOME/.config/librewolf/librewolf/XXXXXXXX.default-default"
mkdir -p "$PROF/chrome"
cat << 'EOF' > "$PROF/chrome/userChrome.css"
/* Dikey sekmeler: tamamen gizli, sol kenara gelince açılır
   Yapı: hbox#browser > box#sidebar-container > sidebar-main */
#browser {
  position: relative !important;
}

/* Paneli yeniden boyutlandırma tutamacını gizle */
#sidebar-launcher-splitter,
.sidebar-launcher-splitter {
  display: none !important;
}

/* Sekme panelinin kapsayıcısı */
#sidebar-container {
  position: absolute !important;
  top: 0 !important;
  bottom: 0 !important;
  left: 0 !important;
  z-index: 10 !important;
  width: 240px !important;
  min-width: 240px !important;
  max-width: 240px !important;
  background-color: var(--toolbox-bgcolor, var(--lwt-accent-color, #1c1b22)) !important;
  /* 6px'lik görünmez şerit hariç tamamen sola kaydır */
  transform: translateX(calc(-100% + 6px)) !important;
  opacity: 0 !important;
  transition: transform 0.15s ease, opacity 0.12s ease !important;
}

#sidebar-container > sidebar-main {
  width: 100% !important;
  max-width: none !important;
}

/* Fare kenara gelince aç */
#sidebar-container:hover {
  transform: none !important;
  opacity: 1 !important;
  box-shadow: 4px 0 16px rgba(0, 0, 0, 0.45) !important;
}
EOF
```

Windows ve macOS'ta profil klasöründe `chrome` adlı bir klasör oluşturun ve yukarıdaki CSS'i içine `userChrome.css` adıyla kaydedin. Dosya adının `userChrome.css.txt` olmadığından emin olun.

## 5. Tarayıcıyı temiz başlatın

`userChrome.css` yalnızca açılışta okunur ve tarayıcı bazen eski sürümü önbellekten yükler. Tarayıcıyı tamamen kapatıp önbelleği temizleyerek açın:

```bash
pkill -f librewolf; sleep 2; librewolf -purgecaches &
# Firefox için: pkill -f firefox; sleep 2; firefox -purgecaches &
```

Fareyi ekranın en sol kenarına götürdüğünüzde panel açılmalıdır.

---

## Nasıl çalışıyor?

- `#sidebar-container` normal akıştan çıkarılır (`position: absolute`). Böylece sayfa içeriği pencerenin tamamını kaplar.
- Panel genişliği değiştirilmez, `transform` ile sola kaydırılır. Böylece sekmelerin düzeni bozulmaz ve animasyon akıcı olur.
- Ekranın kenarında **6px'lik görünmez bir şerit** kalır. `opacity: 0` olan öğeler fare olaylarını almaya devam ettiği için bu şerit üzerine gelmeyi algılar.
- `:hover` olunca panel yerine kayar ve sayfanın **üzerinde** açılır. İçerik kaymaz.

## Özelleştirme

| Ne | Nerede |
|---|---|
| Açılınca panel genişliği | `width`, `min-width`, `max-width` → `240px` |
| Kenarı tetiklemek zorsa | `calc(-100% + 6px)` → `8px` veya `10px` |
| Animasyon hızı | `transition` içindeki `0.15s` / `0.12s` |
| Gölge | `box-shadow` satırı (istemiyorsanız silin) |

Paneli sağ tarafa aldıysanız (kenar çubuğu konumu: sağ) `left: 0` yerine `right: 0` yazın ve `translateX(calc(-100% + 6px))` yerine `translateX(calc(100% - 6px))` kullanın.

---

## Sorun giderme

### Hiçbir şey değişmiyor

Bunun iki olası nedeni var: dosya yüklenmiyor ya da seçiciler (selector) sizin sürümünüzdeki öğelerle eşleşmiyor. Hangisi olduğunu anlamak için **Tarayıcı konsolunu** kullanın.

1. `about:config` sayfasında `devtools.chrome.enabled = true` yapın. Konsolda komut yazabilmek için bu gerekli.
2. **☰ → Daha fazla araç → Tarayıcı konsolu** yolundan ya da `Ctrl+Shift+J` ile konsolu açın.
3. Alttaki satıra şunu yapıştırın. Yapıştırma engellenirse önce `allow pasting` yazın.

```js
[Services.appinfo.version,
 Services.prefs.getBoolPref("toolkit.legacyUserProfileCustomizations.stylesheets"),
 Services.dirsvc.get("UChrm", Ci.nsIFile).path]
```

Çıktı sırasıyla şunları verir: sürüm, ayarın gerçekte okunan değeri ve tarayıcının `userChrome.css` dosyasını **aradığı klasör**. Dosyanız bu klasörde değilse sorun budur.

### Seçicileri kendi sürümünüze göre bulmak

Firefox sürümleri arasında öğe adları değişebilir. Örneğin eski sürümlerde `#sidebar-main` vardı, LibreWolf 159'da yok. Sekme panelinin hangi öğelerin içinde durduğunu görmek için konsola şunu yazın:

```js
(() => { const c=[]; for (let e=document.querySelector("sidebar-main"); e; e=e.parentElement) c.push(e.localName+(e.id?"#"+e.id:"")); return c.join(" < "); })()
```

Örnek çıktı (LibreWolf 159):

```
sidebar-main < box#sidebar-container < hbox#browser < body < html#main-window
```

`sidebar-main`'in **hemen üstündeki** öğe (burada `#sidebar-container`) CSS'te hedeflenmesi gereken kapsayıcıdır. Adı farklıysa CSS'teki `#sidebar-container` yazan yerleri o adla değiştirin.

### Yeniden başlatmadan CSS denemek

Dosyayı düzenledikten sonra tarayıcıyı kapatmadan uygulamak için konsola şunu yapıştırın. Kendi profil yolunuzu yazın. Komut eski kaydı kaldırır, sonuna eklenen `?v=` parametresi sayesinde de dosya önbellekten değil diskten okunur:

```js
(() => {
  const sss = Cc["@mozilla.org/content/style-sheet-service;1"].getService(Ci.nsIStyleSheetService);
  const p = "file:///home/KULLANICI/.config/librewolf/librewolf/XXXXXXXX.default-default/chrome/userChrome.css";
  const old = Services.io.newURI(p);
  if (sss.sheetRegistered(old, sss.USER_SHEET)) sss.unregisterSheet(old, sss.USER_SHEET);
  sss.loadAndRegisterSheet(Services.io.newURI(p + "?v=" + Date.now()), sss.USER_SHEET);
  return "ok";
})()
```

> [!note]
> Bu yöntemle yüklenen stil yalnızca o oturum için geçerlidir. Kalıcı olması için dosyanın profil klasöründe durması ve tarayıcının yeniden başlatılması gerekir.

### Dosyanın yüklendiğini hızlıca test etmek

`userChrome.css` dosyasının en üstüne geçici olarak şunu ekleyin:

```css
#nav-bar { background: red !important; }
```

Tarayıcıyı yeniden başlattıktan sonra adres çubuğu kırmızıysa dosya yükleniyor demektir. Bu durumda sorun seçicilerdedir. Testten sonra satırı silin.

### Panel açılıyor ama sadece ikonlar görünüyor

Kenar çubuğu daraltılmış ya da "üzerine gelince genişlet" modunda. 1. adımdaki gibi **Her zaman göster**'i seçin ve paneli genişletin.

### Kenara gelince açılmıyor

- Fareyi ekranın **en sol pikseline** götürün. Pencere tam ekran değilse pencere kenarına götürün.
- Şerit genişliğini `8px` veya `10px` yapın.

### Tarayıcı Araç Kutusu açılmıyor

`Ctrl+Shift+Alt+I` kısayolu bazı masaüstü ortamlarında çalışmaz ve LibreWolf menüsünde bu seçenek görünmeyebilir. Bu rehberdeki her şey **Tarayıcı konsolu** ile yapılabilir, Araç Kutusu gerekmez.
