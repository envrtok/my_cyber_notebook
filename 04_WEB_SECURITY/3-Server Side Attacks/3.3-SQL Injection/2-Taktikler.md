> [!summary] Özet
> Pratikte işe yarayan temel SQL Injection taktikleri: **koşulu her zaman doğru yapmak** (`OR 1=1`), **sorgunun geri kalanını yoruma almak** (`--`) ve **enjeksiyon noktasını bulmak için siteyi gezmek**. Bu not, hızlıca başvurulacak bir hatırlatma listesidir; tür ayrımı için bkz. [[1-SQL Injection Türleri ve Farkları|SQL Injection Türleri]].

## 1. Koşulu Her Zaman Doğru Yapmak: `OR 1=1`

Sorguda genellikle koşullu bir dal (`WHERE ... AND ...`) vardır. Girdinin sonuna `OR 1=1` eklenince koşul her zaman doğru olur; sona `--` eklenince de sorgunun kalan kısmı yorum satırına döner ve devre dışı kalır.

**Klasik kimlik doğrulama atlatma (auth bypass):**

```sql
-- Uygulamanın beklediği sorgu:
SELECT * FROM users WHERE username='INPUT' AND password='INPUT';

-- username alanına şunu yazarsak:
admin'--

-- Sorgu şuna döner (password kontrolü yorumda kalır):
SELECT * FROM users WHERE username='admin'--' AND password='x';
```

```sql
-- Kullanıcı adı bilinmiyorsa, ilk kullanıcıyla giriş:
' OR 1=1--
```

> [!warning] Yorum sözdizimi veritabanına göre değişir
> - **MySQL:** `-- ` (tireden sonra **bir boşluk şart**) veya `#`
> - **MSSQL / PostgreSQL / Oracle / SQLite:** `--`
> URL'de boşluk kaybolabileceği için `-- -` veya `--+` yazmak daha güvenlidir.

## 2. `--` ile Kalanı Yoruma Almak

`--` kendinden sonrasını yorum satırı yapar. Enjeksiyondan sonra sorguda kalan tırnakları, `AND` koşullarını veya `LIMIT` gibi ekleri susturmak için bolca kullanılır.

## 3. Enjeksiyon Noktasını Bulmak İçin Siteyi Gez

Hangi parametreyi nasıl manipüle edeceğini anlamak için önce uygulamayı normal şekilde kullan:

- Bir `category` parametresini manipüle edeceksen, önce sitede o sayfaya normal gir ve URL'de nasıl göründüğüne bak (ör. `?category=Gifts`).
- Parametreyi gördükten sonra tek tırnak (`'`) ekleyerek test et: hata veya davranış değişikliği enjeksiyon ihtimalini gösterir.

> [!tip] İlk test: tek tırnak
> Bir parametreye tek `'` eklemek en hızlı sınamadır. SQL hatası, boş sonuç veya farklı bir yanıt → o nokta enjekte edilebilir olabilir.

## İlgili Notlar

- [[1-SQL Injection Türleri ve Farkları|SQL Injection Türleri ve Farkları]]: In-band, Blind, Second-Order ayrımı
- [[3-Introduction to IDOR|IDOR]]: bir diğer erişim/yetki tabanlı web zafiyeti
