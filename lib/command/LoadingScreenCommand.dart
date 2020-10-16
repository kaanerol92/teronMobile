import 'package:flutter/material.dart';
import 'package:teronmobile/view/LoadingScreen.dart';

// ignore: must_be_immutable
class LoadingScreenCommand extends StatefulWidget {
  String message;
  LoadingScreenCommand(String message) {
    this.message = message;
  }
  @override
  State<StatefulWidget> createState() {
    return LoadingScreen(message);
  }
}
