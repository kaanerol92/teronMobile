import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:teronmobile/Base/BaseFisScreen.dart';
import 'package:teronmobile/interface/LoginInterface.dart';
import 'package:teronmobile/model/CariDepoAutoComp.dart';
import 'package:teronmobile/model/MusteriSiparisiModel.dart';
import 'package:teronmobile/model/BarkodRowModel.dart';
import 'package:teronmobile/repository/TextRepository.dart';

class MusteriSiparisiScreen extends BaseFisScreen {
  MusteriSiparisiScreen(LoginInterface loginInterface) : super(loginInterface);

  // bool isPBOk = false;
  MusteriSiparisiModel model;
  // List<Step> steps;
  // Map stepIndex;
  // int currentStep = 0;
  // bool complete = false;
  // int maxStep = 0;
  bool cariRed = false;
  bool sevkRed = false;
  bool depoRed = false;
  // String barkod;
  // FocusNode barkodFocus;
  List<BarkodRowModel> satirlarModel = List();
  List<BarkodRowModel> satirlarRowModel = List();
  List<BarkodRowModel> satirlarRefModel = List();
  // List<DropdownMenuItem<String>> paraBirimiList = new List();

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

  // VoidCallback _onStepContinue;
  // VoidCallback _onStepCancel;

  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // String paraBrm;

  // Widget _bottomBar() {
  //   return Container(
  //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
  //       (currentStep != 0
  //           ? Container(
  //               margin: EdgeInsets.only(left: 10, bottom: 5),
  //               child: RaisedButton(
  //                 color: Colors.blueAccent,
  //                 onPressed: () => _onStepCancel(),
  //                 child: Icon(
  //                   Icons.navigate_before,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             )
  //           : SizedBox.shrink()),
  //       Container(
  //         margin: EdgeInsets.only(right: 10, bottom: 5),
  //         child: RaisedButton(
  //             color: currentStep == 2 ? Colors.green : Colors.blueAccent,
  //             onPressed: () => _onStepContinue(),
  //             child: currentStep == 2
  //                 ? Icon(
  //                     Icons.done,
  //                     color: Colors.white,
  //                   )
  //                 : Icon(
  //                     Icons.navigate_next,
  //                     color: Colors.white,
  //                   )),
  //       ),
  //     ]),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   setSteps();
  //   return !isPBOk
  //       ? LoadingScreenCommand("Yükleniyor..")
  //       : WillPopScope(
  //           onWillPop: () => backPress(),
  //           child: Scaffold(
  //             key: scaffoldKey,
  //             resizeToAvoidBottomPadding: true,
  //             resizeToAvoidBottomInset: true,
  //             /*appBar: AppBar(
  //         elevation: 0.0,
  //         backgroundColor: Colors.transparent,
  //         centerTitle: true,
  //         title: Text("Müşteri Siparişi"),
  //         textTheme: Theme.of(context).textTheme,
  //         iconTheme: Theme.of(context).iconTheme,
  //       ),*/
  //             body: SafeArea(
  //               child: Builder(
  //                   builder: (context) => Stack(children: [
  //                         Stepper(
  //                             steps: steps,
  //                             physics: ClampingScrollPhysics(),
  //                             type: StepperType.horizontal,
  //                             currentStep: currentStep,
  //                             onStepCancel: () {
  //                               cancel(context);
  //                             },
  //                             onStepContinue: () {
  //                               next(context);
  //                             },
  //                             onStepTapped: (step) {
  //                               if (stepIndex[step] == true) {
  //                                 goTo(context, step);
  //                               }
  //                             },
  //                             controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
  //                               _onStepCancel = onStepCancel;
  //                               _onStepContinue = onStepContinue;
  //                               return Column(children: [
  //                                 SizedBox(
  //                                   width: 50,
  //                                 ),
  //                               ]);
  //                             }),
  //                         Align(
  //                           alignment: Alignment.bottomCenter,
  //                           child: _bottomBar(),
  //                         )
  //                       ])),
  //             ),
  //           ),
  //         );
  // }

