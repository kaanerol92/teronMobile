import 'package:flutter/material.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/view/StokIslemiScreen.dart';

// ignore: must_be_immutable
class StokIslemiScreenCommand extends StatefulWidget {
  int fisTipi;
  LoginInterface loginInterface;
  StokIslemiScreenCommand(LoginInterface loginInterface, int fisTipi) {
    this.loginInterface = loginInterface;
    this.fisTipi = fisTipi;
  }

  @override
  State<StatefulWidget> createState() {
    return StokIslemiScreen(loginInterface, fisTipi);
  }
}
