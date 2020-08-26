import 'dart:convert';

import 'package:teronmobile/view/LoginScreen.dart';
import 'package:http/http.dart' as http;

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

  Future<http.Response> insert() {
    var map = Map<String, dynamic>();
    map['musteriSiparisNo'] = getMusSipNo;
    map['siparisTarihi'] = getSiparisTarihi.toIso8601String();
    map['terminTarihi'] = getTerminTarihi.toIso8601String();
    map['perId'] = LoginScreenView.ksm.getPersonel.getPerId;
    map['donemId'] = LoginScreenView.ksm.getDonem.getKod;
    map['sirketId'] = LoginScreenView.ksm.getSirket.getKod;

    return http.post(
        'http://192.168.2.58:8080/ERPService/musterisiparisi/insert',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(map));
  }

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
