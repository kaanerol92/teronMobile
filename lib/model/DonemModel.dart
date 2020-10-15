import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teronmobile/interface/LoginInterface.dart';

class DonemModel {
  String kod;
  String adi;
  DateTime baslangicTarihi;
  DateTime bitisTarihi;
  DateTime kapaliBaslangicTarihi;
  DateTime kapaliBitisTarihi;

  DonemModel.fromJson(var json) {
    this.kod = json['kod'];
    this.adi = json['adi'];
  }

  static Future<List> futureDonem(LoginInterface loginInterface) async {
    List<DropdownMenuItem<String>> donemList = new List();
    await loginInterface.getHttpManager().httpGet("/ERPService/donem/list").then((value) {
      if (value != null) {
        String resp = Utf8Decoder().convert(value.bodyBytes);
        var jsonDecode = json.decode(resp);
        for (var jsonDonem in jsonDecode) {
          donemList.add(DropdownMenuItem(
            child: Text(jsonDonem['kod'] + " - " + jsonDonem['adi']),
            value: jsonDonem['kod'].toString(),
          ));
        }
      }
    });
    return donemList;
  }

  String get getKod => kod;

  set setKod(String kod) => this.kod = kod;

  String get getAdi => adi;

  set setAdi(String adi) => this.adi = adi;

  DateTime get getBaslangicTarihi => baslangicTarihi;

  set setBaslangicTarihi(DateTime baslangicTarihi) => this.baslangicTarihi = baslangicTarihi;

  DateTime get getBitisTarihi => bitisTarihi;

  set setBitisTarihi(DateTime bitisTarihi) => this.bitisTarihi = bitisTarihi;

  DateTime get getKapaliBaslangicTarihi => kapaliBaslangicTarihi;

  set setKapaliBaslangicTarihi(DateTime kapaliBaslangicTarihi) => this.kapaliBaslangicTarihi = kapaliBaslangicTarihi;

  DateTime get getKapaliBitisTarihi => kapaliBitisTarihi;

  set setKapaliBitisTarihi(DateTime kapaliBitisTarihi) => this.kapaliBitisTarihi = kapaliBitisTarihi;
}
