import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teronmobile/command/LoadingScreenCommand.dart';
import 'package:teronmobile/command/LoginScreenCommand.dart';
import 'package:teronmobile/model/DonemModel.dart';
import 'package:teronmobile/model/KullaniciSessionModel.dart';
import 'package:teronmobile/model/PersonelModel.dart';
import 'package:teronmobile/model/SirketModel.dart';
import 'package:teronmobile/view/MainMenuScreen.dart';
import 'package:teronmobile/view/SiparisIslemleriMenuScreen.dart';

class LoginScreenView extends State<LoginViewCommand> {
  List<DropdownMenuItem<String>> sirketList = new List();
  List<DropdownMenuItem<String>> donemList = new List();
  var selectedSirket;
  var selectedDonem;
  var perId;
  var sifre;
  bool sirketOk = false;
  bool donemOk = false;

  Future<List> futureSirket() async {
    var url = "http://192.168.2.58:8080/ERPService/sirket/list";
    var response = await http.get(url);

    sirketList.clear();
    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      for (var jsonSirket in jsonDecode) {
        sirketList.add(DropdownMenuItem(
          child: Text(jsonSirket['kod'] + " - " + jsonSirket['adi']),
          value: jsonSirket['kod'].toString(),
        ));
        if (selectedSirket == null) {
          selectedSirket = jsonSirket['kod'].toString();
        }
      }
    }
    return sirketList;
  }

  void setSirket() {
    futureSirket().then((value) {
      setState(() {
        sirketList = value;
        sirketOk = true;
      });
    });
  }

  Future<List> futureDonem() async {
    var url = "http://192.168.2.58:8080/ERPService/donem/list";
    var response = await http.get(Uri.encodeFull(url));

    donemList.clear();
    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      for (var jsonDonem in jsonDecode) {
        donemList.add(DropdownMenuItem(
          child: Text(jsonDonem['kod'] + " - " + jsonDonem['adi']),
          value: jsonDonem['kod'].toString(),
        ));
        selectedDonem = jsonDonem['kod'].toString();
      }
    }
    return donemList;
  }

  void setDonem() {
    futureDonem().then((value) {
      setState(() {
        donemList = value;
        donemOk = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setSirket();
    setDonem();
  }

  void giris(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoadingScreenViewCommand("Giriş Yapılıyor");
    }));
    print("navi push");
    futureGiris(context).then((value) {
      Navigator.pop(context);
      if (value == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
          children: [
            Icon(Icons.announcement),
            Padding(padding: EdgeInsets.all(20)),
            Text("Giriş Başarısızç"),
          ],
        )));
      } else {
        Map menuMap = Map<String, dynamic>();
        menuMap.putIfAbsent(
            'Sipariş İşlemleri', () => SiparisIslemleriMenuScreen());
        menuMap.putIfAbsent('Stok İşlemleri',
            () => LoadingScreenViewCommand("Henüz Yükleniyor.."));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MainMenuView(menuMap, "Ana Menü");
        }));
      }
    });
  }

  Future<KullaniciSessionModel> futureGiris(BuildContext context) async {
    KullaniciSessionModel ksm;
    var personel = perId.toString().trim();
    var sifreLink = sifre == null ? "" : sifre;
    var url =
        "http://192.168.2.58:8080/ERPService/login/kullanici?personel_kodu=$personel&sifre=$sifreLink&donem_kodu=$selectedDonem&sirket_kodu=$selectedSirket";
    var response;
    try {
      response = await http.get(Uri.encodeFull(url));
    } catch (e) {
      print(e.toString());
      return ksm;
    }

    print(url);
    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      Map jsonDecode = json.decode(resp);
      var sirketMap = jsonDecode['sirket'];
      var donemMap = jsonDecode['donem'];
      var personelMap = jsonDecode['personel'];
      if (personelMap['recorded'] == true &&
          donemMap['recorded'] == true &&
          sirketMap['recorded'] == true) {
        var per = PersonelModel.fromJson(personelMap);
        var sirket = SirketModel.fromJson(sirketMap);
        var donem = DonemModel.fromJson(donemMap);
        ksm = KullaniciSessionModel(per, sirket, donem);
      }
    }
    return ksm;
  }

  @override
  Widget build(BuildContext context) {
    return (sirketOk == true && donemOk == true) ? login() : Scaffold();
  }

  Widget login() {
    return Scaffold(
      body: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Center(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Center(
                      child: Text("GURU SİSTEM YÖNETİMİ VE YAZILIMI - TERON")),
                  SizedBox(height: 80.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      contentPadding: EdgeInsets.all(20),
                      labelText: 'Kullanıcı Adı',
                      labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      filled: true,
                    ),
                    onChanged: (newText) {
                      perId = newText;
                    },
                  ),
                  SizedBox(height: 24.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      contentPadding: EdgeInsets.all(20),
                      labelText: 'Şifre',
                      filled: true,
                      labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    obscureText: true,
                    onChanged: (newText) {
                      sifre = newText;
                    },
                  ),
                  SizedBox(height: 24.0),
                  InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(
                          "Şirket",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        value: selectedSirket,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedSirket = newValue;
                          });
                        },
                        items: sirketList,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(
                          "Dönem",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        value: selectedDonem,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDonem = newValue;
                          });
                        },
                        items: donemList,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('Çıkış'),
                        onPressed: () {
                          //SystemChannels.platform
                          //.invokeMethod('SystemNavigator.pop');
                          exit(1);
                        },
                      ),
                      FlatButton(
                        child: Text('Giriş'),
                        onPressed: () {
                          giris(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
