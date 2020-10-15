import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpManager {
  String ip;
  String port;
  String icIp;
  String icPort;
  String disIp;
  String disPort;
  String httpUrl;
  bool connect = false;

  Future<Response> httpPost(String url) async {
    var uri = "$httpUrl$url";
    print(uri);
    var response = await http.post(Uri.encodeFull(uri));
    if (response.statusCode != 200) {
      return null;
    }
    print("POST status $response");
    return response;
  }

  Future<Response> httpGet(String url) async {
    var uri = "$httpUrl$url";
    print(uri);
    var response = await http.get(Uri.encodeFull(uri));
    if (response.statusCode != 200) {
      return null;
    }
    print("GET status $response");
    return response;
  }

  void checkConnection(BuildContext context) async {
    String icAdress = "$icIp";
    String disAdress = "$disIp";
    print(icAdress);
    print(disAdress);
    try {
      final result = await InternetAddress.lookup(icAdress).timeout(Duration(seconds: 10));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setIp = icIp;
        setPort = icPort;
        print(ip);
        print(port);
        setHttpUrl = "http://$ip:$port";
        setConnect = true;
        print(httpUrl);
      }
    } on SocketException catch (_) {
      try {
        final result = await InternetAddress.lookup(disAdress).timeout(Duration(seconds: 10));
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setIp = disIp;
          setPort = disPort;
          setHttpUrl = "http://$ip:$port";
          setConnect = true;
        }
      } on SocketException catch (_) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
          children: [
            Icon(Icons.announcement),
            Padding(padding: EdgeInsets.all(20)),
            Text("Bağlantı Kurulamadı."),
          ],
        )));
      }
    }
  }

  // static Future<bool> isInternetExist() async {
  //   try {
  //     await InternetAddress.lookup("$ip").timeout(Duration(seconds: 10)).then((value) {
  //       if (value.isNotEmpty && value[0].rawAddress.isNotEmpty) {
  //         return true;
  //       }
  //     });
  //   } on SocketException catch (_) {
  //     return false;
  //   }
  //   return false;
  // }

  bool get getConnect => connect;

  set setConnect(bool connect) => this.connect = connect;

  String get getIp => ip;

  set setIp(String ip) => this.ip = ip;

  String get getPort => port;

  set setPort(String port) => this.port = port;

  String get getIcIp => icIp;

  set setIcIp(String icIp) => this.icIp = icIp;

  String get getIcPort => icPort;

  set setIcPort(String icPort) => this.icPort = icPort;

  String get getDisIp => disIp;

  set setDisIp(String disIp) => this.disIp = disIp;

  String get getDisPort => disPort;

  set setDisPort(String disPort) => this.disPort = disPort;

  String get getHttpUrl => httpUrl;

  set setHttpUrl(String httpUrl) => this.httpUrl = httpUrl;
}
