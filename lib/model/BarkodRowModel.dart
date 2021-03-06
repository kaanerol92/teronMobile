import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teronmobile/interface/LoginInterface.dart';

class BarkodRowModel {
  LoginInterface loginInterface;
  String barkod = "";
  String kodu = "";
  String adi = "";
  String renk = "";
  String beden = "";
  int miktar = 0;
  String paraBirimi = "TL";
  double fiyat = 0;
  double kur = 0;
  int musSipId;

  int stokRenkBoyutId;

  int stokId;
  int renkId;
  int boyut1Id;
  int lot;
  int lotAdeti;
  int headerKurType;
  DateTime headerTarih;

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

  BarkodRowModel(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
  }

  Future<List<BarkodRowModel>> setData(String barkod, var sipModel) async {
    String ip = loginInterface.getHttpManager().getIp;
    String port = loginInterface.getHttpManager().getPort;
    var url = 'http://$ip:$port/ERPService/musterisiparisibarkod/specific?master_value=$barkod';
    List<BarkodRowModel> list = List();
    await http.get(Uri.encodeFull(url)).then((value) async {
      print(url);
      if (value.statusCode == 200) {
        String resp = Utf8Decoder().convert(value.bodyBytes);
        List jsonDecode = json.decode(resp);
        int lotAdet = 0;
        for (var json in jsonDecode) {
          await BarkodRowModel(loginInterface).fromJson(loginInterface, json, sipModel).then((value) async {
            await value.fillFiyat(value, sipModel).then((value) {
              lotAdet += json['miktar'];
              list.add(value);
            });
          });
        }

        for (var i = 0; i < list.length; i++) {
          BarkodRowModel model = list[i];
          model.lotAdeti = lotAdet;
        }
      }
    });

    return list;
  }

  Map<String, String> toJson() {
    var map = Map<String, String>();
    map['stokId'] = this.stokId.toString();
    map['stokKodu'] = this.kodu;
    map['stokRenkBoyutId'] = this.stokRenkBoyutId.toString();
    map['boyut1Id'] = this.boyut1Id.toString();
    map['stokRenkBoyutId'] = this.stokRenkBoyutId.toString();
    map['renkId'] = this.renkId.toString();
    map['kur'] = this.kur.toString();
    map['paraBirimi'] = this.paraBirimi;
    map['planlananMiktar'] = this.miktar.toString();
    map['gecerliFiyat'] = this.fiyat.toString();
    map['musteriSipId'] = this.musSipId.toString();
    map['headerKurType'] = this.headerKurType.toString();
    map['headerTarih'] = this.headerTarih.toIso8601String();
    return map;
  }

  Future<BarkodRowModel> fromJson(LoginInterface loginInterface, var json, var sipModel) async {
    this.loginInterface = loginInterface;
    this.barkod = json['barkodu'];
    this.kodu = json['stokKodu'];
    this.adi = json['stokAdi'];
    this.renk = json['renkAdi'];
    this.beden = json['boyut1Adi'];
    this.stokId = json['stokId'];
    this.stokRenkBoyutId = json['stokRenkBoyutId'];
    this.boyut1Id = json['boyut1Id'];
    this.renkId = json['renkId'];
    this.kur = json['kur'];
    this.lot = json['lot'];
    if (json['miktar'] == 0) {
      this.miktar = 1;
    } else {
      this.miktar = json['miktar'];
    }

    return this;
  }

  Future<BarkodRowModel> fillFiyat(BarkodRowModel model, var sipModel) async {
    String whereClause = "cari=" + sipModel.getCariKodu + "&stokid=" + stokId.toString() + "&renkid=" + renkId.toString() + "&boyutid=" + boyut1Id.toString() + "&sirket=" + loginInterface.getKullaniciSession().getSirket.getKod;

    String ip = loginInterface.getHttpManager().getIp;
    String port = loginInterface.getHttpManager().getPort;

    var url = 'http://$ip:$port/ERPService/barkodluislem/specific_barkod?$whereClause';
    await http.get(Uri.encodeFull(url)).then((value) {
      if (value.statusCode == 200) {
        String resp = Utf8Decoder().convert(value.bodyBytes);
        var jsonDecode = json.decode(resp);
        model.setParaBirimi = jsonDecode['paraBirimi'];
        model.setFiyat = jsonDecode['gecerliFiyat'];
        model.kur = jsonDecode['kur'];
      }
    });

    print(url);

    return model;
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

  double get getFiyat => fiyat;

  int get getMusSipId => musSipId;

  set setMusSipId(int musSipId) => this.musSipId = musSipId;

  set setFiyat(double fiyat) => this.fiyat = fiyat;

  int get getStokRenkBoyutId => stokRenkBoyutId;

  set setStokRenkBoyutId(int stokRenkBoyutId) => this.stokRenkBoyutId = stokRenkBoyutId;
  int get getStokId => stokId;

  set setStokId(int stokId) => this.stokId = stokId;

  int get getRenkId => renkId;

  set setRenkId(int renkId) => this.renkId = renkId;

  int get getBoyut1Id => boyut1Id;

  set setBoyut1Id(int boyut1Id) => this.boyut1Id = boyut1Id;
}
