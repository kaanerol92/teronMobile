import 'package:flutter/material.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/view/MusteriSiparisiScreen.dart';

class MusteriSiparisiScreenCommand extends StatefulWidget {
  LoginInterface loginInterface;

  MusteriSiparisiScreenCommand(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
  }

  @override
  State<StatefulWidget> createState() {
    return MusteriSiparisiScreen(loginInterface);
  }
}
