import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teronmobile/command/LoadingScreenCommand.dart';

class LoadingScreen extends State<LoadingScreenCommand> {
  String message;

  LoadingScreen(String message) {
    this.message = message;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Center(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 0.5,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      message,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
