import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teronmobile/Utility/HttpManager.dart';
import 'package:teronmobile/command/LoadingScreenCommand.dart';
import 'package:teronmobile/command/LoginScreenCommand.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/model/DonemModel.dart';
import 'package:teronmobile/model/KullaniciSessionModel.dart';
import 'package:teronmobile/model/PersonelModel.dart';
import 'package:teronmobile/model/SirketModel.dart';
import 'package:teronmobile/view/MainMenuScreen.dart';
import 'package:teronmobile/view/SiparisIslemleriMenuScreen.dart';
import 'package:teronmobile/view/StokIslemleriMenuScreen.dart';

import 'AnaMenuScreen.dart';

class LoginScreenView extends State<LoginViewCommand> implements LoginInterface {
  KullaniciSessionModel ksm;
  List<DropdownMenuItem<String>> sirketList = new List();
  List<DropdownMenuItem<String>> donemList = new List();
  var selectedSirket;
  var selectedDonem;
  var perId;
  var sifre;
  bool sirketOk = false;
  bool donemOk = false;
  HttpManager httpManager = HttpManager();

  // LoginScreenView() {
  //   httpManager = HttpManager();
  // }

  void setSirket() async {
    await SirketModel.futureSirket(this).then((value) {
      setState(() {
        sirketList = value;
        print(sirketList);
        if (sirketList != null) {
          sirketOk = true;
          selectedSirket = sirketList.elementAt(0).value;
        }
      });
    });
  }

  void setDonem() async {
    await DonemModel.futureDonem(this).then((value) {
      setState(() {
        donemList = value;
        if (donemList != null) {
          donemOk = true;
          selectedDonem = donemList.elementAt(donemList.length - 1).value;
        }
      });
    });
  }

  void giris(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoadingScreenViewCommand("Giriş Yapılıyor");
    }));
    await KullaniciSessionModel.futureGiris(this, perId, sifre, selectedSirket, selectedDonem).then((value) {
      Navigator.pop(context);
      if (value == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
          children: [
            Icon(Icons.announcement),
            Padding(padding: EdgeInsets.all(20)),
            Text("Giriş Başarısız."),
          ],
        )));
      } else {
        //ANA MENU ACAN KISIM
        ksm = value;
        // Map menuMap = Map<String, dynamic>();
        // menuMap.putIfAbsent('Sipariş İşlemleri', () => SiparisIslemleriMenuScreen());
        // menuMap.putIfAbsent('Stok İşlemleri', () => StokIslemleriMenuScreen());
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AnaMenuScreen(this);
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(httpManager.getConnect);
    return (httpManager.getConnect) ? login() : ipLog();
  }

  Widget login() {
    if (sirketOk == false || donemOk == false) {
      setSirket();
      setDonem();
      return LoadingScreenViewCommand("Sistem Yükleniyor..");
    }

    return Scaffold(
      body: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Center(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Center(child: Text("TERON MOBILE")),
                  SizedBox(height: 80.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
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
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)))),
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
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)))),
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

  TextEditingController ipCont = TextEditingController();
  TextEditingController ipPortCont = TextEditingController();
  TextEditingController ipDisCont = TextEditingController();
  TextEditingController ipDisPortCont = TextEditingController();

  Widget ipLog() {
    return Scaffold(
      body: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Center(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Center(child: Text("TERON MOBILE - IP Ayarları")),
                  SizedBox(height: 80.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                      contentPadding: EdgeInsets.all(20),
                      labelText: 'İç Ip',
                      labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      filled: true,
                    ),
                    controller: ipCont,
                  ),
                  SizedBox(height: 24.0),
                  TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                        contentPadding: EdgeInsets.all(20),
                        labelText: 'İç Port',
                        filled: true,
                        labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      controller: ipPortCont),
                  SizedBox(height: 24.0),
                  TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                        contentPadding: EdgeInsets.all(20),
                        labelText: 'Dış Ip',
                        labelStyle: TextStyle(fontStyle: FontStyle.italic),
                        filled: true,
                      ),
                      controller: ipDisCont),
                  SizedBox(height: 24.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                      contentPadding: EdgeInsets.all(20),
                      labelText: 'Dış Port',
                      filled: true,
                      labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    controller: ipDisPortCont,
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
                        child: Text('Tamam'),
                        onPressed: () {
                          setState(() {
                            httpManager.setIcIp = ipCont.text;
                            httpManager.setIcPort = ipPortCont.text;
                            httpManager.setDisIp = ipDisCont.text;
                            httpManager.setDisPort = ipDisPortCont.text;
                            httpManager.checkConnection(context);
                          });
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

  @override
  HttpManager getHttpManager() {
    return httpManager;
  }

  @override
  KullaniciSessionModel getKullaniciSession() {
    return ksm;
  }
}
