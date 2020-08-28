import 'dart:convert';
import 'dart:typed_data';

import 'package:teronmobile/model/DonemModel.dart';
import 'package:teronmobile/model/PersonelModel.dart';
import 'package:teronmobile/model/SirketModel.dart';
import 'package:teronmobile/view/LoginScreen.dart';

class KullaniciSessionModel {
  DonemModel donem;
  PersonelModel personel;
  SirketModel sirket;
  String userPass;

  KullaniciSessionModel(
      PersonelModel personel, SirketModel sirket, DonemModel donem) {
    this.personel = personel;
    this.sirket = sirket;
    this.donem = donem;

    var codec = Latin1Codec();
    Uint8List list =
        codec.encode(getPersonel.getPerId + ":" + getPersonel.getSifre);
    userPass = base64.encode(list);
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
