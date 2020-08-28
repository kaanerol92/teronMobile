import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teronmobile/view/LoginScreen.dart';

class CariDepoAutoComp {
  static Future<List> getCariJson(String query) async {
    await Future.delayed(Duration(seconds: 1));

    String ip = LoginScreenView.ip;
    String port = LoginScreenView.port;

    var url =
        'http://$ip:$port/ERPService/cari/simple?constraint=$query&orderByCondition=cari_no&auto_complete=true';
    var response = await http.get(
      Uri.encodeFull(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Basic " + LoginScreenView.ksm.userPass,
        'SessionType': '0',
        'Sirket': LoginScreenView.ksm.getSirket.getKod,
        'DonemModel': LoginScreenView.ksm.getDonem.getKod
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

  static Future<List> getDepoJson(String query) async {
    await Future.delayed(Duration(seconds: 1));

    String ip = LoginScreenView.ip;
    String port = LoginScreenView.port;

    var url =
        'http://$ip:$port/ERPService/depo/simple?constraint=$query&orderByCondition=depo_kod&auto_complete=true';
    var response = await http.get(
      Uri.encodeFull(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Basic " + LoginScreenView.ksm.userPass,
        'SessionType': '0',
        'Sirket': LoginScreenView.ksm.getSirket.getKod,
        'DonemModel': LoginScreenView.ksm.getDonem.getKod
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
