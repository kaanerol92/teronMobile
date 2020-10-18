import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teronmobile/command/LoadingScreenCommand.dart';
import 'package:teronmobile/interface/LoginInterface.dart';

abstract class BaseFisScreen extends State {
  LoginInterface loginInterface;
  bool isPBOk = false;
  List<DropdownMenuItem<String>> paraBirimiList = new List();
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;
  List<Step> steps;
  Map stepIndex;
  int currentStep = 0;
  bool complete = false;
  int maxStep = 0;
  String barkod;
  FocusNode barkodFocus;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String paraBrm;
  String selectedParaBirimi;
  final labelWidth = 120.0;
  // var label;

  BaseFisScreen(LoginInterface loginInterface) {
    this.loginInterface = loginInterface;
  }

  @override
  void initState() {
    super.initState();
    setParaBrm();
    stepIndex = {
      0: true,
      1: false,
      2: false
    };
    barkodFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    setSteps();
    return !isPBOk
        ? LoadingScreenCommand("Yükleniyor..")
        : WillPopScope(
            onWillPop: () => backPress(),
            child: Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomPadding: true,
              resizeToAvoidBottomInset: true,
              /*appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Müşteri Siparişi"),
          textTheme: Theme.of(context).textTheme,
          iconTheme: Theme.of(context).iconTheme,
        ),*/
              body: SafeArea(
                child: Builder(
                    builder: (context) => Stack(children: [
                          Stepper(
                              steps: steps,
                              physics: ClampingScrollPhysics(),
                              type: StepperType.horizontal,
                              currentStep: currentStep,
                              onStepCancel: () {
                                cancel(context);
                              },
                              onStepContinue: () {
                                next(context);
                              },
                              onStepTapped: (step) {
                                if (stepIndex[step] == true) {
                                  goTo(context, step);
                                }
                              },
                              controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                                _onStepCancel = onStepCancel;
                                _onStepContinue = onStepContinue;
                                return Column(children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                ]);
                              }),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: _bottomBar(),
                          )
                        ])),
              ),
            ),
          );
  }

  Widget _bottomBar() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        (currentStep != 0
            ? Container(
                margin: EdgeInsets.only(left: 10, bottom: 5),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () => _onStepCancel(),
                  child: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                ),
              )
            : SizedBox.shrink()),
        Container(
          margin: EdgeInsets.only(right: 10, bottom: 5),
          child: RaisedButton(
              color: currentStep == 2 ? Colors.green : Colors.blueAccent,
              onPressed: () => _onStepContinue(),
              child: currentStep == 2
                  ? Icon(
                      Icons.done,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    )),
        ),
      ]),
    );
  }

  Future<bool> backPress() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Çıkmak istediğinize emin misiniz?"),
              actions: [
                FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("Hayır")),
                FlatButton(onPressed: () => Navigator.pop(context, true), child: Text("Evet")),
              ],
            ));
  }

  Future<List> futureParaBirimi() async {
    paraBirimiList.clear();
    await loginInterface.getHttpManager().httpGet("/ERPService/parabirimi/list").then((value) {
      if (value.statusCode == 200) {
        String resp = Utf8Decoder().convert(value.bodyBytes);
        var jsonDecode = json.decode(resp);
        print(jsonDecode);
        for (var jsonPB in jsonDecode) {
          paraBirimiList.add(DropdownMenuItem(
            child: Text(jsonPB['paraBirimi']),
            value: jsonPB['paraBirimi'].toString(),
          ));
          if (selectedParaBirimi == null) {
            selectedParaBirimi = jsonPB['paraBirimi'].toString();
          }
        }
      }
    });
    return paraBirimiList;
  }

  void setParaBrm() {
    futureParaBirimi().then((value) {
      setState(() {
        paraBirimiList = value;
        if (paraBirimiList.length != 0) {
          isPBOk = true;
        }
      });
    });
  }

  setSteps();
  next(BuildContext context);
  cancel(BuildContext context);
  goTo(BuildContext context, int step);
}
