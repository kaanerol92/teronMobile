import 'dart:convert';
import 'dart:typed_data';

import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/model/DonemModel.dart';
import 'package:teronmobile/model/PersonelModel.dart';
import 'package:teronmobile/model/SirketModel.dart';

class KullaniciSessionModel {
  DonemModel donem;
  PersonelModel personel;
  SirketModel sirket;
  String userPass;
  LoginInterface loginInterface;

  KullaniciSessionModel(LoginInterface loginInterface, PersonelModel personel, SirketModel sirket, DonemModel donem) {
    this.loginInterface = loginInterface;
    this.personel = personel;
    this.sirket = sirket;
    this.donem = donem;

    var codec = Utf8Codec();
    Uint8List list = codec.encode(getPersonel.getPerId + ":" + getPersonel.getSifre);
    userPass = base64.encode(list);
  }

  static Future<KullaniciSessionModel> futureGiris(LoginInterface loginInterface, String personel, String sifre, String sirket, String donem) async {
    var perId = personel.toString().trim();
    var sifreLink = sifre == null ? "" : sifre;
    KullaniciSessionModel ksm;
    ksm = null;
    await loginInterface.getHttpManager().httpGet("/ERPService/login/kullanici?personel_kodu=$perId&sifre=$sifreLink&donem_kodu=$donem&sirket_kodu=$sirket").then((value) {
      if (value != null) {
        String resp = Utf8Decoder().convert(value.bodyBytes);
        Map jsonDecode = json.decode(resp);
        var sirketMap = jsonDecode['sirket'];
        var donemMap = jsonDecode['donem'];
        var personelMap = jsonDecode['personel'];
        if (personelMap['recorded'] == true && donemMap['recorded'] == true && sirketMap['recorded'] == true) {
          var per = PersonelModel.fromJson(personelMap);
          var sirket = SirketModel.fromJson(sirketMap);
          var donem = DonemModel.fromJson(donemMap);
          ksm = KullaniciSessionModel(loginInterface, per, sirket, donem);
        }
      }
    });
    return ksm;
  }

  String get getUserPass => userPass;

  set setUserPass(String userPass) => this.userPass = userPass;

  DonemModel get getDonem => donem;

  set setDonem(DonemModel donem) => this.donem = donem;

  PersonelModel get getPersonel => personel;

  set setPersonel(PersonelModel personel) => this.personel = personel;

  SirketModel get getSirket => sirket;

  set setSirket(SirketModel sirket) => this.sirket = sirket;
}
