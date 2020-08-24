import 'package:flutter/material.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';
import 'package:teronmobile/model/MusteriSiparisiModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  @override
  Widget build(BuildContext context) {
    setSteps();
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Müşteri Siparişi"),
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Builder(
        builder: (context) => Center(
          child: Stepper(
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
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Column(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: onStepCancel,
                          child: const Text('Geri'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40),
                        ),
                        RaisedButton(
                          onPressed: onStepContinue,
                          child: const Text('İleri'),
                        ),
                      ],
                    ),
                  ],
                );
              }),
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
  }

  next(BuildContext context) {
    print(currentStep);
    currentStep + 1 != steps.length
        ? goTo(context, currentStep + 1)
        : setState(() => complete = true);
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
        title: const Text('Sipariş Oluştur'),
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
                        controller: sipTarihController,
                        onChanged: (newText) {},
                      )),
                ],
              ),
              Row(
                children: [
                  Container(child: Text("Termin Tarihi"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 150,
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
                        controller: terminTarihController,
                        onChanged: (newText) {},
                      )),
                ],
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
                        onChanged: (newText) {},
                      )),
                ],
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
                        onChanged: (newText) {},
                      )),
                ],
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
                        onChanged: (newText) {},
                      )),
                ],
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
                        onChanged: (newText) {},
                      )),
                ],
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
                        onChanged: (newText) {},
                      )),
                ],
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
                        onChanged: (newText) {},
                      )),
                ],
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
                        onChanged: (newText) {},
                      )),
                ],
              ),
              Row(
                children: [
                  Container(child: Text("Açıklama"), width: labelWidth),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                      width: 200,
                      child: TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        textAlign: TextAlign.left,
                        readOnly: false,
                        controller: aciklamaController,
                        onChanged: (newText) {},
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
        title: const Text('Satır Bilgileri'),
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
                        controller: sipTarihController,
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
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 300,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: 15,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => slidableSatir(index),
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
            CircleAvatar(
              backgroundColor: Colors.red,
            )
          ],
        ),
      ),
    ];
  }

  Widget satir() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Text("Barkod", style: TextStyle(color: Colors.red)),
              Padding(padding: EdgeInsets.only(right: 20)),
              Text("123456789"),
            ],
          ),
          Row(
            children: [
              Text("Kodu", style: TextStyle(color: Colors.red)),
              Padding(padding: EdgeInsets.only(right: 20)),
              Text("Stok kodu"),
            ],
          ),
          Row(
            children: [
              Text("Adı", style: TextStyle(color: Colors.red)),
              Padding(padding: EdgeInsets.only(right: 20)),
              Text("Stok adı"),
            ],
          ),
        ],
      ),
    );
  }

  Widget slidableSatir(int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
          color: Colors.white,
          child: Table(
            children: [
              TableRow(children: [
                Text("Barkod"),
                Text("123456789"),
                Text("Kodu"),
                Text("Stok Kodu"),
              ]),
              TableRow(children: [
                Text("asd"),
                Text("asdqwe"),
                Text("zxczcx"),
                Text("cxvvcxvxc"),
              ]),
              TableRow(children: [
                Text("asd"),
                Text("asdqwe"),
                Text("zxczcx"),
                Text("cxvvcxvxc"),
              ]),
            ],
          )),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Düzenle',
          color: Colors.black45,
          icon: Icons.edit,
          onTap: () => print('Düzenle'),
        ),
        IconSlideAction(
          caption: 'Sil',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => print('Sil'),
        ),
      ],
    );
  }
}
