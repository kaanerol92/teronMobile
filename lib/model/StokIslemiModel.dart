import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/model/BarkodRowModel.dart';
import 'package:teronmobile/view/LoginScreen.dart';

class StokIslemiModel {
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
  String girisDepoKodu;
  String girisDepoAdi;
  String cikisDepoKodu;
  String cikisDepoAdi;
  String paraBrm;
  String aciklama;
  int sipNo;
  int fisTip;
  int kurType;
  LoginInterface loginInterface;

  StokIslemiModel(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
    DateTime now = DateTime.now();
    this.siparisTarihi = now;
    this.terminTarihi = now;
    this.cariKodu = "";
    this.cariAdi = "";
    this.sevkCariKodu = "";
    this.sevkCariAdi = "";
    this.girisDepoKodu = "";
    this.girisDepoAdi = "";
    this.cikisDepoKodu = "";
    this.cikisDepoAdi = "";
    this.paraBrm = "TL";
    this.aciklama = "";
  }

  Future insert(List<BarkodRowModel> satirlarModel) async {
    var map = Map<String, dynamic>();
    map['fisTipi'] = fisTip.toString();
    map['paraBirimi'] = paraBrm;
    map['cariKodu'] = getCariKodu;
    map['sevkCariKodu'] = getSevkCariKodu;
    map['girisDepoKodu'] = girisDepoKodu;
    map['girisDepoAdi'] = girisDepoAdi;
    map['cikisDepoKodu'] = cikisDepoKodu;
    map['cikisDepoAdi'] = cikisDepoAdi;
    map['fisTarihi'] = getSiparisTarihi.toIso8601String();
    map['sevkTarihi'] = getTerminTarihi.toIso8601String();
    map['aciklama'] = getAciklama;
    print(girisDepoKodu);
    //map['perId'] = LoginScreenView.ksm.getPersonel.getPerId;
    //map['donemId'] = LoginScreenView.ksm.getDonem.getKod;
    //map['sirketId'] = LoginScreenView.ksm.getSirket.getKod;

    String ip = loginInterface.getHttpManager().getIp;
    String port = loginInterface.getHttpManager().getPort;

    await http
        .post('http://$ip:$port/ERPService/mamulstokfisi/insert',
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

      //cariId = jsonDecode['musteriCariId'];
      //sevkCariId = jsonDecode['sevkCariId'];
      //depoId = jsonDecode['depoId'];
      //fisTip = jsonDecode['fisTipi'];
      sipNo = jsonDecode['fisNo'];
      kurType = jsonDecode['kurType'];
      insertRows(satirlarModel);
    });
  }

  insertRows(List<BarkodRowModel> satirlarModel) {
    List<Map<String, String>> list = List();
    for (var i = 0; i < satirlarModel.length; i++) {
      BarkodRowModel model = satirlarModel.elementAt(i);
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
        .post('http://$ip:$port/ERPService/stokbarkodservice/insertbarkod',
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

  String get getGirisDepoKodu => girisDepoKodu;

  set setGirisDepoKodu(String girisDepoKodu) => this.girisDepoKodu = girisDepoKodu;

  String get getGirisDepoAdi => girisDepoAdi;

  set setGirisDepoAdi(String girisDepoAdi) => this.girisDepoAdi = girisDepoAdi;

  String get getParaBrm => paraBrm;

  set setParaBrm(String paraBrm) => this.paraBrm = paraBrm;

  String get getAciklama => aciklama;

  set setAciklama(String aciklama) => this.aciklama = aciklama;
}
