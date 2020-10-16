import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teronmobile/Utility/HttpManager.dart';
import 'package:teronmobile/command/LoadingScreenCommand.dart';
import 'package:teronmobile/command/LoginScreenCommand.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/model/DonemModel.dart';
import 'package:teronmobile/model/KullaniciSessionModel.dart';
import 'package:teronmobile/model/SirketModel.dart';
import 'package:teronmobile/repository/TextRepository.dart';

import 'AnaMenuScreen.dart';

class LoginScreenView extends State<LoginScreenCommand> implements LoginInterface {
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
  SharedPreferences prefs;
  bool dil;

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

  @override
  void initState() {
    super.initState();
    TextRepository.setTexts();
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
      return LoadingScreenCommand(TextRepository.getText(TextRepository.GIRIS_YAPILIYOR));
    }));
    await KullaniciSessionModel.futureGiris(this, perId, sifre, selectedSirket, selectedDonem).then((value) {
      Navigator.pop(context);
      if (value == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
          children: [
            Icon(Icons.announcement),
            Padding(padding: EdgeInsets.all(20)),
            Text(TextRepository.getText(TextRepository.GIRIS_BASARISIZ)),
          ],
        )));
      } else {
        //ANA MENU ACAN KISIM
        ksm = value;
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AnaMenuScreen(this);
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("HTTP CONNECT");
    print(httpManager.getConnect);
    return (httpManager.getConnect) ? login() : ipLog();
  }

  Widget login() {
    if (sirketOk == false || donemOk == false) {
      setSirket();
      setDonem();
      return LoadingScreenCommand(TextRepository.getText(TextRepository.SISTEM_YUKLENIYOR));
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
                  Center(child: Text(TextRepository.getText(TextRepository.MOBILE_TITLE))),
                  SizedBox(height: 80.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                      contentPadding: EdgeInsets.all(20),
                      labelText: TextRepository.getText(TextRepository.KULLANICI_ADI),
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
                      labelText: TextRepository.getText(TextRepository.SIFRE),
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
                          TextRepository.getText(TextRepository.SIRKET),
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
                          TextRepository.getText(TextRepository.DONEM),
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
                      Text("EN"),
                      Checkbox(
                          value: dil,
                          onChanged: (bool value) {
                            setState(() {
                              dil = value;
                              prefs.setBool("Dil", value);
                              if (dil) {
                                TextRepository.setEnTexts();
                              } else {
                                TextRepository.setTexts();
                              }
                            });
                          }),
                      FlatButton(
                        child: Text(TextRepository.getText(TextRepository.CIKIS)),
                        onPressed: () {
                          //SystemChannels.platform
                          //.invokeMethod('SystemNavigator.pop');
                          exit(1);
                        },
                      ),
                      FlatButton(
                        child: Text(TextRepository.getText(TextRepository.GIRIS)),
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

  getIpPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString("icIp") == null || prefs.getString("icPort") == null || prefs.getString("DisIp") == null || prefs.getString("DisPort") == null) {
      return;
    } else {
      setState(() {
        httpManager.setIcIp = prefs.getString("icIp");
        httpManager.setIcPort = prefs.getString("icPort");
        httpManager.setDisIp = prefs.getString("DisIp");
        httpManager.setDisPort = prefs.getString("DisPort");
        httpManager.checkConnection(context);
        if (prefs.getBool("Dil") != null) {
          setState(() {
            dil = prefs.getBool("Dil");
            if (prefs.getBool("Dil") == true) {
              TextRepository.setEnTexts();
            }
          });
        } else {
          setState(() {
            dil = false;
          });
        }
      });
    }
  }

  setIpPrefs(String key, var value) async {
    await prefs.setString(key, value);
  }

  Widget ipLog() {
    getIpPrefs();
    return Scaffold(
      body: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Center(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Center(child: Text(TextRepository.getText(TextRepository.MOBILE_TITLE) + " - " + TextRepository.getText(TextRepository.IP_AYARLARI))),
                  SizedBox(height: 80.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                      contentPadding: EdgeInsets.all(20),
                      labelText: TextRepository.getText(TextRepository.ICIP),
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
                        labelText: TextRepository.getText(TextRepository.ICPORT),
                        filled: true,
                        labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      controller: ipPortCont),
                  SizedBox(height: 24.0),
                  TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                        contentPadding: EdgeInsets.all(20),
                        labelText: TextRepository.getText(TextRepository.DISIP),
                        labelStyle: TextStyle(fontStyle: FontStyle.italic),
                        filled: true,
                      ),
                      controller: ipDisCont),
                  SizedBox(height: 24.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                      contentPadding: EdgeInsets.all(20),
                      labelText: TextRepository.getText(TextRepository.DISPORT),
                      filled: true,
                      labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    controller: ipDisPortCont,
                  ),
                  SizedBox(height: 24.0),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text(TextRepository.getText(TextRepository.CIKIS)),
                        onPressed: () {
                          exit(1);
                        },
                      ),
                      FlatButton(
                        child: Text(TextRepository.getText(TextRepository.TAMAM)),
                        onPressed: () {
                          setState(() {
                            setIpPrefs("icIp", ipCont.text);
                            setIpPrefs("icPort", ipPortCont.text);
                            setIpPrefs("DisIp", ipDisCont.text);
                            setIpPrefs("DisPort", ipDisPortCont.text);
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

  @override
  SharedPreferences getPrefs() {
    return prefs;
  }
}
