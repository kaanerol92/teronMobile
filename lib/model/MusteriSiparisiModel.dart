import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/model/MusteriSiparisiRowModel.dart';
import 'package:teronmobile/view/LoginScreen.dart';

class MusteriSiparisiModel {
  LoginInterface loginInterface;
  int id;
  int cariId;
  int sevkCariId;
  int depoId;
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
  int sipNo;
  int kurType;

  MusteriSiparisiModel(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
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

  Future insert(List<MusteriSiparisiRowModel> satirlarModel) async {
    var map = Map<String, dynamic>();
    map['musteriSiparisNo'] = getMusSipNo;
    map['musteriCariKodu'] = getCariKodu;
    map['sevkCariKod'] = getSevkCariKodu;
    map['depoKodu'] = getDepoKodu;
    map['siparisTarihi'] = getSiparisTarihi.toIso8601String();
    map['terminTarihi'] = getTerminTarihi.toIso8601String();
    map['aciklama'] = getAciklama;
    map['perId'] = loginInterface.getKullaniciSession().getPersonel.getPerId;
    map['donemId'] = loginInterface.getKullaniciSession().getDonem.getKod;
    map['sirketId'] = loginInterface.getKullaniciSession().getSirket.getKod;

    String ip = loginInterface.getHttpManager().getIp;
    String port = loginInterface.getHttpManager().getPort;

    await http
        .post('http://$ip:$port/ERPService/musterisiparisi/insert',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': "Basic " + loginInterface.getKullaniciSession().userPass,
              'SessionType': '0',
              'Sirket': loginInterface.getKullaniciSession().getSirket.getKod,
              'DonemModel': loginInterface.getKullaniciSession().getDonem.getKod
            },
            body: jsonEncode(map))
        .then((http.Response response) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      id = jsonDecode['id'];
      cariId = jsonDecode['musteriCariId'];
      sevkCariId = jsonDecode['sevkCariId'];
      depoId = jsonDecode['depoId'];
      sipNo = jsonDecode['siparisNo'];
      kurType = jsonDecode['kurType'];
      insertRows(satirlarModel);
    });
  }

  insertRows(List<MusteriSiparisiRowModel> satirlarModel) {
    List<Map<String, String>> list = List();
    for (var i = 0; i < satirlarModel.length; i++) {
      MusteriSiparisiRowModel model = satirlarModel.elementAt(i);
      model.setMusSipId = this.id;
      model.headerKurType = this.kurType;
      model.headerTarih = this.siparisTarihi;
      list.add(model.toJson());
    }

    Map jsonMap = Map();
    jsonMap.putIfAbsent("rowList", () => list);

    String ip = loginInterface.getHttpManager().getIp;
    String port = loginInterface.getHttpManager().getPort;

    http
        .post('http://$ip:$port/ERPService/barkodservice/insertbarkod',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': "Basic " + loginInterface.getKullaniciSession().userPass,
              'SessionType': '0',
              'Sirket': loginInterface.getKullaniciSession().getSirket.getKod,
              'DonemModel': loginInterface.getKullaniciSession().getDonem.getKod
            },
            body: jsonEncode(jsonMap))
        .then((value) => print("Satırlar eklendi"));
  }

  int get getId => id;

  set setId(int cariKodu) => this.id = id;

  DateTime get getSiparisTarihi => siparisTarihi;

  set setSiparisTarihi(DateTime siparisTarihi) => this.siparisTarihi = siparisTarihi;

  DateTime get getTerminTarihi => terminTarihi;

  set setTerminTarihi(DateTime terminTarihi) => this.terminTarihi = terminTarihi;

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
