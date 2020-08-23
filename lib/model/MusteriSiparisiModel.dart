class MusteriSiparisiModel {
  DateTime siparisTarihi;
  DateTime terminTarihi;
  String cariKodu;
  String cariAdi;
  String sevkCariKodu;
  String sevkCariAdi;
  String depoKodu;
  String depoAdi;
  String musSipNo;
  String aciklama;

  MusteriSiparisiModel() {
    DateTime now = DateTime.now();
    this.siparisTarihi = now;
    this.terminTarihi = now;
    this.cariKodu = "";
    this.cariAdi = "";
    this.sevkCariKodu = "";
    this.sevkCariAdi = "";
    this.depoKodu = "";
    this.depoAdi = "";
    this.musSipNo = "";
    this.aciklama = "";
  }

  insert() {}

  DateTime get getSiparisTarihi => siparisTarihi;

  set setSiparisTarihi(DateTime siparisTarihi) =>
      this.siparisTarihi = siparisTarihi;

  DateTime get getTerminTarihi => terminTarihi;

  set setTerminTarihi(DateTime terminTarihi) =>
      this.terminTarihi = terminTarihi;

  String get getCariKodu => cariKodu;

  set setCariKodu(String cariKodu) => this.cariKodu = cariKodu;

  String get getCariAdi => cariAdi;

  set setCariAdi(String cariAdi) => this.cariAdi = cariAdi;

  String get getSevkCariKodu => sevkCariKodu;

  set setSevkCariKodu(String sevkCariKodu) => this.sevkCariKodu = sevkCariKodu;

  String get getSevkCariAdi => sevkCariAdi;

  set setSevkCariAdi(String sevkCariAdi) => this.sevkCariAdi = sevkCariAdi;

  String get getDepoKodu => depoKodu;

  set setDepoKodu(String depoKodu) => this.depoKodu = depoKodu;

  String get getDepoAdi => depoAdi;

  set setDepoAdi(String depoAdi) => this.depoAdi = depoAdi;

  String get getMusSipNo => musSipNo;

  set setMusSipNo(String musSipNo) => this.musSipNo = musSipNo;

  String get getAciklama => aciklama;

  set setAciklama(String aciklama) => this.aciklama = aciklama;
}
