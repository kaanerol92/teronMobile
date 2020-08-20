import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreen();
  }
}

class LoginScreen extends State<Login> {
  List<DropdownMenuItem<String>> sirketList = new List();
  List<DropdownMenuItem<String>> donemList = new List();
  var selectedSirket;
  var selectedDonem;

  Future<List> futureSirket() async {
    var url = "http://192.168.2.84:8080/ERPService/sirket/list";
    var response = await http.get(url);

    sirketList.clear();
    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      for (var jsonSirket in jsonDecode) {
        sirketList.add(DropdownMenuItem(
          child: Text(jsonSirket['kod'] + " - " + jsonSirket['adi']),
          value: Text(jsonSirket['kod']).toString(),
        ));
      }
    }
    return sirketList;
  }

  void setSirket() {
    futureSirket().then((value) {
      setState(() {
        sirketList = value;
      });
    });
  }

  Future<List> futureDonem() async {
    var url = "http://192.168.2.84:8080/ERPService/donem/list";
    var response = await http.get(Uri.encodeFull(url));

    donemList.clear();
    if (response.statusCode == 200) {
      String resp = Utf8Decoder().convert(response.bodyBytes);
      var jsonDecode = json.decode(resp);
      for (var jsonDonem in jsonDecode) {
        donemList.add(DropdownMenuItem(
          child: Text(jsonDonem['kod'] + " - " + jsonDonem['adi']),
          value: Text(jsonDonem['kod']).toString(),
        ));
      }
    }
    return donemList;
  }

  void setDonem() {
    futureDonem().then((value) {
      setState(() {
        donemList = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setSirket();
    setDonem();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 80.0),
                Center(child: Text("GURU SİSTEM YÖNETİMİ VE YAZILIMI - TERON")),
                SizedBox(height: 80.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    contentPadding: EdgeInsets.all(20),
                    labelText: 'Kullanıcı Adı',
                    labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    filled: true,
                  ),
                ),
                SizedBox(height: 24.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    contentPadding: EdgeInsets.all(20),
                    labelText: 'Şifre',
                    filled: true,
                    labelStyle: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24.0),
                InputDecorator(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
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
                          borderRadius: BorderRadius.circular(20.0))),
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
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                    ),
                    FlatButton(
                      child: Text('Giriş'),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
