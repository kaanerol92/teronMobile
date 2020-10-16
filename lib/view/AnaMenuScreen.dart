import 'package:flutter/material.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/repository/TextRepository.dart';
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
    menuMap.putIfAbsent(TextRepository.getText(TextRepository.SIPARIS_ISLEMLERI), () => SiparisIslemleriMenuScreen(loginInterface));
    menuMap.putIfAbsent(TextRepository.getText(TextRepository.STOK_ISLEMLERI), () => StokIslemleriMenuScreen(loginInterface));
    return MainMenuScreen(menuMap, TextRepository.getText(TextRepository.ANA_MENU));
  }
}
