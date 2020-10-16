import 'package:flutter/material.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/repository/TextRepository.dart';
import 'package:teronmobile/view/MainMenuScreen.dart';

class SiparisIslemleriMenuScreen extends StatelessWidget {
  LoginInterface loginInterface;
  SiparisIslemleriMenuScreen(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
  }

  @override
  Widget build(BuildContext context) {
    Map menuMap = Map<String, dynamic>();
    menuMap.putIfAbsent(TextRepository.getText(TextRepository.MUSTERI_SIPARISI), () => MusteriSiparisiScreenCommand(loginInterface));
    return MainMenuScreen(menuMap, TextRepository.getText(TextRepository.SIPARIS_ISLEMLERI));
  }
}