  @override
  void initState() {
    super.initState();

    model = MusteriSiparisiModel(loginInterface);
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
  }

  // Future<bool> backPress() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text("Çıkmak istediğinize emin misiniz?"),
  //             actions: [
  //               FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("Hayır")),
  //               FlatButton(onPressed: () => Navigator.pop(context, true), child: Text("Evet")),
  //             ],
  //           ));
  // }

  next(BuildContext context) {
    if (currentStep == 1 && satirlarModel.length == 0) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [
          Icon(Icons.announcement),
          Padding(padding: EdgeInsets.all(20)),
          Text("Detay satırları boş geçilemez!"),
        ],
      )));
      return;
    }

    currentStep + 1 != steps.length
        ? goTo(context, currentStep + 1)
        : setState(() {
            showIsOkDialog(context);
          });
  }

  showIsOkDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(TextRepository.getText(TextRepository.HAYIR)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(TextRepository.getText(TextRepository.EVET)),
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

  @override
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
        title: Text(TextRepository.getText(TextRepository.BASLIK)),
        isActive: stepIndex[0],
        state: maxStep > 0 ? StepState.complete : StepState.editing,
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Container(child: Text(TextRepository.getText(TextRepository.SIPARIS_TARIHI)), width: labelWidth),
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
                  Container(child: Text(TextRepository.getText(TextRepository.TERMIN_TARIHI)), width: labelWidth),
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
                  Container(child: Text(TextRepository.getText(TextRepository.CARI_KODU)), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 150,
                      height: 35,
                      child: TypeAheadField(
                        suggestionsCallback: (pattern) async {
                          if (pattern != null && pattern != "") {
                            return await CariDepoAutoComp.getCariJson(loginInterface, pattern);
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
                  Container(child: Text(TextRepository.getText(TextRepository.CARI_ADI)), width: labelWidth),
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
                  Container(child: Text(TextRepository.getText(TextRepository.SEVK_CARI_KODU)), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 150,
                      height: 35,
                      child: TypeAheadField(
                        suggestionsCallback: (pattern) async {
                          if (pattern != null && pattern != "") {
                            return await CariDepoAutoComp.getCariJson(loginInterface, pattern);
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
                  Container(child: Text(TextRepository.getText(TextRepository.SEVK_CARI_ADI)), width: labelWidth),
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
                  Container(child: Text(TextRepository.getText(TextRepository.DEPO_KODU)), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 150,
                      height: 35,
                      child: TypeAheadField(
                        suggestionsCallback: (pattern) async {
                          if (pattern != null && pattern != "") {
                            return await CariDepoAutoComp.getDepoJson(loginInterface, pattern);
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
                  Container(child: Text(TextRepository.getText(TextRepository.DEPO_ADI)), width: labelWidth),
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
                  Container(child: Text(TextRepository.getText(TextRepository.MUSTERI_SIPARIS_NO)), width: labelWidth),
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
                  Container(child: Text(TextRepository.getText(TextRepository.ACIKLAMA)), width: labelWidth),
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
        title: Text(TextRepository.getText(TextRepository.DETAY)),
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                      TextRepository.getText(TextRepository.BARKOD),
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
                          BarkodRowModel satirModel = BarkodRowModel(loginInterface);
                          satirModel.setData(value, model).then((list) async {
                            BarkodRowModel tempModel;
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

                                      bool add = true;
                                      for (var i = 0; i < satirlarModel.length; i++) {
                                        BarkodRowModel m = satirlarModel[i];
                                        if (m.barkod == satirModel.barkod && m.stokId == satirModel.stokId && m.renkId == satirModel.renkId) {
                                          m.setMiktar = m.getMiktar + satirModel.getMiktar;
                                          print(satirModel.getMiktar);
                                          add = false;
                                        }
                                      }

                                      if (add == true) {
                                        BarkodRowModel lotModel = BarkodRowModel(loginInterface);
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

                                      bool addRow = true;
                                      for (var i = 0; i < satirlarRowModel.length; i++) {
                                        BarkodRowModel m = satirlarRowModel[i];
                                        if (m.getStokRenkBoyutId == satirModel.getStokRenkBoyutId) {
                                          m.setMiktar = m.getMiktar + satirModel.getMiktar;
                                          addRow = false;
                                        }
                                      }

                                      if (addRow == true) {
                                        BarkodRowModel refModel = BarkodRowModel(loginInterface);
                                        refModel.setBarkod = satirModel.getBarkod;
                                        refModel.setKodu = satirModel.getKodu;
                                        refModel.setAdi = satirModel.getAdi;
                                        refModel.setRenk = satirModel.getRenk;
                                        refModel.setParaBirimi = satirModel.getParaBirimi;
                                        refModel.setFiyat = satirModel.getFiyat;
                                        refModel.setMiktar = satirModel.getMiktar;
                                        refModel.kur = satirModel.kur;
                                        refModel.setStokId = satirModel.getStokId;
                                        refModel.setRenkId = satirModel.getRenkId;
                                        refModel.setBeden = satirModel.getBeden;
                                        refModel.setStokRenkBoyutId = satirModel.getStokRenkBoyutId;
                                        refModel.lot = satirModel.lot;
                                        refModel.lotAdeti = satirModel.lotAdeti;
                                        refModel.setBoyut1Id = satirModel.getBoyut1Id;
                                        satirlarRowModel.add(refModel);
                                      }

                                      bool addRef = true;
                                      for (var i = 0; i < satirlarRefModel.length; i++) {
                                        BarkodRowModel m = satirlarRefModel[i];
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
        title: Text(TextRepository.getText(TextRepository.OZET)),
        content: Column(
          children: <Widget>[
            Row(
              children: [
                Container(child: Text(TextRepository.getText(TextRepository.CARI_KODU)), width: 100),
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
                Container(child: Text(TextRepository.getText(TextRepository.CARI_ADI)), width: 100),
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
                            DataColumn(label: Text(TextRepository.getText(TextRepository.PARA_BIRIMI))),
                            DataColumn(label: Text(TextRepository.getText(TextRepository.MIKTAR))),
                            DataColumn(label: Text(TextRepository.getText(TextRepository.TUTAR))),
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
                Container(child: Text(TextRepository.getText(TextRepository.TOPLAM_ADET)), width: 100),
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
      BarkodRowModel model = satirlarModel[i];
      BarkodRowModel toplamModel = paraBrmMap[model.getParaBirimi];
      if (toplamModel == null) {
        toplamModel = BarkodRowModel(loginInterface);
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
      BarkodRowModel toplamModel = paraBrmMap[keys];
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
      BarkodRowModel model = satirlarModel[i];
      toplam += model.getMiktar;
      fiyat += model.getFiyat;
    }
    ozetCariKoduController.text = model.getCariKodu;
    ozetCariAdiController.text = model.getCariAdi;
    ozetToplamMiktarController.text = toplam.toString();
    ozetToplamFiyatController.text = fiyat.toString();
  }

  Widget table(BarkodRowModel model, index) {
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
            TextRepository.getText(TextRepository.BARKOD),
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getBarkod, style: TextStyle(color: value, fontSize: valueSize)),
          Text(
            TextRepository.getText(TextRepository.RENK),
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getRenk, style: TextStyle(color: value, fontSize: valueSize)),
          Text(
            TextRepository.getText(TextRepository.PARA_BIRIMI),
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getParaBirimi, style: TextStyle(color: value, fontSize: valueSize)),
        ]),
        TableRow(decoration: BoxDecoration(color: index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100]), children: [
          Text(
            TextRepository.getText(TextRepository.KODU),
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getKodu, style: TextStyle(color: value, fontSize: valueSize)),
          Text(
            model.lot == 1 ? TextRepository.getText(TextRepository.LOT_ICI_ADEDI) : TextRepository.getText(TextRepository.BEDEN),
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.lot == 1 ? model.lotAdeti.toString() : model.getBeden, style: TextStyle(color: value, fontSize: valueSize)),
          Text(
            TextRepository.getText(TextRepository.FIYAT),
            style: TextStyle(color: baslik, fontSize: baslikSize),
          ),
          Text(model.getFiyat.toString(), style: TextStyle(color: value, fontSize: valueSize)),
        ]),
        TableRow(
          decoration: BoxDecoration(color: index % 2 == 0 ? Colors.grey[200] : Colors.blueGrey[100]),
          children: [
            Text(
              TextRepository.getText(TextRepository.ADI),
              style: TextStyle(color: baslik, fontSize: baslikSize),
            ),
            Text(model.getAdi, style: TextStyle(color: value, fontSize: valueSize)),
            Text(
              model.lot == 1 ? TextRepository.getText(TextRepository.LOT_ICI_ADEDI) : TextRepository.getText(TextRepository.MIKTAR),
              style: TextStyle(color: baslik, fontSize: baslikSize),
            ),
            Text(model.lot == 1 ? (model.getMiktar / model.lotAdeti).toString() : model.getMiktar.toString(), style: TextStyle(color: value, fontSize: valueSize)),
            Text(
              model.lot == 1 ? TextRepository.getText(TextRepository.TOPLAM_ADET) : "",
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

  Widget slidableSatir(BarkodRowModel model, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(child: table(model, index)),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: TextRepository.getText(TextRepository.DUZENLE),
          color: Colors.black45,
          icon: Icons.edit,
          onTap: () => editDialog(model),
        ),
        IconSlideAction(
          caption: TextRepository.getText(TextRepository.SIL),
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Silmek istediğinize emin misiniz?"),
                      actions: [
                        FlatButton(onPressed: () => Navigator.pop(context, false), child: Text(TextRepository.getText(TextRepository.HAYIR))),
                        FlatButton(onPressed: () => Navigator.pop(context, true), child: Text(TextRepository.getText(TextRepository.EVET))),
                      ],
                    )).then((value) {
              if (value == true) {
                setState(() {
                  satirlarModel.removeAt(satirlarModel.indexOf(model));
                  for (var i = 0; i < satirlarRowModel.length; i++) {
                    BarkodRowModel rowModel = satirlarRowModel[i];
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

  /*void editDialog(MusteriSiparisiRowModel model) {
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
  }*/

  void editDialog(BarkodRowModel model) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          paraBrm = model.paraBirimi;
          TextEditingController miktarController = TextEditingController();
          TextEditingController fiyatController = TextEditingController();
          fiyatController.text = model.getFiyat.toString();
          miktarController.text = model.lot == 0 ? model.getMiktar.toString() : (model.getMiktar ~/ model.lotAdeti).toInt().toString();
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputDecorator(
                          decoration: InputDecoration(labelText: TextRepository.getText(TextRepository.PARA_BIRIMI), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                TextRepository.getText(TextRepository.PARA_BIRIMI),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              isDense: true,
                              value: paraBrm,
                              onChanged: (newValue) {
                                setState(() {
                                  print(paraBrm);
                                  paraBrm = newValue;
                                  print(paraBrm);
                                });
                              },
                              items: paraBirimiList,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          /*inputFormatters: <TextInputFormatter>[ // SADECE NUMARA - VIRGUL BILE ISLEMIYOR 0-9
                          FilteringTextInputFormatter.digitsOnly
                        ],*/
                          controller: fiyatController,
                          decoration: InputDecoration(labelText: TextRepository.getText(TextRepository.FIYAT), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)), hintText: 'Yeni fiyatı giriniz.'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: miktarController,
                          decoration: InputDecoration(labelText: (model.lot == 1 ? TextRepository.getText(TextRepository.LOT_ADEDI) : TextRepository.getText(TextRepository.ADET)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)), hintText: 'Yeni miktarı giriniz.'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: SizedBox(
                            width: 320.0,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  if (model.lot == 0) {
                                    model.setMiktar = int.parse(miktarController.text);
                                    model.setFiyat = double.parse(fiyatController.text);
                                    model.setParaBirimi = paraBrm;
                                    print("TEKLI MIKTAR GIRISI");
                                    for (var i = 0; i < satirlarRowModel.length; i++) {
                                      BarkodRowModel rowModel = satirlarRowModel[i];
                                      if (rowModel.stokRenkBoyutId == model.stokRenkBoyutId) {
                                        rowModel.setMiktar = int.parse(miktarController.text);
                                        rowModel.setFiyat = double.parse(fiyatController.text);
                                        rowModel.setParaBirimi = paraBrm;
                                      }
                                    }
                                  } else {
                                    //GORUNEN LOT
                                    model.setMiktar = model.lotAdeti * int.parse(miktarController.text);
                                    model.setFiyat = double.parse(fiyatController.text);
                                    model.setParaBirimi = paraBrm;

                                    //ARKA PLANDAKI LOT ICI TEKLISI
                                    for (var i = 0; i < satirlarRefModel.length; i++) {
                                      BarkodRowModel refModel = satirlarRefModel[i];
                                      if (refModel.barkod == model.barkod && refModel.stokId == model.stokId && refModel.renkId == model.renkId) {
                                        for (var k = 0; k < satirlarRowModel.length; k++) {
                                          BarkodRowModel rowModel = satirlarRowModel[k];
                                          if (rowModel.getStokRenkBoyutId == refModel.getStokRenkBoyutId) {
                                            rowModel.setMiktar = refModel.getMiktar * int.parse(miktarController.text);
                                            rowModel.setFiyat = double.parse(fiyatController.text);
                                            rowModel.setParaBirimi = paraBrm;
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
                                TextRepository.getText(TextRepository.KAYDET),
                                style: TextStyle(color: Colors.white),
                              ),
                              color: const Color(0xFF1BC0C5),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  /*Future<int> barkodMiktarDialog(MusteriSiparisiRowModel tempModel) async {
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
  }*/

  Future<int> barkodMiktarDialog(BarkodRowModel tempModel) async {
    TextEditingController controller = TextEditingController();
    int miktar = 0;
    controller.text = 1.toString();
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 250,
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
                            TextRepository.getText(TextRepository.STOK_KODU),
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(tempModel.getKodu),
                        ]),
                        TableRow(children: [
                          Text(
                            TextRepository.getText(TextRepository.STOK_ADI),
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(tempModel.getAdi),
                        ]),
                        TableRow(children: [
                          Text(
                            TextRepository.getText(TextRepository.RENK),
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(tempModel.getRenk),
                        ]),
                        tempModel.lot == 1
                            ? TableRow(children: [
                                Text(
                                  TextRepository.getText(TextRepository.LOT_ICI_ADEDI),
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(tempModel.lotAdeti.toString()),
                              ])
                            : TableRow(children: [
                                Text(
                                  TextRepository.getText(TextRepository.BEDEN),
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(tempModel.getBeden.toString()),
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
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)), hintText: 'Miktarı giriniz.', labelText: (tempModel.lot == 0 ? TextRepository.getText(TextRepository.ADET) : TextRepository.getText(TextRepository.LOT_ADEDI))),
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
                            TextRepository.getText(TextRepository.KAYDET),
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
    return miktar;
  }

  // Future<List> futureParaBirimi() async {
  //   String ip = loginInterface.getHttpManager().getIp;
  //   String port = loginInterface.getHttpManager().getPort;
  //   var url = "http://$ip:$port/ERPService/parabirimi/list";
  //   await http.get(url).then((value) {
  //     paraBirimiList.clear();
  //     if (value.statusCode == 200) {
  //       String resp = Utf8Decoder().convert(value.bodyBytes);
  //       var jsonDecode = json.decode(resp);
  //       print(jsonDecode);
  //       for (var jsonPB in jsonDecode) {
  //         paraBirimiList.add(DropdownMenuItem(
  //           child: Text(jsonPB['paraBirimi']),
  //           value: jsonPB['paraBirimi'].toString(),
  //         ));
  //       }
  //     }
  //   });
  //   return paraBirimiList;
  // }

  // void setParaBrm() {
  //   futureParaBirimi().then((value) {
  //     setState(() {
  //       paraBirimiList = value;
  //       if (paraBirimiList.length != 0) {
  //         isPBOk = true;
  //       }
  //     });
  //   });
  // }
}
