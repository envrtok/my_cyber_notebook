Kısaca: **Subnet mask, bir IP adresinin hangi kısmının ağı, hangi kısmının cihazı temsil ettiğini belirler. Ağ adresi ise o ağın kimliğidir.**

Bir örnek üzerinden gidelim.

## **1. IP adresi nedir?**

Diyelim ki bilgisayarının IP adresi şu:

`192.168.1.35`

Bu adres, ağdaki cihazını tanımlar.

Ama bu IP'ye bakarak cihazın hangi ağa ait olduğunu tek başına anlayamayız. Bunun için subnet mask kullanırız.

## **2. Subnet mask nedir?**

Örneğin:

`255.255.255.0`

Bu subnet mask, IP adresinin hangi bölümünün ağ, hangi bölümünün cihaz olduğunu söyler.

İkisini yan yana yazalım:

|IP adresi|192.168.1|35|
|---|---|---|
|Subnet mask|255.255.255|0|
|Anlamı|Ağ kısmı|Cihaz kısmı|

Yani:

- `192.168.1` → Ağın kimliği.
    
- `35` → O ağdaki cihazın numarası.
    

Bu subnet mask'in CIDR gösterimi de `/24` şeklindedir.

## **3. Ağ adresi (Network Address) nedir?**

Ağ adresi, bir subnet'i tanımlayan özel IP adresidir.

Bizim örneğimiz:

- IP adresi: `192.168.1.35`
    
- Subnet mask: `255.255.255.0`
    
- Ağ adresi: `192.168.1.0`
    

Peki neden `.0`?

Çünkü subnet mask'e göre son 8 bit cihazlara ayrılmıştır. Ağ adresinde cihaz kısmının tamamı `0` yapılır.

Dolayısıyla:

**192.168.1.0/24 ağı**

Ağ adresi

**192.168.1.0**

Kullanılabilir IP'ler

**192.168.1.1 – 254**

Broadcast

**192.168.1.255**

Toplam 256 adres, geleneksel kullanımda 254 cihaz adresi.

## **4. Peki bunlar ne işe yarıyor?**

Diyelim ki üç cihazımız var:

|Cihaz|IP adresi|
|---|---|
|Bilgisayar A|192.168.1.35|
|Bilgisayar B|192.168.1.70|
|Bilgisayar C|192.168.2.10|

Hepsinin subnet mask'i `255.255.255.0` olsun.

- A ve B aynı ağda: `192.168.1.0`
    
- C farklı ağda: `192.168.2.0`
    

A ve B aynı subnet içerisinde oldukları için doğrudan yerel ağ üzerinden haberleşebilirler.

C ile haberleşmek için ise normalde router gerekir.

## **5. Öğrenip öğrenmediğini kontrol edelim**

Şu IP adresini düşün:

`192.168.10.45/24`

**Bu IP'nin ağ adresi hangisidir?**

192.168.10.45

192.168.10.0

192.168.10.255

192.168.0.0

Kontrol et

Doğru!Son oktet cihaz kısmı olduğu için sıfırlanır.

**Önemli:** Subnetting'in asıl amacı bir ağı daha küçük ağlara bölmektir. Subnet mask ve network address kavramlarını oturttuktan sonra `/24`, `/25`, `/26`, `/27` gibi CIDR değerlerini öğrenmeye başlayacağız. Bunlar subnetting'in temelini oluşturuyor.