import 'package:teronmobile/model/DonemModel.dart';
import 'package:teronmobile/model/PersonelModel.dart';
import 'package:teronmobile/model/SirketModel.dart';

class KullaniciSessionModel {
  DonemModel donem;
  PersonelModel personel;
  SirketModel sirket;

  KullaniciSessionModel(
      PersonelModel personel, SirketModel sirket, DonemModel donem) {
    this.personel = personel;
    this.sirket = sirket;
    this.donem = donem;
  }

  DonemModel get getDonem => donem;

  set setDonem(DonemModel donem) => this.donem = donem;

  PersonelModel get getPersonel => personel;

  set setPersonel(PersonelModel personel) => this.personel = personel;

  SirketModel get getSirket => sirket;

  set setSirket(SirketModel sirket) => this.sirket = sirket;
}
