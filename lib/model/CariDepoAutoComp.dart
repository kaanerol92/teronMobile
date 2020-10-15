import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/view/LoginScreen.dart';

class CariDepoAutoComp {
  static Future<List> getCariJson(LoginInterface loginInterface, String query) async {
    await Future.delayed(Duration(seconds: 1));

    String ip = loginInterface.getHttpManager().getIp;
    String port = loginInterface.getHttpManager().getPort;

    var url = 'http://$ip:$port/ERPService/cari/simple?constraint=$query&orderByCondition=cari_no&auto_complete=true';
    var response = await http.get(
      Uri.encodeFull(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Basic " + loginInterface.getKullaniciSession().userPass,
        'SessionType': '0',
        'Sirket': loginInterface.getKullaniciSession().getSirket.getKod,
        'DonemModel': loginInterface.getKullaniciSession().getDonem.getKod
      },
    );

    print(url);

    List<Map<String, String>> liste = List();

    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      for (var json in jsonDecode) {
        Map<String, String> map = Map();
        map.putIfAbsent(json['kodu'], () => json['adi']);
        liste.add(map);
      }
    }

    return liste;
  }

  static Future<List> getDepoJson(LoginInterface loginInterface, String query) async {
    await Future.delayed(Duration(seconds: 1));

    String ip = loginInterface.getHttpManager().getIp;
    String port = loginInterface.getHttpManager().getPort;

    var url = 'http://$ip:$port/ERPService/depo/simple?constraint=$query&orderByCondition=depo_kod&auto_complete=true';
    var response = await http.get(
      Uri.encodeFull(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Basic " + loginInterface.getKullaniciSession().userPass,
        'SessionType': '0',
        'Sirket': loginInterface.getKullaniciSession().getSirket.getKod,
        'DonemModel': loginInterface.getKullaniciSession().getDonem.getKod
      },
    );

    print(url);

    List<Map<String, String>> liste = List();

    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      for (var json in jsonDecode) {
        Map<String, String> map = Map();
        map.putIfAbsent(json['kodu'], () => json['adi']);
        liste.add(map);
      }
    }

    return liste;
  }
}
