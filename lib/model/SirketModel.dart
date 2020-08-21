class SirketModel {
  String kod;
  String sifre;
  String adi;
  String adres1;
  String adres2;
  String ilce;
  String il;
  String postaKodu;
  String tel;
  String fax;
  String internet;
  String vergiDairesi;
  String vergiNo;
  String mahalle;
  String semt;
  String cadde;
  String sokak;
  String kapiNo;
  String daireNo;
  String turu;
  String faaliyet;
  DateTime donemBasi;
  DateTime donemSonu;
  String kasaHesabi;
  String hesapDelimiter;
  int syNo;
  double syBorc;
  double syAlacak;
  DateTime syTarih;
  int miktar;
  String fthsp1;
  String fthsp2;
  String fthsp3;
  String fthsp4;
  String fthsp5;
  String fthsp6;
  String fthsp7;
  String fthsp8;
  String fthsp9;
  String fthsp10;
  String fthsp11;
  String fthsp12;
  String fthsp13;
  String fthsp14;
  String fthsp15;
  String fthsp16;
  String fthsp17;
  String fthsp18;
  String fthsp19;
  String fthsp20;
  String cshsp1;
  String cshsp2;
  String cshsp3;
  String cshsp4;
  String cshsp5;
  String cshsp6;
  String cshsp7;
  String cshsp8;
  String cshsp9;
  String cshsp10;
  String cariHsp1;
  String cariHsp2;
  String stokHsp1;
  String stokHsp2;
  String stokHsp3;
  String stokHsp4;
  String stokHsp5;
  String stokHsp6;
  String stokHsp7;
  String stokHsp8;
  String stokHsp9;
  String stokHsp10;
  String stokHsp11;
  String stokHsp12;
  String stokHsp13;
  String stokHsp14;
  String stokHsp15;
  String bnkhsp1;
  String bnkhsp2;
  String bnkhsp3;
  String bnkhsp4;
  String bnkhsp5;
  String email;
  String mersisNo;
  String ticariSicilNo;
  String akdv1;
  String akdv2;
  String akdv3;
  String akdv4;
  String akdv5;
  String akdv6;
  String akdv7;
  String akdv8;
  String akdv9;
  String akdv10;
  String skdv1;
  String skdv2;
  String skdv3;
  String skdv4;
  String skdv5;
  String skdv6;
  String skdv7;
  String skdv8;
  String skdv9;
  String tckn;
  String eFaturaKullaniciAdi;
  String eFaturaKullaniciSifresi;
  String eFaturaUserLoginLink;
  String eFaturaConnectorLink;
  String sermaye;

  SirketModel.fromJson(var json) {
    this.kod = json['kod'];
    this.adi = json['adi'];
  }

  String get getKod => kod;

  set setKod(String kod) => this.kod = kod;

  String get getSifre => sifre;

  set setSifre(String sifre) => this.sifre = sifre;

  String get getAdi => adi;

  set setAdi(String adi) => this.adi = adi;

  String get getAdres1 => adres1;

  set setAdres1(String adres1) => this.adres1 = adres1;

  String get getAdres2 => adres2;

  set setAdres2(String adres2) => this.adres2 = adres2;

  String get getIlce => ilce;

  set setIlce(String ilce) => this.ilce = ilce;

  String get getIl => il;

  set setIl(String il) => this.il = il;

  String get getPostaKodu => postaKodu;

  set setPostaKodu(String postaKodu) => this.postaKodu = postaKodu;

  String get getTel => tel;

  set setTel(String tel) => this.tel = tel;

  String get getFax => fax;

  set setFax(String fax) => this.fax = fax;

  String get getInternet => internet;

  set setInternet(String internet) => this.internet = internet;

  String get getVergiDairesi => vergiDairesi;

  set setVergiDairesi(String vergiDairesi) => this.vergiDairesi = vergiDairesi;

  String get getVergiNo => vergiNo;

  set setVergiNo(String vergiNo) => this.vergiNo = vergiNo;

  String get getMahalle => mahalle;

  set setMahalle(String mahalle) => this.mahalle = mahalle;

  String get getSemt => semt;

  set setSemt(String semt) => this.semt = semt;

  String get getCadde => cadde;

  set setCadde(String cadde) => this.cadde = cadde;

  String get getSokak => sokak;

  set setSokak(String sokak) => this.sokak = sokak;

  String get getKapiNo => kapiNo;

  set setKapiNo(String kapiNo) => this.kapiNo = kapiNo;

  String get getDaireNo => daireNo;

  set setDaireNo(String daireNo) => this.daireNo = daireNo;

  String get getTuru => turu;

  set setTuru(String turu) => this.turu = turu;

  String get getFaaliyet => faaliyet;

  set setFaaliyet(String faaliyet) => this.faaliyet = faaliyet;

  String get getKasaHesabi => kasaHesabi;

  set setKasaHesabi(String kasaHesabi) => this.kasaHesabi = kasaHesabi;

  String get getHesapDelimiter => hesapDelimiter;

  set setHesapDelimiter(String hesapDelimiter) =>
      this.hesapDelimiter = hesapDelimiter;

  int get getSyNo => syNo;

  set setSyNo(int syNo) => this.syNo = syNo;

  double get getSyBorc => syBorc;

  set setSyBorc(double syBorc) => this.syBorc = syBorc;

  double get getSyAlacak => syAlacak;

  set setSyAlacak(double syAlacak) => this.syAlacak = syAlacak;

  int get getMiktar => miktar;

  set setMiktar(int miktar) => this.miktar = miktar;

  String get getFthsp1 => fthsp1;

  set setFthsp1(String fthsp1) => this.fthsp1 = fthsp1;

  String get getFthsp2 => fthsp2;

  set setFthsp2(String fthsp2) => this.fthsp2 = fthsp2;

  String get getFthsp3 => fthsp3;

  set setFthsp3(String fthsp3) => this.fthsp3 = fthsp3;

  String get getFthsp4 => fthsp4;

  set setFthsp4(String fthsp4) => this.fthsp4 = fthsp4;

  String get getFthsp5 => fthsp5;

  set setFthsp5(String fthsp5) => this.fthsp5 = fthsp5;

  String get getFthsp6 => fthsp6;

  set setFthsp6(String fthsp6) => this.fthsp6 = fthsp6;

  String get getFthsp7 => fthsp7;

  set setFthsp7(String fthsp7) => this.fthsp7 = fthsp7;

  String get getFthsp8 => fthsp8;

  set setFthsp8(String fthsp8) => this.fthsp8 = fthsp8;

  String get getFthsp9 => fthsp9;

  set setFthsp9(String fthsp9) => this.fthsp9 = fthsp9;

  String get getFthsp10 => fthsp10;

  set setFthsp10(String fthsp10) => this.fthsp10 = fthsp10;

  String get getFthsp11 => fthsp11;

  set setFthsp11(String fthsp11) => this.fthsp11 = fthsp11;

  String get getFthsp12 => fthsp12;

  set setFthsp12(String fthsp12) => this.fthsp12 = fthsp12;

  String get getFthsp13 => fthsp13;

  set setFthsp13(String fthsp13) => this.fthsp13 = fthsp13;

  String get getFthsp14 => fthsp14;

  set setFthsp14(String fthsp14) => this.fthsp14 = fthsp14;

  String get getFthsp15 => fthsp15;

  set setFthsp15(String fthsp15) => this.fthsp15 = fthsp15;

  String get getFthsp16 => fthsp16;

  set setFthsp16(String fthsp16) => this.fthsp16 = fthsp16;

  String get getFthsp17 => fthsp17;

  set setFthsp17(String fthsp17) => this.fthsp17 = fthsp17;

  String get getFthsp18 => fthsp18;

  set setFthsp18(String fthsp18) => this.fthsp18 = fthsp18;

  String get getFthsp19 => fthsp19;

  set setFthsp19(String fthsp19) => this.fthsp19 = fthsp19;

  String get getFthsp20 => fthsp20;

  set setFthsp20(String fthsp20) => this.fthsp20 = fthsp20;

  String get getCshsp1 => cshsp1;

  set setCshsp1(String cshsp1) => this.cshsp1 = cshsp1;

  String get getCshsp2 => cshsp2;

  set setCshsp2(String cshsp2) => this.cshsp2 = cshsp2;

  String get getCshsp3 => cshsp3;

  set setCshsp3(String cshsp3) => this.cshsp3 = cshsp3;

  String get getCshsp4 => cshsp4;

  set setCshsp4(String cshsp4) => this.cshsp4 = cshsp4;

  String get getCshsp5 => cshsp5;

  set setCshsp5(String cshsp5) => this.cshsp5 = cshsp5;

  String get getCshsp6 => cshsp6;

  set setCshsp6(String cshsp6) => this.cshsp6 = cshsp6;

  String get getCshsp7 => cshsp7;

  set setCshsp7(String cshsp7) => this.cshsp7 = cshsp7;

  String get getCshsp8 => cshsp8;

  set setCshsp8(String cshsp8) => this.cshsp8 = cshsp8;

  String get getCshsp9 => cshsp9;

  set setCshsp9(String cshsp9) => this.cshsp9 = cshsp9;

  String get getCshsp10 => cshsp10;

  set setCshsp10(String cshsp10) => this.cshsp10 = cshsp10;

  String get getCariHsp1 => cariHsp1;

  set setCariHsp1(String cariHsp1) => this.cariHsp1 = cariHsp1;

  String get getCariHsp2 => cariHsp2;

  set setCariHsp2(String cariHsp2) => this.cariHsp2 = cariHsp2;

  String get getStokHsp1 => stokHsp1;

  set setStokHsp1(String stokHsp1) => this.stokHsp1 = stokHsp1;

  String get getStokHsp2 => stokHsp2;

  set setStokHsp2(String stokHsp2) => this.stokHsp2 = stokHsp2;

  String get getStokHsp3 => stokHsp3;

  set setStokHsp3(String stokHsp3) => this.stokHsp3 = stokHsp3;

  String get getStokHsp4 => stokHsp4;

  set setStokHsp4(String stokHsp4) => this.stokHsp4 = stokHsp4;

  String get getStokHsp5 => stokHsp5;

  set setStokHsp5(String stokHsp5) => this.stokHsp5 = stokHsp5;

  String get getStokHsp6 => stokHsp6;

  set setStokHsp6(String stokHsp6) => this.stokHsp6 = stokHsp6;

  String get getStokHsp7 => stokHsp7;

  set setStokHsp7(String stokHsp7) => this.stokHsp7 = stokHsp7;

  String get getStokHsp8 => stokHsp8;

  set setStokHsp8(String stokHsp8) => this.stokHsp8 = stokHsp8;

  String get getStokHsp9 => stokHsp9;

  set setStokHsp9(String stokHsp9) => this.stokHsp9 = stokHsp9;

  String get getStokHsp10 => stokHsp10;

  set setStokHsp10(String stokHsp10) => this.stokHsp10 = stokHsp10;

  String get getStokHsp11 => stokHsp11;

  set setStokHsp11(String stokHsp11) => this.stokHsp11 = stokHsp11;

  String get getStokHsp12 => stokHsp12;

  set setStokHsp12(String stokHsp12) => this.stokHsp12 = stokHsp12;

  String get getStokHsp13 => stokHsp13;

  set setStokHsp13(String stokHsp13) => this.stokHsp13 = stokHsp13;

  String get getStokHsp14 => stokHsp14;

  set setStokHsp14(String stokHsp14) => this.stokHsp14 = stokHsp14;

  String get getStokHsp15 => stokHsp15;

  set setStokHsp15(String stokHsp15) => this.stokHsp15 = stokHsp15;

  String get getBnkhsp1 => bnkhsp1;

  set setBnkhsp1(String bnkhsp1) => this.bnkhsp1 = bnkhsp1;

  String get getBnkhsp2 => bnkhsp2;

  set setBnkhsp2(String bnkhsp2) => this.bnkhsp2 = bnkhsp2;

  String get getBnkhsp3 => bnkhsp3;

  set setBnkhsp3(String bnkhsp3) => this.bnkhsp3 = bnkhsp3;

  String get getBnkhsp4 => bnkhsp4;

  set setBnkhsp4(String bnkhsp4) => this.bnkhsp4 = bnkhsp4;

  String get getBnkhsp5 => bnkhsp5;

  set setBnkhsp5(String bnkhsp5) => this.bnkhsp5 = bnkhsp5;

  String get getEmail => email;

  set setEmail(String email) => this.email = email;

  String get getMersisNo => mersisNo;

  set setMersisNo(String mersisNo) => this.mersisNo = mersisNo;

  String get getTicariSicilNo => ticariSicilNo;

  set setTicariSicilNo(String ticariSicilNo) =>
      this.ticariSicilNo = ticariSicilNo;

  String get getAkdv1 => akdv1;

  set setAkdv1(String akdv1) => this.akdv1 = akdv1;

  String get getAkdv2 => akdv2;

  set setAkdv2(String akdv2) => this.akdv2 = akdv2;

  String get getAkdv3 => akdv3;

  set setAkdv3(String akdv3) => this.akdv3 = akdv3;

  String get getAkdv4 => akdv4;

  set setAkdv4(String akdv4) => this.akdv4 = akdv4;

  String get getAkdv5 => akdv5;

  set setAkdv5(String akdv5) => this.akdv5 = akdv5;

  String get getAkdv6 => akdv6;

  set setAkdv6(String akdv6) => this.akdv6 = akdv6;

  String get getAkdv7 => akdv7;

  set setAkdv7(String akdv7) => this.akdv7 = akdv7;

  String get getAkdv8 => akdv8;

  set setAkdv8(String akdv8) => this.akdv8 = akdv8;

  String get getAkdv9 => akdv9;

  set setAkdv9(String akdv9) => this.akdv9 = akdv9;

  String get getAkdv10 => akdv10;

  set setAkdv10(String akdv10) => this.akdv10 = akdv10;

  String get getSkdv1 => skdv1;

  set setSkdv1(String skdv1) => this.skdv1 = skdv1;

  String get getSkdv2 => skdv2;

  set setSkdv2(String skdv2) => this.skdv2 = skdv2;

  String get getSkdv3 => skdv3;

  set setSkdv3(String skdv3) => this.skdv3 = skdv3;

  String get getSkdv4 => skdv4;

  set setSkdv4(String skdv4) => this.skdv4 = skdv4;

  String get getSkdv5 => skdv5;

  set setSkdv5(String skdv5) => this.skdv5 = skdv5;

  String get getSkdv6 => skdv6;

  set setSkdv6(String skdv6) => this.skdv6 = skdv6;

  String get getSkdv7 => skdv7;

  set setSkdv7(String skdv7) => this.skdv7 = skdv7;

  String get getSkdv8 => skdv8;

  set setSkdv8(String skdv8) => this.skdv8 = skdv8;

  String get getSkdv9 => skdv9;

  set setSkdv9(String skdv9) => this.skdv9 = skdv9;

  String get getTckn => tckn;

  set setTckn(String tckn) => this.tckn = tckn;

  String get getEFaturaKullaniciAdi => eFaturaKullaniciAdi;

  set setEFaturaKullaniciAdi(String eFaturaKullaniciAdi) =>
      this.eFaturaKullaniciAdi = eFaturaKullaniciAdi;

  String get getEFaturaKullaniciSifresi => eFaturaKullaniciSifresi;

  set setEFaturaKullaniciSifresi(String eFaturaKullaniciSifresi) =>
      this.eFaturaKullaniciSifresi = eFaturaKullaniciSifresi;

  String get getEFaturaUserLoginLink => eFaturaUserLoginLink;

  set setEFaturaUserLoginLink(String eFaturaUserLoginLink) =>
      this.eFaturaUserLoginLink = eFaturaUserLoginLink;

  String get getEFaturaConnectorLink => eFaturaConnectorLink;

  set setEFaturaConnectorLink(String eFaturaConnectorLink) =>
      this.eFaturaConnectorLink = eFaturaConnectorLink;

  String get getSermaye => sermaye;

  set setSermaye(String sermaye) => this.sermaye = sermaye;
}
