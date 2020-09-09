import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:teronmobile/command/StokIslemiScreenCommand.dart';
import 'package:teronmobile/model/CariDepoAutoComp.dart';
import 'package:teronmobile/model/MusteriSiparisiRowModel.dart';
import 'package:teronmobile/model/StokIslemiModel.dart';

class StokIslemiScreen extends State<StokIslemiScreenCommand> {
  int fisTipi;
  int depoType;
  StokIslemiModel model;
  StokIslemiScreen(int fisTipi) {
    this.fisTipi = fisTipi;
    model = StokIslemiModel();
    model.fisTip = fisTipi;
    if (fisTipi == 1) {
      depoType = 0;
    } else if (fisTipi == 30 || fisTipi == 31) {
      depoType = 1;
    }
  }

  final labelWidth = 120.0;
  var label;

  List<Step> steps;
  Map stepIndex;
  int currentStep = 0;
  bool complete = false;
  int maxStep = 0;
  bool cariRed = false;
  bool sevkRed = false;
  bool cikisDepoRed = false;
  bool girisDepoRed = false;
  String barkod;
  FocusNode barkodFocus;
  List<MusteriSiparisiRowModel> satirlarModel = List();
  List<MusteriSiparisiRowModel> satirlarRowModel = List();
  List<MusteriSiparisiRowModel> satirlarRefModel = List();
  String selectedParaBirimi = "TL";
  TextEditingController sipTarihController = TextEditingController();
  TextEditingController terminTarihController = TextEditingController();
  TextEditingController cariKoduController = TextEditingController();
  TextEditingController cariAdiController = TextEditingController();
  TextEditingController sevkCariKoduController = TextEditingController();
  TextEditingController sevkCariAdiController = TextEditingController();
  TextEditingController girisDepoKoduController = TextEditingController();
  TextEditingController girisDepoAdiController = TextEditingController();
  TextEditingController cikisDepoKoduController = TextEditingController();
  TextEditingController cikisDepoAdiController = TextEditingController();
  TextEditingController belgeAciklamaController = TextEditingController();
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

    sipTarihController.text = "${model.getSiparisTarihi.day.toString().padLeft(2, '0')}-${model.getSiparisTarihi.month.toString().padLeft(2, '0')}-${model.getSiparisTarihi.year.toString()}";
    terminTarihController.text = "${model.getTerminTarihi.day.toString().padLeft(2, '0')}-${model.getTerminTarihi.month.toString().padLeft(2, '0')}-${model.getTerminTarihi.year.toString()}";

    cariKoduController.text = model.getCariKodu;
    cariAdiController.text = model.getCariAdi;
    sevkCariKoduController.text = model.getSevkCariKodu;
    sevkCariAdiController.text = model.getSevkCariAdi;
    girisDepoKoduController.text = model.getGirisDepoKodu;
    girisDepoAdiController.text = model.getGirisDepoAdi;
    cikisDepoKoduController.text = model.cikisDepoKodu;
    cikisDepoAdiController.text = model.cikisDepoAdi;
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
    /*if (currentStep == 1 && satirlarModel.length == 0) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [
          Icon(Icons.announcement),
          Padding(padding: EdgeInsets.all(20)),
          Text("Detay satırları boş geçilemez!"),
        ],
      )));
      return;
    }*/
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
        girisDepoRed = false;
        cikisDepoRed = false;
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
      if (depoType == 0 || depoType == 2) {
        if (girisDepoKoduController.text == null || girisDepoKoduController.text == "") {
          setState(() {
            ret = true;
            girisDepoRed = true;
          });
        }
      }

