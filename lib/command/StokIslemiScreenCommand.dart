import 'package:flutter/material.dart';
import 'package:teronmobile/view/StokIslemiScreen.dart';

// ignore: must_be_immutable
class StokIslemiScreenCommand extends StatefulWidget {
  int fisTipi;

  StokIslemiScreenCommand(int fisTipi) {
    this.fisTipi = fisTipi;
  }

  @override
  State<StatefulWidget> createState() {
    return StokIslemiScreen(fisTipi);
  }
}
