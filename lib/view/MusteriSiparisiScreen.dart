import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';
import 'package:teronmobile/model/MusteriSiparisiModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teronmobile/model/MusteriSiparisiRowModel.dart';

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
  String ileriBtnStr = "İleri";

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
                          child: Text(ileriBtnStr),
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
    barkodFocus = FocusNode();
    setSatirlar();
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
    ileriBtnStr = "İleri";
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
      ileriBtnStr = "Tamamla";
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
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: model.getSiparisTarihi,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2030))
                              .then((value) {
                            model.setSiparisTarihi = value;
                            sipTarihController.text =
                                "${model.getSiparisTarihi.day.toString().padLeft(2, '0')}-${model.getSiparisTarihi.month.toString().padLeft(2, '0')}-${model.getSiparisTarihi.year.toString()}";
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
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: model.getTerminTarihi,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2030))
                              .then((value) {
                            model.setTerminTarihi = value;
                            terminTarihController.text =
                                "${model.getTerminTarihi.day.toString().padLeft(2, '0')}-${model.getTerminTarihi.month.toString().padLeft(2, '0')}-${model.getTerminTarihi.year.toString()}";
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
                        onChanged: (newText) {},
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
                        onChanged: (newText) {},
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
                        onChanged: (newText) {},
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
                        onChanged: (newText) {},
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
                        onChanged: (newText) {},
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
                        onChanged: (newText) {},
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
                        onChanged: (newText) {},
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
                        controller: barkodController,
                        focusNode: barkodFocus,
                        onSubmitted: (value) {
                          setState(() {
                            barkod = value;
                            barkodFocus.requestFocus();
                            barkodController.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: barkodController.text.length);
                            //SETMODEL
                            MusteriSiparisiRowModel model =
                                MusteriSiparisiRowModel();
                            model.setBarkod = "123456789";
                            model.setKodu = "Stok Kodu";
                            model.setAdi = "Stok Adı";
                            model.setRenk = "Kırmızı";
                            model.setBeden = "XL";
                            model.setParaBirimi = "TL";
                            model.setFiyat = 20;
                            model.setMiktar = 20;
                            satirlarModel.add(model);
                            print(barkod);
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
                              width: 0),
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 350,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: satirlarModel.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>
                            slidableSatir(satirlarModel[index]),
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
                              width: 0),
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 400,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: satirlarModel.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>
                            table(satirlarModel[index]),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(child: Text("Toplam Miktar"), width: 100),
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

  void setOzet() {
    
    int toplam = 0;
    for (var i = 0; i < satirlarModel.length; i++) {
      MusteriSiparisiRowModel model = satirlarModel[i];
      toplam += model.getMiktar;
    }
    ozetCariKoduController.text = model.getCariKodu;
    ozetCariAdiController.text = model.getCariAdi;
    ozetToplamMiktarController.text = toplam.toString();
  }

//SILINCEK
  void setSatirlar() {
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
  }

  Widget table(MusteriSiparisiRowModel model) {
    return Table(
      border: TableBorder.symmetric(
          inside: BorderSide(color: Colors.black45, width: 0)),
      columnWidths: {
        0: FixedColumnWidth(50),
        1: FixedColumnWidth(100),
        2: FixedColumnWidth(50),
        3: FixedColumnWidth(50),
        4: FixedColumnWidth(70),
        5: FixedColumnWidth(50),
      },
      children: [
        TableRow(children: [
          Text(
            "Barkod",
            style: TextStyle(color: Colors.red),
          ),
          Text(model.getBarkod),
          Text(
            "Renk",
            style: TextStyle(color: Colors.red),
          ),
          Text(model.getRenk),
          Text(
            "Para Birimi",
            style: TextStyle(color: Colors.red),
          ),
          Text(model.getParaBirimi),
        ]),
        TableRow(children: [
          Text(
            "Kodu",
            style: TextStyle(color: Colors.red),
          ),
          Text(model.getKodu),
          Text(
            "Beden",
            style: TextStyle(color: Colors.red),
          ),
          Text(model.getBeden),
          Text(
            "Fiyat",
            style: TextStyle(color: Colors.red),
          ),
          Text(model.getFiyat.toString()),
        ]),
        TableRow(
            children: [
              Text(
                "Adi",
                style: TextStyle(color: Colors.red),
              ),
              Text(model.getAdi),
              Text(
                "Miktar",
                style: TextStyle(color: Colors.red),
              ),
              Text(model.getMiktar.toString()),
              Text(""),
              Text(""),
            ],
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 2,
                      color: Theme.of(context).textTheme.bodyText1.color)),
            )),
      ],
    );
  }

  Widget slidableSatir(MusteriSiparisiRowModel model) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(child: table(model)),
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
            setState(() {
              satirlarModel.removeAt(satirlarModel.indexOf(model));
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
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          model.setMiktar = int.parse(controller.text);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Kaydet",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
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
