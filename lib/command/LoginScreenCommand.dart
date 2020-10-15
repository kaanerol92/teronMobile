import 'package:flutter/material.dart';
import 'package:teronmobile/view/LoginScreen.dart';

class LoginViewCommand extends StatefulWidget {
  LoginScreenView lsv = LoginScreenView();

  LoginScreenView get getLsv => lsv;

  @override
  State<StatefulWidget> createState() {
    return lsv;
  }
}
