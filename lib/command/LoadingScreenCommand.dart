import 'package:flutter/material.dart';
import 'package:teronmobile/view/LoadingScreen.dart';

// ignore: must_be_immutable
class LoadingScreenViewCommand extends StatefulWidget {
  String message;
  LoadingScreenViewCommand(String message) {
    this.message = message;
  }
  @override
  State<StatefulWidget> createState() {
    return LoadingScreenView(message);
  }
}
