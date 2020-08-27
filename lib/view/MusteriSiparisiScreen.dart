import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';
import 'package:teronmobile/model/MusteriSiparisiModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teronmobile/model/MusteriSiparisiRowModel.dart';
//import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:teronmobile/view/LoginScreen.dart';

class MusteriSiparisiScreen extends State<MusteriSiparisiScreenCommand> {
  final labelWidth = 120.0;
  var label;
  MusteriSiparisiModel model;
  List<Step> steps;
  Map stepIndex;
  int currentStep = 0;
  bool complete = false;
  int maxStep = 0;
  bool cariRed = false;
  bool sevkRed = false;
  bool depoRed = false;
  String barkod;
  FocusNode barkodFocus;
  List<MusteriSiparisiRowModel> satirlarModel = List();

  TextEditingController sipTarihController = TextEditingController();
  TextEditingController terminTarihController = TextEditingController();
  TextEditingController cariKoduController = TextEditingController();
  TextEditingController cariAdiController = TextEditingController();
  TextEditingController sevkCariKoduController = TextEditingController();
  TextEditingController sevkCariAdiController = TextEditingController();
  TextEditingController depoKoduController = TextEditingController();
  TextEditingController depoAdiController = TextEditingController();
  TextEditingController musSipNoController = TextEditingController();
  TextEditingController aciklamaController = TextEditingController();
  TextEditingController barkodController = TextEditingController();
  TextEditingController ozetCariKoduController = TextEditingController();
  TextEditingController ozetCariAdiController = TextEditingController();
  TextEditingController ozetToplamMiktarController = TextEditingController();
  TextEditingController ozetToplamFiyatController = TextEditingController();

  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  Widget _bottomBar() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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
                  color: Colors.blueAccent,
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

