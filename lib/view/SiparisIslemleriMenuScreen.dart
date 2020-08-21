import 'package:flutter/material.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';
import 'package:teronmobile/view/MainMenuScreen.dart';

class SiparisIslemleriMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map menuMap = Map<String, dynamic>();
    menuMap.putIfAbsent(
        'Müşteri Siparişi', () => MusteriSiparisiScreenCommand());
    return MainMenuView(menuMap, "Sipariş İşlemleri");
  }
}
