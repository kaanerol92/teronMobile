import 'package:flutter/material.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';
import 'package:teronmobile/model/MusteriSiparisiModel.dart';

class MusteriSiparisiScreen extends State<MusteriSiparisiScreenCommand> {
  final labelWidth = 120.0;
  var label;
  MusteriSiparisiModel model;
  List<Step> steps;
  Map stepIndex;
  int currentStep = 0;
  bool complete = false;
  int maxStep = 0;

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
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepCancel: () {
                cancel();
              },
              onStepContinue: () {
                next(context);
              },
              onStepTapped: (step) {
                if (stepIndex[step] == true) {
                  goTo(step);
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
        "${model.getSiparisTarihi.year.toString()}-${model.getSiparisTarihi.month.toString().padLeft(2, '0')}-${model.getSiparisTarihi.day.toString().padLeft(2, '0')}";
    terminTarihController.text =
        "${model.getTerminTarihi.year.toString()}-${model.getTerminTarihi.month.toString().padLeft(2, '0')}-${model.getTerminTarihi.day.toString().padLeft(2, '0')}";
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
    if (maxStep == 0 &&
        (cariKoduController.text == null || cariKoduController.text == "") &&
        (sevkCariKoduController.text == null ||
            sevkCariKoduController.text == "") &&
        (depoKoduController.text == null || depoKoduController.text == "") &&
        (musSipNoController.text == null || musSipNoController.text == "") &&
        (aciklamaController.text == null || aciklamaController.text == "")) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [
          Icon(Icons.announcement),
          Padding(padding: EdgeInsets.all(20)),
          Text("Lütfen Eksik Alanları Doldurun."),
        ],
      )));
      return;
    }

    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
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
        content: Column(
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                Container(child: Text("Müşteri Sipariş No"), width: labelWidth),
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
      Step(
        isActive: stepIndex[1],
        state: maxStep > 1
            ? StepState.complete
            : maxStep == 1 ? StepState.editing : StepState.indexed,
        title: const Text('Satır Bilgileri'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Home Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Postcode'),
            ),
          ],
        ),
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
}