  @override
  Widget build(BuildContext context) {
    setSteps();
    return WillPopScope(
      onWillPop: () => backPress(),
      child: Scaffold(
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
                        controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) {
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

  @override
  void initState() {
    super.initState();
    stepIndex = {0: true, 1: false, 2: false};
    model = MusteriSiparisiModel();
    sipTarihController.text =
        "${model.getSiparisTarihi.day.toString().padLeft(2, '0')}-${model.getSiparisTarihi.month.toString().padLeft(2, '0')}-${model.getSiparisTarihi.year.toString()}";
    terminTarihController.text =
        "${model.getTerminTarihi.day.toString().padLeft(2, '0')}-${model.getTerminTarihi.month.toString().padLeft(2, '0')}-${model.getTerminTarihi.year.toString()}";

    cariKoduController.text = model.getCariKodu;
    cariAdiController.text = model.getCariAdi;
    sevkCariKoduController.text = model.getSevkCariKodu;
    sevkCariAdiController.text = model.getSevkCariAdi;
    depoKoduController.text = model.getDepoKodu;
    depoAdiController.text = model.getDepoAdi;
    musSipNoController.text = model.getMusSipNo;
    aciklamaController.text = model.getAciklama;
    barkodFocus = FocusNode();
  }

  Future<bool> backPress() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Çıkmak istediğinize emin misadminiz?"),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("Hayır")),
                FlatButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Evet")),
              ],
            ));
  }

  next(BuildContext context) {
    print(currentStep);
    print(steps.length);
    currentStep + 1 != steps.length
        ? goTo(context, currentStep + 1)
        : setState(() {
            complete = true;
            model.insert();
            print("kayıt");
            Navigator.popAndPushNamed(context, '/musterisiparisi');
          });
  }

  cancel(BuildContext context) {
    if (currentStep > 0) {
      goTo(context, currentStep - 1);
    }
  }

  goTo(BuildContext context, int step) {
    if (currentStep == 0) {
      bool ret = false;
      setState(() {
        cariRed = false;
        sevkRed = false;
        depoRed = false;
      });
      if (cariKoduController.text == null || cariKoduController.text == "") {
        setState(() {
          ret = true;
          cariRed = true;
        });
      }
      if (sevkCariKoduController.text == null ||
          sevkCariKoduController.text == "") {
        setState(() {
          ret = true;
          sevkRed = true;
        });
      }
      if (depoKoduController.text == null || depoKoduController.text == "") {
        setState(() {
          ret = true;
          depoRed = true;
        });
      }

      if (ret == true) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
          children: [
            Icon(Icons.announcement),
            Padding(padding: EdgeInsets.all(20)),
            Text("Lütfen eksik alanları doldurun."),
          ],
        )));
        return;
      }
    }
    if (step == 2) {
      setOzet();
    }
    setState(() {
      currentStep = step;
      stepIndex[step] = true;
      if (currentStep > maxStep) {
        maxStep = currentStep;
      }
    });
  }

  setSteps() {
    steps = [
      Step(
        title: const Text('Başlık Bilgileri'),
        isActive: stepIndex[0],
        state: maxStep > 0 ? StepState.complete : StepState.editing,
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Container(child: Text("Sipariş Tarihi"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 150,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: true,
                        controller: sipTarihController,
                        onTap: () {
                          showDatePicker(
                                  locale: const Locale('tr'),
                                  context: context,
                                  initialDate: model.getSiparisTarihi,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2030))
                              .then((value) {
                            if (value != null) {
                              model.setSiparisTarihi = value;
                              sipTarihController.text =
                                  "${model.getSiparisTarihi.day.toString().padLeft(2, '0')}-${model.getSiparisTarihi.month.toString().padLeft(2, '0')}-${model.getSiparisTarihi.year.toString()}";
                            }
                          });
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Termin Tarihi"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 150,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: true,
                        controller: terminTarihController,
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: model.getTerminTarihi,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2030))
                              .then((value) {
                            if (value != null) {
                              model.setTerminTarihi = value;
                              terminTarihController.text =
                                  "${model.getTerminTarihi.day.toString().padLeft(2, '0')}-${model.getTerminTarihi.month.toString().padLeft(2, '0')}-${model.getTerminTarihi.year.toString()}";
                            }
                          });
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Cari Kodu"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 200,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: cariRed == true
                                    ? BorderSide(color: Colors.red, width: 2)
                                    : BorderSide(width: 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: false,
                        controller: cariKoduController,
                        onChanged: (newText) {
                          if (newText != null) {
                            model.setCariKodu = newText;
                            sevkCariKoduController.text = newText;
                            model.setSevkCariKodu = newText;
                          }
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Cari Adı"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 200,
                      height: 35,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.yellow[100],
                            filled: true,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: true,
                        controller: cariAdiController,
                        onChanged: (newText) {
                          if (newText != null) {
                            model.setCariAdi = newText;
                          }
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Sevk Cari Kodu"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 200,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: sevkRed == true
                                    ? BorderSide(color: Colors.red, width: 2)
                                    : BorderSide(width: 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: false,
                        controller: sevkCariKoduController,
                        onChanged: (newText) {
                          if (newText != null) {
                            model.setSevkCariKodu = newText;
                          }
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Sevk Cari Adı"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 200,
                      height: 35,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.yellow[100],
                            filled: true,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: true,
                        controller: sevkCariAdiController,
                        onChanged: (newText) {
                          if (newText != null) {
                            model.setSevkCariAdi = newText;
                          }
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Depo Kodu"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 200,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: depoRed == true
                                    ? BorderSide(color: Colors.red, width: 2)
                                    : BorderSide(width: 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: false,
                        controller: depoKoduController,
                        onChanged: (newText) {
                          if (newText != null) {
                            model.setDepoKodu = newText;
                          }
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Depo Adı"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 200,
                      height: 35,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.yellow[100],
                            filled: true,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: true,
                        controller: depoAdiController,
                        onChanged: (newText) {
                          if (newText != null) {
                            model.setDepoAdi = newText;
                          }
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                      child: Text("Müşteri Sipariş No"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 150,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: false,
                        controller: musSipNoController,
                        onChanged: (newText) {
                          if (newText != null) {
                            model.setMusSipNo = newText;
                          }
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Açıklama"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 200,
                      child: TextField(
                        maxLines: 2,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: false,
                        controller: aciklamaController,
                        onChanged: (newText) {
                          if (newText != null) {
                            model.setAciklama = newText;
                          }
                        },
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        isActive: stepIndex[1],
        state: maxStep > 1
            ? StepState.complete
            : maxStep == 1 ? StepState.editing : StepState.indexed,
        title: const Text('Detay Bilgileri'),
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: Text("Barkod"), width: 50),
                Padding(padding: EdgeInsets.only(right: 10)),
                Expanded(
                  child: Container(
                      width: 300,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: false,
                        controller: barkodController,
                        focusNode: barkodFocus,
                        onSubmitted: (value) {
                          MusteriSiparisiRowModel satirModel =
                              MusteriSiparisiRowModel();
                          satirModel.setData(value, model).then((sonModel) {
                            setState(() {
                              barkod = value;
                              barkodFocus.requestFocus();
                              barkodController.selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: barkodController.text.length);

                              satirModel = sonModel;
                              bool add = true;
                              for (var i = 0; i < satirlarModel.length; i++) {
                                MusteriSiparisiRowModel m = satirlarModel[i];
                                if (m.barkod == satirModel.barkod) {
                                  m.setMiktar = m.getMiktar + 1;
                                  add = false;
                                  print("deneme");
                                }
                              }
                              if (add == true) {
                                satirlarModel.add(satirModel);
                                print("deneme");
                              }
                            });
                          });
                        },
                      )),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                              width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: ListView.builder(
                        //padding: EdgeInsets.all(10),
                        itemCount: satirlarModel.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>
                            slidableSatir(satirlarModel[index], index),
                      )),
                ),
              ],
            )
          ],
        )),
      ),
      Step(
        isActive: stepIndex[2],
        state: maxStep > 1 ? StepState.editing : StepState.indexed,
        title: const Text('Özet'),
        content: Column(
          children: <Widget>[
            Row(
              children: [
                Container(child: Text("Cari Kodu"), width: 100),
                Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                    width: 250,
                    height: 35,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.yellow[100],
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      textAlign: TextAlign.left,
                      readOnly: true,
                      controller: cariKoduController,
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(child: Text("Cari Adı"), width: 100),
                Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                    width: 250,
                    height: 35,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.yellow[100],
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      textAlign: TextAlign.left,
                      readOnly: true,
                      controller: ozetCariAdiController,
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                              width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView.builder(
                        //padding: EdgeInsets.all(10),
                        itemCount: satirlarModel.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>
                            table(satirlarModel[index], index),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(child: Text("Toplam Miktar"), width: 100),
                Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                    width: 100,
                    height: 35,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.yellow[100],
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      textAlign: TextAlign.right,
                      readOnly: true,
                      onChanged: (newText) {},
                      controller: ozetToplamMiktarController,
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(child: Text("Toplam Fiyat"), width: 100),
                Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                    width: 100,
                    height: 35,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.yellow[100],
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      textAlign: TextAlign.right,
                      readOnly: true,
                      onChanged: (newText) {},
                      controller: ozetToplamFiyatController,
                    )),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  void setOzet() {
    int toplam = 0;
    int fiyat = 0;
    for (var i = 0; i < satirlarModel.length; i++) {
      MusteriSiparisiRowModel model = satirlarModel[i];
      toplam += model.getMiktar;
      fiyat += model.getFiyat;
    }
    ozetCariKoduController.text = model.getCariKodu;
    ozetCariAdiController.text = model.getCariAdi;
    ozetToplamMiktarController.text = toplam.toString();
    ozetToplamFiyatController.text = fiyat.toString();
  }

//SILINCEK
  /*void setSatirlar() {
    MusteriSiparisiRowModel model = MusteriSiparisiRowModel();
    model.setBarkod = "123456789";
    model.setKodu = "Stok Kodu";
    model.setAdi = "Stok Adı";
    model.setRenk = "Kırmızı";
    model.setBeden = "XL";
    model.setParaBirimi = "TL";
    model.setFiyat = 20;
    model.setMiktar = 20;

    MusteriSiparisiRowModel model1 = MusteriSiparisiRowModel();
    model1.setBarkod = "asdasd";
    model1.setKodu = "zxc";
    model1.setAdi = "Stok Adı";
    model1.setRenk = "qwe";
    model1.setBeden = "XL";
    model1.setParaBirimi = "TL";
    model1.setFiyat = 40;
    model1.setMiktar = 40;

    MusteriSiparisiRowModel model2 = MusteriSiparisiRowModel();
    model2.setBarkod = "123456789";
    model2.setKodu = "Stok qwe";
    model2.setAdi = "Stok zxcczx";
    model2.setRenk = "Kırmızı";
    model2.setBeden = "SSS";
    model2.setParaBirimi = "QGB";
    model2.setFiyat = 60;
    model2.setMiktar = 60;

    satirlarModel.add(model);
    satirlarModel.add(model1);
    satirlarModel.add(model2);
  }*/

  Widget table(MusteriSiparisiRowModel model, index) {
    print(model.getBarkod);
    Color baslik = Colors.blueGrey;
    Color value = Colors.black;
    double baslikSize = 11;
    double valueSize = 15;
    return Table(
      key: UniqueKey(),
      /*border: TableBorder.symmetric(
          inside: BorderSide(color: Colors.black45, width: 0)),*/
      columnWidths: {
        0: FractionColumnWidth(.1),
        1: FractionColumnWidth(.4),
        2: FractionColumnWidth(.1),
        3: FractionColumnWidth(.2),
        4: FractionColumnWidth(.1),
        5: FractionColumnWidth(.1),
      },
      children: [
        TableRow(
            decoration: BoxDecoration(
                color:
                    index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100]),
            children: [
              Text(
                "Barkod",
                style: TextStyle(color: baslik, fontSize: baslikSize),
              ),
              Text(model.getBarkod,
                  style: TextStyle(color: value, fontSize: valueSize)),
              Text(
                "Renk",
                style: TextStyle(color: baslik, fontSize: baslikSize),
              ),
              Text(model.getRenk,
                  style: TextStyle(color: value, fontSize: valueSize)),
              Text(
                "Para Birimi",
                style: TextStyle(color: baslik, fontSize: baslikSize),
              ),
              Text(model.getParaBirimi,
                  style: TextStyle(color: value, fontSize: valueSize)),
            ]),
        TableRow(
            decoration: BoxDecoration(
                color:
                    index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100]),
            children: [
              Text(
                "Kodu",
                style: TextStyle(color: baslik, fontSize: baslikSize),
              ),
              Text(model.getKodu,
                  style: TextStyle(color: value, fontSize: valueSize)),
              Text(
                "Beden",
                style: TextStyle(color: baslik, fontSize: baslikSize),
              ),
              Text(model.getBeden,
                  style: TextStyle(color: value, fontSize: valueSize)),
              Text(
                "Fiyat",
                style: TextStyle(color: baslik, fontSize: baslikSize),
              ),
              Text(model.getFiyat.toString(),
                  style: TextStyle(color: value, fontSize: valueSize)),
            ]),
        TableRow(
          decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100]),
          children: [
            Text(
              "Adi",
              style: TextStyle(color: baslik, fontSize: baslikSize),
            ),
            Text(model.getAdi,
                style: TextStyle(color: value, fontSize: valueSize)),
            Text(
              "Miktar",
              style: TextStyle(color: baslik, fontSize: baslikSize),
            ),
            Text(model.getMiktar.toString(),
                style: TextStyle(color: value, fontSize: valueSize)),
            Text(""),
            Text(""),
          ],
          /*decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 2,
                      color: Theme.of(context).textTheme.bodyText1.color)),
            )*/
        ),
      ],
    );
  }

  Widget slidableSatir(MusteriSiparisiRowModel model, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(child: table(model, index)),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Düzenle',
          color: Colors.black45,
          icon: Icons.edit,
          onTap: () => dialog(model),
        ),
        IconSlideAction(
          caption: 'Sil',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            print('Sil');
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Silmek istediğinize emin misiniz?"),
                      actions: [
                        FlatButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text("Hayır")),
                        FlatButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text("Evet")),
                      ],
                    )).then((value) {
              if (value == true) {
                setState(() {
                  satirlarModel.removeAt(satirlarModel.indexOf(model));
                });
              }
            });
          },
        ),
      ],
    );
  }

  void dialog(MusteriSiparisiRowModel model) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: controller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Yeni miktarı giriniz.'),
                    ),
                    Center(
                      child: SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              model.setMiktar = int.parse(controller.text);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Kaydet",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
