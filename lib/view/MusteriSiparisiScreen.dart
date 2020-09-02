import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';
import 'package:teronmobile/main.dart';
import 'package:teronmobile/main.dart';
import 'package:teronmobile/model/CariDepoAutoComp.dart';
import 'package:teronmobile/model/MusteriSiparisiModel.dart';
import 'package:teronmobile/model/MusteriSiparisiRowModel.dart';
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
  List<MusteriSiparisiRowModel> satirlarRowModel = List();

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

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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

  @override
  Widget build(BuildContext context) {
    setSteps();
    return WillPopScope(
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

  @override
  void initState() {
    super.initState();
    stepIndex = {
      0: true,
      1: false,
      2: false
    };
    model = MusteriSiparisiModel();
    sipTarihController.text = "${model.getSiparisTarihi.day.toString().padLeft(2, '0')}-${model.getSiparisTarihi.month.toString().padLeft(2, '0')}-${model.getSiparisTarihi.year.toString()}";
    terminTarihController.text = "${model.getTerminTarihi.day.toString().padLeft(2, '0')}-${model.getTerminTarihi.month.toString().padLeft(2, '0')}-${model.getTerminTarihi.year.toString()}";

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
              title: Text("Çıkmak istediğinize emin misiniz?"),
              actions: [
                FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("Hayır")),
                FlatButton(onPressed: () => Navigator.pop(context, true), child: Text("Evet")),
              ],
            ));
  }

  next(BuildContext context) {
    currentStep + 1 != steps.length
        ? goTo(context, currentStep + 1)
        : setState(() {
            showIsOkDialog(context);
          });
  }

  showIsOkDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Hayır"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Evet"),
      onPressed: () {
        complete = true;
        model.insert(satirlarRowModel).then((_) {
          Navigator.pop(context);
          String fisNo = model.sipNo.toString();
          AlertDialog alert = AlertDialog(
            title: Text("İşlem Başarılı!"),
            content: Text("Siparişiniz $fisNo no ile oluşmuştur."),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, '/musterisiparisi');
                  },
                  child: Text("Tamam")),
            ],
          );
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı!"),
      content: Text("Müşteri Siparişi oluşturmak istediğinize emin misiniz?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
      if (sevkCariKoduController.text == null || sevkCariKoduController.text == "") {
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
        title: const Text('Başlık'),
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
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: true,
                        controller: sipTarihController,
                        onTap: () {
                          showDatePicker(locale: const Locale('tr'), context: context, initialDate: model.getSiparisTarihi, firstDate: DateTime(2010), lastDate: DateTime(2030)).then((value) {
                            if (value != null) {
                              model.setSiparisTarihi = value;
                              sipTarihController.text = "${model.getSiparisTarihi.day.toString().padLeft(2, '0')}-${model.getSiparisTarihi.month.toString().padLeft(2, '0')}-${model.getSiparisTarihi.year.toString()}";
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
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: true,
                        controller: terminTarihController,
                        onTap: () {
                          showDatePicker(context: context, initialDate: model.getTerminTarihi, firstDate: DateTime(2010), lastDate: DateTime(2030)).then((value) {
                            if (value != null) {
                              model.setTerminTarihi = value;
                              terminTarihController.text = "${model.getTerminTarihi.day.toString().padLeft(2, '0')}-${model.getTerminTarihi.month.toString().padLeft(2, '0')}-${model.getTerminTarihi.year.toString()}";
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
                      width: 150,
                      height: 35,
                      child: TypeAheadField(
                        suggestionsCallback: (pattern) async {
                          if (pattern != null && pattern != "") {
                            return await CariDepoAutoComp.getCariJson(pattern);
                          }
                          return null;
                        },
                        noItemsFoundBuilder: (context) {
                          return Text(
                            "Cari kodu bulunamadı..",
                            style: TextStyle(fontSize: 18),
                          );
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.keys.elementAt(0)),
                            subtitle: Text(suggestion.values.elementAt(0)),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          cariKoduController.text = suggestion.keys.elementAt(0);
                          cariAdiController.text = suggestion.values.elementAt(0);
                          sevkCariKoduController.text = suggestion.keys.elementAt(0);
                          sevkCariAdiController.text = suggestion.values.elementAt(0);
                          model.setCariKodu = cariKoduController.text;
                          model.setSevkCariKodu = sevkCariKoduController.text;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: cariRed == true ? BorderSide(color: Colors.red, width: 2) : BorderSide(width: 0), borderRadius: BorderRadius.all(Radius.circular(5))), contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                          textAlign: TextAlign.left,
                          controller: cariKoduController,
                          /*onChanged: (newText) {
                            if (newText != null) {
                              model.setCariKodu = newText;
                              sevkCariKoduController.text = newText;
                              model.setSevkCariKodu = newText;
                            }
                          },*/
                        ),
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
                      width: 150,
                      height: 35,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(fillColor: Colors.yellow[100], filled: true, contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
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
                      width: 150,
                      height: 35,
                      child: TypeAheadField(
                        suggestionsCallback: (pattern) async {
                          if (pattern != null && pattern != "") {
                            return await CariDepoAutoComp.getCariJson(pattern);
                          }
                          return null;
                        },
                        noItemsFoundBuilder: (context) {
                          return Text(
                            "Cari kodu bulunamadı..",
                            style: TextStyle(fontSize: 18),
                          );
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.keys.elementAt(0)),
                            subtitle: Text(suggestion.values.elementAt(0)),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          sevkCariKoduController.text = suggestion.keys.elementAt(0);
                          sevkCariAdiController.text = suggestion.values.elementAt(0);
                          model.sevkCariKodu = sevkCariKoduController.text;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: cariRed == true ? BorderSide(color: Colors.red, width: 2) : BorderSide(width: 0), borderRadius: BorderRadius.all(Radius.circular(5))), contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                          textAlign: TextAlign.left,
                          controller: sevkCariKoduController,
                          /*onChanged: (newText) {
                            if (newText != null) {
                              model.setCariKodu = newText;
                              sevkCariKoduController.text = newText;
                              model.setSevkCariKodu = newText;
                            }
                          },*/
                        ),
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
                      width: 150,
                      height: 35,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(fillColor: Colors.yellow[100], filled: true, contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
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
                      width: 150,
                      height: 35,
                      child: TypeAheadField(
                        suggestionsCallback: (pattern) async {
                          if (pattern != null && pattern != "") {
                            return await CariDepoAutoComp.getDepoJson(pattern);
                          }
                          return null;
                        },
                        autoFlipDirection: true,
                        noItemsFoundBuilder: (context) {
                          return Text(
                            "Depo kodu bulunamadı..",
                            style: TextStyle(fontSize: 18),
                          );
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.keys.elementAt(0)),
                            subtitle: Text(suggestion.values.elementAt(0)),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          depoKoduController.text = suggestion.keys.elementAt(0);
                          depoAdiController.text = suggestion.values.elementAt(0);
                          model.depoKodu = depoKoduController.text;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: cariRed == true ? BorderSide(color: Colors.red, width: 2) : BorderSide(width: 0), borderRadius: BorderRadius.all(Radius.circular(5))), contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                          textAlign: TextAlign.left,
                          controller: depoKoduController,
                          /*onChanged: (newText) {
                            if (newText != null) {
                              model.setCariKodu = newText;
                              sevkCariKoduController.text = newText;
                              model.setSevkCariKodu = newText;
                            }
                          },*/
                        ),
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
                      width: 150,
                      height: 35,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(fillColor: Colors.yellow[100], filled: true, contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
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
                  Container(child: Text("Müşteri Sipariş No"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 150,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
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
                      width: 150,
                      child: TextField(
                        maxLines: 3,
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
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
        state: maxStep > 1 ? StepState.complete : maxStep == 1 ? StepState.editing : StepState.indexed,
        title: const Text('Detay'),
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                      "Barkod",
                      style: TextStyle(fontSize: 12),
                    ),
                    width: 50),
                Padding(padding: EdgeInsets.only(right: 10)),
                Expanded(
                  child: Container(
                      width: 300,
                      height: 35,
                      child: TextFormField(
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: false,
                        controller: barkodController,
                        focusNode: barkodFocus,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        onFieldSubmitted: (value) {
                          MusteriSiparisiRowModel satirModel = MusteriSiparisiRowModel();
                          satirModel.setData(value, model).then((list) {
                            setState(() {
                              barkod = value;
                              barkodFocus.requestFocus();
                              barkodController.selection = TextSelection(baseOffset: 0, extentOffset: barkodController.text.length);
                              if (list.length != 0) {
                                for (var i = 0; i < list.length; i++) {
                                  print(satirlarRowModel);
                                  print(satirlarModel);
                                  satirModel = list[i];
                                  MusteriSiparisiRowModel satirRowModel = list[i];
                                  bool addRow = true;
                                  for (var i = 0; i < satirlarRowModel.length; i++) {
                                    MusteriSiparisiRowModel m = satirlarRowModel[i];
                                    if (m.getStokRenkBoyutId == satirRowModel.getStokRenkBoyutId) {
                                      m.setMiktar = m.getMiktar + satirRowModel.getMiktar;
                                      addRow = false;
                                    }
                                  }

                                  if (addRow == true) {
                                    satirlarRowModel.add(satirRowModel);
                                  }

                                  bool add = true;
                                  for (var i = 0; i < satirlarModel.length; i++) {
                                    MusteriSiparisiRowModel m = satirlarModel[i];
                                    if (m.barkod == satirModel.barkod && m.stokId == satirModel.stokId && m.renkId == satirModel.renkId) {
                                      m.setMiktar = m.getMiktar + satirModel.getMiktar;
                                      add = false;
                                    }
                                  }

                                  if (add == true) {
                                    /*if (satirModel.lot == 0) {
                                      satirlarModel.add(satirModel);
                                    } else {*/
                                    MusteriSiparisiRowModel lotModel = MusteriSiparisiRowModel();
                                    lotModel.setBarkod = satirModel.getBarkod;
                                    lotModel.setKodu = satirModel.getKodu;
                                    lotModel.setAdi = satirModel.getAdi;
                                    lotModel.setRenk = satirModel.getRenk;
                                    lotModel.setParaBirimi = satirModel.getParaBirimi;
                                    lotModel.setFiyat = satirModel.getFiyat;
                                    lotModel.setMiktar = satirModel.getMiktar;
                                    lotModel.setStokId = satirModel.getStokId;
                                    lotModel.setRenkId = satirModel.getRenkId;
                                    lotModel.setBeden = satirModel.getBeden;
                                    lotModel.lot = satirModel.lot;
                                    lotModel.lotAdeti = satirModel.lotAdeti;
                                    satirlarModel.add(lotModel);
                                    /*}*/
                                  }

                                  print(satirlarModel);
                                  print(satirlarRowModel);
                                }
                              } else {
                                scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Row(
                                  children: [
                                    Icon(Icons.announcement),
                                    Padding(padding: EdgeInsets.all(20)),
                                    Text("Barkod Bulunamadı."),
                                  ],
                                )));
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
                      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).textTheme.bodyText1.color, width: 1), borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: ListView.builder(
                        //padding: EdgeInsets.all(10),
                        itemCount: satirlarModel.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => slidableSatir(satirlarModel[index], index),
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
                    width: 200,
                    height: 35,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(fillColor: Colors.yellow[100], filled: true, contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
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
                    width: 200,
                    height: 35,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(fillColor: Colors.yellow[100], filled: true, contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                      textAlign: TextAlign.left,
                      readOnly: true,
                      controller: cariAdiController,
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
                      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).textTheme.bodyText1.color, width: 1), borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.33,
                      child: ListView.builder(
                        //padding: EdgeInsets.all(10),
                        itemCount: satirlarModel.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => table(satirlarModel[index], index),
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
                /*Container(child: Text("Toplam Fiyat"), width: 100),
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
                    )),*/
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Theme.of(context).textTheme.bodyText1.color, width: 1), borderRadius: BorderRadius.circular(5)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: SingleChildScrollView(
                      child: DataTable(
                          columnSpacing: 5,
                          dataRowHeight: 30,
                          headingRowHeight: 30,
                          columns: [
                            DataColumn(label: Text("Para Birimi")),
                            DataColumn(label: Text("Miktar")),
                            DataColumn(label: Text("Tutar")),
                          ],
                          rows: setToplam()),
                    ),
                  ),
                )
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
                      decoration: InputDecoration(fillColor: Colors.yellow[100], filled: true, contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                      textAlign: TextAlign.right,
                      readOnly: true,
                      onChanged: (newText) {},
                      controller: ozetToplamMiktarController,
                    )),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  List<DataRow> setToplam() {
    Map paraBrmMap = Map();
    List<DataRow> list = List();
    for (var i = 0; i < satirlarModel.length; i++) {
      MusteriSiparisiRowModel model = satirlarModel[i];
      MusteriSiparisiRowModel toplamModel = paraBrmMap[model.getParaBirimi];
      if (toplamModel == null) {
        toplamModel = MusteriSiparisiRowModel();
        toplamModel.setParaBirimi = model.getParaBirimi;
        paraBrmMap.putIfAbsent(model.getParaBirimi, () => toplamModel);
      }
      setState(() {
        toplamModel.setMiktar = toplamModel.getMiktar + model.getMiktar;
        toplamModel.setFiyat = toplamModel.getFiyat + (model.getMiktar * model.getFiyat);
      });
    }
    int index = 0;
    for (var keys in paraBrmMap.keys) {
      MusteriSiparisiRowModel toplamModel = paraBrmMap[keys];
      index++;
      list.add(DataRow(
          color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100];
          }),
          cells: [
            DataCell(Text(toplamModel.getParaBirimi)),
            DataCell(Text(toplamModel.getMiktar.toString())),
            DataCell(Text(toplamModel.getFiyat.toString()))
          ]));
    }
    return list;
  }

  void setOzet() {
    int toplam = 0;
    double fiyat = 0;
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
        TableRow(decoration: BoxDecoration(color: index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100]), children: [
          Text(
            "Barkod",
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getBarkod, style: TextStyle(color: value, fontSize: valueSize)),
          Text(
            "Renk",
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getRenk, style: TextStyle(color: value, fontSize: valueSize)),
          Text(
            "Para Birimi",
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getParaBirimi, style: TextStyle(color: value, fontSize: valueSize)),
        ]),
        TableRow(decoration: BoxDecoration(color: index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100]), children: [
          Text(
            "Kodu",
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getKodu, style: TextStyle(color: value, fontSize: valueSize)),
          Text(
            model.lot == 1 ? "Lot Adeti" : "Beden",
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.lot == 1 ? model.lotAdeti.toString() : model.getBeden, style: TextStyle(color: value, fontSize: valueSize)),
          Text(
            "Fiyat",
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getFiyat.toString(), style: TextStyle(color: value, fontSize: valueSize)),
        ]),
        TableRow(
          decoration: BoxDecoration(color: index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100]),
          children: [
            Text(
              "Adi",
              style: TextStyle(color: baslik, fontSize: baslikSize),
            ),
            Text(model.getAdi, style: TextStyle(color: value, fontSize: valueSize)),
            Text(
              model.lot == 1 ? "Lot İçi Adeti" : "Miktar",
              style: TextStyle(color: baslik, fontSize: baslikSize),
            ),
            Text(model.getMiktar.toString(), style: TextStyle(color: value, fontSize: valueSize)),
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
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Silmek istediğinize emin misiniz?"),
                      actions: [
                        FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("Hayır")),
                        FlatButton(onPressed: () => Navigator.pop(context, true), child: Text("Evet")),
                      ],
                    )).then((value) {
              if (value == true) {
                setState(() {
                  satirlarModel.removeAt(satirlarModel.indexOf(model));
                  for (var i = 0; i < satirlarRowModel.length; i++) {
                    MusteriSiparisiRowModel rowModel = satirlarRowModel[i];
                    if (model.barkod == rowModel.barkod && model.stokId == rowModel.stokId && model.renkId == rowModel.renkId) {
                      satirlarRowModel.removeAt(satirlarRowModel.indexOf(rowModel));
                      i--;
                    }
                  }
                  print(satirlarModel);
                  print(satirlarRowModel);
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Yeni miktarı giriniz.'),
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
