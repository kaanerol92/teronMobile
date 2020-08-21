import 'package:flutter/material.dart';
import 'package:teronmobile/command/MusteriSiparisiScreenCommand.dart';

class MusteriSiparisiScreen extends State<MusteriSiparisiScreenCommand> {
  static TextEditingController sipTarihController = TextEditingController();

  var label;

  List<Step> steps = [
    Step(
      title: const Text('Sipariş Oluştur'),
      subtitle: const Text("Kafa Bilgiler"),
      isActive: true,
      state: StepState.editing,
      content: Column(
        children: [
          TextField(
            enabled: false,
            decoration: InputDecoration(
              suffixText: "Sipariş Tarihi",
              filled: false,
            ),
            controller: sipTarihController,
            onChanged: (newText) {},
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Sipariş Tarihi",
              suffixText: "Sipariş Tarihi",
              filled: false,
            ),
            onChanged: (newText) {
              if (newText != "") {}
            },
          ),
        ],
      ),
    ),
    Step(
      isActive: true,
      state: StepState.indexed,
      title: const Text('Satır Bilgileri'),
      subtitle: const Text("Barkod ile işlem"),
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
      isActive: true,
      state: StepState.indexed,
      title: const Text('Özet'),
      subtitle: const Text("Sonuç"),
      content: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
          )
        ],
      ),
    ),
  ];

  int currentStep = 0;
  bool complete = false;

  next() {
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
    });
  }

  @override
  void initState() {
    super.initState();
    sipTarihController.text = "01010001";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Müşteri Siparişi"),
      ),
      body: Center(
        child: Stepper(
            steps: steps,
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: () {
              cancel();
            },
            onStepContinue: () {
              next();
            },
            onStepTapped: (step) => goTo(step),
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
                      FlatButton(
                        onPressed: onStepCancel,
                        child: const Text('Geri'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                      ),
                      FlatButton(
                        onPressed: onStepContinue,
                        child: const Text('İleri'),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
