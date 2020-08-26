import 'dart:convert';

import 'package:http/http.dart' as http;

class MusteriSiparisiRowModel {
  String barkod = "";
  String kodu = "";
  String adi = "";
  String renk = "";
  String beden = "";
  int miktar = 0;
  String paraBirimi = "TL";
  int fiyat = 0;

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

  Future<MusteriSiparisiRowModel> setData(String barkod) async {
    var url =
        'http://192.168.2.58:8080/ERPService/musterisiparisibarkod/specific?master_value=$barkod';
    var response = await http.get(Uri.encodeFull(url));

    print(url);

    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      return MusteriSiparisiRowModel.fromJson(jsonDecode);
    }
    return MusteriSiparisiRowModel();
  }

  MusteriSiparisiRowModel();

  MusteriSiparisiRowModel.fromJson(var json) {
    this.barkod = json['barkodu'];
    this.kodu = json['stokKodu'];
    this.adi = json['stokAdi'];
    this.renk = json['renkAdi'];
    this.beden = json['boyut1Adi'];
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
}
