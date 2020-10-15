import 'package:flutter/material.dart';
import 'package:teronmobile/command/StokIslemiScreenCommand.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/view/MainMenuScreen.dart';

class StokIslemleriMenuScreen extends StatelessWidget {
  LoginInterface loginInterface;

  StokIslemleriMenuScreen(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
  }

  @override
  Widget build(BuildContext context) {
    Map menuMap = Map<String, dynamic>();
    menuMap.putIfAbsent('Mal Alım', () => StokIslemiScreenCommand(loginInterface, 1));
    menuMap.putIfAbsent('Toptan Satış', () => StokIslemiScreenCommand(loginInterface, 30));
    menuMap.putIfAbsent('Perakende Satış', () => StokIslemiScreenCommand(loginInterface, 31));
    return MainMenuView(menuMap, "Stok İşlemleri");
  }
}
