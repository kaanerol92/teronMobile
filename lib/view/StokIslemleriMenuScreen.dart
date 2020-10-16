import 'package:flutter/material.dart';
import 'package:teronmobile/command/StokIslemiScreenCommand.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/repository/TextRepository.dart';
import 'package:teronmobile/view/MainMenuScreen.dart';

class StokIslemleriMenuScreen extends StatelessWidget {
  LoginInterface loginInterface;

  StokIslemleriMenuScreen(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
  }

  @override
  Widget build(BuildContext context) {
    Map menuMap = Map<String, dynamic>();
    menuMap.putIfAbsent(TextRepository.getText(TextRepository.MAL_ALIM), () => StokIslemiScreenCommand(loginInterface, 1));
    menuMap.putIfAbsent(TextRepository.getText(TextRepository.TOPTAN_SATIS), () => StokIslemiScreenCommand(loginInterface, 30));
    menuMap.putIfAbsent(TextRepository.getText(TextRepository.PERAKENDE_SATIS), () => StokIslemiScreenCommand(loginInterface, 31));
    menuMap.putIfAbsent(TextRepository.getText(TextRepository.URETIM), () => StokIslemiScreenCommand(loginInterface, 10));
    return MainMenuScreen(menuMap, TextRepository.getText(TextRepository.STOK_ISLEMLERI));
  }
}
