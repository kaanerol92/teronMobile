import 'package:flutter/material.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/view/MainMenuScreen.dart';

import 'SiparisIslemleriMenuScreen.dart';
import 'StokIslemleriMenuScreen.dart';

class AnaMenuScreen extends StatelessWidget {
  LoginInterface loginInterface;

  AnaMenuScreen(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
  }

  @override
  Widget build(BuildContext context) {
    Map menuMap = Map<String, dynamic>();
    menuMap.putIfAbsent('Sipariş İşlemleri', () => SiparisIslemleriMenuScreen(loginInterface));
    menuMap.putIfAbsent('Stok İşlemleri', () => StokIslemleriMenuScreen(loginInterface));
    return MainMenuView(menuMap, "Ana Menü");
  }
}
