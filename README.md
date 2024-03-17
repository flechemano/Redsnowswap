# hazırlık  (ubuntu 22.04) 

npmjs sitesine üye ol, mail doğrulaması isterse yap. kullanıcı adını ve şifrenle terminalden giriş yapacaksın.

```console 
https://www.npmjs.com/signup
```

# kullanıcı adı ve şifreyle giriş yap maile gelen otp kodunu gir.
```console
npm login --auth-type legacy
```
# kurulum scripti bazı bilgiler isteyecek bunları önceden hazırla.
# kuruluma başlamadan önce bir proje ismi belirle, başka projelerle isim benzerliği olmaması için random sayı ya da benzersiz harfler eklemek sorun çıkmasını önler. mesela blacktea yaparsam benzeri çok  olabilir ama blacktea024 ihtimalleri düşürür, blacktea024jdjdb yaparsam büyük ihtimalle böyle bir proje yoktur. bu isimi belirledikten sonra bu isimle bir repo aç.


# ssh key aşamasında oluşacak ssk key in public key kısmını github hesabına eklemeniz lazım. ayarlar/ssh-and-gpg-keys e girince sağ üstlerde "new ssh key" butonuna basın, herhangi bir isim verin, public keyi ekleyin kaydete basın. public key hatasız girilmeli. tam olarak, boşluk bile bırakmadan,"ssh-rsa ile başlayıp uzun eşittire benzeyen işaretle '===' biten kısma kadar. (eğer mail adresini boş geçmediyseniz mail@mail.com gibi, .com kısmına kadar olmalı.) 
*ssh key githuba eklenmez, o kullandığınız bilgisayarda durmalı.


# GitHub homapage URL: "açtığın repoya giriş yaptığında tarayıcıdaki adres"

# GitHub repository  URL : "projenin içindeyken sağ üst kısımlarda code kutusunda https sekmesindeki"
# GitHub repository SSH URL: " bu da ssh sekmesindeki adres"
# Description sorusuna projenin amacına dair bir şey ya da herhangi bir şey yazabilirsin.
# author : "github kullanıcı adı"
# bu soruları birçok kez sorabilir her seferinde farklı dosyaları düzenlediği için.



# repoyu indir ve kuruluma başla
```console
git clone https://github.com/flechemano/simpleteaproject.git
```
```console
cd simpleteaproject
```
```console
chmod +x kurulum.sh
```

```console
. ./kurulum.sh
```
