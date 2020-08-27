import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teronmobile/model/MusteriSiparisiModel.dart';
import 'package:teronmobile/view/LoginScreen.dart';

class MusteriSiparisiRowModel {
  String barkod = "";
  String kodu = "";
  String adi = "";
  String renk = "";
  String beden = "";
  int miktar = 0;
  String paraBirimi = "TL";
  int fiyat = 0;

  int stokRenkBoyutId;

  int stokId;
  int renkId;
  int boyut1Id;

  /*Future<http.Response> insert() {
    var map = Map<String, dynamic>();
    map['master'] = getMusSipNo;
    map['siparisTarihi'] = getSiparisTarihi.toIso8601String();
    map['terminTarihi'] = getTerminTarihi.toIso8601String();
    map['perId'] = LoginScreenView.ksm.getPersonel.getPerId;
    map['donemId'] = LoginScreenView.ksm.getDonem.getKod;
    map['sirketId'] = LoginScreenView.ksm.getSirket.getKod;

    return http.post(
        'http://192.168.2.58:8080/ERPService/musterisiparisibarkod/specific?master_value=',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(map));
  }*/

  Future<MusteriSiparisiRowModel> setData(
      String barkod, MusteriSiparisiModel sipModel) async {
    var url =
        'http://192.168.2.58:8080/ERPService/musterisiparisibarkod/specific?master_value=$barkod';
    var response = await http.get(Uri.encodeFull(url));

    print(url);

    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      return MusteriSiparisiRowModel.fromJson(jsonDecode, sipModel);
    }
    return MusteriSiparisiRowModel();
  }

  MusteriSiparisiRowModel();

  MusteriSiparisiRowModel.fromJson(var json, MusteriSiparisiModel sipModel) {
    this.barkod = json['barkodu'];
    this.kodu = json['stokKodu'];
    this.adi = json['stokAdi'];
    this.renk = json['renkAdi'];
    this.beden = json['boyut1Adi'];
    this.stokId = json['stokId'];
    this.stokRenkBoyutId = json['stokRenkBoyutId'];
    this.boyut1Id = json['boyut1Id'];
    this.renkId = json['renkId'];
    this.miktar = 1;

    fillFiyat(sipModel);
  }

  Future fillFiyat(MusteriSiparisiModel sipModel) async {
    String whereClause = "cari=" +
        sipModel.getCariKodu +
        "&stokid=" +
        stokId.toString() +
        "&renkid=" +
        renkId.toString() +
        "&boyutid=" +
        boyut1Id.toString() +
        "&sirket=" +
        LoginScreenView.ksm.getSirket.getKod;

    var url =
        'http://192.168.2.58:8080/ERPService/barkodluislem/specific_barkod?$whereClause';
    var response = await http.get(Uri.encodeFull(url));

    print(url);

    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      print(jsonDecode);
    }

    return null;
  }

  String get getBarkod => barkod;

  set setBarkod(String barkod) => this.barkod = barkod;

  String get getKodu => kodu;

  set setKodu(String kodu) => this.kodu = kodu;

  String get getAdi => adi;

  set setAdi(String adi) => this.adi = adi;

  String get getRenk => renk;

  set setRenk(String renk) => this.renk = renk;

  String get getBeden => beden;

  set setBeden(String beden) => this.beden = beden;

  int get getMiktar => miktar;

  set setMiktar(int miktar) => this.miktar = miktar;

  String get getParaBirimi => paraBirimi;

  set setParaBirimi(String paraBirimi) => this.paraBirimi = paraBirimi;

  int get getFiyat => fiyat;

  set setFiyat(int fiyat) => this.fiyat = fiyat;

  int get getStokRenkBoyutId => stokRenkBoyutId;

  set setStokRenkBoyutId(int stokRenkBoyutId) =>
      this.stokRenkBoyutId = stokRenkBoyutId;
  int get getStokId => stokId;

  set setStokId(int stokId) => this.stokId = stokId;

  int get getRenkId => renkId;

  set setRenkId(int renkId) => this.renkId = renkId;

  int get getBoyut1Id => boyut1Id;

  set setBoyut1Id(int boyut1Id) => this.boyut1Id = boyut1Id;
}
