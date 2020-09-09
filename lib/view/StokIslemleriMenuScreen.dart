import 'package:flutter/material.dart';
import 'package:teronmobile/command/StokIslemiScreenCommand.dart';
import 'package:teronmobile/view/MainMenuScreen.dart';

class StokIslemleriMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map menuMap = Map<String, dynamic>();
    menuMap.putIfAbsent('Mal Alım', () => StokIslemiScreenCommand(1));
    menuMap.putIfAbsent('Toptan Satış', () => StokIslemiScreenCommand(30));
    menuMap.putIfAbsent('Perakende Satış', () => StokIslemiScreenCommand(31));
    return MainMenuView(menuMap, "Stok İşlemleri");
  }
}