      if (depoType == 1 || depoType == 2) {
        if (cikisDepoKoduController.text == null || cikisDepoKoduController.text == "") {
          setState(() {
            ret = true;
            cikisDepoRed = true;
          });
        }
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
    List<DropdownMenuItem<String>> asd = List();
    asd.add(DropdownMenuItem(
      child: Text("TL"),
      value: "TL",
    ));
    asd.add(DropdownMenuItem(
      child: Text("EUR"),
      value: "EUR",
    ));

    int deneme = 0;

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
              /*Row(
                children: [
                  Container(child: Text("Giriş Depo Kodu"), width: labelWidth),
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
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(child: Text("Giriş Depo Adı"), width: labelWidth),
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
              ),*/
              depoType == 0 || depoType == 2
                  ? Row(
                      children: [
                        Container(child: Text("Giriş Depo Kodu"), width: labelWidth),
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
                                girisDepoKoduController.text = suggestion.keys.elementAt(0);
                                girisDepoAdiController.text = suggestion.values.elementAt(0);
                                model.girisDepoKodu = girisDepoAdiController.text;
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: girisDepoRed == true ? BorderSide(color: Colors.red, width: 2) : BorderSide(width: 0), borderRadius: BorderRadius.all(Radius.circular(5))), contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                                textAlign: TextAlign.left,
                                controller: girisDepoKoduController,
                              ),
                            )),
                      ],
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              depoType == 0 || depoType == 2
                  ? SizedBox(
                      height: 5,
                    )
                  : SizedBox(),
              depoType == 0 || depoType == 2
                  ? Row(
                      children: [
                        Container(child: Text("Giriş Depo Adı"), width: labelWidth),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Container(
                            width: 150,
                            height: 35,
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(fillColor: Colors.yellow[100], filled: true, contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                              textAlign: TextAlign.left,
                              readOnly: true,
                              controller: girisDepoAdiController,
                              onChanged: (newText) {
                                if (newText != null) {
                                  model.setGirisDepoAdi = newText;
                                }
                              },
                            )),
                      ],
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              depoType == 0 || depoType == 2
                  ? SizedBox(
                      height: 5,
                    )
                  : SizedBox(),
              depoType == 1 || depoType == 2
                  ? Row(
                      children: [
                        Container(child: Text("Çıkış Depo Kodu"), width: labelWidth),
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
                                cikisDepoKoduController.text = suggestion.keys.elementAt(0);
                                cikisDepoAdiController.text = suggestion.values.elementAt(0);
                                model.cikisDepoKodu = cikisDepoKoduController.text;
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: cikisDepoRed == true ? BorderSide(color: Colors.red, width: 2) : BorderSide(width: 0), borderRadius: BorderRadius.all(Radius.circular(5))), contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                                textAlign: TextAlign.left,
                                controller: cikisDepoKoduController,
                              ),
                            )),
                      ],
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              depoType == 1 || depoType == 2
                  ? SizedBox(
                      height: 5,
                    )
                  : SizedBox(),
              depoType == 1 || depoType == 2
                  ? Row(
                      children: [
                        Container(child: Text("Çıkış Depo Adı"), width: labelWidth),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Container(
                            width: 150,
                            height: 35,
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(fillColor: Colors.yellow[100], filled: true, contentPadding: EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                              textAlign: TextAlign.left,
                              readOnly: true,
                              controller: cikisDepoAdiController,
                              onChanged: (newText) {
                                if (newText != null) {
                                  model.cikisDepoAdi = newText;
                                }
                              },
                            )),
                      ],
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              depoType == 1 || depoType == 2
                  ? SizedBox(
                      height: 5,
                    )
                  : SizedBox(),
              Row(
                children: [
                  Container(child: Text("Para Birimi"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                    width: 150,
                    height: 35,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(border: Border.all(width: 0), borderRadius: BorderRadius.circular(5)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: selectedParaBirimi,
                          onChanged: (newValue) {
                            setState(() {
                              selectedParaBirimi = newValue;
                            });
                          },
                          items: asd),
                    ),
                  ),
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
                          /*MusteriSiparisiRowModel satirModel = MusteriSiparisiRowModel();
                          satirModel.setData(value, model).then((list) async {
                            MusteriSiparisiRowModel tempModel;
                            if (list.length != 0) {
                              tempModel = list[0];
                              await barkodMiktarDialog(tempModel).then((miktar) {
                                print("miktar");
                                print(miktar);
                                setState(() {
                                  barkod = value;
                                  barkodFocus.requestFocus();
                                  barkodController.selection = TextSelection(baseOffset: 0, extentOffset: barkodController.text.length);
                                  for (var i = 0; i < miktar; i++) {
                                    print("miktar for ici");
                                    for (var i = 0; i < list.length; i++) {
                                      print(satirlarRowModel);
                                      print(satirlarModel);

                                      satirModel = list[i];

                                      bool addRow = true;
                                      for (var i = 0; i < satirlarRowModel.length; i++) {
                                        MusteriSiparisiRowModel m = satirlarRowModel[i];
                                        if (m.getStokRenkBoyutId == satirModel.getStokRenkBoyutId) {
                                          m.setMiktar = m.getMiktar + satirModel.getMiktar;
                                          addRow = false;
                                        }
                                      }

                                      if (addRow == true) {
                                        MusteriSiparisiRowModel refModel = MusteriSiparisiRowModel();
                                        refModel.setBarkod = satirModel.getBarkod;
                                        refModel.setKodu = satirModel.getKodu;
                                        refModel.setAdi = satirModel.getAdi;
                                        refModel.setRenk = satirModel.getRenk;
                                        refModel.setParaBirimi = satirModel.getParaBirimi;
                                        refModel.setFiyat = satirModel.getFiyat;
                                        refModel.setMiktar = satirModel.getMiktar;
                                        refModel.setStokId = satirModel.getStokId;
                                        refModel.setRenkId = satirModel.getRenkId;
                                        refModel.setBeden = satirModel.getBeden;
                                        refModel.setStokRenkBoyutId = satirModel.getStokRenkBoyutId;
                                        refModel.lot = satirModel.lot;
                                        refModel.lotAdeti = satirModel.lotAdeti;
                                        refModel.setBoyut1Id = satirModel.getBoyut1Id;
                                        satirlarRowModel.add(refModel);
                                      }

                                      bool add = true;
                                      for (var i = 0; i < satirlarModel.length; i++) {
                                        MusteriSiparisiRowModel m = satirlarModel[i];
                                        if (m.barkod == satirModel.barkod && m.stokId == satirModel.stokId && m.renkId == satirModel.renkId) {
                                          m.setMiktar = m.getMiktar + satirModel.getMiktar;
                                          print(satirModel.getMiktar);
                                          add = false;
                                        }
                                      }

                                      if (add == true) {
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
                                        lotModel.setBoyut1Id = satirModel.getBoyut1Id;
                                        lotModel.setStokRenkBoyutId = satirModel.getStokRenkBoyutId;
                                        satirlarModel.add(lotModel);
                                      }

                                      bool addRef = true;
                                      for (var i = 0; i < satirlarRefModel.length; i++) {
                                        MusteriSiparisiRowModel m = satirlarRefModel[i];
                                        if (m.getStokRenkBoyutId == satirModel.getStokRenkBoyutId) {
                                          addRef = false;
                                        }
                                      }

                                      if (addRef == true) {
                                        satirlarRefModel.add(satirModel);
                                      }
                                    }
                                  }
                                });
                              });
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
                          });*/
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

  Widget table(MusteriSiparisiRowModel model, index) {
    Color baslik = Colors.blueGrey;
    Color value = Colors.black;
    double baslikSize = 10;
    double valueSize = 13;
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
            model.lot == 1 ? "Lot İçi Adeti" : "Beden",
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
              model.lot == 1 ? "Lot Adeti" : "Miktar",
              style: TextStyle(color: baslik, fontSize: baslikSize),
            ),
            Text(model.lot == 1 ? (model.getMiktar / model.lotAdeti).toString() : model.getMiktar.toString(), style: TextStyle(color: value, fontSize: valueSize)),
            Text(
              model.lot == 1 ? "Toplam Adet" : "",
              style: TextStyle(color: baslik, fontSize: baslikSize),
            ),
            Text(model.lot == 1 ? model.getMiktar.toString() : ""),
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
          onTap: () => editDialog(model),
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

  void editDialog(MusteriSiparisiRowModel model) {
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
                              if (model.lot == 0) {
                                model.setMiktar = int.parse(controller.text);
                                print("TEKLI MIKTAR GIRISI");
                                for (var i = 0; i < satirlarRowModel.length; i++) {
                                  if (satirlarRowModel[i].stokRenkBoyutId == model.stokRenkBoyutId) {
                                    satirlarRowModel[i].setMiktar = int.parse(controller.text);
                                  }
                                }
                              } else {
                                model.setMiktar = model.lotAdeti * int.parse(controller.text);
                                print(satirlarRefModel);
                                for (var i = 0; i < satirlarRefModel.length; i++) {
                                  MusteriSiparisiRowModel refModel = satirlarRefModel[i];
                                  print(model.getBarkod);
                                  print(refModel.getBarkod);
                                  if (refModel.barkod == model.barkod && refModel.stokId == model.stokId && refModel.renkId == model.renkId) {
                                    for (var k = 0; k < satirlarRowModel.length; k++) {
                                      MusteriSiparisiRowModel rowModel = satirlarRowModel[k];
                                      print(rowModel.getStokRenkBoyutId);
                                      print(refModel.getStokRenkBoyutId);
                                      if (rowModel.getStokRenkBoyutId == refModel.getStokRenkBoyutId) {
                                        rowModel.setMiktar = refModel.getMiktar * int.parse(controller.text);
                                        print(rowModel.getMiktar);
                                      }
                                    }
                                  }
                                }
                                print("LOT MIKTAR GIRISI");
                              }
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

  Future<int> barkodMiktarDialog(MusteriSiparisiRowModel tempModel) async {
    TextEditingController controller = TextEditingController();
    int miktar = 1;
    controller.text = miktar.toString();
    await showDialog(
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
                    /*Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Stok Kodu  - ",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(tempModel.getKodu),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Stok Adı  - ",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(tempModel.getAdi),
                            ],
                          ),
                        ],
                      ),
                    ),*/
                    Table(
                      columnWidths: {
                        0: FractionColumnWidth(.3),
                        1: FractionColumnWidth(.7),
                      },
                      children: [
                        TableRow(children: [
                          Text(
                            "Stok Kodu",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(tempModel.getKodu),
                        ]),
                        TableRow(children: [
                          Text(
                            "Stok Adı",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(tempModel.getAdi),
                        ]),
                        TableRow(children: [
                          Text(
                            "Lot",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text("Lot içi"),
                        ])
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: controller,
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Miktarı giriniz.'),
                    ),
                    Center(
                      child: SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              miktar = int.parse(controller.text);
                              Navigator.pop(context);
                            });
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
        }).then((value) {
      return miktar;
    });
    return miktar;
  }
}
