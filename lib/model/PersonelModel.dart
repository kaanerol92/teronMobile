class PersonelModel {
  String perId;
  String soyadi;
  String gorevi;
  String adi;
  String sifre;
  int aktif;
  String mailAdresi;
  String mailSifresi;
  String dilKodu;
  int uygulama;
  int kurAktarma;
  String mailKullaniciAdi;

  PersonelModel.fromJson(var json) {
    this.perId = json['perId'];
    this.soyadi = json['soyadi'];
    this.adi = json['adi'];
    this.sifre = json['sifre'];
  }

  String get getPerId => perId;

  set setPerId(String perId) => this.perId = perId;

  String get getSoyadi => soyadi;

  set setSoyadi(String soyadi) => this.soyadi = soyadi;

  String get getGorevi => gorevi;

  set setGorevi(String gorevi) => this.gorevi = gorevi;

  String get getAdi => adi;

  set setAdi(String adi) => this.adi = adi;

  String get getSifre => sifre;

  set setSifre(String sifre) => this.sifre = sifre;

  int get getAktif => aktif;

  set setAktif(int aktif) => this.aktif = aktif;

  String get getMailAdresi => mailAdresi;

  set setMailAdresi(String mailAdresi) => this.mailAdresi = mailAdresi;

  String get getMailSifresi => mailSifresi;

  set setMailSifresi(String mailSifresi) => this.mailSifresi = mailSifresi;

  String get getDilKodu => dilKodu;

  set setDilKodu(String dilKodu) => this.dilKodu = dilKodu;

  int get getUygulama => uygulama;

  set setUygulama(int uygulama) => this.uygulama = uygulama;

  int get getKurAktarma => kurAktarma;

  set setKurAktarma(int kurAktarma) => this.kurAktarma = kurAktarma;

  String get getMailKullaniciAdi => mailKullaniciAdi;

  set setMailKullaniciAdi(String mailKullaniciAdi) =>
      this.mailKullaniciAdi = mailKullaniciAdi;
}
